#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"
#include "vm.h"
#include "sleeplock.h"
#include "fs.h"
#include "file.h"
#include "stat.h"
#include "buf.h"

extern struct superblock sb;

uint64
sys_exit(void)
{
  int n;
  argint(0, &n);
  kexit(n);
  return 0;  // not reached
}

uint64
sys_getpid(void)
{
  return myproc()->pid;
}

uint64
sys_fork(void)
{
  return kfork();
}

uint64
sys_wait(void)
{
  uint64 p;
  argaddr(0, &p);
  return kwait(p);
}

uint64
sys_sbrk(void)
{
  uint64 addr;
  int t;
  int n;

  argint(0, &n);
  argint(1, &t);
  addr = myproc()->sz;

  if(t == SBRK_EAGER || n < 0) {
    if(growproc(n) < 0) {
      return -1;
    }
  } else {
    // Lazily allocate memory for this process: increase its memory
    // size but don't allocate memory. If the processes uses the
    // memory, vmfault() will allocate it.
    if(addr + n < addr)
      return -1;
    if(addr + n > TRAPFRAME)
      return -1;
    myproc()->sz += n;
  }
  return addr;
}

uint64
sys_pause(void)
{
  int n;
  uint ticks0;

  argint(0, &n);
  if(n < 0)
    n = 0;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(killed(myproc())){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

uint64
sys_kill(void)
{
  int pid;

  argint(0, &pid);
  return kkill(pid);
}

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}


// we added this !!!
uint64
sys_fsinfo(void)
{
  uint64 addr;
  argaddr(0, &addr);

  struct fsinfo info;

  int inodes_per_block = BSIZE / sizeof(struct dinode);
  int ninodeblocks = (sb.ninodes + inodes_per_block - 1) / inodes_per_block;

  int b, i;

  info.total_inodes = 0;
  info.total_files = 0;
  info.total_dirs = 0;
  info.free_blocks = 0;

  // inode scan
  for(b = 0; b < ninodeblocks; b++){
    struct buf *bp = bread(ROOTDEV, sb.inodestart + b);
    struct dinode *dip = (struct dinode*)bp->data;

    for(i = 0; i < inodes_per_block; i++, dip++){
      int inum = b * inodes_per_block + i;
      if(inum >= sb.ninodes)
        break;

      if(dip->type != 0){
        info.total_inodes++;

        if(dip->type == T_FILE)
          info.total_files++;
        else if(dip->type == T_DIR)
          info.total_dirs++;
      }
    }
    brelse(bp);
  }

  // bitmap scan
  for(b = 0; b < sb.size; b += BPB){
    struct buf *bp = bread(ROOTDEV, BBLOCK(b, sb));

    for(i = 0; i < BPB && (b + i) < sb.size; i++){
      if((bp->data[i/8] & (1 << (i % 8))) == 0){
        info.free_blocks++;
      }
    }
    brelse(bp);
  }

  // copy to user
  if(copyout(myproc()->pagetable, addr, (char*)&info, sizeof(info)) < 0)
    return -1;

  return 0;
}
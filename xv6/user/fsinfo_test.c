#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

// !!! we changed this 
// this is the actual function that runs to display info on user side.
int
main(void)
{
  struct fsinfo info;

  if(fsinfo(&info) < 0){
    printf("fsinfo failed\n");
    exit(1);
  }

  printf("File System Information\n");
  printf("------------------------------\n");
  printf("Total files        : %d\n", info.total_files);
  printf("Total directories  : %d\n", info.total_dirs);
  printf("Allocated inodes   : %d\n", info.total_inodes);
  printf("Free disk blocks   : %d\n", info.free_blocks);

  exit(0);
}
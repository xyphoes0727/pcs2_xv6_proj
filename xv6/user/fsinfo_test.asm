
user/_fsinfo_test:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <main>:

// !!! we changed this 
// this is the actual function that runs to display info on user side.
int
main(void)
{
   0:	1101                	addi	sp,sp,-32
   2:	ec06                	sd	ra,24(sp)
   4:	e822                	sd	s0,16(sp)
   6:	1000                	addi	s0,sp,32
  struct fsinfo info;

  if(fsinfo(&info) < 0){
   8:	fe040513          	addi	a0,s0,-32
   c:	3ac000ef          	jal	3b8 <fsinfo>
  10:	06054163          	bltz	a0,72 <main+0x72>
    printf("fsinfo failed\n");
    exit(1);
  }

  printf("File System Information\n");
  14:	00001517          	auipc	a0,0x1
  18:	90450513          	addi	a0,a0,-1788 # 918 <malloc+0x11c>
  1c:	72c000ef          	jal	748 <printf>
  printf("------------------------------\n");
  20:	00001517          	auipc	a0,0x1
  24:	91850513          	addi	a0,a0,-1768 # 938 <malloc+0x13c>
  28:	720000ef          	jal	748 <printf>
  printf("Total files        : %d\n", info.total_files);
  2c:	fe042583          	lw	a1,-32(s0)
  30:	00001517          	auipc	a0,0x1
  34:	92850513          	addi	a0,a0,-1752 # 958 <malloc+0x15c>
  38:	710000ef          	jal	748 <printf>
  printf("Total directories  : %d\n", info.total_dirs);
  3c:	fe442583          	lw	a1,-28(s0)
  40:	00001517          	auipc	a0,0x1
  44:	93850513          	addi	a0,a0,-1736 # 978 <malloc+0x17c>
  48:	700000ef          	jal	748 <printf>
  printf("Allocated inodes   : %d\n", info.total_inodes);
  4c:	fe842583          	lw	a1,-24(s0)
  50:	00001517          	auipc	a0,0x1
  54:	94850513          	addi	a0,a0,-1720 # 998 <malloc+0x19c>
  58:	6f0000ef          	jal	748 <printf>
  printf("Free disk blocks   : %d\n", info.free_blocks);
  5c:	fec42583          	lw	a1,-20(s0)
  60:	00001517          	auipc	a0,0x1
  64:	95850513          	addi	a0,a0,-1704 # 9b8 <malloc+0x1bc>
  68:	6e0000ef          	jal	748 <printf>

  exit(0);
  6c:	4501                	li	a0,0
  6e:	2aa000ef          	jal	318 <exit>
    printf("fsinfo failed\n");
  72:	00001517          	auipc	a0,0x1
  76:	88e50513          	addi	a0,a0,-1906 # 900 <malloc+0x104>
  7a:	6ce000ef          	jal	748 <printf>
    exit(1);
  7e:	4505                	li	a0,1
  80:	298000ef          	jal	318 <exit>

0000000000000084 <start>:
//
// wrapper so that it's OK if main() does not call exit().
//
void
start(int argc, char **argv)
{
  84:	1141                	addi	sp,sp,-16
  86:	e406                	sd	ra,8(sp)
  88:	e022                	sd	s0,0(sp)
  8a:	0800                	addi	s0,sp,16
  int r;
  extern int main(int argc, char **argv);
  r = main(argc, argv);
  8c:	f75ff0ef          	jal	0 <main>
  exit(r);
  90:	288000ef          	jal	318 <exit>

0000000000000094 <strcpy>:
}

char*
strcpy(char *s, const char *t)
{
  94:	1141                	addi	sp,sp,-16
  96:	e422                	sd	s0,8(sp)
  98:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  9a:	87aa                	mv	a5,a0
  9c:	0585                	addi	a1,a1,1
  9e:	0785                	addi	a5,a5,1
  a0:	fff5c703          	lbu	a4,-1(a1)
  a4:	fee78fa3          	sb	a4,-1(a5)
  a8:	fb75                	bnez	a4,9c <strcpy+0x8>
    ;
  return os;
}
  aa:	6422                	ld	s0,8(sp)
  ac:	0141                	addi	sp,sp,16
  ae:	8082                	ret

00000000000000b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  b0:	1141                	addi	sp,sp,-16
  b2:	e422                	sd	s0,8(sp)
  b4:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
  b6:	00054783          	lbu	a5,0(a0)
  ba:	cb91                	beqz	a5,ce <strcmp+0x1e>
  bc:	0005c703          	lbu	a4,0(a1)
  c0:	00f71763          	bne	a4,a5,ce <strcmp+0x1e>
    p++, q++;
  c4:	0505                	addi	a0,a0,1
  c6:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
  c8:	00054783          	lbu	a5,0(a0)
  cc:	fbe5                	bnez	a5,bc <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
  ce:	0005c503          	lbu	a0,0(a1)
}
  d2:	40a7853b          	subw	a0,a5,a0
  d6:	6422                	ld	s0,8(sp)
  d8:	0141                	addi	sp,sp,16
  da:	8082                	ret

00000000000000dc <strlen>:

uint
strlen(const char *s)
{
  dc:	1141                	addi	sp,sp,-16
  de:	e422                	sd	s0,8(sp)
  e0:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
  e2:	00054783          	lbu	a5,0(a0)
  e6:	cf91                	beqz	a5,102 <strlen+0x26>
  e8:	0505                	addi	a0,a0,1
  ea:	87aa                	mv	a5,a0
  ec:	86be                	mv	a3,a5
  ee:	0785                	addi	a5,a5,1
  f0:	fff7c703          	lbu	a4,-1(a5)
  f4:	ff65                	bnez	a4,ec <strlen+0x10>
  f6:	40a6853b          	subw	a0,a3,a0
  fa:	2505                	addiw	a0,a0,1
    ;
  return n;
}
  fc:	6422                	ld	s0,8(sp)
  fe:	0141                	addi	sp,sp,16
 100:	8082                	ret
  for(n = 0; s[n]; n++)
 102:	4501                	li	a0,0
 104:	bfe5                	j	fc <strlen+0x20>

0000000000000106 <memset>:

void*
memset(void *dst, int c, uint n)
{
 106:	1141                	addi	sp,sp,-16
 108:	e422                	sd	s0,8(sp)
 10a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 10c:	ca19                	beqz	a2,122 <memset+0x1c>
 10e:	87aa                	mv	a5,a0
 110:	1602                	slli	a2,a2,0x20
 112:	9201                	srli	a2,a2,0x20
 114:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
 118:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 11c:	0785                	addi	a5,a5,1
 11e:	fee79de3          	bne	a5,a4,118 <memset+0x12>
  }
  return dst;
}
 122:	6422                	ld	s0,8(sp)
 124:	0141                	addi	sp,sp,16
 126:	8082                	ret

0000000000000128 <strchr>:

char*
strchr(const char *s, char c)
{
 128:	1141                	addi	sp,sp,-16
 12a:	e422                	sd	s0,8(sp)
 12c:	0800                	addi	s0,sp,16
  for(; *s; s++)
 12e:	00054783          	lbu	a5,0(a0)
 132:	cb99                	beqz	a5,148 <strchr+0x20>
    if(*s == c)
 134:	00f58763          	beq	a1,a5,142 <strchr+0x1a>
  for(; *s; s++)
 138:	0505                	addi	a0,a0,1
 13a:	00054783          	lbu	a5,0(a0)
 13e:	fbfd                	bnez	a5,134 <strchr+0xc>
      return (char*)s;
  return 0;
 140:	4501                	li	a0,0
}
 142:	6422                	ld	s0,8(sp)
 144:	0141                	addi	sp,sp,16
 146:	8082                	ret
  return 0;
 148:	4501                	li	a0,0
 14a:	bfe5                	j	142 <strchr+0x1a>

000000000000014c <gets>:

char*
gets(char *buf, int max)
{
 14c:	711d                	addi	sp,sp,-96
 14e:	ec86                	sd	ra,88(sp)
 150:	e8a2                	sd	s0,80(sp)
 152:	e4a6                	sd	s1,72(sp)
 154:	e0ca                	sd	s2,64(sp)
 156:	fc4e                	sd	s3,56(sp)
 158:	f852                	sd	s4,48(sp)
 15a:	f456                	sd	s5,40(sp)
 15c:	f05a                	sd	s6,32(sp)
 15e:	ec5e                	sd	s7,24(sp)
 160:	1080                	addi	s0,sp,96
 162:	8baa                	mv	s7,a0
 164:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 166:	892a                	mv	s2,a0
 168:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 16a:	4aa9                	li	s5,10
 16c:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 16e:	89a6                	mv	s3,s1
 170:	2485                	addiw	s1,s1,1
 172:	0344d663          	bge	s1,s4,19e <gets+0x52>
    cc = read(0, &c, 1);
 176:	4605                	li	a2,1
 178:	faf40593          	addi	a1,s0,-81
 17c:	4501                	li	a0,0
 17e:	1b2000ef          	jal	330 <read>
    if(cc < 1)
 182:	00a05e63          	blez	a0,19e <gets+0x52>
    buf[i++] = c;
 186:	faf44783          	lbu	a5,-81(s0)
 18a:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 18e:	01578763          	beq	a5,s5,19c <gets+0x50>
 192:	0905                	addi	s2,s2,1
 194:	fd679de3          	bne	a5,s6,16e <gets+0x22>
    buf[i++] = c;
 198:	89a6                	mv	s3,s1
 19a:	a011                	j	19e <gets+0x52>
 19c:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 19e:	99de                	add	s3,s3,s7
 1a0:	00098023          	sb	zero,0(s3)
  return buf;
}
 1a4:	855e                	mv	a0,s7
 1a6:	60e6                	ld	ra,88(sp)
 1a8:	6446                	ld	s0,80(sp)
 1aa:	64a6                	ld	s1,72(sp)
 1ac:	6906                	ld	s2,64(sp)
 1ae:	79e2                	ld	s3,56(sp)
 1b0:	7a42                	ld	s4,48(sp)
 1b2:	7aa2                	ld	s5,40(sp)
 1b4:	7b02                	ld	s6,32(sp)
 1b6:	6be2                	ld	s7,24(sp)
 1b8:	6125                	addi	sp,sp,96
 1ba:	8082                	ret

00000000000001bc <stat>:

int
stat(const char *n, struct stat *st)
{
 1bc:	1101                	addi	sp,sp,-32
 1be:	ec06                	sd	ra,24(sp)
 1c0:	e822                	sd	s0,16(sp)
 1c2:	e04a                	sd	s2,0(sp)
 1c4:	1000                	addi	s0,sp,32
 1c6:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c8:	4581                	li	a1,0
 1ca:	18e000ef          	jal	358 <open>
  if(fd < 0)
 1ce:	02054263          	bltz	a0,1f2 <stat+0x36>
 1d2:	e426                	sd	s1,8(sp)
 1d4:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 1d6:	85ca                	mv	a1,s2
 1d8:	198000ef          	jal	370 <fstat>
 1dc:	892a                	mv	s2,a0
  close(fd);
 1de:	8526                	mv	a0,s1
 1e0:	160000ef          	jal	340 <close>
  return r;
 1e4:	64a2                	ld	s1,8(sp)
}
 1e6:	854a                	mv	a0,s2
 1e8:	60e2                	ld	ra,24(sp)
 1ea:	6442                	ld	s0,16(sp)
 1ec:	6902                	ld	s2,0(sp)
 1ee:	6105                	addi	sp,sp,32
 1f0:	8082                	ret
    return -1;
 1f2:	597d                	li	s2,-1
 1f4:	bfcd                	j	1e6 <stat+0x2a>

00000000000001f6 <atoi>:

int
atoi(const char *s)
{
 1f6:	1141                	addi	sp,sp,-16
 1f8:	e422                	sd	s0,8(sp)
 1fa:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1fc:	00054683          	lbu	a3,0(a0)
 200:	fd06879b          	addiw	a5,a3,-48
 204:	0ff7f793          	zext.b	a5,a5
 208:	4625                	li	a2,9
 20a:	02f66863          	bltu	a2,a5,23a <atoi+0x44>
 20e:	872a                	mv	a4,a0
  n = 0;
 210:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
 212:	0705                	addi	a4,a4,1
 214:	0025179b          	slliw	a5,a0,0x2
 218:	9fa9                	addw	a5,a5,a0
 21a:	0017979b          	slliw	a5,a5,0x1
 21e:	9fb5                	addw	a5,a5,a3
 220:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 224:	00074683          	lbu	a3,0(a4)
 228:	fd06879b          	addiw	a5,a3,-48
 22c:	0ff7f793          	zext.b	a5,a5
 230:	fef671e3          	bgeu	a2,a5,212 <atoi+0x1c>
  return n;
}
 234:	6422                	ld	s0,8(sp)
 236:	0141                	addi	sp,sp,16
 238:	8082                	ret
  n = 0;
 23a:	4501                	li	a0,0
 23c:	bfe5                	j	234 <atoi+0x3e>

000000000000023e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 23e:	1141                	addi	sp,sp,-16
 240:	e422                	sd	s0,8(sp)
 242:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
 244:	02b57463          	bgeu	a0,a1,26c <memmove+0x2e>
    while(n-- > 0)
 248:	00c05f63          	blez	a2,266 <memmove+0x28>
 24c:	1602                	slli	a2,a2,0x20
 24e:	9201                	srli	a2,a2,0x20
 250:	00c507b3          	add	a5,a0,a2
  dst = vdst;
 254:	872a                	mv	a4,a0
      *dst++ = *src++;
 256:	0585                	addi	a1,a1,1
 258:	0705                	addi	a4,a4,1
 25a:	fff5c683          	lbu	a3,-1(a1)
 25e:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 262:	fef71ae3          	bne	a4,a5,256 <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret
    dst += n;
 26c:	00c50733          	add	a4,a0,a2
    src += n;
 270:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 272:	fec05ae3          	blez	a2,266 <memmove+0x28>
 276:	fff6079b          	addiw	a5,a2,-1
 27a:	1782                	slli	a5,a5,0x20
 27c:	9381                	srli	a5,a5,0x20
 27e:	fff7c793          	not	a5,a5
 282:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 284:	15fd                	addi	a1,a1,-1
 286:	177d                	addi	a4,a4,-1
 288:	0005c683          	lbu	a3,0(a1)
 28c:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 290:	fee79ae3          	bne	a5,a4,284 <memmove+0x46>
 294:	bfc9                	j	266 <memmove+0x28>

0000000000000296 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 29c:	ca05                	beqz	a2,2cc <memcmp+0x36>
 29e:	fff6069b          	addiw	a3,a2,-1
 2a2:	1682                	slli	a3,a3,0x20
 2a4:	9281                	srli	a3,a3,0x20
 2a6:	0685                	addi	a3,a3,1
 2a8:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 2aa:	00054783          	lbu	a5,0(a0)
 2ae:	0005c703          	lbu	a4,0(a1)
 2b2:	00e79863          	bne	a5,a4,2c2 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 2b6:	0505                	addi	a0,a0,1
    p2++;
 2b8:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 2ba:	fed518e3          	bne	a0,a3,2aa <memcmp+0x14>
  }
  return 0;
 2be:	4501                	li	a0,0
 2c0:	a019                	j	2c6 <memcmp+0x30>
      return *p1 - *p2;
 2c2:	40e7853b          	subw	a0,a5,a4
}
 2c6:	6422                	ld	s0,8(sp)
 2c8:	0141                	addi	sp,sp,16
 2ca:	8082                	ret
  return 0;
 2cc:	4501                	li	a0,0
 2ce:	bfe5                	j	2c6 <memcmp+0x30>

00000000000002d0 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 2d0:	1141                	addi	sp,sp,-16
 2d2:	e406                	sd	ra,8(sp)
 2d4:	e022                	sd	s0,0(sp)
 2d6:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 2d8:	f67ff0ef          	jal	23e <memmove>
}
 2dc:	60a2                	ld	ra,8(sp)
 2de:	6402                	ld	s0,0(sp)
 2e0:	0141                	addi	sp,sp,16
 2e2:	8082                	ret

00000000000002e4 <sbrk>:

char *
sbrk(int n) {
 2e4:	1141                	addi	sp,sp,-16
 2e6:	e406                	sd	ra,8(sp)
 2e8:	e022                	sd	s0,0(sp)
 2ea:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_EAGER);
 2ec:	4585                	li	a1,1
 2ee:	0b2000ef          	jal	3a0 <sys_sbrk>
}
 2f2:	60a2                	ld	ra,8(sp)
 2f4:	6402                	ld	s0,0(sp)
 2f6:	0141                	addi	sp,sp,16
 2f8:	8082                	ret

00000000000002fa <sbrklazy>:

char *
sbrklazy(int n) {
 2fa:	1141                	addi	sp,sp,-16
 2fc:	e406                	sd	ra,8(sp)
 2fe:	e022                	sd	s0,0(sp)
 300:	0800                	addi	s0,sp,16
  return sys_sbrk(n, SBRK_LAZY);
 302:	4589                	li	a1,2
 304:	09c000ef          	jal	3a0 <sys_sbrk>
}
 308:	60a2                	ld	ra,8(sp)
 30a:	6402                	ld	s0,0(sp)
 30c:	0141                	addi	sp,sp,16
 30e:	8082                	ret

0000000000000310 <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
 310:	4885                	li	a7,1
 ecall
 312:	00000073          	ecall
 ret
 316:	8082                	ret

0000000000000318 <exit>:
.global exit
exit:
 li a7, SYS_exit
 318:	4889                	li	a7,2
 ecall
 31a:	00000073          	ecall
 ret
 31e:	8082                	ret

0000000000000320 <wait>:
.global wait
wait:
 li a7, SYS_wait
 320:	488d                	li	a7,3
 ecall
 322:	00000073          	ecall
 ret
 326:	8082                	ret

0000000000000328 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
 328:	4891                	li	a7,4
 ecall
 32a:	00000073          	ecall
 ret
 32e:	8082                	ret

0000000000000330 <read>:
.global read
read:
 li a7, SYS_read
 330:	4895                	li	a7,5
 ecall
 332:	00000073          	ecall
 ret
 336:	8082                	ret

0000000000000338 <write>:
.global write
write:
 li a7, SYS_write
 338:	48c1                	li	a7,16
 ecall
 33a:	00000073          	ecall
 ret
 33e:	8082                	ret

0000000000000340 <close>:
.global close
close:
 li a7, SYS_close
 340:	48d5                	li	a7,21
 ecall
 342:	00000073          	ecall
 ret
 346:	8082                	ret

0000000000000348 <kill>:
.global kill
kill:
 li a7, SYS_kill
 348:	4899                	li	a7,6
 ecall
 34a:	00000073          	ecall
 ret
 34e:	8082                	ret

0000000000000350 <exec>:
.global exec
exec:
 li a7, SYS_exec
 350:	489d                	li	a7,7
 ecall
 352:	00000073          	ecall
 ret
 356:	8082                	ret

0000000000000358 <open>:
.global open
open:
 li a7, SYS_open
 358:	48bd                	li	a7,15
 ecall
 35a:	00000073          	ecall
 ret
 35e:	8082                	ret

0000000000000360 <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
 360:	48c5                	li	a7,17
 ecall
 362:	00000073          	ecall
 ret
 366:	8082                	ret

0000000000000368 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
 368:	48c9                	li	a7,18
 ecall
 36a:	00000073          	ecall
 ret
 36e:	8082                	ret

0000000000000370 <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
 370:	48a1                	li	a7,8
 ecall
 372:	00000073          	ecall
 ret
 376:	8082                	ret

0000000000000378 <link>:
.global link
link:
 li a7, SYS_link
 378:	48cd                	li	a7,19
 ecall
 37a:	00000073          	ecall
 ret
 37e:	8082                	ret

0000000000000380 <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
 380:	48d1                	li	a7,20
 ecall
 382:	00000073          	ecall
 ret
 386:	8082                	ret

0000000000000388 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
 388:	48a5                	li	a7,9
 ecall
 38a:	00000073          	ecall
 ret
 38e:	8082                	ret

0000000000000390 <dup>:
.global dup
dup:
 li a7, SYS_dup
 390:	48a9                	li	a7,10
 ecall
 392:	00000073          	ecall
 ret
 396:	8082                	ret

0000000000000398 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
 398:	48ad                	li	a7,11
 ecall
 39a:	00000073          	ecall
 ret
 39e:	8082                	ret

00000000000003a0 <sys_sbrk>:
.global sys_sbrk
sys_sbrk:
 li a7, SYS_sbrk
 3a0:	48b1                	li	a7,12
 ecall
 3a2:	00000073          	ecall
 ret
 3a6:	8082                	ret

00000000000003a8 <pause>:
.global pause
pause:
 li a7, SYS_pause
 3a8:	48b5                	li	a7,13
 ecall
 3aa:	00000073          	ecall
 ret
 3ae:	8082                	ret

00000000000003b0 <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
 3b0:	48b9                	li	a7,14
 ecall
 3b2:	00000073          	ecall
 ret
 3b6:	8082                	ret

00000000000003b8 <fsinfo>:
.global fsinfo
fsinfo:
 li a7, SYS_fsinfo
 3b8:	48d9                	li	a7,22
 ecall
 3ba:	00000073          	ecall
 ret
 3be:	8082                	ret

00000000000003c0 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
 3c0:	1101                	addi	sp,sp,-32
 3c2:	ec06                	sd	ra,24(sp)
 3c4:	e822                	sd	s0,16(sp)
 3c6:	1000                	addi	s0,sp,32
 3c8:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
 3cc:	4605                	li	a2,1
 3ce:	fef40593          	addi	a1,s0,-17
 3d2:	f67ff0ef          	jal	338 <write>
}
 3d6:	60e2                	ld	ra,24(sp)
 3d8:	6442                	ld	s0,16(sp)
 3da:	6105                	addi	sp,sp,32
 3dc:	8082                	ret

00000000000003de <printint>:

static void
printint(int fd, long long xx, int base, int sgn)
{
 3de:	715d                	addi	sp,sp,-80
 3e0:	e486                	sd	ra,72(sp)
 3e2:	e0a2                	sd	s0,64(sp)
 3e4:	f84a                	sd	s2,48(sp)
 3e6:	0880                	addi	s0,sp,80
 3e8:	892a                	mv	s2,a0
  char buf[20];
  int i, neg;
  unsigned long long x;

  neg = 0;
  if(sgn && xx < 0){
 3ea:	c299                	beqz	a3,3f0 <printint+0x12>
 3ec:	0805c363          	bltz	a1,472 <printint+0x94>
  neg = 0;
 3f0:	4881                	li	a7,0
 3f2:	fb840693          	addi	a3,s0,-72
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 3f6:	4781                	li	a5,0
  do{
    buf[i++] = digits[x % base];
 3f8:	00000517          	auipc	a0,0x0
 3fc:	5e850513          	addi	a0,a0,1512 # 9e0 <digits>
 400:	883e                	mv	a6,a5
 402:	2785                	addiw	a5,a5,1
 404:	02c5f733          	remu	a4,a1,a2
 408:	972a                	add	a4,a4,a0
 40a:	00074703          	lbu	a4,0(a4)
 40e:	00e68023          	sb	a4,0(a3)
  }while((x /= base) != 0);
 412:	872e                	mv	a4,a1
 414:	02c5d5b3          	divu	a1,a1,a2
 418:	0685                	addi	a3,a3,1
 41a:	fec773e3          	bgeu	a4,a2,400 <printint+0x22>
  if(neg)
 41e:	00088b63          	beqz	a7,434 <printint+0x56>
    buf[i++] = '-';
 422:	fd078793          	addi	a5,a5,-48
 426:	97a2                	add	a5,a5,s0
 428:	02d00713          	li	a4,45
 42c:	fee78423          	sb	a4,-24(a5)
 430:	0028079b          	addiw	a5,a6,2

  while(--i >= 0)
 434:	02f05a63          	blez	a5,468 <printint+0x8a>
 438:	fc26                	sd	s1,56(sp)
 43a:	f44e                	sd	s3,40(sp)
 43c:	fb840713          	addi	a4,s0,-72
 440:	00f704b3          	add	s1,a4,a5
 444:	fff70993          	addi	s3,a4,-1
 448:	99be                	add	s3,s3,a5
 44a:	37fd                	addiw	a5,a5,-1
 44c:	1782                	slli	a5,a5,0x20
 44e:	9381                	srli	a5,a5,0x20
 450:	40f989b3          	sub	s3,s3,a5
    putc(fd, buf[i]);
 454:	fff4c583          	lbu	a1,-1(s1)
 458:	854a                	mv	a0,s2
 45a:	f67ff0ef          	jal	3c0 <putc>
  while(--i >= 0)
 45e:	14fd                	addi	s1,s1,-1
 460:	ff349ae3          	bne	s1,s3,454 <printint+0x76>
 464:	74e2                	ld	s1,56(sp)
 466:	79a2                	ld	s3,40(sp)
}
 468:	60a6                	ld	ra,72(sp)
 46a:	6406                	ld	s0,64(sp)
 46c:	7942                	ld	s2,48(sp)
 46e:	6161                	addi	sp,sp,80
 470:	8082                	ret
    x = -xx;
 472:	40b005b3          	neg	a1,a1
    neg = 1;
 476:	4885                	li	a7,1
    x = -xx;
 478:	bfad                	j	3f2 <printint+0x14>

000000000000047a <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %c, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
 47a:	711d                	addi	sp,sp,-96
 47c:	ec86                	sd	ra,88(sp)
 47e:	e8a2                	sd	s0,80(sp)
 480:	e0ca                	sd	s2,64(sp)
 482:	1080                	addi	s0,sp,96
  char *s;
  int c0, c1, c2, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
 484:	0005c903          	lbu	s2,0(a1)
 488:	28090663          	beqz	s2,714 <vprintf+0x29a>
 48c:	e4a6                	sd	s1,72(sp)
 48e:	fc4e                	sd	s3,56(sp)
 490:	f852                	sd	s4,48(sp)
 492:	f456                	sd	s5,40(sp)
 494:	f05a                	sd	s6,32(sp)
 496:	ec5e                	sd	s7,24(sp)
 498:	e862                	sd	s8,16(sp)
 49a:	e466                	sd	s9,8(sp)
 49c:	8b2a                	mv	s6,a0
 49e:	8a2e                	mv	s4,a1
 4a0:	8bb2                	mv	s7,a2
  state = 0;
 4a2:	4981                	li	s3,0
  for(i = 0; fmt[i]; i++){
 4a4:	4481                	li	s1,0
 4a6:	4701                	li	a4,0
      if(c0 == '%'){
        state = '%';
      } else {
        putc(fd, c0);
      }
    } else if(state == '%'){
 4a8:	02500a93          	li	s5,37
      c1 = c2 = 0;
      if(c0) c1 = fmt[i+1] & 0xff;
      if(c1) c2 = fmt[i+2] & 0xff;
      if(c0 == 'd'){
 4ac:	06400c13          	li	s8,100
        printint(fd, va_arg(ap, int), 10, 1);
      } else if(c0 == 'l' && c1 == 'd'){
 4b0:	06c00c93          	li	s9,108
 4b4:	a005                	j	4d4 <vprintf+0x5a>
        putc(fd, c0);
 4b6:	85ca                	mv	a1,s2
 4b8:	855a                	mv	a0,s6
 4ba:	f07ff0ef          	jal	3c0 <putc>
 4be:	a019                	j	4c4 <vprintf+0x4a>
    } else if(state == '%'){
 4c0:	03598263          	beq	s3,s5,4e4 <vprintf+0x6a>
  for(i = 0; fmt[i]; i++){
 4c4:	2485                	addiw	s1,s1,1
 4c6:	8726                	mv	a4,s1
 4c8:	009a07b3          	add	a5,s4,s1
 4cc:	0007c903          	lbu	s2,0(a5)
 4d0:	22090a63          	beqz	s2,704 <vprintf+0x28a>
    c0 = fmt[i] & 0xff;
 4d4:	0009079b          	sext.w	a5,s2
    if(state == 0){
 4d8:	fe0994e3          	bnez	s3,4c0 <vprintf+0x46>
      if(c0 == '%'){
 4dc:	fd579de3          	bne	a5,s5,4b6 <vprintf+0x3c>
        state = '%';
 4e0:	89be                	mv	s3,a5
 4e2:	b7cd                	j	4c4 <vprintf+0x4a>
      if(c0) c1 = fmt[i+1] & 0xff;
 4e4:	00ea06b3          	add	a3,s4,a4
 4e8:	0016c683          	lbu	a3,1(a3)
      c1 = c2 = 0;
 4ec:	8636                	mv	a2,a3
      if(c1) c2 = fmt[i+2] & 0xff;
 4ee:	c681                	beqz	a3,4f6 <vprintf+0x7c>
 4f0:	9752                	add	a4,a4,s4
 4f2:	00274603          	lbu	a2,2(a4)
      if(c0 == 'd'){
 4f6:	05878363          	beq	a5,s8,53c <vprintf+0xc2>
      } else if(c0 == 'l' && c1 == 'd'){
 4fa:	05978d63          	beq	a5,s9,554 <vprintf+0xda>
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
        printint(fd, va_arg(ap, uint64), 10, 1);
        i += 2;
      } else if(c0 == 'u'){
 4fe:	07500713          	li	a4,117
 502:	0ee78763          	beq	a5,a4,5f0 <vprintf+0x176>
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
        printint(fd, va_arg(ap, uint64), 10, 0);
        i += 2;
      } else if(c0 == 'x'){
 506:	07800713          	li	a4,120
 50a:	12e78963          	beq	a5,a4,63c <vprintf+0x1c2>
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 1;
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
        printint(fd, va_arg(ap, uint64), 16, 0);
        i += 2;
      } else if(c0 == 'p'){
 50e:	07000713          	li	a4,112
 512:	14e78e63          	beq	a5,a4,66e <vprintf+0x1f4>
        printptr(fd, va_arg(ap, uint64));
      } else if(c0 == 'c'){
 516:	06300713          	li	a4,99
 51a:	18e78e63          	beq	a5,a4,6b6 <vprintf+0x23c>
        putc(fd, va_arg(ap, uint32));
      } else if(c0 == 's'){
 51e:	07300713          	li	a4,115
 522:	1ae78463          	beq	a5,a4,6ca <vprintf+0x250>
        if((s = va_arg(ap, char*)) == 0)
          s = "(null)";
        for(; *s; s++)
          putc(fd, *s);
      } else if(c0 == '%'){
 526:	02500713          	li	a4,37
 52a:	04e79563          	bne	a5,a4,574 <vprintf+0xfa>
        putc(fd, '%');
 52e:	02500593          	li	a1,37
 532:	855a                	mv	a0,s6
 534:	e8dff0ef          	jal	3c0 <putc>
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c0);
      }

      state = 0;
 538:	4981                	li	s3,0
 53a:	b769                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, int), 10, 1);
 53c:	008b8913          	addi	s2,s7,8
 540:	4685                	li	a3,1
 542:	4629                	li	a2,10
 544:	000ba583          	lw	a1,0(s7)
 548:	855a                	mv	a0,s6
 54a:	e95ff0ef          	jal	3de <printint>
 54e:	8bca                	mv	s7,s2
      state = 0;
 550:	4981                	li	s3,0
 552:	bf8d                	j	4c4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'd'){
 554:	06400793          	li	a5,100
 558:	02f68963          	beq	a3,a5,58a <vprintf+0x110>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 55c:	06c00793          	li	a5,108
 560:	04f68263          	beq	a3,a5,5a4 <vprintf+0x12a>
      } else if(c0 == 'l' && c1 == 'u'){
 564:	07500793          	li	a5,117
 568:	0af68063          	beq	a3,a5,608 <vprintf+0x18e>
      } else if(c0 == 'l' && c1 == 'x'){
 56c:	07800793          	li	a5,120
 570:	0ef68263          	beq	a3,a5,654 <vprintf+0x1da>
        putc(fd, '%');
 574:	02500593          	li	a1,37
 578:	855a                	mv	a0,s6
 57a:	e47ff0ef          	jal	3c0 <putc>
        putc(fd, c0);
 57e:	85ca                	mv	a1,s2
 580:	855a                	mv	a0,s6
 582:	e3fff0ef          	jal	3c0 <putc>
      state = 0;
 586:	4981                	li	s3,0
 588:	bf35                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 58a:	008b8913          	addi	s2,s7,8
 58e:	4685                	li	a3,1
 590:	4629                	li	a2,10
 592:	000bb583          	ld	a1,0(s7)
 596:	855a                	mv	a0,s6
 598:	e47ff0ef          	jal	3de <printint>
        i += 1;
 59c:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 1);
 59e:	8bca                	mv	s7,s2
      state = 0;
 5a0:	4981                	li	s3,0
        i += 1;
 5a2:	b70d                	j	4c4 <vprintf+0x4a>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'd'){
 5a4:	06400793          	li	a5,100
 5a8:	02f60763          	beq	a2,a5,5d6 <vprintf+0x15c>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'u'){
 5ac:	07500793          	li	a5,117
 5b0:	06f60963          	beq	a2,a5,622 <vprintf+0x1a8>
      } else if(c0 == 'l' && c1 == 'l' && c2 == 'x'){
 5b4:	07800793          	li	a5,120
 5b8:	faf61ee3          	bne	a2,a5,574 <vprintf+0xfa>
        printint(fd, va_arg(ap, uint64), 16, 0);
 5bc:	008b8913          	addi	s2,s7,8
 5c0:	4681                	li	a3,0
 5c2:	4641                	li	a2,16
 5c4:	000bb583          	ld	a1,0(s7)
 5c8:	855a                	mv	a0,s6
 5ca:	e15ff0ef          	jal	3de <printint>
        i += 2;
 5ce:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 16, 0);
 5d0:	8bca                	mv	s7,s2
      state = 0;
 5d2:	4981                	li	s3,0
        i += 2;
 5d4:	bdc5                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 1);
 5d6:	008b8913          	addi	s2,s7,8
 5da:	4685                	li	a3,1
 5dc:	4629                	li	a2,10
 5de:	000bb583          	ld	a1,0(s7)
 5e2:	855a                	mv	a0,s6
 5e4:	dfbff0ef          	jal	3de <printint>
        i += 2;
 5e8:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 1);
 5ea:	8bca                	mv	s7,s2
      state = 0;
 5ec:	4981                	li	s3,0
        i += 2;
 5ee:	bdd9                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 10, 0);
 5f0:	008b8913          	addi	s2,s7,8
 5f4:	4681                	li	a3,0
 5f6:	4629                	li	a2,10
 5f8:	000be583          	lwu	a1,0(s7)
 5fc:	855a                	mv	a0,s6
 5fe:	de1ff0ef          	jal	3de <printint>
 602:	8bca                	mv	s7,s2
      state = 0;
 604:	4981                	li	s3,0
 606:	bd7d                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 608:	008b8913          	addi	s2,s7,8
 60c:	4681                	li	a3,0
 60e:	4629                	li	a2,10
 610:	000bb583          	ld	a1,0(s7)
 614:	855a                	mv	a0,s6
 616:	dc9ff0ef          	jal	3de <printint>
        i += 1;
 61a:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 10, 0);
 61c:	8bca                	mv	s7,s2
      state = 0;
 61e:	4981                	li	s3,0
        i += 1;
 620:	b555                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 10, 0);
 622:	008b8913          	addi	s2,s7,8
 626:	4681                	li	a3,0
 628:	4629                	li	a2,10
 62a:	000bb583          	ld	a1,0(s7)
 62e:	855a                	mv	a0,s6
 630:	dafff0ef          	jal	3de <printint>
        i += 2;
 634:	2489                	addiw	s1,s1,2
        printint(fd, va_arg(ap, uint64), 10, 0);
 636:	8bca                	mv	s7,s2
      state = 0;
 638:	4981                	li	s3,0
        i += 2;
 63a:	b569                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint32), 16, 0);
 63c:	008b8913          	addi	s2,s7,8
 640:	4681                	li	a3,0
 642:	4641                	li	a2,16
 644:	000be583          	lwu	a1,0(s7)
 648:	855a                	mv	a0,s6
 64a:	d95ff0ef          	jal	3de <printint>
 64e:	8bca                	mv	s7,s2
      state = 0;
 650:	4981                	li	s3,0
 652:	bd8d                	j	4c4 <vprintf+0x4a>
        printint(fd, va_arg(ap, uint64), 16, 0);
 654:	008b8913          	addi	s2,s7,8
 658:	4681                	li	a3,0
 65a:	4641                	li	a2,16
 65c:	000bb583          	ld	a1,0(s7)
 660:	855a                	mv	a0,s6
 662:	d7dff0ef          	jal	3de <printint>
        i += 1;
 666:	2485                	addiw	s1,s1,1
        printint(fd, va_arg(ap, uint64), 16, 0);
 668:	8bca                	mv	s7,s2
      state = 0;
 66a:	4981                	li	s3,0
        i += 1;
 66c:	bda1                	j	4c4 <vprintf+0x4a>
 66e:	e06a                	sd	s10,0(sp)
        printptr(fd, va_arg(ap, uint64));
 670:	008b8d13          	addi	s10,s7,8
 674:	000bb983          	ld	s3,0(s7)
  putc(fd, '0');
 678:	03000593          	li	a1,48
 67c:	855a                	mv	a0,s6
 67e:	d43ff0ef          	jal	3c0 <putc>
  putc(fd, 'x');
 682:	07800593          	li	a1,120
 686:	855a                	mv	a0,s6
 688:	d39ff0ef          	jal	3c0 <putc>
 68c:	4941                	li	s2,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
 68e:	00000b97          	auipc	s7,0x0
 692:	352b8b93          	addi	s7,s7,850 # 9e0 <digits>
 696:	03c9d793          	srli	a5,s3,0x3c
 69a:	97de                	add	a5,a5,s7
 69c:	0007c583          	lbu	a1,0(a5)
 6a0:	855a                	mv	a0,s6
 6a2:	d1fff0ef          	jal	3c0 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
 6a6:	0992                	slli	s3,s3,0x4
 6a8:	397d                	addiw	s2,s2,-1
 6aa:	fe0916e3          	bnez	s2,696 <vprintf+0x21c>
        printptr(fd, va_arg(ap, uint64));
 6ae:	8bea                	mv	s7,s10
      state = 0;
 6b0:	4981                	li	s3,0
 6b2:	6d02                	ld	s10,0(sp)
 6b4:	bd01                	j	4c4 <vprintf+0x4a>
        putc(fd, va_arg(ap, uint32));
 6b6:	008b8913          	addi	s2,s7,8
 6ba:	000bc583          	lbu	a1,0(s7)
 6be:	855a                	mv	a0,s6
 6c0:	d01ff0ef          	jal	3c0 <putc>
 6c4:	8bca                	mv	s7,s2
      state = 0;
 6c6:	4981                	li	s3,0
 6c8:	bbf5                	j	4c4 <vprintf+0x4a>
        if((s = va_arg(ap, char*)) == 0)
 6ca:	008b8993          	addi	s3,s7,8
 6ce:	000bb903          	ld	s2,0(s7)
 6d2:	00090f63          	beqz	s2,6f0 <vprintf+0x276>
        for(; *s; s++)
 6d6:	00094583          	lbu	a1,0(s2)
 6da:	c195                	beqz	a1,6fe <vprintf+0x284>
          putc(fd, *s);
 6dc:	855a                	mv	a0,s6
 6de:	ce3ff0ef          	jal	3c0 <putc>
        for(; *s; s++)
 6e2:	0905                	addi	s2,s2,1
 6e4:	00094583          	lbu	a1,0(s2)
 6e8:	f9f5                	bnez	a1,6dc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 6ea:	8bce                	mv	s7,s3
      state = 0;
 6ec:	4981                	li	s3,0
 6ee:	bbd9                	j	4c4 <vprintf+0x4a>
          s = "(null)";
 6f0:	00000917          	auipc	s2,0x0
 6f4:	2e890913          	addi	s2,s2,744 # 9d8 <malloc+0x1dc>
        for(; *s; s++)
 6f8:	02800593          	li	a1,40
 6fc:	b7c5                	j	6dc <vprintf+0x262>
        if((s = va_arg(ap, char*)) == 0)
 6fe:	8bce                	mv	s7,s3
      state = 0;
 700:	4981                	li	s3,0
 702:	b3c9                	j	4c4 <vprintf+0x4a>
 704:	64a6                	ld	s1,72(sp)
 706:	79e2                	ld	s3,56(sp)
 708:	7a42                	ld	s4,48(sp)
 70a:	7aa2                	ld	s5,40(sp)
 70c:	7b02                	ld	s6,32(sp)
 70e:	6be2                	ld	s7,24(sp)
 710:	6c42                	ld	s8,16(sp)
 712:	6ca2                	ld	s9,8(sp)
    }
  }
}
 714:	60e6                	ld	ra,88(sp)
 716:	6446                	ld	s0,80(sp)
 718:	6906                	ld	s2,64(sp)
 71a:	6125                	addi	sp,sp,96
 71c:	8082                	ret

000000000000071e <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
 71e:	715d                	addi	sp,sp,-80
 720:	ec06                	sd	ra,24(sp)
 722:	e822                	sd	s0,16(sp)
 724:	1000                	addi	s0,sp,32
 726:	e010                	sd	a2,0(s0)
 728:	e414                	sd	a3,8(s0)
 72a:	e818                	sd	a4,16(s0)
 72c:	ec1c                	sd	a5,24(s0)
 72e:	03043023          	sd	a6,32(s0)
 732:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
 736:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
 73a:	8622                	mv	a2,s0
 73c:	d3fff0ef          	jal	47a <vprintf>
}
 740:	60e2                	ld	ra,24(sp)
 742:	6442                	ld	s0,16(sp)
 744:	6161                	addi	sp,sp,80
 746:	8082                	ret

0000000000000748 <printf>:

void
printf(const char *fmt, ...)
{
 748:	711d                	addi	sp,sp,-96
 74a:	ec06                	sd	ra,24(sp)
 74c:	e822                	sd	s0,16(sp)
 74e:	1000                	addi	s0,sp,32
 750:	e40c                	sd	a1,8(s0)
 752:	e810                	sd	a2,16(s0)
 754:	ec14                	sd	a3,24(s0)
 756:	f018                	sd	a4,32(s0)
 758:	f41c                	sd	a5,40(s0)
 75a:	03043823          	sd	a6,48(s0)
 75e:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
 762:	00840613          	addi	a2,s0,8
 766:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
 76a:	85aa                	mv	a1,a0
 76c:	4505                	li	a0,1
 76e:	d0dff0ef          	jal	47a <vprintf>
}
 772:	60e2                	ld	ra,24(sp)
 774:	6442                	ld	s0,16(sp)
 776:	6125                	addi	sp,sp,96
 778:	8082                	ret

000000000000077a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 77a:	1141                	addi	sp,sp,-16
 77c:	e422                	sd	s0,8(sp)
 77e:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
 780:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 784:	00001797          	auipc	a5,0x1
 788:	87c7b783          	ld	a5,-1924(a5) # 1000 <freep>
 78c:	a02d                	j	7b6 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 78e:	4618                	lw	a4,8(a2)
 790:	9f2d                	addw	a4,a4,a1
 792:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
 796:	6398                	ld	a4,0(a5)
 798:	6310                	ld	a2,0(a4)
 79a:	a83d                	j	7d8 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
 79c:	ff852703          	lw	a4,-8(a0)
 7a0:	9f31                	addw	a4,a4,a2
 7a2:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
 7a4:	ff053683          	ld	a3,-16(a0)
 7a8:	a091                	j	7ec <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7aa:	6398                	ld	a4,0(a5)
 7ac:	00e7e463          	bltu	a5,a4,7b4 <free+0x3a>
 7b0:	00e6ea63          	bltu	a3,a4,7c4 <free+0x4a>
{
 7b4:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b6:	fed7fae3          	bgeu	a5,a3,7aa <free+0x30>
 7ba:	6398                	ld	a4,0(a5)
 7bc:	00e6e463          	bltu	a3,a4,7c4 <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7c0:	fee7eae3          	bltu	a5,a4,7b4 <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
 7c4:	ff852583          	lw	a1,-8(a0)
 7c8:	6390                	ld	a2,0(a5)
 7ca:	02059813          	slli	a6,a1,0x20
 7ce:	01c85713          	srli	a4,a6,0x1c
 7d2:	9736                	add	a4,a4,a3
 7d4:	fae60de3          	beq	a2,a4,78e <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
 7d8:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
 7dc:	4790                	lw	a2,8(a5)
 7de:	02061593          	slli	a1,a2,0x20
 7e2:	01c5d713          	srli	a4,a1,0x1c
 7e6:	973e                	add	a4,a4,a5
 7e8:	fae68ae3          	beq	a3,a4,79c <free+0x22>
    p->s.ptr = bp->s.ptr;
 7ec:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
 7ee:	00001717          	auipc	a4,0x1
 7f2:	80f73923          	sd	a5,-2030(a4) # 1000 <freep>
}
 7f6:	6422                	ld	s0,8(sp)
 7f8:	0141                	addi	sp,sp,16
 7fa:	8082                	ret

00000000000007fc <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 7fc:	7139                	addi	sp,sp,-64
 7fe:	fc06                	sd	ra,56(sp)
 800:	f822                	sd	s0,48(sp)
 802:	f426                	sd	s1,40(sp)
 804:	ec4e                	sd	s3,24(sp)
 806:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 808:	02051493          	slli	s1,a0,0x20
 80c:	9081                	srli	s1,s1,0x20
 80e:	04bd                	addi	s1,s1,15
 810:	8091                	srli	s1,s1,0x4
 812:	0014899b          	addiw	s3,s1,1
 816:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
 818:	00000517          	auipc	a0,0x0
 81c:	7e853503          	ld	a0,2024(a0) # 1000 <freep>
 820:	c915                	beqz	a0,854 <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 822:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 824:	4798                	lw	a4,8(a5)
 826:	08977a63          	bgeu	a4,s1,8ba <malloc+0xbe>
 82a:	f04a                	sd	s2,32(sp)
 82c:	e852                	sd	s4,16(sp)
 82e:	e456                	sd	s5,8(sp)
 830:	e05a                	sd	s6,0(sp)
  if(nu < 4096)
 832:	8a4e                	mv	s4,s3
 834:	0009871b          	sext.w	a4,s3
 838:	6685                	lui	a3,0x1
 83a:	00d77363          	bgeu	a4,a3,840 <malloc+0x44>
 83e:	6a05                	lui	s4,0x1
 840:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
 844:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 848:	00000917          	auipc	s2,0x0
 84c:	7b890913          	addi	s2,s2,1976 # 1000 <freep>
  if(p == SBRK_ERROR)
 850:	5afd                	li	s5,-1
 852:	a081                	j	892 <malloc+0x96>
 854:	f04a                	sd	s2,32(sp)
 856:	e852                	sd	s4,16(sp)
 858:	e456                	sd	s5,8(sp)
 85a:	e05a                	sd	s6,0(sp)
    base.s.ptr = freep = prevp = &base;
 85c:	00000797          	auipc	a5,0x0
 860:	7b478793          	addi	a5,a5,1972 # 1010 <base>
 864:	00000717          	auipc	a4,0x0
 868:	78f73e23          	sd	a5,1948(a4) # 1000 <freep>
 86c:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
 86e:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
 872:	b7c1                	j	832 <malloc+0x36>
        prevp->s.ptr = p->s.ptr;
 874:	6398                	ld	a4,0(a5)
 876:	e118                	sd	a4,0(a0)
 878:	a8a9                	j	8d2 <malloc+0xd6>
  hp->s.size = nu;
 87a:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
 87e:	0541                	addi	a0,a0,16
 880:	efbff0ef          	jal	77a <free>
  return freep;
 884:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
 888:	c12d                	beqz	a0,8ea <malloc+0xee>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88a:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
 88c:	4798                	lw	a4,8(a5)
 88e:	02977263          	bgeu	a4,s1,8b2 <malloc+0xb6>
    if(p == freep)
 892:	00093703          	ld	a4,0(s2)
 896:	853e                	mv	a0,a5
 898:	fef719e3          	bne	a4,a5,88a <malloc+0x8e>
  p = sbrk(nu * sizeof(Header));
 89c:	8552                	mv	a0,s4
 89e:	a47ff0ef          	jal	2e4 <sbrk>
  if(p == SBRK_ERROR)
 8a2:	fd551ce3          	bne	a0,s5,87a <malloc+0x7e>
        return 0;
 8a6:	4501                	li	a0,0
 8a8:	7902                	ld	s2,32(sp)
 8aa:	6a42                	ld	s4,16(sp)
 8ac:	6aa2                	ld	s5,8(sp)
 8ae:	6b02                	ld	s6,0(sp)
 8b0:	a03d                	j	8de <malloc+0xe2>
 8b2:	7902                	ld	s2,32(sp)
 8b4:	6a42                	ld	s4,16(sp)
 8b6:	6aa2                	ld	s5,8(sp)
 8b8:	6b02                	ld	s6,0(sp)
      if(p->s.size == nunits)
 8ba:	fae48de3          	beq	s1,a4,874 <malloc+0x78>
        p->s.size -= nunits;
 8be:	4137073b          	subw	a4,a4,s3
 8c2:	c798                	sw	a4,8(a5)
        p += p->s.size;
 8c4:	02071693          	slli	a3,a4,0x20
 8c8:	01c6d713          	srli	a4,a3,0x1c
 8cc:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
 8ce:	0137a423          	sw	s3,8(a5)
      freep = prevp;
 8d2:	00000717          	auipc	a4,0x0
 8d6:	72a73723          	sd	a0,1838(a4) # 1000 <freep>
      return (void*)(p + 1);
 8da:	01078513          	addi	a0,a5,16
  }
}
 8de:	70e2                	ld	ra,56(sp)
 8e0:	7442                	ld	s0,48(sp)
 8e2:	74a2                	ld	s1,40(sp)
 8e4:	69e2                	ld	s3,24(sp)
 8e6:	6121                	addi	sp,sp,64
 8e8:	8082                	ret
 8ea:	7902                	ld	s2,32(sp)
 8ec:	6a42                	ld	s4,16(sp)
 8ee:	6aa2                	ld	s5,8(sp)
 8f0:	6b02                	ld	s6,0(sp)
 8f2:	b7f5                	j	8de <malloc+0xe2>

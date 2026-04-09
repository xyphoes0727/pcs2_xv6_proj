# File System Exploration in xv6

## Introduction
This project focuses on understanding the internal working of the xv6 file system and extending it by adding a new system call. The aim of this assignment is to study how files and directories are managed in xv6 and to implement a system call that returns useful information about the file system.

---

## System Overview
The xv6 file system is based on a Unix-like design. It uses inodes to represent files and directories. Each inode contains metadata such as file type, size, and addresses of data blocks. The actual file data is stored in disk blocks, and directories are implemented as special files that map file names to inode numbers.

The system consists of:
- Inodes → store metadata of files
- Data blocks → store actual file content
- Directories → map file names to inode numbers
- Bitmap → keeps track of free and allocated disk blocks

---

## Part A: Understanding the File System

### Inode Structure
The inode structure is defined in `fs.h`. It stores important information such as:
- File type (file, directory, device)
- File size
- Number of links
- Addresses of data blocks

It is important to note that inode does not store the file name. File names are stored in directory entries.

---

### File Size and Data Blocks
The file size is stored in the `size` field of the inode. The `addrs[]` array stores the addresses of the data blocks. These include direct block pointers and one indirect pointer for larger files.

---

### Directory Structure
Directories are implemented as special files. Each directory contains entries that map:
- File name → inode number

This allows the system to locate the actual file using its inode.

---

### System Call Flow (open)
When a file is opened:
1. The user program calls `open()`
2. The kernel handles it in `sys_open()`
3. Path is resolved using `namei()`
4. Inode is loaded using `iget()`
5. A file descriptor is returned

---

## Part B: Implementation of File System Information System Call

### Objective
A new system call `fsinfo()` is implemented to return:
- Total number of inodes
- Number of files
- Number of directories
- Number of free disk blocks

---

### 1. New Structure Definition

A new structure is created to store file system information.

**File:** `fsinfo.h`

It contains:
- total_inodes
- files
- directories
- free_blocks

---

### 2. System Call Implementation

File: `sysfile.c`

A new function is added which:
- Traverses the inode table
- Counts active inodes
- Differentiates between files and directories
- Scans the bitmap to count free disk blocks

The inode traversal is done using `iget()` and `iput()` functions.  
The bitmap is scanned block by block to check whether a block is free or allocated.

---

### 3. System Call Registration

The system call is integrated into the xv6 system by:

- Adding a syscall number in `syscall.h`
- Adding entry in syscall table in `syscall.c`
- Declaring the function in `user.h`
- Adding syscall entry in `usys.S`

---

## Part C: User Program

A user program is created to call the system call and display the results.

File: `fsinfo.c`

The program:
- Calls `fsinfo()`
- Receives the structure
- Prints all values in readable format

---

## Working of the Implementation

When the user runs the `fsinfo` program:
1. The user program calls the system call
2. The request goes to the kernel
3. The kernel function collects file system data
4. Data is copied back to user space using `copyout()`
5. The user program prints the results

---

## Testing

The implementation was tested using different scenarios:

1. Running immediately after boot  
   → shows initial file system state  

2. After creating files and directories  
   → number of files and directories increased  
   → free blocks decreased  

3. After deleting files  
   → free blocks increased  

The results were consistent with expected behavior.

---

## Limitations

- The inode table is scanned completely, which is not efficient  
- No caching mechanism is used  
- Only basic information is returned  
- Performance may degrade for larger file systems  

---

## Conclusion

This assignment helped in understanding the working of a file system at a low level. It provided practical knowledge about inodes, directories, and disk block management. Implementing a system call also helped in understanding how user programs interact with the kernel. Overall, this project was useful in learning operating system internals and file system design.
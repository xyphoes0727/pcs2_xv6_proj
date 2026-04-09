#define T_DIR     1   // Directory
#define T_FILE    2   // File
#define T_DEVICE  3   // Device

struct stat {
  int dev;     // File system's disk device
  uint ino;    // Inode number
  short type;  // Type of file
  short nlink; // Number of links to file2
  uint64 size; // Size of file in bytes
};

// !!! we added this
// This is a struct we'll use to store the fs info we got from the
// function defined in sysproc.c 
struct fsinfo {
  int total_files;
  int total_dirs;
  int total_inodes;
  int free_blocks;
};
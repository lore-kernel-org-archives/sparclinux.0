From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 04 Dec 2004 05:22:33 +0000
Subject: mmap breakage
Message-Id: <Pine.LNX.4.61.0412032354010.1963@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

In Debian we have recently received a number of bug reports [0,1] about 
glibc's ld-linux.so.2 failing (when called via ldd, for example) on some 
binaries. The minimum test case, originally mentioned in [0], was the 
following:

char a[134084860];
int main() { return 0; }

Running the compiled binary under strace on my Ultra1 with 2.6.8 
(same issue is expected to be present for 2.4.x) kernel results in

kundera:~# strace /usr/lib/debug/ld-linux.so.2 ./a.out
execve("/usr/lib/debug/ld-linux.so.2", ["/usr/lib/debug/ld-linux.so.2", "./a.out"], [/* 22 vars */]) = 0
uname({sys="Linux", node="kundera", ...}) = 0
brk(0)                                  = 0x802a000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("./a.out", O_RDONLY)               = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\2\0\2\0\0\0\1\0\1\3P"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size133, ...}) = 0
getcwd("/root", 128)                    = 6
mmap(0x10000, 8192, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x10000
mmap(0x20000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x20000
mmap(0x24000, 134077000, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x24000
close(3)                                = 0
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
--- SIGILL (Illegal instruction) @ 0 (0) ---
+++ killed by SIGILL +++

After some debugging I was able to trace the problem to the last mmap 
syscall. It actually manages to overwrite a portion of the ld-linux.so.2 
code, causing the SIGILL. Presumably, this happens due to rounding of the 
size of mmaped chunk upwards to the next full page of 8K, which
is performed in sys_mmap (arch/sparc64/kernel/sys_sparc.c). In my case 
that increased the size of mmapped region from 134077000 to 134078464, so 
that the occupied region of memory extended all the way to 0x8002000
(0x24000 + 134078464). However, according to gdb, the function 
_dl_start_user (where SIGILL actually happens) have been previously 
located at the address 0x8001cac, and so was obliterated by this syscall.

Unfortunately, I don't have a clear idea on how the mmap's memory 
management is supposed to work, so I would appreciate any clues, which 
could lead to a solution.

[0] http://bugs.debian.org/268450
[1] http://lists.debian.org/debian-sparc/2004/12/msg00009.html

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

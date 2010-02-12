From: Laszlo Valko <valko@linux.karinthy.hu>
Date: Fri, 12 Feb 2010 00:47:18 +0000
Subject: strace problem on sparc
Message-Id: <20100212014718.A1980@linux.karinthy.hu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi all!

I don't know if this has been reported by somebody else but seeing the
stack frame problem, I'll give it a try :)

Basically my problem is that with my new Linux running 2.6.32 on a V210
I cannot use strace to follow clone() calls. It does work on x86 with the
same kernel and it does work on sparc with older (2.4) kernels on another
machine.

Here's a small test case:

root@qwer:~>uname -a
Linux qwer 2.4.36.2-grsec #1 Tue Mar 18 16:58:28 MET 2008 sparc64 unknown unknown GNU/Linux
root@qwer:~>mkdir /tmp/a; cd /tmp/a; touch x y
root@qwer:/tmp/a>ls;ls
x  y
x  y
root@qwer:/tmp/a>bash -c "ls;ls"
x  y
x  y
root@qwer:/tmp/a>strace -fvo /tmp/log.2.4.36 bash -c "ls;ls"
Process 20081 attached
Process 20080 suspended
x  y
Process 20080 resumed
Process 20081 detached
Process 20082 attached
Process 20080 suspended
x  y
Process 20080 resumed
Process 20082 detached
root@qwer:/tmp/a>

worked as expected.

Now the same on my new Linux:

root@@qwer:~>uname -a
Linux qwer 2.6.32-hardened #4 SMP PREEMPT Mon Dec 28 23:54:13 CET 2009 sparc64 sun4u TI UltraSparc IIIi (Jalapeno) GNU/Linux
root@@qwer:~>mkdir /tmp/a; cd /tmp/a; touch x y
root@@qwer:/tmp/a>ls;ls
x  y
x  y
root@@qwer:/tmp/a>bash -c "ls;ls"
x  y
x  y
root@@qwer:/tmp/a>strace -fvo /tmp/log.2.6.32 bash -c "ls;ls"
x  y
.... here it waits forever

in another session, relevant part of ps ajx:
 5745 29315 29315  5745 pts/2    29315 S+       0   0:00 strace -fvo /tmp/log ba
29315 29316 29315  5745 pts/2    29315 T+       0   0:00 bash -c ls;ls
29316 29317 29315  5745 pts/2    29315 Z+       0   0:00 [ls] <defunct>

then trying to stop it:
kill -9 29316

resume: ptrace(PTRACE_SYSCALL, ...): No such process
root@@qwer:/tmp/a>

The attachments are the two strace logs.

Thanks for any help,
Laszlo

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.2.4.36"

20080 execve("/bin/bash", ["bash", "-c", "ls;ls"], [/* 38 vars */]) = 0
20080 brk(0)                            = 0x9f430
20080 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001a000
20080 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
20080 open("/etc/ld.so.cache", O_RDONLY) = 3
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=361422, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=32, st_size=14554, st_atime=2010/02/12-00:24:27, st_mtime=2009/07/19-20:23:55, st_ctime=2009/07/19-20:23:55}) = 0
20080 mmap(NULL, 14554, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7001c000
20080 close(3)                          = 0
20080 open("/usr/lib/libreadline.so.4", O_RDONLY) = 3
20080 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0\304"..., 1024) = 1024
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=426173, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=472, st_size=237278, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/23-21:52:00, st_ctime=2003/01/02-16:52:42}) = 0
20080 mmap(NULL, 269416, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x7002c000
20080 mprotect(0x7005a000, 81000, PROT_NONE) = 0
20080 mmap(0x7005c000, 73728, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x20000) = 0x7005c000
20080 close(3)                          = 0
20080 open("/usr/lib/libhistory.so.4", O_RDONLY) = 3
20080 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0\27"..., 1024) = 1024
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=426169, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=72, st_size=33569, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/23-21:52:00, st_ctime=2003/01/02-16:52:42}) = 0
20080 mmap(NULL, 91280, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x70070000
20080 mprotect(0x70076000, 66704, PROT_NONE) = 0
20080 mmap(0x70080000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x70080000
20080 close(3)                          = 0
20080 open("/usr/lib/libncurses.so.5", O_RDONLY) = 3
20080 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\1!\274"..., 1024) = 1024
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=426118, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=648, st_size=325906, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-17:07:58, st_ctime=2003/01/02-16:52:41}) = 0
20080 mmap(NULL, 359232, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x70088000
20080 mprotect(0x700c8000, 97088, PROT_NONE) = 0
20080 mmap(0x700c8000, 98304, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x30000) = 0x700c8000
20080 close(3)                          = 0
20080 open("/lib/libdl.so.2", O_RDONLY) = 3
20080 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0\33"..., 1024) = 1024
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=245813, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=112, st_size=51869, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:39:53, st_ctime=2003/01/02-16:52:33}) = 0
20080 mmap(NULL, 74560, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x700e0000
20080 mprotect(0x700e2000, 66368, PROT_NONE) = 0
20080 mmap(0x700f0000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x700f0000
20080 close(3)                          = 0
20080 open("/lib/libc.so.6", O_RDONLY)  = 3
20080 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\1\311"..., 1024) = 1024
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=245808, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=21792, st_size=11137589, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:32, st_ctime=2003/01/02-16:52:33}) = 0
20080 mmap(NULL, 1368816, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x700f4000
20080 mprotect(0x7022a000, 99056, PROT_NONE) = 0
20080 mmap(0x70234000, 49152, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0x70234000
20080 mmap(0x70240000, 8944, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x70240000
20080 close(3)                          = 0
20080 munmap(0x7001c000, 14554)         = 0
20080 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
20080 open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
20080 close(3)                          = 0
20080 brk(0)                            = 0x9f430
20080 brk(0xa1430)                      = 0xa1430
20080 brk(0xa2000)                      = 0xa2000
20080 getuid()                          = 0
20080 getgid()                          = 0
20080 geteuid()                         = 0
20080 getegid()                         = 0
20080 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
20080 gettimeofday({1265930667, 519801}, NULL) = 0
20080 open("/etc/mtab", O_RDONLY)       = 3
20080 fstat(3, {st_dev=makedev(8, 1), st_ino=361380, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=136, st_atime=2010/02/12-00:24:10, st_mtime=2009/07/27-01:40:34, st_ctime=2009/07/27-01:40:34}) = 0
20080 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001c000
20080 read(3, "/dev/sda1 / ext3 rw 0 0\nnone /pr"..., 8192) = 136
20080 close(3)                          = 0
20080 munmap(0x7001c000, 8192)          = 0
20080 open("/proc/meminfo", O_RDONLY)   = 3
20080 fstat(3, {st_dev=makedev(0, 2), st_ino=4098, st_mode=S_IFREG|0444, st_nlink=1, st_uid=0, st_gid=80, st_blksize=8192, st_blocks=0, st_size=0, st_atime=2010/02/12-00:24:27, st_mtime=2010/02/12-00:24:27, st_ctime=2010/02/12-00:24:27}) = 0
20080 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001c000
20080 read(3, "        total:    used:    free:"..., 8192) = 524
20080 close(3)                          = 0
20080 munmap(0x7001c000, 8192)          = 0
20080 rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
20080 rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 uname({sysname="Linux", nodename="qwer", release="2.4.36.2-grsec", version="#1 Tue Mar 18 16:58:28 MET 2008", machine="sparc64"}) = 0
20080 stat("/tmp/a", {st_dev=makedev(8, 1), st_ino=132371, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=4096, st_atime=2010/02/12-00:24:10, st_mtime=2010/02/12-00:23:10, st_ctime=2010/02/12-00:23:10}) = 0
20080 stat(".", {st_dev=makedev(8, 1), st_ino=132371, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=4096, st_atime=2010/02/12-00:24:10, st_mtime=2010/02/12-00:23:10, st_ctime=2010/02/12-00:23:10}) = 0
20080 getpid()                          = 20080
20080 getppid()                         = 20079
20080 stat(".", {st_dev=makedev(8, 1), st_ino=132371, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=4096, st_atime=2010/02/12-00:24:10, st_mtime=2010/02/12-00:23:10, st_ctime=2010/02/12-00:23:10}) = 0
20080 stat("/bin/bash", {st_dev=makedev(8, 1), st_ino=131074, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=992, st_size=501416, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/23-21:56:30, st_ctime=2003/01/02-16:52:23}) = 0
20080 stat("/bin/bash", {st_dev=makedev(8, 1), st_ino=131074, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=992, st_size=501416, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/23-21:56:30, st_ctime=2003/01/02-16:52:23}) = 0
20080 getpgrp(0x32434)                  = 20079
20080 rt_sigaction(SIGCHLD, {0x3b89c, [], 0}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 brk(0xa4000)                      = 0xa4000
20080 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
20080 getpeername(0, 0xeffff578, [16])  = -1 ENOTSOCK (Socket operation on non-socket)
20080 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
20080 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
20080 stat(".", {st_dev=makedev(8, 1), st_ino=132371, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=4096, st_atime=2010/02/12-00:24:10, st_mtime=2010/02/12-00:23:10, st_ctime=2010/02/12-00:23:10}) = 0
20080 stat("/bin/ls", {st_dev=makedev(8, 1), st_ino=131098, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=144, st_size=68976, st_atime=2010/02/12-00:24:10, st_mtime=2002/11/24-12:31:32, st_ctime=2003/01/02-16:52:23}) = 0
20080 stat("/bin/ls", {st_dev=makedev(8, 1), st_ino=131098, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=144, st_size=68976, st_atime=2010/02/12-00:24:10, st_mtime=2002/11/24-12:31:32, st_ctime=2003/01/02-16:52:23}) = 0
20080 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
20080 fork()                            = 20081
20080 rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
20081 getpid( <unfinished ...>
20080 <... rt_sigprocmask resumed> NULL, 8) = 0
20081 <... getpid resumed> )            = 20081
20080 rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
20081 rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
20080 <... rt_sigprocmask resumed> [], 8) = 0
20081 <... rt_sigprocmask resumed> NULL, 8) = 0
20080 rt_sigprocmask(SIG_SETMASK, [],  <unfinished ...>
20081 rt_sigaction(SIGTSTP, {SIG_DFL},  <unfinished ...>
20080 <... rt_sigprocmask resumed> NULL, 8) = 0
20081 <... rt_sigaction resumed> {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigprocmask(SIG_BLOCK, [CHLD],  <unfinished ...>
20081 rt_sigaction(SIGTTIN, {SIG_DFL},  <unfinished ...>
20080 <... rt_sigprocmask resumed> [], 8) = 0
20081 <... rt_sigaction resumed> {SIG_DFL}, 0x70126ff0, 8) = 0
20080 rt_sigaction(SIGINT, {0x3a6f8, [], 0},  <unfinished ...>
20081 rt_sigaction(SIGTTOU, {SIG_DFL},  <unfinished ...>
20080 <... rt_sigaction resumed> {SIG_DFL}, 0x70126ff0, 8) = 0
20081 <... rt_sigaction resumed> {SIG_DFL}, 0x70126ff0, 8) = 0
20080 wait4(-1,  <unfinished ...>
20081 rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20081 rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_IGN}, 0x70126ff0, 8) = 0
20081 rt_sigaction(SIGCHLD, {SIG_DFL}, {0x3b89c, [], 0}, 0x70126ff0, 8) = 0
20081 execve("/bin/ls", ["ls"], ["SITENAME=x", "NNTPSERVER=x", "MANPATH=/usr/man:/usr/local/man:"..., "HOSTNAME=qwer", "HOST=qwer", "SHELL=/bin/tcsh", "TERM=screen", "SSH_CLIENT=192.18.8.1 31504 22", "SSH_TTY=/dev/pts/1", "http_proxy=http://qwer:3128/", "GROUP=root", "USER=root", "OPENWINHOME=/usr/X11R6", "HOSTTYPE=sparc", "TERMCAP=SC|screen|VT 100/ANSI X3"..., "ftp_proxy=http://qwer:3128/", "MAIL=/root/Mailbox", "PATH=/bin:/sbin:/usr/bin:/usr/sb"..., "STY=13955.pts-1.qwer", "PWD=/tmp/a", "JAVA_HOME=/usr/java", "I_WANT_A_BROKEN_PS=", "EDITOR=joe", "https_proxy=http://qwer:3128/", "SHLVL=3", "HOME=/root", "OSTYPE=linux", "no_proxy=qwer localhost", "LS_OPTIONS=-F -T 0", "VENDOR=unknown", "LESS=-iRS", "MACHTYPE=sparc", "LOGNAME=root", "WINDOW=4", "CLASSPATH=/usr/local/lib/netscap"..., "SSH_CONNECTION=192.18.8.1 31504 "..., "MOZILLA_HOME=/usr/local/lib/nets"..., "NPX_PLUGIN_PATH=/usr/local/lib/n"..., "_=/bin/ls"]) = 0
20081 brk(0)                            = 0x20988
20081 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001a000
20081 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
20081 open("/etc/ld.so.cache", O_RDONLY) = 3
20081 fstat(3, {st_dev=makedev(8, 1), st_ino=361422, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=32, st_size=14554, st_atime=2010/02/12-00:24:27, st_mtime=2009/07/19-20:23:55, st_ctime=2009/07/19-20:23:55}) = 0
20081 mmap(NULL, 14554, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7001c000
20081 close(3)                          = 0
20081 open("/lib/librt.so.1", O_RDONLY) = 3
20081 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0\33"..., 1024) = 1024
20081 fstat(3, {st_dev=makedev(8, 1), st_ino=245821, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=600, st_size=302281, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:23, st_ctime=2003/01/02-16:52:33}) = 0
20081 mmap(NULL, 135056, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x7002c000
20081 mprotect(0x70032000, 110480, PROT_NONE) = 0
20081 mmap(0x7003c000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x7003c000
20081 mmap(0x70044000, 36752, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x70044000
20081 close(3)                          = 0
20081 open("/lib/libc.so.6", O_RDONLY)  = 3
20081 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\1\311"..., 1024) = 1024
20081 fstat(3, {st_dev=makedev(8, 1), st_ino=245808, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=21792, st_size=11137589, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:32, st_ctime=2003/01/02-16:52:33}) = 0
20081 mmap(NULL, 1368816, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x70050000
20081 mprotect(0x70186000, 99056, PROT_NONE) = 0
20081 mmap(0x70190000, 49152, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0x70190000
20081 mmap(0x7019c000, 8944, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7019c000
20081 close(3)                          = 0
20081 open("/lib/libpthread.so.0", O_RDONLY) = 3
20081 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0C$\0"..., 1024) = 1024
20081 fstat(3, {st_dev=makedev(8, 1), st_ino=245816, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=1408, st_size=714894, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:20, st_ctime=2003/01/02-16:52:33}) = 0
20081 mmap(NULL, 389736, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x701a0000
20081 mprotect(0x701ac000, 340584, PROT_NONE) = 0
20081 mmap(0x701b0000, 65536, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x701b0000
20081 mmap(0x701c0000, 258664, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x701c0000
20081 close(3)                          = 0
20081 munmap(0x7001c000, 14554)         = 0
20081 getpid()                          = 20081
20081 uname({sysname="Linux", nodename="qwer", release="2.4.36.2-grsec", version="#1 Tue Mar 18 16:58:28 MET 2008", machine="sparc64"}) = 0
20081 rt_sigaction(SIGRT_0, {0x701a8164, [], 0}, NULL, 0x70082ff0, 8) = 0
20081 rt_sigaction(SIGRT_1, {0x701a818c, [], 0}, NULL, 0x70082ff0, 8) = 0
20081 rt_sigaction(SIGRT_2, {0x701a82a0, [], 0}, NULL, 0x70082ff0, 8) = 0
20081 rt_sigprocmask(SIG_BLOCK, [32], NULL, 8) = 0
20081 _sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xeffff220, 31, (nil), 0}) = 0
20081 brk(0)                            = 0x20988
20081 brk(0x22988)                      = 0x22988
20081 brk(0x24000)                      = 0x24000
20081 ioctl(1, 0x40245408, {c_iflags=0x500, c_oflags=0x5, c_cflags=0xbf, c_lflags=0x8a3b, c_line=0, c_cc="\x03\x1c\x08\x15\x04\x00\x00\x00\x11\x13\x1a\x19\x12\x15\x17\x16\x01"}) = 0
20081 ioctl(1, 0x40087468, 0xeffff5e8)  = 0
20081 open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY|0x4) = -1 ENOTDIR (Not a directory)
20081 open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x4) = 3
20081 fstat(3, {st_dev=makedev(8, 1), st_ino=132371, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=4096, st_atime=2010/02/12-00:24:10, st_mtime=2010/02/12-00:23:10, st_ctime=2010/02/12-00:23:10}) = 0
20081 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
20081 brk(0x26000)                      = 0x26000
20081 getdents64(0x3, 0x23c88, 0x2000, 0x7019a110) = 96
20081 getdents64(0x3, 0x23c88, 0x2000, 0x7019a110) = 0
20081 close(3)                          = 0
20081 fstat(1, {st_dev=makedev(0, 7), st_ino=9, st_mode=S_IFCHR|0620, st_nlink=1, st_uid=0, st_gid=5, st_blksize=1024, st_blocks=0, st_rdev=makedev(136, 7), st_atime=2010/02/12-00:24:27, st_mtime=2010/02/12-00:24:27, st_ctime=2010/01/13-18:24:58}) = 0
20081 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001c000
20081 write(1, "x  y\n", 5)             = 5
20081 munmap(0x7001c000, 8192)          = 0
20081 exit(0)                           = ?
20080 <... wait4 resumed> [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 20081
20080 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
20080 --- SIGCHLD (Child exited) ---
20080 wait4(-1, 0xeffff014, WNOHANG, NULL) = -1 ECHILD (No child processes)
20080 sigreturn()                       = ? (mask now [EMT PIPE ALRM TERM TSTP TTIN LOST USR1 USR2])
20080 rt_sigaction(SIGINT, {SIG_DFL}, {0x3a6f8, [], 0}, 0x70126ff0, 8) = 0
20080 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
20080 fork()                            = 20082
20080 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
20080 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
20080 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
20080 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
20080 rt_sigaction(SIGINT, {0x3a6f8, [], 0}, {SIG_DFL}, 0x70126ff0, 8) = 0
20080 wait4(-1,  <unfinished ...>
20082 getpid()                          = 20082
20082 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
20082 rt_sigaction(SIGTSTP, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20082 rt_sigaction(SIGTTIN, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20082 rt_sigaction(SIGTTOU, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20082 rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 0x70126ff0, 8) = 0
20082 rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_IGN}, 0x70126ff0, 8) = 0
20082 rt_sigaction(SIGCHLD, {SIG_DFL}, {0x3b89c, [], 0}, 0x70126ff0, 8) = 0
20082 execve("/bin/ls", ["ls"], ["SITENAME=x", "NNTPSERVER=x", "MANPATH=/usr/man:/usr/local/man:"..., "HOSTNAME=qwer", "HOST=qwer", "SHELL=/bin/tcsh", "TERM=screen", "SSH_CLIENT=192.18.8.1 31504 22", "SSH_TTY=/dev/pts/1", "http_proxy=http://qwer:3128/", "GROUP=root", "USER=root", "OPENWINHOME=/usr/X11R6", "HOSTTYPE=sparc", "TERMCAP=SC|screen|VT 100/ANSI X3"..., "ftp_proxy=http://qwer:3128/", "MAIL=/root/Mailbox", "PATH=/bin:/sbin:/usr/bin:/usr/sb"..., "STY=13955.pts-1.qwer", "PWD=/tmp/a", "JAVA_HOME=/usr/java", "I_WANT_A_BROKEN_PS=", "EDITOR=joe", "https_proxy=http://qwer:3128/", "SHLVL=3", "HOME=/root", "OSTYPE=linux", "no_proxy=qwer localhost", "LS_OPTIONS=-F -T 0", "VENDOR=unknown", "LESS=-iRS", "MACHTYPE=sparc", "LOGNAME=root", "WINDOW=4", "CLASSPATH=/usr/local/lib/netscap"..., "SSH_CONNECTION=192.18.8.1 31504 "..., "MOZILLA_HOME=/usr/local/lib/nets"..., "NPX_PLUGIN_PATH=/usr/local/lib/n"..., "_=/bin/ls"]) = 0
20082 brk(0)                            = 0x20988
20082 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001a000
20082 open("/etc/ld.so.preload", O_RDONLY) = -1 ENOENT (No such file or directory)
20082 open("/etc/ld.so.cache", O_RDONLY) = 3
20082 fstat(3, {st_dev=makedev(8, 1), st_ino=361422, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=32, st_size=14554, st_atime=2010/02/12-00:24:27, st_mtime=2009/07/19-20:23:55, st_ctime=2009/07/19-20:23:55}) = 0
20082 mmap(NULL, 14554, PROT_READ, MAP_PRIVATE, 3, 0) = 0x7001c000
20082 close(3)                          = 0
20082 open("/lib/librt.so.1", O_RDONLY) = 3
20082 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0\33"..., 1024) = 1024
20082 fstat(3, {st_dev=makedev(8, 1), st_ino=245821, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=600, st_size=302281, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:23, st_ctime=2003/01/02-16:52:33}) = 0
20082 mmap(NULL, 135056, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x7002c000
20082 mprotect(0x70032000, 110480, PROT_NONE) = 0
20082 mmap(0x7003c000, 32768, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x7003c000
20082 mmap(0x70044000, 36752, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x70044000
20082 close(3)                          = 0
20082 open("/lib/libc.so.6", O_RDONLY)  = 3
20082 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\1\311"..., 1024) = 1024
20082 fstat(3, {st_dev=makedev(8, 1), st_ino=245808, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=21792, st_size=11137589, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:32, st_ctime=2003/01/02-16:52:33}) = 0
20082 mmap(NULL, 1368816, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x70050000
20082 mprotect(0x70186000, 99056, PROT_NONE) = 0
20082 mmap(0x70190000, 49152, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0x70190000
20082 mmap(0x7019c000, 8944, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x7019c000
20082 close(3)                          = 0
20082 open("/lib/libpthread.so.0", O_RDONLY) = 3
20082 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\2\0\0\0\1\0\0C$\0"..., 1024) = 1024
20082 fstat(3, {st_dev=makedev(8, 1), st_ino=245816, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=1408, st_size=714894, st_atime=2010/02/12-00:24:27, st_mtime=2002/11/19-16:40:20, st_ctime=2003/01/02-16:52:33}) = 0
20082 mmap(NULL, 389736, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x701a0000
20082 mprotect(0x701ac000, 340584, PROT_NONE) = 0
20082 mmap(0x701b0000, 65536, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x701b0000
20082 mmap(0x701c0000, 258664, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x701c0000
20082 close(3)                          = 0
20082 munmap(0x7001c000, 14554)         = 0
20082 getpid()                          = 20082
20082 uname({sysname="Linux", nodename="qwer", release="2.4.36.2-grsec", version="#1 Tue Mar 18 16:58:28 MET 2008", machine="sparc64"}) = 0
20082 rt_sigaction(SIGRT_0, {0x701a8164, [], 0}, NULL, 0x70082ff0, 8) = 0
20082 rt_sigaction(SIGRT_1, {0x701a818c, [], 0}, NULL, 0x70082ff0, 8) = 0
20082 rt_sigaction(SIGRT_2, {0x701a82a0, [], 0}, NULL, 0x70082ff0, 8) = 0
20082 rt_sigprocmask(SIG_BLOCK, [32], NULL, 8) = 0
20082 _sysctl({{CTL_KERN, KERN_VERSION}, 2, 0xeffff220, 31, (nil), 0}) = 0
20082 brk(0)                            = 0x20988
20082 brk(0x22988)                      = 0x22988
20082 brk(0x24000)                      = 0x24000
20082 ioctl(1, 0x40245408, {c_iflags=0x500, c_oflags=0x5, c_cflags=0xbf, c_lflags=0x8a3b, c_line=0, c_cc="\x03\x1c\x08\x15\x04\x00\x00\x00\x11\x13\x1a\x19\x12\x15\x17\x16\x01"}) = 0
20082 ioctl(1, 0x40087468, 0xeffff5e8)  = 0
20082 open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY|0x4) = -1 ENOTDIR (Not a directory)
20082 open(".", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x4) = 3
20082 fstat(3, {st_dev=makedev(8, 1), st_ino=132371, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=8, st_size=4096, st_atime=2010/02/12-00:24:27, st_mtime=2010/02/12-00:23:10, st_ctime=2010/02/12-00:23:10}) = 0
20082 fcntl(3, F_SETFD, FD_CLOEXEC)     = 0
20082 brk(0x26000)                      = 0x26000
20082 getdents64(0x3, 0x23c88, 0x2000, 0x7019a110) = 96
20082 getdents64(0x3, 0x23c88, 0x2000, 0x7019a110) = 0
20082 close(3)                          = 0
20082 fstat(1, {st_dev=makedev(0, 7), st_ino=9, st_mode=S_IFCHR|0620, st_nlink=1, st_uid=0, st_gid=5, st_blksize=1024, st_blocks=0, st_rdev=makedev(136, 7), st_atime=2010/02/12-00:24:27, st_mtime=2010/02/12-00:24:27, st_ctime=2010/01/13-18:24:58}) = 0
20082 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7001c000
20082 write(1, "x  y\n", 5)             = 5
20082 munmap(0x7001c000, 8192)          = 0
20082 exit(0)                           = ?
20080 <... wait4 resumed> [WIFEXITED(s) && WEXITSTATUS(s) == 0], 0, NULL) = 20082
20080 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
20080 --- SIGCHLD (Child exited) ---
20080 wait4(-1, 0xeffff07c, WNOHANG, NULL) = -1 ECHILD (No child processes)
20080 sigreturn()                       = ? (mask now [EMT PIPE ALRM TERM TSTP TTIN LOST USR1 USR2])
20080 rt_sigaction(SIGINT, {SIG_DFL}, {0x3a6f8, [], 0}, 0x70126ff0, 8) = 0
20080 exit(0)                           = ?

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="log.2.6.32"

29316 execve("/bin/bash", ["bash", "-c", "ls;ls"], ["USER=root", "LOGNAME=root", "HOME=/root", "PATH=/usr/local/sbin:/usr/local/"..., "MAIL=/var/mail/root", "SHELL=/bin/tcsh", "SSH_CLIENT=172.17.0.1 16595 22", "SSH_CONNECTION=172.17.0.1 16595 "..., "SSH_TTY=/dev/pts/2", "TERM=screen", "HOSTTYPE=sparc", "VENDOR=unknown", "OSTYPE=linux", "MACHTYPE=sparc", "SHLVL=1", "PWD=/tmp/a", "GROUP=root", "HOST=qwer", "REMOTEHOST=qwer", "LS_COLORS=rs=0:di=01;34:ln=01;36"..., "CONFIG_PROTECT=/var/bind", "CONFIG_PROTECT_MASK=/etc/sandbox"..., "CVS_RSH=ssh", "EDITOR=/usr/bin/joe", "GCC_SPECS=", "INFOPATH=/usr/share/info:/usr/sh"..., "LESS=-R -M --shift 5", "LESSOPEN=|lesspipe.sh %s", "MANPATH=/usr/local/share/man:/us"..., "PAGER=/usr/bin/less", "INPUTRC=/etc/inputrc"]) = 0
29316 brk(0)                            = 0xed408
29316 uname({sysname="Linux", nodename="qwer", release="2.6.32-hardened", version="#4 SMP PREEMPT Mon Dec 28 23:54:13 CET 2009", machine="sparc64"}) = 0
29316 access("/etc/ld.so.preload", R_OK) = -1 ENOENT (No such file or directory)
29316 open("/etc/ld.so.cache", O_RDONLY) = 3
29316 fstat64(3, {st_dev=makedev(253, 3), st_ino=17295659, st_mode=S_IFREG|0644, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=64, st_size=31239, st_atime=2010/01/20-10:34:20, st_mtime=2010/01/20-10:34:20, st_ctime=2010/01/20-10:34:20}) = 0
29316 mmap(NULL, 31239, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7fbc000
29316 close(3)                          = 0
29316 open("/lib/libncurses.so.5", O_RDONLY) = 3
29316 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1G\240\0\0\0004\0"..., 512) = 512
29316 fstat64(3, {st_dev=makedev(253, 3), st_ino=253, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=640, st_size=327476, st_atime=2010/01/18-23:50:54, st_mtime=2009/12/05-19:06:42, st_ctime=2009/12/05-19:11:21}) = 0
29316 mmap(NULL, 393728, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f30000
29316 mprotect(0xf7f76000, 65536, PROT_NONE) = 0
29316 mmap(0xf7f86000, 40960, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x46000) = 0xf7f86000
29316 mmap(0xf7f90000, 512, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f90000
29316 close(3)                          = 0
29316 open("/lib/libdl.so.2", O_RDONLY) = 3
29316 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\v\240\0\0\0004\0"..., 512) = 512
29316 fstat64(3, {st_dev=makedev(253, 3), st_ino=1276891, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=40, st_size=18132, st_atime=2010/01/18-23:50:54, st_mtime=2009/12/07-06:01:50, st_ctime=2009/12/07-06:06:10}) = 0
29316 mmap(NULL, 82424, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f18000
29316 mprotect(0xf7f1c000, 57344, PROT_NONE) = 0
29316 mmap(0xf7f2a000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf7f2a000
29316 close(3)                          = 0
29316 open("/lib/libc.so.6", O_RDONLY)  = 3
29316 read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\376\300\0\0\0004\0"..., 512) = 512
29316 fstat64(3, {st_dev=makedev(253, 3), st_ino=1085720, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=2856, st_size=1460204, st_atime=2010/01/18-23:50:53, st_mtime=2009/12/07-06:01:50, st_ctime=2009/12/07-06:06:10}) = 0
29316 mmap(NULL, 1530200, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7da0000
29316 mprotect(0xf7efe000, 65536, PROT_NONE) = 0
29316 mmap(0xf7f0e000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x15e000) = 0xf7f0e000
29316 mmap(0xf7f14000, 6488, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f14000
29316 close(3)                          = 0
29316 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fca000
29316 mprotect(0xf7f0e000, 8192, PROT_READ) = 0
29316 mprotect(0xf7f2a000, 8192, PROT_READ) = 0
29316 mprotect(0xf7f86000, 32768, PROT_READ) = 0
29316 mprotect(0xe2000, 8192, PROT_READ) = 0
29316 mprotect(0xf7fc6000, 8192, PROT_READ) = 0
29316 munmap(0xf7fbc000, 31239)         = 0
29316 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
29316 open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
29316 close(3)                          = 0
29316 brk(0)                            = 0xed408
29316 brk(0x10f408)                     = 0x10f408
29316 brk(0x110000)                     = 0x110000
29316 getuid32()                        = 0
29316 getgid32()                        = 0
29316 geteuid32()                       = 0
29316 getegid32()                       = 0
29316 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
29316 time(NULL)                        = 1265930834
29316 open("/proc/meminfo", O_RDONLY)   = 3
29316 fstat64(3, {st_dev=makedev(0, 3), st_ino=4026531967, st_mode=S_IFREG|0444, st_nlink=1, st_uid=0, st_gid=0, st_blksize=1024, st_blocks=0, st_size=0, st_atime=2010/02/12-00:27:14, st_mtime=2010/02/12-00:27:14, st_ctime=2010/02/12-00:27:14}) = 0
29316 mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fc4000
29316 read(3, "MemTotal:        2060032 kB\nMemFr"..., 1024) = 956
29316 close(3)                          = 0
29316 munmap(0xf7fc4000, 8192)          = 0
29316 brk(0x10e000)                     = 0x10e000
29316 rt_sigaction(SIGCHLD, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 rt_sigaction(SIGCHLD, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 rt_sigaction(SIGINT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 rt_sigaction(SIGQUIT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 rt_sigaction(SIGQUIT, {SIG_DFL, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
29316 rt_sigaction(SIGQUIT, {0x1, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 uname({sysname="Linux", nodename="qwer", release="2.6.32-hardened", version="#4 SMP PREEMPT Mon Dec 28 23:54:13 CET 2009", machine="sparc64"}) = 0
29316 stat64("/tmp/a", {st_dev=makedev(0, 13), st_ino=72243, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=0, st_size=80, st_atime=2010/02/12-00:25:13, st_mtime=2010/02/12-00:25:10, st_ctime=2010/02/12-00:25:10}) = 0
29316 stat64(".", {st_dev=makedev(0, 13), st_ino=72243, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=0, st_size=80, st_atime=2010/02/12-00:25:13, st_mtime=2010/02/12-00:25:10, st_ctime=2010/02/12-00:25:10}) = 0
29316 getpid()                          = 29316
29316 getppid()                         = 29315
29316 stat64(".", {st_dev=makedev(0, 13), st_ino=72243, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=0, st_size=80, st_atime=2010/02/12-00:25:13, st_mtime=2010/02/12-00:25:10, st_ctime=2010/02/12-00:25:10}) = 0
29316 stat64("/usr/local/sbin/bash", 0xff8ccf88) = -1 ENOENT (No such file or directory)
29316 stat64("/usr/local/bin/bash", 0xff8ccf88) = -1 ENOENT (No such file or directory)
29316 stat64("/usr/sbin/bash", 0xff8ccf88) = -1 ENOENT (No such file or directory)
29316 stat64("/usr/bin/bash", 0xff8ccf88) = -1 ENOENT (No such file or directory)
29316 stat64("/sbin/bash", 0xff8ccf88)  = -1 ENOENT (No such file or directory)
29316 stat64("/bin/bash", {st_dev=makedev(253, 3), st_ino=8388856, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=1616, st_size=823524, st_atime=2010/01/18-23:50:54, st_mtime=2009/12/08-01:29:01, st_ctime=2009/12/08-01:29:07}) = 0
29316 stat64("/bin/bash", {st_dev=makedev(253, 3), st_ino=8388856, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=1616, st_size=823524, st_atime=2010/01/18-23:50:54, st_mtime=2009/12/08-01:29:01, st_ctime=2009/12/08-01:29:07}) = 0
29316 gettimeofday({1265930834, 525030}, NULL) = 0
29316 getpgrp()                         = 29315
29316 rt_sigaction(SIGCHLD, {0x4e640, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4294967295) = 0
29316 getrlimit(RLIMIT_NPROC, {rlim_cur=8034, rlim_max=8034}) = 0
29316 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
29316 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
29316 rt_sigprocmask(SIG_BLOCK, NULL, [], 8) = 0
29316 stat64(".", {st_dev=makedev(0, 13), st_ino=72243, st_mode=S_IFDIR|0755, st_nlink=2, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=0, st_size=80, st_atime=2010/02/12-00:25:13, st_mtime=2010/02/12-00:25:10, st_ctime=2010/02/12-00:25:10}) = 0
29316 stat64("/usr/local/sbin/ls", 0xff8cce08) = -1 ENOENT (No such file or directory)
29316 stat64("/usr/local/bin/ls", 0xff8cce08) = -1 ENOENT (No such file or directory)
29316 stat64("/usr/sbin/ls", 0xff8cce08) = -1 ENOENT (No such file or directory)
29316 stat64("/usr/bin/ls", 0xff8cce08) = -1 ENOENT (No such file or directory)
29316 stat64("/sbin/ls", 0xff8cce08)    = -1 ENOENT (No such file or directory)
29316 stat64("/bin/ls", {st_dev=makedev(253, 3), st_ino=8388741, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=200, st_size=101156, st_atime=2009/12/08-02:54:11, st_mtime=2009/12/08-02:54:11, st_ctime=2009/12/08-02:54:33}) = 0
29316 stat64("/bin/ls", {st_dev=makedev(253, 3), st_ino=8388741, st_mode=S_IFREG|0755, st_nlink=1, st_uid=0, st_gid=0, st_blksize=8192, st_blocks=200, st_size=101156, st_atime=2009/12/08-02:54:11, st_mtime=2009/12/08-02:54:11, st_ctime=2009/12/08-02:54:33}) = 0
29316 rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
29316 clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fca388) = 29317
29316 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
29316 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
29316 rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
29316 rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
29316 rt_sigaction(SIGINT, {0x4eba0, [], 0}, {SIG_DFL, [], 0}, 0xf7dd7a98, 4160529288) = 0
29316 waitpid(-1,  <unfinished ...>

--wac7ysb48OaltWcw--

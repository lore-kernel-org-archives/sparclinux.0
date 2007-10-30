From: Bernd Zeimetz <bernd@bzed.de>
Date: Tue, 30 Oct 2007 00:50:30 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47267FD6.30904@bzed.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070503030605060401010302"
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------070503030605060401010302
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


> Here you go.
> 
> (Mind, this is capturing the current status of the chroot, which is fairly
> unclean, because right now it happens to be building python-qt4-4.3.1.)

What we're missing here is a probably important piece:

If dpkg-query is running during a build, it is running in a fakeroot
environment. I've straced that, see the attachment.

What I find in the strace are at least several clones, which is the
point where aptitude -u crashed according to the straces in
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=433187#102


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

--------------070503030605060401010302
Content-Type: text/plain;
 name="strace_fakeroot"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="strace_fakeroot"

execve("/usr/bin/fakeroot", ["fakeroot", "dpkg-query", "-S", "libc.so.6"], [/* 12 vars */]) = 0
brk(0)                                  = 0xca000
uname({sys="Linux", node="titan", ...}) = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fba000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=12402, ...}) = 0
mmap(NULL, 12402, PROT_READ, MAP_PRIVATE, 3, 0) = 0xf7fb4000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\263"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=208688, ...}) = 0
mmap(NULL, 208480, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f80000
mmap(0xf7fb0000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x30000) = 0xf7fb0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\0\f"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size=18216, ...}) = 0
mmap(NULL, 82432, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7f68000
mprotect(0xf7f6c000, 57344, PROT_NONE)  = 0
mmap(0xf7f7a000, 16384, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x2000) = 0xf7f7a000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\22\0\0\0\1\0\1\364"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size=1419756, ...}) = 0
mmap(NULL, 1489032, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0xf7dfc000
mprotect(0xf7f50000, 65536, PROT_NONE)  = 0
mmap(0xf7f60000, 24576, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x154000) = 0xf7f60000
mmap(0xf7f66000, 6280, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xf7f66000
close(3)                                = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fde000
mprotect(0xf7f7a000, 8192, PROT_READ)   = 0
munmap(0xf7fb4000, 12402)               = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/dev/tty", O_RDWR|O_NONBLOCK|O_LARGEFILE) = 3
close(3)                                = 0
brk(0)                                  = 0xca000
brk(0xec000)                            = 0xec000
getuid32()                              = 1000
getgid32()                              = 1000
geteuid32()                             = 1000
getegid32()                             = 1000
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
time(NULL)                              = 1193705202
open("/proc/meminfo", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7fb8000
read(3, "MemTotal:      8314712 kB\nMemFre"..., 1024) = 624
close(3)                                = 0
munmap(0xf7fb8000, 8192)                = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigaction(SIGCHLD, {SIG_DFL}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigaction(SIGQUIT, {SIG_DFL}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigaction(SIGQUIT, {SIG_IGN}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
uname({sys="Linux", node="titan", ...}) = 0
stat64("/home/foo", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
getpid()                                = 18537
getppid()                               = 18536
getpgrp()                               = 18536
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4294967295) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
open("/usr/bin/fakeroot", O_RDONLY|O_LARGEFILE) = 3
ioctl(3, TCSETAF or SNDCTL_TMR_SELECT, 0xffbd775c) = -1 ENOTTY (Inappropriate ioctl for device)
_llseek(3, 0, [0], SEEK_CUR)            = 0
read(3, "#!/bin/sh\n\n# This script first s"..., 80) = 80
_llseek(3, 0, [0], SEEK_SET)            = 0
getrlimit(RLIMIT_NOFILE, {rlim_cur=1024, rlim_max=1024}) = 0
dup2(3, 255)                            = 255
close(3)                                = 0
fcntl64(255, F_SETFD, FD_CLOEXEC)       = 0
fcntl64(255, F_GETFL)                   = 0x40000 (flags O_RDONLY|O_LARGEFILE)
fstat64(255, {st_mode=S_IFREG|0755, st_size=3481, ...}) = 0
_llseek(255, 0, [0], SEEK_CUR)          = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "#!/bin/sh\n\n# This script first s"..., 3481) = 3481
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 3
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -2736, [745], SEEK_CUR)    = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18538
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {0x42460, [], 0}, 0xf7e32cb8, 4160612088) = 0
close(4)                                = 0
read(3, "getopt (enhanced) 1.1.4\n", 128) = 24
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 18538
waitpid(-1, 0xffbd6f3c, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [ILL TRAP ABRT EMT FPE SYS PIPE ALRM TERM STOP TSTP CONT])
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "case $GETOPTEST in\ngetopt*) # GN"..., 3481) = 2736
pipe([3, 4])                            = 3
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -2510, [971], SEEK_CUR)    = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18539
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {0x42460, [], 0}, 0xf7e32cb8, 4160612088) = 0
close(4)                                = 0
read(3, " -- \'dpkg-query\' \'-S\' \'libc.so.6"..., 128) = 34
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 18539
waitpid(-1, 0xffbd6d44, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [ILL TRAP ABRT EMT FPE SYS PIPE ALRM TERM STOP TSTP CONT])
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nif test \"$?\" -ne 0; then\n  usag"..., 3481) = 2510
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
pipe([3, 4])                            = 3
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -1275, [2206], SEEK_CUR)   = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18540
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {0x42460, [], 0}, 0xf7e32cb8, 4160612088) = 0
close(4)                                = 0
read(3, "/usr/lib/libfakeroot /usr/lib64/"..., 128) = 67
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 18540
waitpid(-1, 0xffbd6f14, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [ILL TRAP ABRT EMT FPE SYS PIPE ALRM TERM STOP TSTP CONT])
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64("/usr/lib/libfakeroot/libfakeroot-sysv.so", {st_mode=S_IFREG|0755, st_size=30536, ...}) = 0
open("/proc/sys/kernel/ngroups_max", O_RDONLY) = 3
read(3, "65536\n", 31)                  = 6
close(3)                                = 0
mmap(NULL, 270336, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0xf7dba000
getgroups32(65536, [0])                 = 1
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64("/usr/lib64/libfakeroot/libfakeroot-sysv.so", {st_mode=S_IFREG|0755, st_size=40864, ...}) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
stat64("/usr/lib32/libfakeroot/libfakeroot-sysv.so", 0xffbd6d08) = -1 ENOENT (No such file or directory)
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nif test $libfound = no\nthen\n   "..., 3481) = 1275
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
pipe([3, 4])                            = 3
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -947, [2534], SEEK_CUR)    = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18543
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {0x42460, [], 0}, 0xf7e32cb8, 4160612088) = 0
close(4)                                = 0
read(3, "22592087:18545\n", 128)        = 15
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 18543
waitpid(-1, 0xffbd6f3c, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [ILL TRAP ABRT EMT FPE SYS PIPE ALRM TERM STOP TSTP CONT])
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "FAKEROOTKEY=`echo $KEY_PID|cut -"..., 3481) = 947
pipe([3, 4])                            = 3
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -907, [2574], SEEK_CUR)    = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18546
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {0x42460, [], 0}, 0xf7e32cb8, 4160612088) = 0
close(4)                                = 0
read(3, "22592087\n", 128)              = 9
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 18546
waitpid(-1, 0xffbd6f3c, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [ILL TRAP ABRT EMT FPE SYS PIPE ALRM TERM STOP TSTP CONT])
read(3, "", 128)                        = 0
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "PID=`echo $KEY_PID|cut -d: -f2`\n"..., 3481) = 907
pipe([3, 4])                            = 3
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
_llseek(255, -875, [2606], SEEK_CUR)    = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18549
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGCHLD, {0x42460, [], 0}, {0x42460, [], 0}, 0xf7e32cb8, 4160612088) = 0
close(4)                                = 0
read(3, "18545\n", 128)                 = 6
read(3, "", 128)                        = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], WNOHANG) = 18549
waitpid(-1, 0xffbd6f3c, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [ILL TRAP ABRT EMT FPE SYS PIPE ALRM TERM STOP TSTP CONT])
close(3)                                = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGINT, {SIG_DFL}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nif [ \"$WAITINTRAP\" -eq 0 ]; the"..., 3481) = 875
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigaction(SIGHUP, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGINT, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGILL, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGTRAP, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGABRT, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGEMT, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGFPE, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGBUS, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGSEGV, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGSYS, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGPIPE, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGALRM, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGTERM, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGXCPU, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGXFSZ, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGVTALRM, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGLOST, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGUSR1, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGUSR2, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, {SIG_DFL}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGINT, {SIG_IGN}, {0x55048, [HUP INT ILL TRAP ABRT EMT FPE BUS SEGV SYS PIPE ALRM TERM XCPU XFSZ VTALRM LOST USR1 USR2], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigaction(SIGINT, {0x53620, [], 0}, {SIG_IGN}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
stat64(".", {st_mode=S_IFDIR|0755, st_size=4096, ...}) = 0
stat64("/usr/local/bin/dpkg-query", 0xffbd7050) = -1 ENOENT (No such file or directory)
stat64("/usr/bin/dpkg-query", {st_mode=S_IFREG|0755, st_size=76596, ...}) = 0
stat64("/usr/bin/dpkg-query", {st_mode=S_IFREG|0755, st_size=76596, ...}) = 0
rt_sigprocmask(SIG_BLOCK, [INT CHLD], [], 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [INT CHLD], 8) = 0
rt_sigprocmask(SIG_SETMASK, [INT CHLD], NULL, 8) = 0
_llseek(255, -14, [3467], SEEK_CUR)     = 0
clone(child_stack=0, flags=CLONE_CHILD_CLEARTID|CLONE_CHILD_SETTID|SIGCHLD, child_tidptr=0xf7fde6f8) = 18552
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, [CHLD], [], 8) = 0
rt_sigaction(SIGINT, {0x4310c, [], 0}, {0x53620, [], 0}, 0xf7e32cb8, 4160612088) = 0
waitpid(-1, [{WIFEXITED(s) && WEXITSTATUS(s) == 0}], 0) = 18552
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
--- SIGCHLD (Child exited) @ 0 (0) ---
waitpid(-1, 0xffbd6df4, WNOHANG)        = -1 ECHILD (No child processes)
sigreturn()                             = ? (mask now [TRAP ABRT EMT KILL BUS SYS PIPE ALRM CONT])
rt_sigaction(SIGINT, {0x53620, [], 0}, {0x4310c, [], 0}, 0xf7e32cb8, 4160612088) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
read(255, "\nexit $RESULT\n", 3481)     = 14
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_SETMASK, [], NULL, 8) = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
rt_sigprocmask(SIG_BLOCK, NULL, [], 8)  = 0
kill(18545, SIGTERM)                    = 0
exit_group(0)                           = ?

--------------070503030605060401010302--

From: Jan Engelhardt <jengelh@medozas.de>
Date: Fri, 08 Jan 2010 22:59:04 +0000
Subject: Re: fstat seems broken on sparc64
Message-Id: <alpine.LSU.2.01.1001082355250.20848@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
In-Reply-To: <alpine.LSU.2.01.0912132357090.19051@obet.zrqbmnf.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


On Tuesday 2009-12-15 08:38, David Miller wrote:
>> I added some dump_stack() to all the cp_* functions, leading
>> to this result:
>> 
>> Call Trace:
>>  [0000000000522990] cp_new_stat+0xdc/0x134
>>  [0000000000522d9c] SyS_newfstat+0x24/0x38
>>  [0000000000406294] linux_sparc_syscall+0x34/0x44
>> 
>> Is glibc doing the right thing here? Calling sys_newfstat (instead of 
>> sys_newfstat64) for fstat64()?
>
>That's completely bogus.
>
>And I can't reproduce your problem on debian unstable.  What
>are you using, Fedora?  Maybe something is fubared in their
>glibc build or the checkout they are using.

It seems like a glibc bug, but it is also happening on Debian now:

I have no name!@ares:/# gcc stat.c -o stat64 -m64 -Wall
I have no name!@ares:/# ./stat64
1262990222.527474569
1262990222.000000000
I have no name!@ares:/# dpkg-query -W | grep libc
libc-bin        2.10.2-4
libc-dev-bin    2.10.2-4
libc6   2.10.2-4
libc6-dev       2.10.2-4
libc6-dev-sparc64       2.10.2-4
libc6-sparc64   2.10.2-4

And I can see why that is:
$ ./strace/strace-4.5.19/strace ./stat64
execve("./stat64", ["./stat64"], [/* 67 vars */]) = 0
uname({sys="Linux", node="ares", ...})  = 0
brk(0)                                  = 0x28e000
brk(0x28ef50)                           = 0x28ef50
brk(0x2b0f50)                           = 0x2b0f50
brk(0x2b2000)                           = 0x2b2000
open("foo", O_RDWR|O_CREAT, 0666)       = 3
lstat64(0x16b288, 0x7feff880a78)        = 0
fstat(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(136, 12), ...}) = 0

Compare with:

$ ./strace/strace-4.5.19/strace ./stat32
execve("./stat32", ["./stat32"], [/* 67 vars */]) = 0
uname({sys="Linux", node="ares", ...})  = 0
brk(0)                                  = 0xb2000
brk(0xb2cd0)                            = 0xb2cd0
brk(0xd4cd0)                            = 0xd4cd0
brk(0xd6000)                            = 0xd6000
open("foo", O_RDWR|O_CREAT, 0666)       = 3
lstat64(0x806d8, 0xffdc1030)            = 0
fstat64(0x3, 0xffdc1030)                = 0
fstat64(0x1, 0xffdc08b8)                = 0

So glibc calls fstat instead of fstat64. That does not sound
right at all.

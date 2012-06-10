From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 10 Jun 2012 08:49:56 +0000
Subject: some observations with smp sparc32
Message-Id: <CA+=Fv5RLfV9fEOTWqYkNb3EkTAMnOegMC-kD-=+5a2CCziebiQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

Here are some observations from running linux smp kernels on sparc32 hardware:

linux-2.6.31.9 seems stable on both hypersparc and supersparc, runs
fine for long periods of time even under quite heavy load.
linux-2.32.x also runs fine some instability notices with lookups on
both hypersparc and supersparc but I've had a ss10 dual
 superparc-II running for over 100 days without problems so its fairly
reliable. Sometimes.

With kernel 2.6.32.46 I see things like:

Jan 20 00:46:23 ss10 kernel: BUG: rwlock wrong CPU on CPU#2, tr/7032, f0234020
Jan 20 00:46:23 ss10 kernel: [f0038420 : do_exit+0x5b0/0x64c ]
[f0038768 : do_group_exit+0x88/0xb8 ] [f00387a8 :
sys_exit_group+0x10/0x1c ] [f001229c : syscall_is_too_hard+0x34/0x40 ]
[f0011fa0 : srmmu_fault+0x58/0x68 ]  f0234020=tasklist_lock

More recent kernels will run smp but freezes fairly quick under heavy
load (like building the kernel), The more recent kernel the less
uptime I get under heavy load.
On linux 3.4.x I get messages like:

"BUG: scheduling while atomic: swapper/2/0/0x00000000"

These messages are frequent and quickly fills my log files whit the
same repeated message.


The exception seems to bee 3.5-rc1 (modified for hypersparc) which on
hypersparc runs fairly stable even i smp. Building a kernel with "make
-j2" is no problem and I can do it over and over again.
However building a kernel with "make -j4" will cause the system too
freeze after like 30min. Not a complete lockup though, I can ping the
machine, I can toggle numlock and if I hit ctlr-alt-del it displays
a message that the system is about to reboot, but then nothing
happens. On supersparc-II the modified 3.5-rc1 kernel will freeze alot
faster than on hypersparc, not sure why but smp on hypersparc seems
much more stable than with supersparc-II at least on 3.5-rc1.

Magnus

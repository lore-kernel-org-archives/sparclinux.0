From: Pierre Muller <pierre@freepascal.org>
Date: Fri, 21 Jul 2017 21:37:28 +0000
Subject: Re: Reproducer for sparc64 kernel lock-up bug
Message-Id: <63c81f4a-7ac4-c2d8-9bb4-f3a33665c7f8@freepascal.org>
List-Id: <sparclinux.vger.kernel.org>
References: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
In-Reply-To: <a1bac634-7b19-3238-1a39-6c8484b32bf5@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org



Le 21/07/2017 à 16:28, John Paul Adrian Glaubitz a écrit :
> Hi!
> 
> As mentioned in an earlier thread, the sparc64 kernel can be brought down
> by certain applications which cause the kernel to lock up. This was first
> observed in gcc-7 testsuite but also independently by the Free Pascal developers
> who are currently porting their compiler to sparc64.

  I tried to run the crasher in qemu on a GNU commpile farm machine (gcc21)
muller@gcc21:~/pas/test$ qemu-sparc64 -strace ./tiorte-kernel-bug
64714 getrlimit(3,274886300480,0,0,0,0) = 0
64714 rt_sigaction(SIGFPE,0x0000004000801278,0x0000000000255e58) = 0
64714 rt_sigaction(SIGSEGV,0x0000004000801278,0x0000000000255e80) = 0
64714 rt_sigaction(7,0x0000004000801278,0x0000000000255ea8) = 0
64714 rt_sigaction(SIGILL,0x0000004000801278,0x0000000000255ed0) = 0
64714 ioctl(1,1076122632,274886299880,0,0,0) = 0
64714 ioctl(2,1076122632,274886299880,0,0,0) = 0
64714 ioctl(1,1076122632,274886299880,0,0,0) = 0
64714 ioctl(2,1076122632,274886299880,0,0,0) = 0
64714 readlink("/proc/self/exe",0x0000000000255d59,255) = 44
64714 write(1,0x2541dc,36)Reading from not opened text file... = 36
64714 write(1,0x2541dc,9) Passed!
 = 9
64714 write(1,0x2541dc,37)Seekeoln from not opened text file... = 37
64714 write(1,0x2541dc,9) Passed!
 = 9
64714 write(1,0x2541dc,36)Seekeof from not opened text file... = 36
64714 write(1,0x2541dc,9) Passed!
 = 9
64714 mmap(NULL,32768,PROT_READ|PROT_WRITE,MAP_PRIVATE|MAP_ANONYMOUS,-1,0) = 0x0000004000802000
setup_rt_frame: not implemented
Segmentation fault (core dumped)

But I suspect that the line:
setup_rt_frame: not implemented
is more a general limitation of qemu-sparc64...
muller@gcc21:~/pas/test$ qemu-sparc64 -version
qemu-sparc64 version 2.0.0 (Debian 2.0.0+dfsg-2ubuntu1.34), Copyright (c) 2003-2008 Fabrice Bellard
Is there a newer version out?

I just noticed that the directory on which I ran this executable seems to have suffered also:
I copied the tiorte-kernel-bug executable from stadler machine
to directory ~/pas/test directlry that is in fact on
/scratch/6/muller/pas/test
but now apparently, this mount is read-only...
mount output:
muller@gcc21:~/pas/test$ mount
/dev/sdd on /scratch/6 type ext4 (rw,noatime,errors=remount-ro)
while:
muller@gcc21:~/pas/test$ cat /proc/mounts
/dev/sdd /scratch/6 ext4 ro,noatime,errors=remount-ro,data=ordered 0 0

Quite weird, isn't it?

The 32-bit version of the same source code does not seem to generate a lot of system calls...
Of course, the 64bit version might contain wrongly sized struct, which
might explain why the program crashes...


Pierre Muller

> When running the attached, statically linked binary on a recent kernel, the
> kernel locks up with:
> 
> [  252.730349]  9010001c
> [  252.730358]  02400006
> [  252.730360]
> [  252.750121] OOPS: Bogus kernel PC [00000000000004c0] in fault handler
> [  252.750126] OOPS: RPC [000000000042c908]
> [  252.750126] OOPS: RPC [[  252.750143] OOPS: RPC <arch_cpu_idle+0x68/0xa0>
> [  252.750162] CPU: 18 PID: 0 Comm: swapper/18 Tainted: G      D         4.12.0-rc1-sparc64-smp #1 Debian 4.12~rc1-1~exp1~sparc64
> [  252.750166] Call Trace:
> [  252.750183]  [00000000009fe578] do_sparc64_fault+0x178/0x9e0
> [  252.750183]  [00000000009fe578] do_sparc64[  252.750197]  [0000000000407c1c] sparc64_realfault_common+0x10/0x20
> [  252.750229]  [00000000009fcc68] default_idle_call+0x28/0x60
> [  252.750243]  [00000000004b01a4] do_idle+0xc4/0x1a0
> [  252.750257]  [00000000004b04c4] cpu_startup_entry+0x24/0x40
> [  252.750276]  [000000000043efa4] smp_callin+0x104/0x140
> [  252.750276]  [000000000043efa4] smp_ca[  252.750285]  [0000000000bb5c04] 0xbb5c04
> [  252.750297] Unable to handle kernel NULL pointer dereference
> [  252.750302] tsk->{mm,active_mm}->context = 00000000000003b5
> [  252.750308] tsk->{mm,active_mm}->pgd = ffff8001f17cc000
> [  252.750313]               \|/ ____ \|/
> [  252.750313]               "@'/ .. \`@"
> [  252.750313]               /_| \__/ |_\
> [  252.750313]                  \__U_/
> [  252.750313]               \|/ ____ \|/
> [  252.750[  252.750319] swapper/18(0): Oops [#36]
> [  252.750342] task: ffff8001f405a4a0 task.stack: ffff8001f405c000
> [  252.750353] TSTATE: 0000004480001605 TPC: 00000000000004c0 TNPC: 00000000000004c4 Y: 00000000    Tainted: G      D
> [  252.750361] TPC: <0x4c0>
> [  252.750370] g0: 80000000088007c3 g1: 0000000000000016 g2: 00000000f0200000 g3: 00000000fff78000
> [  252.750380] g4: 0000000000005220 g5: ffff8001fe970000 g6: ffff8001f405c000 g7: 0000000006004000
> [  252.750388] o0: 00000000000004c0 o1: 0000000000000000 o2: 0000000000000000 o3: 0000000000000000
> [  252.750397] o4: 0000000000000000 o5: 0000000000000000 sp: ffff8001f405f3d1 ret_pc: 000000000042c908
> [  252.750412] RPC: <arch_cpu_idle+0x68/0xa0>
> [  252.750412] RPC: <arch_cpu_idle+0x68/0xa0>
> 
> This binary is part of the testsuite of the FreePascal compiler [1].
> 
> Adrian
> 
>> [1] https://svn.freepascal.org/cgi-bin/viewvc.cgi/trunk/tests/test/units/system/tiorte.pp?view=markup
> 

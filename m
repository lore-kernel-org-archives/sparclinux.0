From: "Richard Mortimer" <richm@oldelvet.org.uk>
Date: Mon, 09 Jan 2006 16:03:31 +0000
Subject: RE: strace broken on SPARC64
Message-Id: <000201c61536$40b09750$9505a8c0@tech1>
List-Id: <sparclinux.vger.kernel.org>
References: <1136767843.9208.15.camel@duncow>
In-Reply-To: <1136767843.9208.15.camel@duncow>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dave,

The patch seems to totally break my kernels I tried with something
approaching 2.6.15 and 2.6.13 and get the same symptoms with both.
It crashes very early during boot. A "-p" boot gives the output at
the end of the message.

A quick look at the code in entry.S shows that %l1 is used for TPC
values a little later in the code and that would correspond to the "zero"
PC report in the messages.

        bne,pn          %icc, linux_syscall_trace2
         add            %l1, 0x4, %l2                   ! npc = npc+4
        stx             %l1, [%sp + PTREGS_OFF + PT_V9_TPC]
        ba,pt           %xcc, rtrap_clr_l6

I should get more time to look at this and try out different registers
etc tonight.

Thanks

Richard

> -----Original Message-----
> From: David S. Miller [mailto:davem@davemloft.net] 
> Sent: 09 January 2006 06:50

> Looking at the entry.S part of the diff, the problem is obvious.
> 
> We're spamming the existing flags value in register %l0, thus
> corrupting the subsequent tracing flag et al. checks.
> 
> This should fix it:
> 
> diff --git a/arch/sparc64/kernel/entry.S b/arch/sparc64/kernel/entry.S
> index 11a8484..86ff6a9 100644
> --- a/arch/sparc64/kernel/entry.S
> +++ b/arch/sparc64/kernel/entry.S
> @@ -1657,8 +1657,8 @@ ret_sys_call:
>  	/* Check if force_successful_syscall_return()
>  	 * was invoked.
>  	 */
> -	ldub		[%curptr + TI_SYS_NOERROR], %l0
> -	brz,pt		%l0, 1f
> +	ldub		[%curptr + TI_SYS_NOERROR], %l1
> +	brz,pt		%l1, 1f
>  	 nop
>  	ba,pt		%xcc, 80f
>  	 stb		%g0, [%curptr + TI_SYS_NOERROR]
> 

PROMLIB: Sun IEEE Boot Prom 4.0.9 2001/05/17 21:52
Linux version 2.6.15 (root@pingu) (gcc version 4.0.3 20051201 (prerelease)
(Debian 4.0.2-5)) #2 Mon Jan 9 13:14:27 GMT 2006
ARCH: SUN4U
Ethernet address: 08:00:20:f8:35:85
Remapping the kernel... done.
Registering callbacks... done.
Booting Linux...
CPU[0]: Caches D[sz(16384):line_sz(32)] I[sz(16384):line_sz(32)]
E[sz(262144):line_sz(64)]
Built 1 zonelists
Kernel command line: root=/dev/hda2 ro -p
PID hash table entries: 2048 (order: 11, 65536 bytes)
Console: colour dummy device 80x25
Dentry cache hash table entries: 65536 (order: 6, 524288 bytes)
Inode-cache hash table entries: 32768 (order: 5, 262144 bytes)
Memory: 508592k available (2024k kernel code, 680k data, 136k init)
[fffff80000000000,0000000067ec8000]
Security Framework v1.0.0 initialized
SELinux:  Disabled at boot.
Capability LSM initialized
Mount-cache hash table entries: 512
OOPS: Bogus kernel PC [0000000000000000] in fault handler
Call Trace:
 [0000000000408cd0] sparc64_realfault_common+0x10/0x20
 [00000000004a96cc] proc_mkdir_mode+0x48/0x6c
 [000000000040e010] rest_init+0x10/0x2c
 [00000000006b0630] start_kernel+0x1f8/0x208
 [00000000004043f4] tlb_fixup_done+0x5c/0x64
 [0000000000000000] start+0xffffffffffbfc000/0x12
Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff800672e8d70
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#1]
TSTATE: 0000004480001603 TPC: 0000000000000000 TNPC: 0000000000000004 Y:
00000000    Not tainted
TPC: <start+0xffffffffffbfc000/0x12>
g0: 0000000000000000 g1: 00000000000000d9 g2: 000000000040e070 g3:
0000000000000000
g4: 0000000000646940 g5: 0000000000000000 g6: 0000000000647d80 g7:
00000000f0000025
o0: 0000000000000001 o1: 0000000000000000 o2: 000000000000416d o3:
0000000000000002
o4: 00000000006f5800 o5: 0000000000000000 sp: 000000000064b271 ret_pc:
00000000004a96cc
RPC: <proc_mkdir_mode+0x48/0x6c>
l0: 00000000004ab56c l1: 00000000006f7c00 l2: 0000000000659490 l3:
000000000065ec38
l4: 0000000000000000 l5: 0000000000000000 l6: 0000000000000000 l7:
0000000000000008
i0: 000000000040e070 i1: 0000000000000000 i2: 0000000000800b00 i3:
fffff80067eacae8
i4: 0000000000656800 i5: 00000000fffedb93 i6: 000000000064b331 i7:
000000000040e010
I7: <rest_init+0x10/0x2c>
Caller[000000000040e010]: rest_init+0x10/0x2c
Caller[00000000006b0630]: start_kernel+0x1f8/0x208
Caller[00000000004043f4]: tlb_fixup_done+0x5c/0x64
Caller[0000000000000000]: start+0xffffffffffbfc000/0x12
Instruction DUMP: 00000000  00000000  00000000 <1>Unable to handle kernel
NULL pointer dereference
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff800672e8d70
              \|/ ____ \|/
              "@'/ .. \`@"
              /_| \__/ |_\
                 \__U_/
swapper(0): Oops [#2]
TSTATE: 0000004480009600 TPC: 0000000000410450 TNPC: 0000000000410454 Y:
00000000    Not tainted
TPC: <instruction_dump+0x44/0x7c>
g0: 0000000000000000 g1: 0000000000000000 g2: 0000000000653008 g3:
0000000000000002
g4: 0000000000646940 g5: 0000000000000000 g6: 0000000000647d80 g7:
0000000000000000
o0: 000000000000000a o1: 000000000000003c o2: 0000000000000000 o3:
000000000000003e
o4: 0000000000000012 o5: 0000000000000000 sp: 000000000064ada1 ret_pc:
0000000000410460
RPC: <instruction_dump+0x54/0x7c>
l0: 0000000000000000 l1: 0000000000000004 l2: 0000000000000000 l3:
0000004480001603
l4: 0000000000000001 l5: 00000000000000d0 l6: 0000000000000000 l7:
0000000000000001
i0: 0000000000000000 i1: 0000000000000000 i2: 000000000064b718 i3:
00000000006092f0
i4: 0000000000000001 i5: 0000000000000000 i6: 000000000064ae61 i7:
0000000000410a20
I7: <die_if_kernel+0x11c/0x268>
Caller[0000000000410a20]: die_if_kernel+0x11c/0x268
Caller[0000000000430eac]: unhandled_fault+0xd0/0xe0
Caller[00000000004313d4]: do_sparc64_fault+0x518/0x5c4
Caller[0000000000408cd0]: sparc64_realfault_common+0x10/0x20
Caller[00000000004a96cc]: proc_mkdir_mode+0x48/0x6c
Caller[000000000040e010]: rest_init+0x10/0x2c
Caller[00000000006b0630]: start_kernel+0x1f8/0x208
Caller[00000000004043f4]: tlb_fixup_done+0x5c/0x64
Caller[0000000000000000]: start+0xffffffffffbfc000/0x12
Instruction DUMP: 83287002  9610203e  97666020 <d4060001> 11001820  a0042001
933a6000  4000b71a  90122240
Kernel panic - not syncing: Attempted to kill the idle task!
 <0>Press Stop-A (L1-A) to return to the boot prom



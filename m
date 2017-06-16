From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 16 Jun 2017 12:17:01 +0000
Subject: Re: [v1 0/2] Early boot timestamp fixes
Message-Id: <c59e8f72-2f94-ccee-fcc7-792c4148f493@ilande.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1497537659-419752-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 15/06/17 20:36, Guenter Roeck wrote:

> Oopsie :-)
> 
> Building sparc64:sun4u:TI UltraSparc IIi:smp:sparc64_defconfig ... running .....  passed
> Building sparc64:sun4v:TI UltraSparc IIe:smp:sparc64_defconfig ... running ............................ failed (timeout)
> ------------
> qemu log:
> OpenBIOS for Sparc64
> Configuration device id QEMU version 1 machine id 64
> kernel addr 404000 size 101dd2c
> kernel cmdline root=/dev/vda init=/sbin/init.sh console=ttyS0 doreboot
> CPUs: 1 x SUNW,UltraSPARC-IIe
> UUID: 00000000-0000-0000-0000-000000000000
> Welcome to OpenBIOS v1.1 built on Nov 24 2016 21:23
>   Type 'help' for detailed information
> [sparc64] Kernel already loaded
> 
> Unhandled Exception 0x0000000000000028
> PC = 0x0000000000462234 NPC = 0x0000000000462238
> Stopping execution
> qemu-system-sparc64: terminating on signal 15 from pid 14226 (/bin/bash)
> ------------
> Building sparc64:sun4v:Fujitsu Sparc64 IV:smp:sparc64_defconfig ... running ..... passed
> 
> Trying with v4.12-rc4 gives me a different crash for UltraSparc IIe:
> 
> [    0.000000] NR_IRQS:2048 nr_irqs:2048 1
> [    0.000000]               \|/ ____ \|/
> [    0.000000]               "@'/ .. \`@"
> [    0.000000]               /_| \__/ |_\
> [    0.000000]                  \__U_/
> [    0.000000] swapper/0(0): TL0: Kernel divide by zero. [#1]
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.12.0-rc4+ #1
> [    0.000000] task: 0000000000ae3e80 task.stack: 0000000000ad4000
> [    0.000000] TSTATE: 0000008880e01607 TPC: 0000000000b5d8a4 TNPC: 0000000000b5d8a8 Y: 00000000    Not tainted
> [    0.000000] TPC: <time_init+0xf4/0x1b8>
> [    0.000000] g0: 0000000000b4cf50 g1: 0000000000000000 g2: 000000ee6b280000 g3: 0000000000000000
> [    0.000000] g4: 0000000000ae3e80 g5: fffff8001ec5c000 g6: 0000000000ad4000 g7: 00000000ffffffff
> [    0.000000] o0: 0000000000000000 o1: 0000000000a3c1f0 o2: 0000000000000000 o3: 0000000000000000
> [    0.000000] o4: 0000000200000000 o5: 0000000000000001 sp: 0000000000ad75c1 ret_pc: 0000000000b5d824
> [    0.000000] RPC: <time_init+0x74/0x1b8>
> [    0.000000] l0: 0000000077359400 l1: 0000000000bb8c00 l2: 0000000000baf940 l3: 0000000000bb2100
> [    0.000000] l4: 0000000000bb8c00 l5: 0000000000adec00 l6: 0000000000bb2100 l7: 0000000000983898
> [    0.000000] i0: 0000000000adb400 i1: 0000000000adec00 i2: 0000000000ae5c00 i3: ffffffffffffffff
> [    0.000000] i4: 0000000000000000 i5: 0000000000a3c2b0 i6: 0000000000ad7671 i7: 0000000000b5a8a4
> [    0.000000] I7: <start_kernel+0x2b0/0x430>
> [    0.000000] Call Trace:
> [    0.000000]  [0000000000b5a8a4] start_kernel+0x2b0/0x430
> [    0.000000]  [00000000009777b4] tlb_fixup_done+0x4c/0x58
> [    0.000000]  [00000000ffd0e444] 0xffd0e444
> [    0.000000] Disabling lock debugging due to kernel taint
> [    0.000000] Caller[0000000000b5a8a4]: start_kernel+0x2b0/0x430
> [    0.000000] Caller[00000000009777b4]: tlb_fixup_done+0x4c/0x58
> 
> Still in the timer code, though. Adding some debugging:
> 
> [    0.000000] ############# spitfire
> [    0.000000] ############# Hummingbird
> [    0.000000] ############# stick-frequency=0
> [    0.000000] ############## time_init(): freq=0
> 
> This suggests that the stick-frequency devicetree property isn't there.
> Checking the openbios source confirms it. Overall the code does not look
> correct, though, since
> 
> 	freq = of_getintprop_default(dp, "stick-frequency", 0);
> 
> suggests that a frequency of 0 would be acceptable but isn't.

Right. I don't see a stick-frequency in a DT from a real Ultra 5, so I
presume that this is specific to IIe?

> Anyway, adding "stick-frequency" to the properties provided by openbios
> fixes this crash both upstream and in your code, only to result in a hang
> a bit later.
> 
> [    0.000000] clocksource: hbtick: mask: 0xffffffffffffffff max_cycles: 0x171024e7e0, max_idle_ns: 440795205315 ns
> [    0.000000] clocksource: mult[a000000] shift[24]
> [    0.000000] clockevent: mult[1999999a] shift[32]
> [    0.000000] Console: colour dummy device 80x25
> 
> [ hangs here until terminated ]
> 
> Guess that means that qemu doesn't really support this CPU,
> and your code is fine.

Yeah that is entirely likely. Currently my focus is on getting the basic
sun4u machine up-and-running to the point where 64-bit Solaris can boot
in -nographic mode, so for the moment the other CPU types tend to be
ignored.


ATB,

Mark.


From: Vince Weaver <vince@deater.net>
Date: Thu, 18 Jan 2007 18:33:15 +0000
Subject: kernel BUG at arch/sparc64/mm/fault.c:413!
Message-Id: <Pine.LNX.4.64.0701181328230.8124@pianoman.cluster.toy>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I am running Linux 2.6.20-rc5 on an UltraSparc T1 (Niagara) with 24 
threads.

When trying to compile gcc-4.2-20070117 gcc snapshot from scratch, the 
following BUG() happens:

[ 1020.332688] kernel BUG at arch/sparc64/mm/fault.c:413!
[ 1020.332710]               \|/ ____ \|/
[ 1020.332716]               "@'/ .. \`@"
[ 1020.332722]               /_| \__/ |_\
[ 1020.332729]                  \__U_/
[ 1020.332742] sh(10473): Kernel bad sw trap 5 [#1]
[ 1020.332758] TSTATE: 0000000011001603 TPC: 0000000000690718 TNPC: 000000000069071c Y: 00000000    Not tainted
[ 1020.332786] TPC: <do_sparc64_fault+0x6c0/0x6e0>
[ 1020.332799] g0: 0000000000000030 g1: 0000000000000000 g2: 0000000000000001 g3: 0000000000000000
[ 1020.332821] g4: fffff801cfcf5680 g5: fffff80003d13fc0 g6: fffff801cfc28000 g7: 0000000000000000
[ 1020.332839] o0: 000000000000003d o1: 0000000000718298 o2: 000000000000019d o3: 0000000000000000
[ 1020.332861] o4: 4849001106491d49 o5: fffff801f1c36bc0 sp: fffff801cfc2b5c1 ret_pc: 0000000000690710
[ 1020.332881] RPC: <do_sparc64_fault+0x6b8/0x6e0>
[ 1020.332896] l0: fffff801f1e9d890 l1: 0000000000000004 l2: fffff801f1c36bc0 l3: 0000000000000000
[ 1020.332918] l4: 00000000ff39c000 l5: fffff801f1c36c20 l6: fffff801cfc28000 l7: 0000000011009002
[ 1020.332937] i0: fffff801cfc2bf60 i1: 0000000000000033 i2: 0000000000024fd2 i3: 0000000000000003
[ 1020.332956] i4: 0000000000000000 i5: 0000000000000003 i6: fffff801cfc2b6a1 i7: 0000000000404d6c
[ 1020.332980] I7: <sparc64_realfault_common+0x18/0x20>
[ 1020.332991] Caller[0000000000404d6c]: sparc64_realfault_common+0x18/0x20
[ 1020.333013] Caller[000000000001a368]: 0x1a370
[ 1020.333045] Instruction DUMP: 9210219d  7ff62a1c  90122298 <91d02005> 7ff6c441  92102000  106fffc5  da5ca2c0  30680005

The relevant code is:

409        /* If we took a ITLB miss on a non-executable page, catch
410         * that here.
411         */
412        if ((fault_code & FAULT_CODE_ITLB) && !(vma->vm_flags & VM_EXEC)) {
413                BUG_ON(address != regs->tpc);
414                BUG_ON(regs->tstate & TSTATE_PRIV);
415                goto bad_area;
416        }

What's the next step in tracking down what's going on?

Thanks,

Vince

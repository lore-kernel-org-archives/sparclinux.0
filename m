From: Meelis Roos <mroos@linux.ee>
Date: Mon, 10 Oct 2005 15:19:29 +0000
Subject: Re: Yesterdays git does not boot on U5
Message-Id: <Pine.SOC.4.61.0510101817510.24806@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510101057330.28936@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>> Remapping the kernel... done.
>
> If you add "-v" to the kernel parameters, does it say anything more?

Yep, -p gave the oops input, should have tried it myself.

PROMLIB: Sun IEEE Boot Prom 3.31.0 2001/07/25 20:36
Linux version 2.6.14-rc3-gdd0fc66f (mroos@mandariin) (gcc version 4.0.2 (Debian 4.0.2-2)) #43 Mon Oct 10 13:15:13 EEST 205
ARCH: SUN4U
Ethernet address: 08:00:20:f8:c7:72
Remapping the kernel... done.
OOPS: Bogus kernel PC [00000000f000801c] in fault handler
Call Trace:
Unable to handle kernel paging request at virtual address 00000000f000801c
tsk->{mm,active_mm}->context = 0000000000000000
tsk->{mm,active_mm}->pgd = fffff800006fe4f8
               \|/ ____ \|/
               "@'/ .. \`@"
               /_| \__/ |_\
                  \__U_/
swapper(0): Oops [#1]
TSTATE: 0000008880f01607 TPC: 00000000f000801c TNPC: 00000000f0008020 Y: 00000000    Not tainted
TPC: <0xf000801c>
g0: 0000000000000000 g1: 0000000000700400 g2: 00000000f0000000 g3: 00000000fffe0000
g4: 0000000000000000 g5: 00000000f005511c g6: 00000000fffefe80 g7: 00000000fffeefb0
o0: 00000000f0014988 o1: 00000000fffa9741 o2: 0000000000000000 o3: 00000000000cea11
o4: 0000000000719900 o5: 0000000000000001 sp: 00000000fffa94f1 ret_pc: 00000000f0055114
RPC: <0xf0055114>
l0: 0000000000055114 l1: 00000000f005634f l2: 0000000000000001 l3: 0000000000000000
l4: 0000000000000013 l5: 0000000000000013 l6: 0000000000000000 l7: 00000000003b0a20
i0: 0000000000719840 i1: 0000000000719800 i2: 0000000000719908 i3: 0000000000000003
i4: 0000000000000000 i5: 0000000000000000 i6: 00000000fffa95b1 i7: 000000000050822c
I7: <prom_cif_interface+0xac/0x134>
Instruction DUMP: 8a016004  ca700006  8a03e008 <e0016000> 81c40002 
8a016004  c8700007  8803e008  e0016000


-- 
Meelis Roos (mroos@linux.ee)

From: "Art Haas" <ahaas@airmail.net>
Date: Thu, 25 Mar 2004 17:07:40 +0000
Subject: [PATCH] Patch for arch/sparc/math-emu/math.c
Message-Id: <20040325170740.GB11895@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.

Here's a small patch that fixes GCC-3.5 compilation. The compiler
doesn't like the "label at end of compound statement", so by simply
adding 'break;' to the "default:" condition the problem is resolved
if 'DEBUG_MATHEMU' is not defined.

Art Haas

=== arch/sparc/math-emu/math.c 1.2 vs edited ==--- 1.2/arch/sparc/math-emu/math.c	Fri Feb  7 02:20:33 2003
+++ edited/arch/sparc/math-emu/math.c	Thu Mar 25 10:55:31 2004
@@ -327,6 +327,7 @@
 #ifdef DEBUG_MATHEMU
 			printk("unknown FPop1: %03lx\n",(insn>>5)&0x1ff);
 #endif
+			break;
 		}
 	} else if ((insn & 0xc1f80000) = 0x81a80000)	/* FPOP2 */ {
 		switch ((insn >> 5) & 0x1ff) {
@@ -340,6 +341,7 @@
 #ifdef DEBUG_MATHEMU
 			printk("unknown FPop2: %03lx\n",(insn>>5)&0x1ff);
 #endif
+			break;
 		}
 	}
 
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822

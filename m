From: "Bernhard R. Link" <brlink@debian.org>
Date: Sat, 21 Jan 2006 17:49:40 +0000
Subject: [PATCH] sparc64: fix sparc_floppy_irq's auxio_register reseting
Message-Id: <20060121174940.GA31735@pcpool00.mathematik.uni-freiburg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The patch "[SPARC64]: Get rid of fast IRQ feature"
moved the the code from arch/sparc64/kernel/entry.S:
      lduba           [%g7] ASI_PHYS_BYPASS_EC_E, %g5
      or              %g5, AUXIO_AUX1_FTCNT, %g5
      stba            %g5, [%g7] ASI_PHYS_BYPASS_EC_E
      andn            %g5, AUXIO_AUX1_FTCNT, %g5
      stba            %g5, [%g7] ASI_PHYS_BYPASS_EC_E
to arch/sparc64/kernel/irq.c:
              val = readb(auxio_register);
              val |= AUXIO_AUX1_FTCNT;
              writeb(val, auxio_register); 
              val &= AUXIO_AUX1_FTCNT;
              writeb(val, auxio_register);
This looks like it it missing a bitwise not, which is reintroduced 
by this patch.

Due to lack of a floppy device, I could not test it, but it looks
evident.

Signed-off-by: Bernhard R Link <brlink@debian.org>

---

This is my first dig into the linux kernel, so I am more than 
eager to hear also minor problems with the format of the
mail or other stuff, also in private mail if you deem them
to minor for the list. Thanks in advance.

--- linux-2.6.15/arch/sparc64/kernel/irq.c.orig	2006-01-21 17:32:48.000000000 +0100
+++ linux-2.6.15/arch/sparc64/kernel/irq.c	2006-01-21 17:34:53.000000000 +0100
@@ -694,7 +694,7 @@ irqreturn_t sparc_floppy_irq(int irq, vo
 		val = readb(auxio_register);
 		val |= AUXIO_AUX1_FTCNT;
 		writeb(val, auxio_register);
-		val &= AUXIO_AUX1_FTCNT;
+		val &= ~AUXIO_AUX1_FTCNT;
 		writeb(val, auxio_register);
 
 		doing_pdma = 0;

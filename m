From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 21 Nov 2004 18:43:05 +0000
Subject: Fix for break handling in sunsab.c for 2.6
Message-Id: <Pine.LNX.4.61.0411211328530.2138@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

Due to some bugs in break handling in the sunsab.c serial driver, sending 
a break over serial console (equivalent of Stop-A sent from keyboard) does 
not dump user to the PROM command line. AFAICT, in the 2.4 -> 2.6 
transition the checking for break has been moved from check_status() to 
receive_chars(). However, in the current version of the driver the BRK 
interrupt never reaches receive_chars(). Even if it would, for the break 
to take effect a non-zero count of characters must be present in the
buffer at the same time, which never happens. The patch below corrects the 
problem (I have tried to make it as unintrusive as possible).

--- build-sparc64.orig/drivers/serial/sunsab.c	2004-11-21 12:03:51.282281488 -0500
+++ build-sparc64/drivers/serial/sunsab.c	2004-11-21 11:49:04.000000000 -0500
@@ -143,6 +143,11 @@
  		writeb(SAB82532_CMDR_RMC, &up->regs->w.cmdr);
  	}

+	/* Count may be zero for BRK, so we check for it here */
+	if((stat->sreg.isr1 & SAB82532_ISR1_BRK) &&
+	   (up->port.line = up->port.cons->index))
+		saw_console_brk = 1;
+
  	for (i = 0; i < count; i++) {
  		unsigned char ch = buf[i];

@@ -172,8 +177,6 @@
  				stat->sreg.isr0 &= ~(SAB82532_ISR0_PERR |
  						     SAB82532_ISR0_FERR);
  				up->port.icount.brk++;
-				if (up->port.line = up->port.cons->index)
-					saw_console_brk = 1;
  				/*
  				 * We do the SysRQ and SAK checking
  				 * here because otherwise the break
@@ -325,8 +328,9 @@

  	tty = NULL;
  	if (status.stat) {
-		if (status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
-					SAB82532_ISR0_RFO | SAB82532_ISR0_RPF))
+		if ((status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
+					SAB82532_ISR0_RFO | SAB82532_ISR0_RPF)) ||
+		    (status.sreg.isr1 & SAB82532_ISR1_BRK))
  			tty = receive_chars(up, &status, regs);
  		if ((status.sreg.isr0 & SAB82532_ISR0_CDSC) ||
  		    (status.sreg.isr1 & SAB82532_ISR1_CSC))
@@ -352,8 +356,9 @@

  	tty = NULL;
  	if (status.stat) {
-		if (status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
-					SAB82532_ISR0_RFO | SAB82532_ISR0_RPF))
+		if ((status.sreg.isr0 & (SAB82532_ISR0_TCD | SAB82532_ISR0_TIME |
+					SAB82532_ISR0_RFO | SAB82532_ISR0_RPF)) ||
+		    (status.sreg.isr1 & SAB82532_ISR1_BRK))
  			tty = receive_chars(up, &status, regs);
  		if ((status.sreg.isr0 & SAB82532_ISR0_CDSC) ||
  		    (status.sreg.isr1 & (SAB82532_ISR1_BRK | SAB82532_ISR1_CSC)))

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC

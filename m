From: David Miller <davem@davemloft.net>
Date: Tue, 24 Apr 2007 06:32:19 +0000
Subject: Re: parport_sunbpp patch, works on ultra2
Message-Id: <20070423.233219.52164250.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <op.tqnalwnm3zd5kp@k37>
In-Reply-To: <op.tqnalwnm3zd5kp@k37>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Arkadi Shishlov" <arkadi@mebius.lv>
Date: Thu, 12 Apr 2007 03:35:46 +0300

> With 2.6(.20) parport_sunbpp parallel port driver the printing on Ultra2 is
> impossible. Most of the characters sent to /dev/lp0 are lost.
> The following patch works for me with LPRNG and CUPS, lpr and Windows client
> via Samba. I can print test pages from CUPS and Windows, documents with tables.
> The printer is very misbehaving HP DeskJet.
> Perhaps the code is in wrong place and generic parport infrastructure should be
> revisited instead for correct operation of polling. It will fill syslog with
> "timeout waiting" at first opportunity. And such amount of udelay()-s is awfull.
 ...
> Apr 11 19:41:36 [kernel] [29915.174784]                  \__U_/
> Apr 11 19:41:36 [kernel] [29915.174801] bash(5398): Oops [#1]
> Apr 11 19:41:36 [kernel] [29915.174824] TSTATE: 0000004411f09601 TPC: 00000000100c6200 TNPC: 00000000100c6204 Y: 00000000    Not tainted
> Apr 11 19:41:36 [kernel] [29915.174875] TPC: <parport_sunbpp_frob_control+0x28/0x100 [parport_sunbpp]>

This OOPS is easy to fix, the registers are being dereferenced
directly instead of going through the sbus_*() I/O accessors.  Fix for
that is at the end of this email.

But your patch doesn't seem right.  The generic parport code should be
polling the status lines properly before calling down into the
->read() and ->write() handlers of the driver.

The FEPS manual states that the BSY signal in the TCR register is
"active low" but that might just be normal for parallel ports.  The
test is therefore inverted in status_sunbpp_to_pc for the P_TCR_BUSY
bit.

That might be what the problem is, could you play around with that
instead?  For example, try making the test in status_sunbpp_to_pc()
be:

	if (value_tcr & P_TCR_BUSY)
		bits |= PARPORT_STATUS_BUSY;

instead of what is there now.

diff --git a/drivers/parport/parport_sunbpp.c b/drivers/parport/parport_sunbpp.c
index 9793533..400bb90 100644
--- a/drivers/parport/parport_sunbpp.c
+++ b/drivers/parport/parport_sunbpp.c
@@ -126,7 +126,7 @@ static unsigned char status_sunbpp_to_pc(struct parport *p)
 	if (!(value_tcr & P_TCR_BUSY))
 		bits |= PARPORT_STATUS_BUSY;
 
-	dprintk((KERN_DEBUG "tcr 0x%x ir 0x%x\n", regs->p_tcr, regs->p_ir));
+	dprintk((KERN_DEBUG "tcr 0x%x ir 0x%x\n", value_tcr, value_ir));
 	dprintk((KERN_DEBUG "read status 0x%x\n", bits));
 	return bits;
 }
@@ -147,7 +147,7 @@ static unsigned char control_sunbpp_to_pc(struct parport *p)
 	if (value_or & P_OR_SLCT_IN)
 		bits |= PARPORT_CONTROL_SELECT;
 
-	dprintk((KERN_DEBUG "tcr 0x%x or 0x%x\n", regs->p_tcr, regs->p_or));
+	dprintk((KERN_DEBUG "tcr 0x%x or 0x%x\n", value_tcr, value_or));
 	dprintk((KERN_DEBUG "read control 0x%x\n", bits));
 	return bits;
 }
@@ -165,7 +165,8 @@ static unsigned char parport_sunbpp_frob_control(struct parport *p,
 	unsigned char value_tcr = sbus_readb(&regs->p_tcr);
 	unsigned char value_or = sbus_readb(&regs->p_or);
 
-	dprintk((KERN_DEBUG "frob1: tcr 0x%x or 0x%x\n", regs->p_tcr, regs->p_or));
+	dprintk((KERN_DEBUG "frob1: tcr 0x%x or 0x%x\n",
+		 value_tcr, value_or));
 	if (mask & PARPORT_CONTROL_STROBE) {
 		if (val & PARPORT_CONTROL_STROBE) {
 			value_tcr &= ~P_TCR_DS;
@@ -197,7 +198,8 @@ static unsigned char parport_sunbpp_frob_control(struct parport *p,
 
 	sbus_writeb(value_or, &regs->p_or);
 	sbus_writeb(value_tcr, &regs->p_tcr);
-	dprintk((KERN_DEBUG "frob2: tcr 0x%x or 0x%x\n", regs->p_tcr, regs->p_or));
+	dprintk((KERN_DEBUG "frob2: tcr 0x%x or 0x%x\n",
+		 value_tcr, value_or));
 	return parport_sunbpp_read_control(p);
 }
 

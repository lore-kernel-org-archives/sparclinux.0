From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Nov 2005 07:43:33 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <20051122.234333.17947913.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Wed, 23 Nov 2005 09:12:23 +0200 (EET)

> > I wonder if we're setting the CEC and TEC timeouts too short.
> >
> > Can you give this patch a spin?  There are some other things
> > we can try if this still doesn't fix things.
> 
> Unfortunately it does not fix the corruption.

Thanks for testing...

Give this one a spin.

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index ba9381f..eae54a7 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -461,6 +461,9 @@ static void sunsab_tx_idle(struct uart_s
 	if (test_bit(SAB82532_REGS_PENDING, &up->irqflags)) {
 		u8 tmp;
 
+		sunsab_tec_wait(up);
+		sunsab_cec_wait(up);
+
 		clear_bit(SAB82532_REGS_PENDING, &up->irqflags);
 		writeb(up->cached_mode, &up->regs->rw.mode);
 		writeb(up->cached_pvr, &up->regs->rw.pvr);

From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 23 Nov 2005 06:30:03 +0000
Subject: Re: Still some serial console corruption on sunsab
Message-Id: <20051122.223003.82991428.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0510121223230.29862@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


I wonder if we're setting the CEC and TEC timeouts too short.

Can you give this patch a spin?  There are some other things
we can try if this still doesn't fix things.

Thanks.

diff --git a/drivers/serial/sunsab.c b/drivers/serial/sunsab.c
index ba9381f..7665a9d 100644
--- a/drivers/serial/sunsab.c
+++ b/drivers/serial/sunsab.c
@@ -93,7 +93,7 @@ static char *sab82532_version[16] = {
 
 static __inline__ void sunsab_tec_wait(struct uart_sunsab_port *up)
 {
-	int timeout = up->tec_timeout;
+	int timeout = SAB82532_MAX_TEC_TIMEOUT;
 
 	while ((readb(&up->regs->r.star) & SAB82532_STAR_TEC) && --timeout)
 		udelay(1);
@@ -101,7 +101,7 @@ static __inline__ void sunsab_tec_wait(s
 
 static __inline__ void sunsab_cec_wait(struct uart_sunsab_port *up)
 {
-	int timeout = up->cec_timeout;
+	int timeout = SAB82532_MAX_CEC_TIMEOUT;
 
 	while ((readb(&up->regs->r.star) & SAB82532_STAR_CEC) && --timeout)
 		udelay(1);

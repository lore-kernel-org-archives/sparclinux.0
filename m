From: "David S. Miller" <davem@redhat.com>
Date: Fri, 27 Aug 2004 01:10:59 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040826181059.140d7f3f.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 26 Aug 2004 17:43:01 -0700
Joshua Kwan <joshk@triplehelix.org> wrote:

> David S. Miller wrote:
> > 2) Once userland starts up, the userland messages print out fine
> >    but are kernel messages still garbled?
> 
> Right now I can say yes to this.

Hmmm, does this fix things?

=== drivers/serial/sunsab.c 1.35 vs edited ==--- 1.35/drivers/serial/sunsab.c	2004-08-26 15:38:22 -07:00
+++ edited/drivers/serial/sunsab.c	2004-08-26 17:54:26 -07:00
@@ -83,7 +83,7 @@
 
 static __inline__ void sunsab_tec_wait(struct uart_sunsab_port *up)
 {
-	int timeout = up->tec_timeout;
+	int timeout = SAB82532_MAX_TEC_TIMEOUT /*up->tec_timeout*/;
 
 	while ((readb(&up->regs->r.star) & SAB82532_STAR_TEC) && --timeout)
 		udelay(1);

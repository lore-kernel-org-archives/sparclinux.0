From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 07:57:21 +0000
Subject: Re: [PATCH 7/12]: rtc: Add TI BQ4802 RTC driver.
Message-Id: <20080829.005721.193729552.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080828.230935.67967832.davem@davemloft.net>
In-Reply-To: <20080828.230935.67967832.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 28 Aug 2008 23:09:35 -0700 (PDT)

> rtc: Add TI BQ4802 RTC driver.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

Testing on ultra45 found a silly typo bug in this driver.

I'll integrate this fix into the original commit when
I integrate this stuff for real.

diff --git a/drivers/rtc/rtc-bq4802.c b/drivers/rtc/rtc-bq4802.c
index 8938b21..541580c 100644
--- a/drivers/rtc/rtc-bq4802.c
+++ b/drivers/rtc/rtc-bq4802.c
@@ -159,7 +159,7 @@ static int __devinit bq4802_probe(struct platform_device *pdev)
 		p->regs = (void __iomem *) p->r->start;
 		p->read = bq4802_read_io;
 		p->write = bq4802_write_io;
-	} else if (p->r->flags & IORESOURCE_IO) {
+	} else if (p->r->flags & IORESOURCE_MEM) {
 		p->regs = ioremap(p->r->start, resource_size(p->r));
 		p->read = bq4802_read_mem;
 		p->write = bq4802_write_mem;

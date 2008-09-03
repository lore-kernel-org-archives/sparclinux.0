From: akpm@linux-foundation.org
Date: Wed, 03 Sep 2008 21:54:42 +0000
Subject: [patch 1/2] rtc-m48t59: reduce structure m48t59_private
Message-Id: <200809032154.m83Lsgj3005964@imap1.linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

Remove element size from the structure m48t59_private as it is used as
local variable for storing temporary value.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Alessandro Zummo <a.zummo@towertech.it>
Cc: David Brownell <david-b@pacbell.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/rtc/rtc-m48t59.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff -puN drivers/rtc/rtc-m48t59.c~rtc-m48t59-reduce-structure-m48t59_private drivers/rtc/rtc-m48t59.c
--- a/drivers/rtc/rtc-m48t59.c~rtc-m48t59-reduce-structure-m48t59_private
+++ a/drivers/rtc/rtc-m48t59.c
@@ -34,7 +34,6 @@
 
 struct m48t59_private {
 	void __iomem *ioaddr;
-	unsigned int size; /* iomem size */
 	int irq;
 	struct rtc_device *rtc;
 	spinlock_t lock; /* serialize the NVRAM and RTC access */
@@ -403,8 +402,7 @@ static int __devinit m48t59_rtc_probe(st
 	if (!m48t59)
 		return -ENOMEM;
 
-	m48t59->size = res->end - res->start + 1;
-	m48t59->ioaddr = ioremap(res->start, m48t59->size);
+	m48t59->ioaddr = ioremap(res->start, res->end - res->start + 1);
 	if (!m48t59->ioaddr)
 		goto out;
 
_

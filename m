From: David Miller <davem@davemloft.net>
Date: Wed, 23 May 2007 21:27:09 +0000
Subject: Re: [PATCH]: Better serial console identification
Message-Id: <20070523.142709.21595897.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070520.140354.92582888.davem@davemloft.net>
In-Reply-To: <20070520.140354.92582888.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Wed, 23 May 2007 14:04:02 -0500

> Just for kicks, I tried passing esp_bus_reset_settle, but it doesn't
> change the result at all.
> 
> I also grabbed a log with esp_debug 47, that log is attached.

Does this fix the problem?

diff --git a/arch/sparc/kernel/prom.c b/arch/sparc/kernel/prom.c
index 227daca..17389f1 100644
--- a/arch/sparc/kernel/prom.c
+++ b/arch/sparc/kernel/prom.c
@@ -575,6 +575,8 @@ EXPORT_SYMBOL(of_console_path);
 char *of_console_options;
 EXPORT_SYMBOL(of_console_options);
 
+extern void restore_current(void);
+
 static void __init of_console_init(void)
 {
 	char *msg = "OF stdout device is: %s";
@@ -633,6 +635,7 @@ static void __init of_console_init(void)
 
 		spin_lock_irqsave(&prom_lock, flags);
 		node = (*romvec->pv_v2devops.v2_inst2pkg)(fd);
+		restore_current();
 		spin_unlock_irqrestore(&prom_lock, flags);
 
 		if (!node) {

From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Date: Sat, 26 May 2007 01:13:34 +0000
Subject: [PATCH] arch/sparc64/time.c doesn't compile on Ultra 1 (no PCI)
Message-Id: <200705260113.l4Q1DYFc007820@laptop13.inf.utfsm.cl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is bug 8540 on bugzilla.kernel.org, my patch (below) was OKed by
Andrew Morton there.

arch/sparc64/time.c contains references to assorted bq4802 stuff if
CONFIG_PCI is not set, and compile fails. I #ifdef'ed out everything that
looks PCI-ish in that file.

diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index 2d63d76..1a8de25 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -1365,6 +1365,7 @@ static int hypervisor_set_rtc_time(struct rtc_time *time)
 	return hypervisor_set_time(seconds);
 }
 
+#ifdef CONFIG_PCI
 static void bq4802_get_rtc_time(struct rtc_time *time)
 {
 	unsigned char val = readb(bq4802_regs + 0x0e);
@@ -1436,6 +1437,7 @@ static int bq4802_set_rtc_time(struct rtc_time *time)
 
 	return 0;
 }
+#endif /* CONFIG_PCI */
 
 struct mini_rtc_ops {
 	void (*get_rtc_time)(struct rtc_time *);
@@ -1452,10 +1454,12 @@ static struct mini_rtc_ops hypervisor_rtc_ops = {
 	.set_rtc_time = hypervisor_set_rtc_time,
 };
 
+#ifdef CONFIG_PCI
 static struct mini_rtc_ops bq4802_rtc_ops = {
 	.get_rtc_time = bq4802_get_rtc_time,
 	.set_rtc_time = bq4802_set_rtc_time,
 };
+#endif /* CONFIG_PCI */
 
 static struct mini_rtc_ops *mini_rtc_ops;
 
@@ -1579,8 +1583,10 @@ static int __init rtc_mini_init(void)
 		mini_rtc_ops = &hypervisor_rtc_ops;
 	else if (this_is_starfire)
 		mini_rtc_ops = &starfire_rtc_ops;
+#ifdef CONFIG_PCI
 	else if (bq4802_regs)
 		mini_rtc_ops = &bq4802_rtc_ops;
+#endif /* CONFIG_PCI */		
 	else
 		return -ENODEV;
 
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513

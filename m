From: David Miller <davem@davemloft.net>
Date: Fri, 12 Aug 2011 00:59:14 +0000
Subject: Re: Bug report: booting 3.1-rc1 on Sunfire V120 fails
Message-Id: <20110811.175914.351039008543512190.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <400C43189542CE41BC0A5B252FC90136A995C8D7EB@SJEXCHCCR02.corp.ad.broadcom.com>
In-Reply-To: <400C43189542CE41BC0A5B252FC90136A995C8D7EB@SJEXCHCCR02.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Pieter-Paul Giesberts" <pieterpg@broadcom.com>
Date: Thu, 11 Aug 2011 08:52:05 -0700

> [   56.043741] swapper(1): Kernel bad sw trap 7f [#1]

We shouldn't be trying sun4v traps on sun4u hardware :-)

This patch should fix it, thanks for the report:

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 490e541..7429b47 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -1256,13 +1256,14 @@ static int __init ds_init(void)
 {
 	unsigned long hv_ret, major, minor;
 
-	hv_ret = sun4v_get_version(HV_GRP_REBOOT_DATA, &major, &minor);
-	if (hv_ret = HV_EOK) {
-		pr_info("SUN4V: Reboot data supported (maj=%lu,min=%lu).\n",
-			major, minor);
-		reboot_data_supported = 1;
+	if (tlb_type = hypervisor) {
+		hv_ret = sun4v_get_version(HV_GRP_REBOOT_DATA, &major, &minor);
+		if (hv_ret = HV_EOK) {
+			pr_info("SUN4V: Reboot data supported (maj=%lu,min=%lu).\n",
+				major, minor);
+			reboot_data_supported = 1;
+		}
 	}
-
 	kthread_run(ds_thread, NULL, "kldomd");
 
 	return vio_register_driver(&ds_driver);

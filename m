From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Fri, 04 Mar 2005 05:44:39 +0000
Subject: [PATCH 2.6] More sparc32 ksyms cleanups
Message-Id: <1109915079.17038.69.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-7Casd1bYroQA7cqJbSq5"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-7Casd1bYroQA7cqJbSq5
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The sparc32 ksyms is missing a few more symbols, these are primarily
related to SMP, and will be needed as SMP gets beaten back into
functionality.

Specifically, add __cpu_data (PER_CPU), cpu_online_map, and
phys_cpu_present_map.

This patch assumes that the earlier "linux-2.6.11-sparc-fixksyms.patch"
is applied, otherwise, it will apply with fuzz.

Signed-off-by: Tom 'spot' Callaway <tcallawa@redhat.com>

~spot
---
Tom "spot" Callaway: Red Hat Sales Engineer || GPG Fingerprint: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-7Casd1bYroQA7cqJbSq5
Content-Disposition: attachment; filename=linux-2.6.11-sparc-fixksyms2.patch
Content-Type: text/x-patch; name=linux-2.6.11-sparc-fixksyms2.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.11/arch/sparc/kernel/sparc_ksyms.c.BAD	2005-03-04 00:39:52.444257587 -0500
+++ linux-2.6.11/arch/sparc/kernel/sparc_ksyms.c	2005-03-04 00:44:03.843039163 -0500
@@ -148,6 +148,9 @@ EXPORT_SYMBOL(___set_bit);
 EXPORT_SYMBOL(___clear_bit);
 EXPORT_SYMBOL(___change_bit);
 
+/* Per-CPU information table */
+EXPORT_PER_CPU_SYMBOL(__cpu_data);
+
 #ifdef CONFIG_SMP
 /* IRQ implementation. */
 EXPORT_SYMBOL(synchronize_irq);
@@ -155,6 +158,10 @@ EXPORT_SYMBOL(synchronize_irq);
 /* Misc SMP information */
 EXPORT_SYMBOL(__cpu_number_map);
 EXPORT_SYMBOL(__cpu_logical_map);
+
+/* CPU online map and active count. */
+EXPORT_SYMBOL(cpu_online_map);
+EXPORT_SYMBOL(phys_cpu_present_map);
 #endif
 
 EXPORT_SYMBOL(__udelay);

--=-7Casd1bYroQA7cqJbSq5--


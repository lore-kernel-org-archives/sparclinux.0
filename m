From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 05 Jun 2008 18:26:42 +0000
Subject: [2.6 patch] sparc: remove PROM_AP1000
Message-Id: <20080605182641.GJ1469@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This seems to be left from the long gone AP1000 support.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---
9f3bccd9b0249260320b2c567d421d36023df077 diff --git a/include/asm-sparc/oplib.h b/include/asm-sparc/oplib.h
index 61c3ca6..00f487e 100644
--- a/include/asm-sparc/oplib.h
+++ b/include/asm-sparc/oplib.h
@@ -21,7 +21,6 @@ enum prom_major_version {
 	PROM_V2,      /* sun4c and early sun4m V2 prom */
 	PROM_V3,      /* sun4m and later, up to sun4d/sun4e machines V3 */
 	PROM_P1275,   /* IEEE compliant ISA based Sun PROM, only sun4u */
-        PROM_AP1000,  /* actually no prom at all */
 	PROM_SUN4,    /* Old sun4 proms are totally different, but we'll shoehorn it to make it fit */
 };
 


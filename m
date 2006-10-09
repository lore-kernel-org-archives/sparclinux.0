From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Mon, 09 Oct 2006 16:48:20 +0000
Subject: [PATCH] sparc32: Fix prom.c build warning
Message-Id: <20061009164820.GA26520@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix these 2.6.19-rc1 build warnings:

  CC      arch/sparc/kernel/prom.o
arch/sparc/kernel/prom.c: In function `of_set_property':
arch/sparc/kernel/prom.c:246: warning: passing arg 2 of `prom_setprop' discards qualifiers from pointer target type
arch/sparc/kernel/prom.c: In function `build_one_prop':
arch/sparc/kernel/prom.c:446: warning: unused variable `len'
arch/sparc/kernel/prom.c:480: warning: ignoring return value of `prom_getproperty', declared with attribute warn_unused_result

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Index: linux/arch/sparc/kernel/prom.c
=================================--- linux.orig/arch/sparc/kernel/prom.c	2006-10-06 00:33:30.000000000 +0100
+++ linux/arch/sparc/kernel/prom.c	2006-10-07 01:01:22.000000000 +0100
@@ -243,7 +243,7 @@
 			void *old_val = prop->value;
 			int ret;
 
-			ret = prom_setprop(dp->node, name, val, len);
+			ret = prom_setprop(dp->node, (char *) name, val, len);
 			err = -EINVAL;
 			if (ret >= 0) {
 				prop->value = new_val;
@@ -477,7 +477,9 @@
 			p->length = 0;
 		} else {
 			p->value = prom_early_alloc(p->length + 1);
-			prom_getproperty(node, p->name, p->value, p->length);
+			len = prom_getproperty(node, p->name, p->value,
+					       p->length);
+			if (len <= 0) p->length = 0;
 			((unsigned char *)p->value)[p->length] = '\0';
 		}
 	}

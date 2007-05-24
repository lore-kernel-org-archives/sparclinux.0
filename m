From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 May 2007 20:11:33 +0000
Subject: [PATCH 2/5] asm-generic: add RO_DATA which take alignment parameter
Message-Id: <20070524201133.GD1109@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200440.GA1109@uranus.ravnborg.org>
In-Reply-To: <20070524200440.GA1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

RODATA has a hardcoded alignment of 4096 but architectures
may which to decide their optimal alignmnet.
Introduce RO_DATA that takes an alignment parameter.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 include/asm-generic/vmlinux.lds.h |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 8307b1b..5388c41 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -14,8 +14,8 @@
 	*(.data)							\
 	*(.data.init.refok)
 
-#define RODATA								\
-	. = ALIGN(4096);						\
+#define RO_DATA(align)							\
+	. = ALIGN((align));						\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start_rodata) = .;			\
 		*(.rodata) *(.rodata.*)					\
@@ -135,7 +135,10 @@
 		VMLINUX_SYMBOL(__end_rodata) = .;			\
 	}								\
 									\
-	. = ALIGN(4096);
+	. = ALIGN((align));
+
+/* for backward compatibility */
+#define RODATA RO_DATA(4096)
 
 #define SECURITY_INIT							\
 	.security_initcall.init : AT(ADDR(.security_initcall.init) - LOAD_OFFSET) { \
-- 
1.5.1.rc3.20.gaa453


From: Akinobu Mita <mita@miraclelinux.com>
Date: Tue, 14 Feb 2006 05:03:59 +0000
Subject: [patch 08/47] generic __ffs()
Message-Id: <20060214050443.261426000@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20060214050351.252615000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org, linuxsh-dev@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>, Akinobu Mita <mita@miraclelinux.com>

This patch introduces the C-language equivalent of the function:
unsigned long __ffs(unsigned long word);

In include/asm-generic/bitops/__ffs.h

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/__ffs.h |   43 +++++++++++++++++++++++++++++++++++++
 1 files changed, 43 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/__ffs.h
=================================--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/__ffs.h
@@ -0,0 +1,43 @@
+#ifndef _ASM_GENERIC_BITOPS___FFS_H_
+#define _ASM_GENERIC_BITOPS___FFS_H_
+
+#include <asm/types.h>
+
+/**
+ * __ffs - find first bit in word.
+ * @word: The word to search
+ *
+ * Undefined if no bit exists, so code should check against 0 first.
+ */
+static inline unsigned long __ffs(unsigned long word)
+{
+	int num = 0;
+
+#if BITS_PER_LONG = 64
+	if ((word & 0xffffffff) = 0) {
+		num += 32;
+		word >>= 32;
+	}
+#endif
+	if ((word & 0xffff) = 0) {
+		num += 16;
+		word >>= 16;
+	}
+	if ((word & 0xff) = 0) {
+		num += 8;
+		word >>= 8;
+	}
+	if ((word & 0xf) = 0) {
+		num += 4;
+		word >>= 4;
+	}
+	if ((word & 0x3) = 0) {
+		num += 2;
+		word >>= 2;
+	}
+	if ((word & 0x1) = 0)
+		num += 1;
+	return num;
+}
+
+#endif /* _ASM_GENERIC_BITOPS___FFS_H_ */

--

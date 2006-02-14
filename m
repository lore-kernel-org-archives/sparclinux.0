From: Akinobu Mita <mita@miraclelinux.com>
Date: Tue, 14 Feb 2006 05:04:00 +0000
Subject: [patch 09/47] generic ffz()
Message-Id: <20060214050443.468528000@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20060214050351.252615000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, Russell King <rmk@arm.linux.org.uk>, Ian Molton <spyro@f2s.com>, David Howells <dhowells@redhat.com>, Hirokazu Takata <takata@linux-m32r.org>, Greg Ungerer <gerg@uclinux.org>, linux-mips@linux-mips.org, parisc-linux@parisc-linux.org, sparclinux@vger.kernel.org, ultralinux@vger.kernel.org, Miles Bader <uclinux-v850@lsi.nec.co.jp>, Akinobu Mita <mita@miraclelinux.com>

This patch introduces the C-language equivalent of the function:
unsigned long ffz(unsigned long word);

In include/asm-generic/bitops/ffz.h

This code largely copied from:
include/asm-parisc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ffz.h |   12 ++++++++++++
 1 files changed, 12 insertions(+)

Index: 2.6-rc/include/asm-generic/bitops/ffz.h
=================================--- /dev/null
+++ 2.6-rc/include/asm-generic/bitops/ffz.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_GENERIC_BITOPS_FFZ_H_
+#define _ASM_GENERIC_BITOPS_FFZ_H_
+
+/*
+ * ffz - find first zero in word.
+ * @word: The word to search
+ *
+ * Undefined if no zero exists, so code should check against ~0UL first.
+ */
+#define ffz(x)  __ffs(~(x))
+
+#endif /* _ASM_GENERIC_BITOPS_FFZ_H_ */

--

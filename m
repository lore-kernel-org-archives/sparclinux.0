From: zengzhaoxiu@163.com
Date: Wed, 11 May 2016 09:13:18 +0000
Subject: [patch V4 08/31] bitops: Add sparc-specific parity functions
Message-Id: <1462958007-24716-1-git-send-email-zengzhaoxiu@163.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sam@ravnborg.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>, "David S. Miller" <davem@davemloft.net>, "wim.coekaerts@oracle.com" <wim.coekaerts@oracle.com>, Guenter Roeck <linux@roeck-us.net>, Julian Calaby <julian.calaby@gmail.com>, sparclinux@vger.kernel.org

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Use runtime patching for sparc64, lifted from hweight

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 arch/sparc/include/asm/bitops_32.h |   1 +
 arch/sparc/include/asm/bitops_64.h |  18 ++++++
 arch/sparc/kernel/sparc_ksyms_64.c |   6 ++
 arch/sparc/lib/Makefile            |   2 +-
 arch/sparc/lib/parity.S            | 129 +++++++++++++++++++++++++++++++++++++
 5 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 arch/sparc/lib/parity.S

diff --git a/arch/sparc/include/asm/bitops_32.h b/arch/sparc/include/asm/bitops_32.h
index 600ed1d..8c41896 100644
--- a/arch/sparc/include/asm/bitops_32.h
+++ b/arch/sparc/include/asm/bitops_32.h
@@ -98,6 +98,7 @@ static inline void change_bit(unsigned long nr, volatile unsigned long *addr)
 #include <asm-generic/bitops/__fls.h>
 #include <asm-generic/bitops/fls64.h>
 #include <asm-generic/bitops/hweight.h>
+#include <asm-generic/bitops/parity.h>
 #include <asm-generic/bitops/lock.h>
 #include <asm-generic/bitops/find.h>
 #include <asm-generic/bitops/le.h>
diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index 2d52240..999d504 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -47,6 +47,24 @@ unsigned int __arch_hweight16(unsigned int w);
 unsigned int __arch_hweight8(unsigned int w);
 
 #include <asm-generic/bitops/const_hweight.h>
+
+/*
+ * parityN: returns the parity of a N-bit word,
+ * i.e. the number of 1-bits in w modulo 2.
+ */
+
+static inline unsigned int __arch_parity4(unsigned int w)
+{
+	w &= 0xf;
+	return ((PARITY_MAGIC) >> w) & 1;
+}
+unsigned int __arch_parity8(unsigned int w);
+unsigned int __arch_parity16(unsigned int w);
+unsigned int __arch_parity32(unsigned int w);
+unsigned int __arch_parity64(__u64 w);
+
+#include <asm-generic/bitops/const_parity.h>
+
 #include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index 9e034f2..7ee0818 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -45,6 +45,12 @@ EXPORT_SYMBOL(__arch_hweight16);
 EXPORT_SYMBOL(__arch_hweight32);
 EXPORT_SYMBOL(__arch_hweight64);
 
+/* from parity.S */
+EXPORT_SYMBOL(__arch_parity8);
+EXPORT_SYMBOL(__arch_parity16);
+EXPORT_SYMBOL(__arch_parity32);
+EXPORT_SYMBOL(__arch_parity64);
+
 /* from ffs_ffz.S */
 EXPORT_SYMBOL(ffs);
 EXPORT_SYMBOL(__ffs);
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 3269b02..2dbbcb1 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -39,7 +39,7 @@ lib-$(CONFIG_SPARC64) += GENmemcpy.o GENcopy_from_user.o GENcopy_to_user.o
 lib-$(CONFIG_SPARC64) += GENpatch.o GENpage.o GENbzero.o
 
 lib-$(CONFIG_SPARC64) += copy_in_user.o user_fixup.o memmove.o
-lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o
+lib-$(CONFIG_SPARC64) += mcount.o ipcsum.o xor.o hweight.o ffs.o parity.o
 
 obj-$(CONFIG_SPARC64) += iomap.o
 obj-$(CONFIG_SPARC32) += atomic32.o ucmpdi2.o
diff --git a/arch/sparc/lib/parity.S b/arch/sparc/lib/parity.S
new file mode 100644
index 0000000..ddfba96
--- /dev/null
+++ b/arch/sparc/lib/parity.S
@@ -0,0 +1,129 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
+ *
+ */
+
+#include <linux/linkage.h>
+
+/*
+ * This file contains the generic code to calculate the parity
+ * of N-bits number, and the popc-patches.
+ */
+
+	.text
+	.align	32
+
+#define PARITY_MAGIC 0x6996
+
+/*
+ * unsigned int __arch_parity8(unsigned int w)
+ */
+ENTRY(__arch_parity8)
+	srl		%o0, 4, %g1
+	xor		%o0, %g1, %o0
+	and		%o0, 0xf, %o0
+	sethi		%hi(PARITY_MAGIC), %g1
+	or		%g1, %lo(PARITY_MAGIC), %g1
+	srl		%g1, %o0, %o0
+	retl
+	 and		%o0, 1, %o0
+ENDPROC(__arch_parity8)
+	.section	.popc_6insn_patch, "ax"
+	.word		__arch_parity8
+	sllx		%o0, 64-8, %g1
+	popc		%g1, %o0
+	retl
+	 and		%o0, 1, %o0
+	nop
+	nop
+	.previous
+
+/*
+ * unsigned int __arch_parity16(unsigned int w)
+ */
+ENTRY(__arch_parity16)
+	srl		%o0, 8, %g1
+	xor		%o0, %g1, %o0
+	srl		%o0, 4, %g1
+	xor		%o0, %g1, %o0
+	and		%o0, 0xf, %o0
+	sethi		%hi(PARITY_MAGIC), %g1
+	or		%g1, %lo(PARITY_MAGIC), %g1
+	srl		%g1, %o0, %o0
+	retl
+	 and		%o0, 1, %o0
+ENDPROC(__arch_parity16)
+	.section	.popc_6insn_patch, "ax"
+	.word		__arch_parity16
+	sllx		%o0, 64-16, %g1
+	popc		%g1, %o0
+	retl
+	 and		%o0, 1, %o0
+	nop
+	nop
+	.previous
+
+/*
+ * unsigned int __arch_parity32(unsigned int w)
+ */
+ENTRY(__arch_parity32)
+	srl		%o0, 16, %g1
+	xor		%o0, %g1, %o0
+	srl		%o0, 8, %g1
+	xor		%o0, %g1, %o0
+	srl		%o0, 4, %g1
+	xor		%o0, %g1, %o0
+	and		%o0, 0xf, %o0
+	sethi		%hi(PARITY_MAGIC), %g1
+	or		%g1, %lo(PARITY_MAGIC), %g1
+	srl		%g1, %o0, %o0
+	retl
+	 and		%o0, 1, %o0
+ENDPROC(__arch_parity32)
+	.section	.popc_6insn_patch, "ax"
+	.word		__arch_parity32
+	sllx		%o0, 64-32, %g1
+	popc		%g1, %o0
+	retl
+	 and		%o0, 1, %o0
+	nop
+	nop
+	.previous
+
+/*
+ * unsigned int __arch_parity64(__u64 w)
+ */
+ENTRY(__arch_parity64)
+	srlx	%o0, 32, %g1
+	xor		%o0, %g1, %o0
+	srl		%o0, 16, %g1
+	xor		%o0, %g1, %o0
+	srl		%o0, 8, %g1
+	xor		%o0, %g1, %o0
+	srl		%o0, 4, %g1
+	xor		%o0, %g1, %o0
+	and		%o0, 0xf, %o0
+	sethi		%hi(PARITY_MAGIC), %g1
+	or		%g1, %lo(PARITY_MAGIC), %g1
+	srl		%g1, %o0, %o0
+	retl
+	 and		%o0, 1, %o0
+ENDPROC(__arch_parity64)
+	.section	.popc_3insn_patch, "ax"
+	.word		__arch_parity64
+	popc		%o0, %o0
+	retl
+	 and		%o0, 1, %o0
+	.previous
-- 
2.7.4



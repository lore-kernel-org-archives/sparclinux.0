From: Akinobu Mita <mita@miraclelinux.com>
Date: Wed, 01 Feb 2006 09:02:40 +0000
Subject: [patch 16/44] generic ext2_{set,clear}_bit_atomic()
Message-Id: <20060201090326.300490000@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <20060201090224.536581000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Hirokazu Takata <takata@linux-m32r.org>, linux-mips@linux-mips.org, linuxsh-dev@lists.sourceforge.net, linuxsh-shmedia-dev@lists.sourceforge.net, sparclinux@vger.kernel.org, Akinobu Mita <mita@miraclelinux.com>

This patch introduces the C-language equivalents of the functions below:

int ext2_set_bit_atomic(int nr, volatile unsigned long *addr);
int ext2_clear_bit_atomic(int nr, volatile unsigned long *addr);

In include/asm-generic/bitops/ext2-atomic.h

This code largely copied from:
include/asm-sparc/bitops.h

Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
 include/asm-generic/bitops/ext2-atomic.h |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+)

Index: 2.6-git/include/asm-generic/bitops/ext2-atomic.h
=================================--- /dev/null
+++ 2.6-git/include/asm-generic/bitops/ext2-atomic.h
@@ -0,0 +1,22 @@
+#ifndef _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_
+#define _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_
+
+#define ext2_set_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_set_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#define ext2_clear_bit_atomic(lock, nr, addr)		\
+	({						\
+		int ret;				\
+		spin_lock(lock);			\
+		ret = ext2_clear_bit((nr), (unsigned long *)(addr)); \
+		spin_unlock(lock);			\
+		ret;					\
+	})
+
+#endif /* _ASM_GENERIC_BITOPS_EXT2_ATOMIC_H_ */

--

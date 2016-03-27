From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Date: Sun, 27 Mar 2016 06:43:10 +0000
Subject: [PATCH 10/31] Add sparc-specific parity functions
Message-Id: <56F780FE.7000600@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 arch/sparc/include/asm/bitops_32.h |  1 +
 arch/sparc/include/asm/bitops_64.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

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
index 2d52240..4d3dcb3 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -47,6 +47,19 @@ unsigned int __arch_hweight16(unsigned int w);
 unsigned int __arch_hweight8(unsigned int w);
 
 #include <asm-generic/bitops/const_hweight.h>
+
+/*
+ * parityN: returns the parity of a N-bit word,
+ * i.e. the number of 1-bits in x modulo 2.
+ */
+
+#define __arch_parity4(w)	(__arch_hweight8((w) & 0xf) & 1)
+#define __arch_parity8(w)	(__arch_hweight8(w) & 1)
+#define __arch_parity16(w)	(__arch_hweight16(w) & 1)
+#define __arch_parity32(w)	(__arch_hweight32(w) & 1)
+#define __arch_parity64(w)	((unsigned int)__arch_hweight64(w) & 1)
+
+#include <asm-generic/bitops/const_hweight.h>
 #include <asm-generic/bitops/lock.h>
 #endif /* __KERNEL__ */
 
-- 
2.5.5


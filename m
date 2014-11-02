From: Clemens Ladisch <clemens@ladisch.de>
Date: Sun, 02 Nov 2014 20:15:12 +0000
Subject: [PATCH] sparc64: Add preprocessor symbols for PAGE_* pgprot_t values.
Message-Id: <545690D0.5040904@ladisch.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Kernel code assumes that the PAGE_* values are preprocessor symbols, and
that therefore arch support can be checked for with #ifdef.

At the moment, sparc64 does not implement any of the symbols checked
for, so these checks happen to work.

To prevent potential breakage when another #ifdef check is added or when
sparc64 implements another PAGE_ value, make such #ifdef checks work by
adding preprocessor symbols on top of the PAGE_* variables.

Signed-off-by: Clemens Ladisch <clemens@ladisch.de>
---
 arch/sparc/include/asm/pgtable_64.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
index bfeb626..a835fe9 100644
--- a/arch/sparc/include/asm/pgtable_64.h
+++ b/arch/sparc/include/asm/pgtable_64.h
@@ -216,9 +216,13 @@ pte_t mk_pte_io(unsigned long, pgprot_t, int, unsigned long);
 unsigned long pte_sz_bits(unsigned long size);

 extern pgprot_t PAGE_KERNEL;
+#define PAGE_KERNEL		PAGE_KERNEL
 extern pgprot_t PAGE_KERNEL_LOCKED;
+#define PAGE_KERNEL_LOCKED	PAGE_KERNEL_LOCKED
 extern pgprot_t PAGE_COPY;
+#define PAGE_COPY		PAGE_COPY
 extern pgprot_t PAGE_SHARED;
+#define PAGE_SHARED		PAGE_SHARED

 /* XXX This uglyness is for the atyfb driver's sparc mmap() support. XXX */
 extern unsigned long _PAGE_IE;

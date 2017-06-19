From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Mon, 19 Jun 2017 17:08:50 +0000
Subject: [PATCH 3/3] Adding the type of exported symbols
Message-Id: <1497892130-875525-4-git-send-email-nagarathnam.muthusamy@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Missing symbol type for few functions prevents genksyms from generating
symbol versions for those functions. This patch fixes them.

Signed-off-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>

---
 arch/sparc/lib/checksum_64.S |    1 +
 arch/sparc/lib/csum_copy.S   |    1 +
 arch/sparc/lib/memscan_64.S  |    2 ++
 arch/sparc/lib/memset.S      |    1 +
 4 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/lib/checksum_64.S b/arch/sparc/lib/checksum_64.S
index f673217..6cfa521 100644
--- a/arch/sparc/lib/checksum_64.S
+++ b/arch/sparc/lib/checksum_64.S
@@ -38,6 +38,7 @@ csum_partial_fix_alignment:
 
 	.align		32
 	.globl		csum_partial
+	.type		csum_partial,#function
 	EXPORT_SYMBOL(csum_partial)
 csum_partial:		/* %o0=buff, %o1=len, %o2=sum */
 	prefetch	[%o0 + 0x000], #n_reads
diff --git a/arch/sparc/lib/csum_copy.S b/arch/sparc/lib/csum_copy.S
index 0ecbafc..b1051e7 100644
--- a/arch/sparc/lib/csum_copy.S
+++ b/arch/sparc/lib/csum_copy.S
@@ -65,6 +65,7 @@
 	 add		%o5, %o4, %o4
 
 	.globl		FUNC_NAME
+	.type		FUNC_NAME,#function
 	EXPORT_SYMBOL(FUNC_NAME)
 FUNC_NAME:		/* %o0=src, %o1=dst, %o2=len, %o3=sum */
 	LOAD(prefetch, %o0 + 0x000, #n_reads)
diff --git a/arch/sparc/lib/memscan_64.S b/arch/sparc/lib/memscan_64.S
index daa96f4..5efee1f 100644
--- a/arch/sparc/lib/memscan_64.S
+++ b/arch/sparc/lib/memscan_64.S
@@ -14,6 +14,8 @@
 	.text
 	.align	32
 	.globl		__memscan_zero, __memscan_generic
+	.type		__memscan_zero,#function
+	.type		__memscan_generic,#function
 	.globl		memscan
 	EXPORT_SYMBOL(__memscan_zero)
 	EXPORT_SYMBOL(__memscan_generic)
diff --git a/arch/sparc/lib/memset.S b/arch/sparc/lib/memset.S
index bb539b4..e23338d 100644
--- a/arch/sparc/lib/memset.S
+++ b/arch/sparc/lib/memset.S
@@ -63,6 +63,7 @@
 __bzero_begin:
 
 	.globl	__bzero
+	.type	__bzero,#function
 	.globl	memset
 	EXPORT_SYMBOL(__bzero)
 	EXPORT_SYMBOL(memset)
-- 
1.7.1


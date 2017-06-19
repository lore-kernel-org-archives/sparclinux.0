From: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Date: Mon, 19 Jun 2017 17:08:49 +0000
Subject: [PATCH 2/3] sed regex in Makefile.build requires line break between exported symbols
Message-Id: <1497892130-875525-3-git-send-email-nagarathnam.muthusamy@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The following regex in Makefile.build matches only one ___EXPORT_SYMBOL per line.

sed
's/.*___EXPORT_SYMBOL[[:space:]]*\([a-zA-Z0-9_]*\)[[:space:]]*,.*/EXPORT_SYMBOL(\1);/'

ATOMIC_OPS macro in atomic_64.S expands multiple symbols in same line hence
version generation is done only for the last matched symbol. This patch adds
new line between the symbol expansions.

Signed-off-by: Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>

---
 arch/sparc/lib/atomic_64.S |   44 ++++++++++++++++++++++++++------------------
 1 files changed, 26 insertions(+), 18 deletions(-)

diff --git a/arch/sparc/lib/atomic_64.S b/arch/sparc/lib/atomic_64.S
index 1c6a1bd..ce17c30 100644
--- a/arch/sparc/lib/atomic_64.S
+++ b/arch/sparc/lib/atomic_64.S
@@ -62,19 +62,23 @@ ENTRY(atomic_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 ENDPROC(atomic_fetch_##op);						\
 EXPORT_SYMBOL(atomic_fetch_##op);
 
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_OP_RETURN(op) ATOMIC_FETCH_OP(op)
+ATOMIC_OP(add)
+ATOMIC_OP_RETURN(add)
+ATOMIC_FETCH_OP(add)
 
-ATOMIC_OPS(add)
-ATOMIC_OPS(sub)
+ATOMIC_OP(sub)
+ATOMIC_OP_RETURN(sub)
+ATOMIC_FETCH_OP(sub)
 
-#undef ATOMIC_OPS
-#define ATOMIC_OPS(op) ATOMIC_OP(op) ATOMIC_FETCH_OP(op)
+ATOMIC_OP(and)
+ATOMIC_FETCH_OP(and)
 
-ATOMIC_OPS(and)
-ATOMIC_OPS(or)
-ATOMIC_OPS(xor)
+ATOMIC_OP(or)
+ATOMIC_FETCH_OP(or)
+
+ATOMIC_OP(xor)
+ATOMIC_FETCH_OP(xor)
 
-#undef ATOMIC_OPS
 #undef ATOMIC_FETCH_OP
 #undef ATOMIC_OP_RETURN
 #undef ATOMIC_OP
@@ -124,19 +128,23 @@ ENTRY(atomic64_fetch_##op) /* %o0 = increment, %o1 = atomic_ptr */	\
 ENDPROC(atomic64_fetch_##op);						\
 EXPORT_SYMBOL(atomic64_fetch_##op);
 
-#define ATOMIC64_OPS(op) ATOMIC64_OP(op) ATOMIC64_OP_RETURN(op) ATOMIC64_FETCH_OP(op)
+ATOMIC64_OP(add)
+ATOMIC64_OP_RETURN(add)
+ATOMIC64_FETCH_OP(add)
+
+ATOMIC64_OP(sub)
+ATOMIC64_OP_RETURN(sub)
+ATOMIC64_FETCH_OP(sub)
 
-ATOMIC64_OPS(add)
-ATOMIC64_OPS(sub)
+ATOMIC64_OP(and)
+ATOMIC64_FETCH_OP(and)
 
-#undef ATOMIC64_OPS
-#define ATOMIC64_OPS(op) ATOMIC64_OP(op) ATOMIC64_FETCH_OP(op)
+ATOMIC64_OP(or)
+ATOMIC64_FETCH_OP(or)
 
-ATOMIC64_OPS(and)
-ATOMIC64_OPS(or)
-ATOMIC64_OPS(xor)
+ATOMIC64_OP(xor)
+ATOMIC64_FETCH_OP(xor)
 
-#undef ATOMIC64_OPS
 #undef ATOMIC64_FETCH_OP
 #undef ATOMIC64_OP_RETURN
 #undef ATOMIC64_OP
-- 
1.7.1


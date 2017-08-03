From: Zi Yan <zi.yan@sent.com>
Date: Thu, 03 Aug 2017 13:17:21 +0000
Subject: [PATCH] mm: add pmd_t initializer __pmd() to work around a GCC bug.
Message-Id: <20170803131721.74011-1-zi.yan@sent.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>, "David S . Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: Zi Yan <zi.yan@cs.rutgers.edu>

From: Zi Yan <zi.yan@cs.rutgers.edu>

THP migration is added but only supports x86_64 at the moment. For all
other architectures, swp_entry_to_pmd() only returns a zero pmd_t.

Due to a GCC zero initializer bug #53119, the standard (pmd_t){0}
initializer is not accepted by all GCC versions. __pmd() is a feasible
workaround. In addition, sparc32's pmd_t is an array instead of a single
value, so we need (pmd_t){ {0}, } instead of (pmd_t){0}. Thus,
a different __pmd() definition is needed in sparc32.

Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
---
 arch/sparc/include/asm/page_32.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/page_32.h b/arch/sparc/include/asm/page_32.h
index 0efd0583a8c9..6249214148c2 100644
--- a/arch/sparc/include/asm/page_32.h
+++ b/arch/sparc/include/asm/page_32.h
@@ -68,6 +68,7 @@ typedef struct { unsigned long iopgprot; } iopgprot_t;
 #define iopgprot_val(x)	((x).iopgprot)
 
 #define __pte(x)	((pte_t) { (x) } )
+#define __pmd(x)	((pmd_t) { { (x) }, })
 #define __iopte(x)	((iopte_t) { (x) } )
 #define __pgd(x)	((pgd_t) { (x) } )
 #define __ctxd(x)	((ctxd_t) { (x) } )
@@ -95,6 +96,7 @@ typedef unsigned long iopgprot_t;
 #define iopgprot_val(x)	(x)
 
 #define __pte(x)	(x)
+#define __pmd(x)	((pmd_t) { { (x) }, })
 #define __iopte(x)	(x)
 #define __pgd(x)	(x)
 #define __ctxd(x)	(x)
-- 
2.13.2


From: Konrad Eisele <konrad@gaisler.com>
Date: Tue, 11 Oct 2011 12:20:00 +0000
Subject: [PATCH 4/5] sparc32: return destination pointer on return from memcpy
Message-Id: <1318335600-25561-2-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1318335487-25506-5-git-send-email-konrad@gaisler.com>
In-Reply-To: <1318335487-25506-5-git-send-email-konrad@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Gcc can optimize constant strcpy to a memcpy call. However
the return value of strcpy is used in KGDB. Return the standard return
value instead of 0

Signed-off-by: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/lib/memcpy.S |    8 ++------
 1 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/lib/memcpy.S b/arch/sparc/lib/memcpy.S
index 34fe657..835014b 100644
--- a/arch/sparc/lib/memcpy.S
+++ b/arch/sparc/lib/memcpy.S
@@ -19,12 +19,8 @@ x:
 #undef FASTER_NONALIGNED
 #define FASTER_ALIGNED
 
-/* In kernel these functions don't return a value.
- * One should use macros in asm/string.h for that purpose.
- * We return 0, so that bugs are more apparent.
- */
-#define SETUP_RETL
-#define RETL_INSN	clr	%o0
+#define SETUP_RETL	mov	%o0, %g6
+#define RETL_INSN	mov	%g6, %o0
 
 #else
 
-- 
1.6.4.1


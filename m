From: Andreas Larsson <andreas@gaisler.com>
Date: Mon, 01 Jul 2013 14:16:07 +0000
Subject: [PATCH] sparc32, leon: Require separate snoop tags set to regard snooping to be enabled
Message-Id: <1372688167-16432-1-git-send-email-andreas@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Even if data snooping is enabled, without separate snoop tags snooping will not
work when the MMU is enabled.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/include/asm/leon.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index b836e92..c2f6ff6 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -108,7 +108,7 @@ static inline int sparc_leon3_snooping_enabled(void)
 {
 	u32 cctrl;
 	__asm__ __volatile__("lda [%%g0] 2, %0\n\t" : "=r"(cctrl));
-        return (cctrl >> 23) & 1;
+	return ((cctrl >> 23) & 1) && ((cctrl >> 17) & 1);
 };
 
 static inline void sparc_leon3_disable_cache(void)
-- 
1.7.10.4


From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Mar 2013 14:35:04 +0000
Subject: [PATCH] sparc64: Provide cmpxchg64()
Message-Id: <1363790104-8140-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

sparc64 allmodconfig:

drivers/block/blockconsole.c: In function ‘bcon_advance_console_bytes’:
drivers/block/blockconsole.c:164: error: implicit declaration of function ‘cmpxchg64’

Map cmpxchg64() to cmpxchg64_local() (which eventually calls
__cmpxchg_u64()) to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/sparc/include/asm/cmpxchg_64.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_64.h b/arch/sparc/include/asm/cmpxchg_64.h
index b30eb37..4adefe8 100644
--- a/arch/sparc/include/asm/cmpxchg_64.h
+++ b/arch/sparc/include/asm/cmpxchg_64.h
@@ -141,5 +141,6 @@ static inline unsigned long __cmpxchg_local(volatile void *ptr,
 	BUILD_BUG_ON(sizeof(*(ptr)) != 8);				\
 	cmpxchg_local((ptr), (o), (n));					\
   })
+#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC64_CMPXCHG__ */
-- 
1.7.0.4


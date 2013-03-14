From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 14 Mar 2013 19:42:08 +0000
Subject: [PATCH -next] sparc32/sparc64: Provide cmpxchg64()
Message-Id: <1363290128-21247-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-next@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

sparc/sparc64 allmodconfig:

drivers/block/blockconsole.c: In function ‘bcon_advance_console_bytes’:
drivers/block/blockconsole.c:164: error: implicit declaration of function
‘cmpxchg64’

Map cmpxchg64 to cmpxchg64_local to fix this.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
http://kisskb.ellerman.id.au/kisskb/buildresult/8398811/
http://kisskb.ellerman.id.au/kisskb/buildresult/8398801/

 arch/sparc/include/asm/cmpxchg_32.h |    1 +
 arch/sparc/include/asm/cmpxchg_64.h |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 1fae1a0..284fb96 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -81,5 +81,6 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC_CMPXCHG__ */
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


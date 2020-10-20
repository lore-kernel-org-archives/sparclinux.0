From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 20 Oct 2020 05:33:28 +0000
Subject: [PATCH] sparc: make xchg() into a statement expression
Message-Id: <20201020053328.17332-1-rdunlap@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix several of the same warning by using a GCC statement expression
(extension):

../arch/sparc/include/asm/cmpxchg_32.h:28:22: warning: value computed is not used [-Wunused-value]
   28 | #define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))

Passes sparc32 allmodconfig with no xchg warnings.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
This is similar to a patch from Arnd for m68k:
  https://lore.kernel.org/linux-m68k/20201008123429.1133896-1-arnd@arndb.de/

 arch/sparc/include/asm/cmpxchg_32.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201009.orig/arch/sparc/include/asm/cmpxchg_32.h
+++ linux-next-20201009/arch/sparc/include/asm/cmpxchg_32.h
@@ -25,7 +25,7 @@ static inline unsigned long __xchg(unsig
 	return x;
 }
 
-#define xchg(ptr,x) ((__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr))))
+#define xchg(ptr,x) ({(__typeof__(*(ptr)))__xchg((unsigned long)(x),(ptr),sizeof(*(ptr)));})
 
 /* Emulate cmpxchg() the same way we emulate atomics,
  * by hashing the object address and indexing into an array

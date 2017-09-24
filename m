From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 24 Sep 2017 17:29:31 +0000
Subject: [PATCH] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <1506274171-28423-1-git-send-email-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S . Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Fix the following build error, seen when building sparc32:allmodconfig.

drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
	In function 'i40e_set_priv_flags':
drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4150:2: error:
	implicit declaration of function 'cmpxchg64'

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sparc/include/asm/cmpxchg_32.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 83ffb83c5397..4b59bf99d2ed 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -72,5 +72,6 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
 			(unsigned long)(n), sizeof(*(ptr))))
 #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr), (o), (n))
+#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
 
 #endif /* __ARCH_SPARC_CMPXCHG__ */
-- 
2.7.4


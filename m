From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 06 Nov 2017 14:41:45 +0000
Subject: [PATCH v3] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <1509979305-11791-1-git-send-email-linux@roeck-us.net>
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
v3: Drop extern from cmpxchg64 declaration in include file
v2: Actually implement cmpxchg64 with code snippet provided by Dave Miller
    Note: I am aware that this doesn't pass checkpatch; I found it more
    important to be in line with __cmpxchg_u32().

 arch/sparc/include/asm/cmpxchg_32.h |  2 ++
 arch/sparc/lib/atomic32.c           | 14 ++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 83ffb83c5397..01bb66b5d125 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -62,6 +62,8 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
 
+u64 cmpxchg64(u64 *ptr, u64 old, u64 new);
+
 #include <asm-generic/cmpxchg-local.h>
 
 /*
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 2c373329d5cb..41601eb540e7 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -172,6 +172,20 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
+u64 cmpxchg64(u64 *ptr, u64 old, u64 new)
+{
+	unsigned long flags;
+	u64 prev;
+
+	spin_lock_irqsave(ATOMIC_HASH(ptr), flags);
+	if ((prev = *ptr) = old)
+		*ptr = new;
+	spin_unlock_irqrestore(ATOMIC_HASH(ptr), flags);
+
+	return prev;
+}
+EXPORT_SYMBOL(cmpxchg64);
+
 unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
 {
 	unsigned long flags;
-- 
2.7.4


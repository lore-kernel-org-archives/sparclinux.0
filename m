From: David Miller <davem@davemloft.net>
Date: Thu, 09 Nov 2017 06:28:52 +0000
Subject: Re: [PATCH v3] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <20171109.152852.88103578951782189.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1509979305-11791-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1509979305-11791-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Mon,  6 Nov 2017 06:41:45 -0800

> Fix the following build error, seen when building sparc32:allmodconfig.
> 
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
> 	In function 'i40e_set_priv_flags':
> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4150:2: error:
> 	implicit declaration of function 'cmpxchg64'
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Guenter, are you really not seeing this commit which has been
in my sparc GIT tree for a while?

commit 23198ddffb6cddb5d5824230af4dd4b46e4046a4
Author: David S. Miller <davem@davemloft.net>
Date:   Wed Sep 27 22:38:19 2017 -0700

    sparc32: Add cmpxchg64().
    
    This fixes the build with i40e driver enabled.
    
    Reported-by: Guenter Roeck <linux@roeck-us.net>
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 83ffb83c5397..a0101a58fd3f 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -62,6 +62,9 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
 
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+#define cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
+
 #include <asm-generic/cmpxchg-local.h>
 
 /*
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 2c373329d5cb..ddacb5aeb424 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -172,6 +172,20 @@ unsigned long __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
+u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
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
+EXPORT_SYMBOL(__cmpxchg_u64);
+
 unsigned long __xchg_u32(volatile u32 *ptr, u32 new)
 {
 	unsigned long flags;

From: David Miller <davem@davemloft.net>
Date: Thu, 28 Sep 2017 05:28:19 +0000
Subject: Re: [PATCH] sparc: Provide cmpxchg64 for 32-bit builds
Message-Id: <20170927.222819.365912965397559137.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1506274171-28423-1-git-send-email-linux@roeck-us.net>
        <20170927.213812.1333158312684109871.davem@davemloft.net>
        <92d872fa-cdde-3e1d-9e2e-0722c9480bbd@roeck-us.net>
In-Reply-To: <92d872fa-cdde-3e1d-9e2e-0722c9480bbd@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Sep 2017 21:55:50 -0700

> On 09/27/2017 09:38 PM, David Miller wrote:
>> From: Guenter Roeck <linux@roeck-us.net>
>> Date: Sun, 24 Sep 2017 10:29:31 -0700
>> 
>>> Fix the following build error, seen when building
>>> sparc32:allmodconfig.
>>>
>>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:
>>> 	In function 'i40e_set_priv_flags':
>>> drivers/net/ethernet/intel/i40e/i40e_ethtool.c:4150:2: error:
>>> 	implicit declaration of function 'cmpxchg64'
>>>
>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> That fixes the build:
>> 
>>> @@ -72,5 +72,6 @@ __cmpxchg(volatile void *ptr, unsigned long old,
>>> unsigned long new_, int size)
>>>   	((__typeof__(*(ptr)))__cmpxchg_local_generic((ptr), (unsigned long)(o),\
>>>   			(unsigned long)(n), sizeof(*(ptr))))
>>>   #define cmpxchg64_local(ptr, o, n) __cmpxchg64_local_generic((ptr),
>>>   #(o), (n))
>>> +#define cmpxchg64(ptr, o, n)	cmpxchg64_local((ptr), (o), (n))
>>>     #endif /* __ARCH_SPARC_CMPXCHG__ */
>> but it's wrong.  cmpxchg64_local() is only atomic on the current cpu
>> so using it for plain cmpxchg64() is not going to work.
>> 
> 
> Yeah, I was concerned about that. My bad.
> 
> Unfortunately I don't know enough about sparc to provide a better
> solution.
> Consider this a problem report, then.

I'll see what I can do.  Something like this:

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 83ffb83..7f95d3c 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -62,6 +62,8 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
 
+extern u64 cmpxchg64(u64 *ptr, u64 old, u64 new);
+
 #include <asm-generic/cmpxchg-local.h>
 
 /*
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index 2c37332..41601eb 100644
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

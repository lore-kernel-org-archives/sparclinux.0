From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 28 Mar 2006 21:13:19 +0000
Subject: Re: [PATCH] futex.h : Fix compilation problem
Message-Id: <20060328.131319.19885294.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <wrp64ly5vo5.fsf@wild-wind.fr.eu.org>
In-Reply-To: <wrp64ly5vo5.fsf@wild-wind.fr.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Marc Zyngier <maz@misterjones.org>
Date: Tue, 28 Mar 2006 19:24:58 +0200

> The included patchlet fixes a compilation problem on sparc64 in the
> last batch of patches included in Linus' repository.

I tried to send the proper fix, attached below, to Linus
already.  I'll resend it today if he hasn't taken it yet.

diff-tree 6e57a3a89785692bd8d012d80f5ee210ab8e0b68 (from 329b10bb0feacb7fb9a41389313ff0a51ae56f2a)
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Tue Mar 28 01:00:08 2006 -0800

    [SPARC64]: Implement futex_atomic_cmpxchg_inatomic().
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
index cd340a2..dee4020 100644
--- a/include/asm-sparc64/futex.h
+++ b/include/asm-sparc64/futex.h
@@ -84,9 +84,27 @@ static inline int futex_atomic_op_inuser
 }
 
 static inline int
-futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
 {
-	return -ENOSYS;
+	__asm__ __volatile__(
+	"\n1:	lduwa	[%2] %%asi, %0\n"
+	"2:	casa	[%2] %%asi, %0, %1\n"
+	"3:\n"
+	"	.section .fixup,#alloc,#execinstr\n"
+	"	.align	4\n"
+	"4:	ba	3b\n"
+	"	 mov	%3, %0\n"
+	"	.previous\n"
+	"	.section __ex_table,\"a\"\n"
+	"	.align	4\n"
+	"	.word	1b, 4b\n"
+	"	.word	2b, 4b\n"
+	"	.previous\n"
+	: "=&r" (oldval)
+	: "r" (newval), "r" (uaddr), "i" (-EFAULT)
+	: "memory");
+
+	return oldval;
 }
 
 #endif /* !(_SPARC64_FUTEX_H) */

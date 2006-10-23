From: David Miller <davem@davemloft.net>
Date: Mon, 23 Oct 2006 04:54:19 +0000
Subject: Re: Unaligned accesses in compat_sys_msgrcv and sys_msgrcv
Message-Id: <20061022.215419.74747802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061021041107.GA4629@droopy.oc.cox.net>
In-Reply-To: <20061021041107.GA4629@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Fri, 20 Oct 2006 21:11:08 -0700

> p = compat_alloc_user_space(second + sizeof(struct msgbuf));

Thanks again for this report Jurij, this patch should fix it up.

commit a94b1d1fd7ca3129e1d38d38167779fa6ee69780
Author: David S. Miller <davem@sunset.davemloft.net>
Date:   Sun Oct 22 21:53:30 2006 -0700

    [SPARC64]: 8-byte align return value from compat_alloc_user_space()
    
    Otherwise we get a ton of unaligned exceptions, for cases such
    as compat_sys_msgrcv() which go:
    
    	p = compat_alloc_user_space(second + sizeof(struct msgbuf));
    
    and here 'second' can for example be an arbitrary odd value.
    
    Based upon a bug report from Jurij Smakov.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/include/asm-sparc64/compat.h b/include/asm-sparc64/compat.h
index c73935d..36511ca 100644
--- a/include/asm-sparc64/compat.h
+++ b/include/asm-sparc64/compat.h
@@ -164,7 +164,7 @@ static inline compat_uptr_t ptr_to_compa
 	return (u32)(unsigned long)uptr;
 }
 
-static __inline__ void __user *compat_alloc_user_space(long len)
+static inline void __user *compat_alloc_user_space(long len)
 {
 	struct pt_regs *regs = current_thread_info()->kregs;
 	unsigned long usp = regs->u_regs[UREG_I6];
@@ -174,7 +174,10 @@ static __inline__ void __user *compat_al
 	else
 		usp &= 0xffffffffUL;
 
-	return (void __user *) (usp - len);
+	usp -= len;
+	usp &= ~0x7UL;
+
+	return (void __user *) usp;
 }
 
 struct compat_ipc64_perm {

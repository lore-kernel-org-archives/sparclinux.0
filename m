From: Marc Zyngier <maz@misterjones.org>
Date: Tue, 28 Mar 2006 17:24:58 +0000
Subject: [PATCH] futex.h : Fix compilation problem
Message-Id: <wrp64ly5vo5.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

People, Dave,

The included patchlet fixes a compilation problem on sparc64 in the
last batch of patches included in Linus' repository.

Regards,

	M.

Signed-off-by: Marc Zyngier <maz@misterjones.org>

diff --git a/include/asm-sparc64/futex.h b/include/asm-sparc64/futex.h
index cd340a2..1aa76b8 100644
--- a/include/asm-sparc64/futex.h
+++ b/include/asm-sparc64/futex.h
@@ -84,7 +84,7 @@ static inline int futex_atomic_op_inuser
 }
 
 static inline int
-futex_atomic_cmpxchg_inuser(int __user *uaddr, int oldval, int newval)
+futex_atomic_cmpxchg_inatomic(int __user *uaddr, int oldval, int newval)
 {
 	return -ENOSYS;
 }

-- 
And if you don't know where you're going, any road will take you there...

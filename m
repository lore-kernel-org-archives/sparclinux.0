From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Thu, 02 Jan 2014 16:03:19 +0000
Subject: [Resend] [PATCH] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <52C58DC7.5090009@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This reverts commit 145e1c0023585e0e8f6df22316308ec61c5066b2.

This commit broke the behavior of __copy_from_user_inatomic when
it is only partially successful. Instead of returning the number
of bytes not copied, it now returns 1. This translates to the
wrong value being returned by iov_iter_copy_from_user_atomic.

xfstests generic/246 and LTP writev01 both fail on btrfs and nfs
because of this.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Hugh Dickins <hugh@veritas.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/uaccess_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index e562d3c..ad7e178 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -262,8 +262,8 @@ extern unsigned long __must_check __clear_user(void __user *, unsigned long);
 extern __must_check long strlen_user(const char __user *str);
 extern __must_check long strnlen_user(const char __user *str, long n);
 
-#define __copy_to_user_inatomic ___copy_to_user
-#define __copy_from_user_inatomic ___copy_from_user
+#define __copy_to_user_inatomic __copy_to_user
+#define __copy_from_user_inatomic __copy_from_user
 
 struct pt_regs;
 extern unsigned long compute_effective_address(struct pt_regs *,
-- 
1.8.5.1


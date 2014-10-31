From: Jiri Slaby <jslaby@suse.cz>
Date: Fri, 31 Oct 2014 13:12:59 +0000
Subject: [PATCH 3.12 057/144] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <34311d46541908ce166018aa6da48967d5c149ad.1414759455.git.jslaby@suse.cz>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>

3.12-stable review patch.  If anyone has any objections, please let me know.

=======
This reverts commit 145e1c0023585e0e8f6df22316308ec61c5066b2.

This commit broke the behavior of __copy_from_user_inatomic when
it is only partially successful. Instead of returning the number
of bytes not copied, it now returns 1. This translates to the
wrong value being returned by iov_iter_copy_from_user_atomic.

xfstests generic/246 and LTP writev01 both fail on btrfs and nfs
because of this.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/uaccess_64.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index e562d3caee57..ad7e178337f1 100644
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
2.1.2


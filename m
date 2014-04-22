From: Kamal Mostafa <kamal@canonical.com>
Date: Tue, 22 Apr 2014 20:12:43 +0000
Subject: [PATCH 3.8 025/133] Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."
Message-Id: <1398197671-12786-26-git-send-email-kamal@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1398197671-12786-1-git-send-email-kamal@canonical.com>
In-Reply-To: <1398197671-12786-1-git-send-email-kamal@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org, kernel-team@lists.ubuntu.com
Cc: Dave Kleikamp <dave.kleikamp@oracle.com>, Hugh Dickins <hughd@google.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Kamal Mostafa <kamal@canonical.com>

3.8.13.22 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dave Kleikamp <dave.kleikamp@oracle.com>

[ Upstream commit 16932237f2978a2265662f8de4af743b1f55a209 ]

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
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
1.9.1


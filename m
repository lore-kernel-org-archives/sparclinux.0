From: Luis Henriques <luis.henriques@canonical.com>
Date: Wed, 16 Apr 2014 10:13:55 +0000
Subject: [3.11.y.z extended stable] Patch "Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."" has
Message-Id: <1397643235-13037-1-git-send-email-luis.henriques@canonical.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This is a note to let you know that I have just added a patch titled

    Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."

to the linux-3.11.y-queue branch of the 3.11.y.z extended stable tree 
which can be found at:

 http://kernel.ubuntu.com/git?p=ubuntu/linux.git;a=shortlog;h=refs/heads/linux-3.11.y-queue

If you, or anyone else, feels it should not be added to this tree, please 
reply to this email.

For more information about the 3.11.y.z tree, see
https://wiki.ubuntu.com/Kernel/Dev/ExtendedStable

Thanks.
-Luis

------

From d507050d7c8cb2fc980057f7f70a9092140b76ef Mon Sep 17 00:00:00 2001
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 16 Dec 2013 15:01:00 -0600
Subject: Revert "sparc64: Fix __copy_{to,from}_user_inatomic defines."

commit 16932237f2978a2265662f8de4af743b1f55a209 upstream.

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
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
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


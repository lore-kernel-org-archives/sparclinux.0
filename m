From: David Miller <davem@davemloft.net>
Date: Fri, 02 May 2014 05:14:38 +0000
Subject: [PATCH] sparc64: Fix argument sign extension for compat_sys_futex().
Message-Id: <20140502.011438.2188428732411012512.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Only the second argument, 'op', is signed.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

I noticed this while auditing the memory management aspects of
the futex implementation.  Pushed to 'sparc' GIT and queued up
for -stable.

 arch/sparc/kernel/sys32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys32.S b/arch/sparc/kernel/sys32.S
index f7c72b6..d066eb1 100644
--- a/arch/sparc/kernel/sys32.S
+++ b/arch/sparc/kernel/sys32.S
@@ -44,7 +44,7 @@ SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
 SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
 SIGN1(sys32_mq_open, compat_sys_mq_open, %o1)
 SIGN1(sys32_select, compat_sys_select, %o0)
-SIGN3(sys32_futex, compat_sys_futex, %o1, %o2, %o5)
+SIGN1(sys32_futex, compat_sys_futex, %o1)
 SIGN1(sys32_recvfrom, compat_sys_recvfrom, %o0)
 SIGN1(sys32_recvmsg, compat_sys_recvmsg, %o0)
 SIGN1(sys32_sendmsg, compat_sys_sendmsg, %o0)
-- 
1.9.0


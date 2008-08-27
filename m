From: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
Date: Wed, 27 Aug 2008 11:16:46 +0000
Subject: [PATCH] sh: fix semtimedop syscall
Message-Id: <48B5379E.5050901@renesas.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-sh@vger.kernel.org

fix the problem that cannot work semtimedop system call.

Signed-off-by: Yoshihiro Shimoda <shimoda.yoshihiro@renesas.com>
---

 I think that SPARC has the similar bug.
 However I cannot confirm it, because I don't have SPARC system.

 arch/sh/kernel/sys_sh.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sh/kernel/sys_sh.c b/arch/sh/kernel/sys_sh.c
index 59cd285..9061b86 100644
--- a/arch/sh/kernel/sys_sh.c
+++ b/arch/sh/kernel/sys_sh.c
@@ -170,7 +170,7 @@ asmlinkage int sys_ipc(uint call, int first, int second,
 	version = call >> 16; /* hack for backward compatibility */
 	call &= 0xffff;

-	if (call <= SEMCTL)
+	if (call <= SEMTIMEDOP)
 		switch (call) {
 		case SEMOP:
 			return sys_semtimedop(first,
-- 
1.5.5


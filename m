From: Rob Gardner <rob.gardner@oracle.com>
Date: Tue, 03 Mar 2015 06:16:55 +0000
Subject: [PATCH] sparc: semtimedop() unreachable due to comparison error
Message-Id: <1425363415-4154-1-git-send-email-rob.gardner@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A bug was reported that the semtimedop() system call was always
failing eith ENOSYS.

Since SEMCTL is defined as 3, and SEMTIMEDOP is defined as 4,
the comparison "call <= SEMCTL" will always prevent SEMTIMEDOP
from getting through to the semaphore ops switch statement.

This is corrected by changing the comparison to "call <= SEMTIMEDOP".

Orabug: 20633375

Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
---
 arch/sparc/kernel/sys_sparc_64.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index c85403d..30e7ddb 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -333,7 +333,7 @@ SYSCALL_DEFINE6(sparc_ipc, unsigned int, call, int, first, unsigned long, second
 	long err;
 
 	/* No need for backward compatibility. We can start fresh... */
-	if (call <= SEMCTL) {
+	if (call <= SEMTIMEDOP) {
 		switch (call) {
 		case SEMOP:
 			err = sys_semtimedop(first, ptr,
-- 
1.7.9.5


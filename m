From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Sat, 26 Dec 2015 23:13:27 +0000
Subject: [PATCH] sparc64: fix incorrect sign extension in sys_sparc64_personality
Message-Id: <20151226231327.GA18682@altlinux.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Rob Gardner <rob.gardner@oracle.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

The value returned by sys_personality has type "long int".
It is saved to a variable of type "int", which is not a problem
yet because the type of task_struct->pesonality is "unsigned int".
The problem is the sign extension from "int" to "long int"
that happens on return from sys_sparc64_personality.

For example, a userspace call personality((unsigned) -EINVAL) will
result to any subsequent personality call, including absolutely
harmless read-only personality(0xffffffff) call, failing with
errno set to EINVAL.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
Cc: <stable@vger.kernel.org>
---
 arch/sparc/kernel/sys_sparc_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 30e7ddb..c690c8e 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -413,15 +413,15 @@ out:
 
 SYSCALL_DEFINE1(sparc64_personality, unsigned long, personality)
 {
-	int ret;
+	long ret;
 
 	if (personality(current->personality) = PER_LINUX32 &&
 	    personality(personality) = PER_LINUX)
 		personality |= PER_LINUX32;
 	ret = sys_personality(personality);
 	if (personality(ret) = PER_LINUX32)
 		ret &= ~PER_LINUX32;
 
 	return ret;
 }

-- 
ldv

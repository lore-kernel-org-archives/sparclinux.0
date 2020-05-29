From: Anupam Aggarwal <anupam.al@samsung.com>
Date: Fri, 29 May 2020 12:38:00 +0000
Subject: [PATCH] sparc: remove unused header file nfs_fs.h
Message-Id: <1590755160-26009-1-git-send-email-anupam.al@samsung.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CGME20200529122614epcas5p38e0acf63c010f8b691caf68916f512bd@epcas5p3.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: a.sahrawat@samsung.com, t.vivek@samsung.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Anupam Aggarwal <anupam.al@samsung.com>

Remove unused header file linux/nfs_fs.h

Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 arch/sparc/kernel/sys_sparc32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index b5da3bf..f84a02a 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -22,7 +22,6 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 #include <linux/uio.h>
-#include <linux/nfs_fs.h>
 #include <linux/quota.h>
 #include <linux/poll.h>
 #include <linux/personality.h>
-- 
1.9.1

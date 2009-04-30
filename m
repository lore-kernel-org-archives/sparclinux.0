From: Tim Abbott <tabbott@MIT.EDU>
Date: Thu, 30 Apr 2009 23:58:51 +0000
Subject: [PATCH 2/4] sparc: use new macros for .data.init_task.
Message-Id: <1241135933-9913-3-git-send-email-tabbott@mit.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <1241135933-9913-1-git-send-email-tabbott@mit.edu>
 <1241135933-9913-2-git-send-email-tabbott@mit.edu>
In-Reply-To: <1241135933-9913-2-git-send-email-tabbott@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>, Anders Kaseorg <andersk@MIT.EDU>, Waseem Daher <wdaher@MIT.EDU>, Denys Vlasenko <vda.linux@googlemail.com>, Jeff Arnold <jbarnold@MIT.EDU>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Tim Abbott <tabbott@MIT.EDU>

.data.init_task should not need a separate output section; this change
moves it into the .data section.

Signed-off-by: Tim Abbott <tabbott@mit.edu>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/init_task.c   |    5 ++---
 arch/sparc/kernel/vmlinux.lds.S |    6 +-----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/init_task.c b/arch/sparc/kernel/init_task.c
index f28cb82..7367984 100644
--- a/arch/sparc/kernel/init_task.c
+++ b/arch/sparc/kernel/init_task.c
@@ -21,6 +21,5 @@ EXPORT_SYMBOL(init_task);
  * If this is not aligned on a 8k boundry, then you should change code
  * in etrap.S which assumes it.
  */
-union thread_union init_thread_union
-	__attribute__((section (".data.init_task")))
-	= { INIT_THREAD_INFO(init_task) };
+union thread_union init_thread_union __init_task_data +	{ INIT_THREAD_INFO(init_task) };
diff --git a/arch/sparc/kernel/vmlinux.lds.S b/arch/sparc/kernel/vmlinux.lds.S
index 6587e03..3fbf650 100644
--- a/arch/sparc/kernel/vmlinux.lds.S
+++ b/arch/sparc/kernel/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 
 	RO_DATA(PAGE_SIZE)
 	.data :	{
+		INIT_TASK_DATA(THREAD_SIZE)
 		CACHELINE_ALIGNED_DATA(SMP_CACHE_BYTES)
 		DATA_DATA
 		CONSTRUCTORS
@@ -66,11 +67,6 @@ SECTIONS
 	/* End of data section */
 	_edata = .;
 
-	/* init_task */
-	. = ALIGN(THREAD_SIZE);
-	.data.init_task : {
-		*(.data.init_task)
-	}
 	.fixup : {
 		__start___fixup = .;
 		*(.fixup)
-- 
1.6.2.1


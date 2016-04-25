From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Mon, 25 Apr 2016 18:28:06 +0000
Subject: [PATCH V3 1/3] Use proper size for task_struct->flags
Message-Id: <1461608888-5063-2-git-send-email-dave.kleikamp@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

task_struct->flags was once defined as a long, but is currently an int.

Signed-off-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 defs.h |    1 +
 task.c |   12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/defs.h b/defs.h
index d1b49d0..e3afc58 100644
--- a/defs.h
+++ b/defs.h
@@ -2093,6 +2093,7 @@ struct size_table {         /* stash of commonly-used sizes */
 	long hrtimer_base;
 	long tnt;
 	long trace_print_flags;
+	long task_struct_flags;
 };
 
 struct array_table {
diff --git a/task.c b/task.c
index 7b01951..0743993 100644
--- a/task.c
+++ b/task.c
@@ -249,6 +249,7 @@ task_init(void)
 	MEMBER_OFFSET_INIT(task_struct_active_mm, "task_struct", "active_mm");
 	MEMBER_OFFSET_INIT(task_struct_next_run, "task_struct", "next_run");
 	MEMBER_OFFSET_INIT(task_struct_flags, "task_struct", "flags");
+	MEMBER_SIZE_INIT(task_struct_flags, "task_struct", "flags");
         MEMBER_OFFSET_INIT(task_struct_pidhash_next,
                 "task_struct", "pidhash_next");
 	MEMBER_OFFSET_INIT(task_struct_pgrp, "task_struct", "pgrp");
@@ -5266,8 +5267,15 @@ task_flags(ulong task)
 
 	fill_task_struct(task);
 
-	flags = tt->last_task_read ?
-		 ULONG(tt->task_struct + OFFSET(task_struct_flags)) : 0;
+	if (tt->last_task_read) {
+		if (SIZE(task_struct_flags) = sizeof(unsigned int))
+			flags = UINT(tt->task_struct +
+				     OFFSET(task_struct_flags));
+		else
+			flags = ULONG(tt->task_struct +
+				      OFFSET(task_struct_flags));
+	} else
+		flags = 0;
 
 	return flags;
 }
-- 
1.7.1


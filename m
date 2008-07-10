From: David Howells <dhowells@redhat.com>
Date: Thu, 10 Jul 2008 19:53:56 +0000
Subject: [PATCH] Remove Sparc's asm-offsets for sclow.S
Message-Id: <20080710195356.11539.57171.stgit@warthog.procyon.org.uk>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove Sparc's asm-offsets for sclow.S as the (E)UID/(E)GID size and offset
definitions will cease to be correct if COW credentials are merged.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 arch/sparc/kernel/asm-offsets.c |   12 ------------
 1 files changed, 0 insertions(+), 12 deletions(-)


diff --git a/arch/sparc/kernel/asm-offsets.c b/arch/sparc/kernel/asm-offsets.c
index cd3f769..b5bb99e 100644
--- a/arch/sparc/kernel/asm-offsets.c
+++ b/arch/sparc/kernel/asm-offsets.c
@@ -18,18 +18,6 @@ int foo(void)
 {
 	DEFINE(AOFF_task_thread, offsetof(struct task_struct, thread));
 	BLANK();
-	/* XXX This is the stuff for sclow.S, kill it. */
-	DEFINE(AOFF_task_pid, offsetof(struct task_struct, pid));
-	DEFINE(AOFF_task_uid, offsetof(struct task_struct, uid));
-	DEFINE(AOFF_task_gid, offsetof(struct task_struct, gid));
-	DEFINE(AOFF_task_euid, offsetof(struct task_struct, euid));
-	DEFINE(AOFF_task_egid, offsetof(struct task_struct, egid));
-	/* DEFINE(THREAD_INFO, offsetof(struct task_struct, stack)); */
-	DEFINE(ASIZ_task_uid,	sizeof(current->uid));
-	DEFINE(ASIZ_task_gid,	sizeof(current->gid));
-	DEFINE(ASIZ_task_euid,	sizeof(current->euid));
-	DEFINE(ASIZ_task_egid,	sizeof(current->egid));
-	BLANK();
 	DEFINE(AOFF_thread_fork_kpsr,
 			offsetof(struct thread_struct, fork_kpsr));
 	BLANK();


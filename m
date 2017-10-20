From: Elena Reshetova <elena.reshetova@intel.com>
Date: Fri, 20 Oct 2017 07:57:57 +0000
Subject: [PATCH] sparc64: convert mdesc_handle.refcnt from atomic_t to refcount_t
Message-Id: <1508486277-24913-1-git-send-email-elena.reshetova@intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, shannon.nelson@oracle.com, jag.raman@oracle.com, peterz@infradead.org, keescook@chromium.org, Elena Reshetova <elena.reshetova@intel.com>

atomic_t variables are currently used to implement reference
counters with the following properties:
 - counter is initialized to 1 using atomic_set()
 - a resource is freed upon counter reaching zero
 - once counter reaches zero, its further
   increments aren't allowed
 - counter schema uses basic atomic operations
   (set, inc, inc_not_zero, dec_and_test, etc.)

Such atomic variables should be converted to a newly provided
refcount_t type and API that prevents accidental counter overflows
and underflows. This is important since overflows and underflows
can lead to use-after-free situation and be exploitable.

The variable mdesc_handle.refcnt is used as pure reference counter.
Convert it to refcount_t and fix up the operations.

Suggested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: David Windsor <dwindsor@gmail.com>
Reviewed-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
---
 arch/sparc/kernel/mdesc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index fa466ce..821a724 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -12,6 +12,7 @@
 #include <linux/miscdevice.h>
 #include <linux/bootmem.h>
 #include <linux/export.h>
+#include <linux/refcount.h>
 
 #include <asm/cpudata.h>
 #include <asm/hypervisor.h>
@@ -70,7 +71,7 @@ struct mdesc_handle {
 	struct list_head	list;
 	struct mdesc_mem_ops	*mops;
 	void			*self_base;
-	atomic_t		refcnt;
+	refcount_t		refcnt;
 	unsigned int		handle_size;
 	struct mdesc_hdr	mdesc;
 };
@@ -152,7 +153,7 @@ static void mdesc_handle_init(struct mdesc_handle *hp,
 	memset(hp, 0, handle_size);
 	INIT_LIST_HEAD(&hp->list);
 	hp->self_base = base;
-	atomic_set(&hp->refcnt, 1);
+	refcount_set(&hp->refcnt, 1);
 	hp->handle_size = handle_size;
 }
 
@@ -182,7 +183,7 @@ static void __init mdesc_memblock_free(struct mdesc_handle *hp)
 	unsigned int alloc_size;
 	unsigned long start;
 
-	BUG_ON(atomic_read(&hp->refcnt) != 0);
+	BUG_ON(refcount_read(&hp->refcnt) != 0);
 	BUG_ON(!list_empty(&hp->list));
 
 	alloc_size = PAGE_ALIGN(hp->handle_size);
@@ -220,7 +221,7 @@ static struct mdesc_handle *mdesc_kmalloc(unsigned int mdesc_size)
 
 static void mdesc_kfree(struct mdesc_handle *hp)
 {
-	BUG_ON(atomic_read(&hp->refcnt) != 0);
+	BUG_ON(refcount_read(&hp->refcnt) != 0);
 	BUG_ON(!list_empty(&hp->list));
 
 	kfree(hp->self_base);
@@ -259,7 +260,7 @@ struct mdesc_handle *mdesc_grab(void)
 	spin_lock_irqsave(&mdesc_lock, flags);
 	hp = cur_mdesc;
 	if (hp)
-		atomic_inc(&hp->refcnt);
+		refcount_inc(&hp->refcnt);
 	spin_unlock_irqrestore(&mdesc_lock, flags);
 
 	return hp;
@@ -271,7 +272,7 @@ void mdesc_release(struct mdesc_handle *hp)
 	unsigned long flags;
 
 	spin_lock_irqsave(&mdesc_lock, flags);
-	if (atomic_dec_and_test(&hp->refcnt)) {
+	if (refcount_dec_and_test(&hp->refcnt)) {
 		list_del_init(&hp->list);
 		hp->mops->free(hp);
 	}
@@ -513,7 +514,7 @@ void mdesc_update(void)
 	if (status != HV_EOK || real_len > len) {
 		printk(KERN_ERR "MD: mdesc reread fails with %lu\n",
 		       status);
-		atomic_dec(&hp->refcnt);
+		refcount_dec(&hp->refcnt);
 		mdesc_free(hp);
 		goto out;
 	}
@@ -526,7 +527,7 @@ void mdesc_update(void)
 	mdesc_notify_clients(orig_hp, hp);
 
 	spin_lock_irqsave(&mdesc_lock, flags);
-	if (atomic_dec_and_test(&orig_hp->refcnt))
+	if (refcount_dec_and_test(&orig_hp->refcnt))
 		mdesc_free(orig_hp);
 	else
 		list_add(&orig_hp->list, &mdesc_zombie_list);
-- 
2.7.4


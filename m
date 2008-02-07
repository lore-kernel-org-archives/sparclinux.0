From: David Rientjes <rientjes@google.com>
Date: Thu, 07 Feb 2008 23:38:52 +0000
Subject: Re: sparc compile error
Message-Id: <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20080207231230.GE7198@cs181133002.pp.htv.fi>
In-Reply-To: <20080207231230.GE7198@cs181133002.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@kernel.org>
Cc: wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

3062fc67 introduced far too many build errors for the convenience it
allows.  It's not even always necessary to rcu deference mm->mem_cgroup in
the first place, so we'll use it on a case by case basis.

Signed-off-by: David Rientjes <rientjes@google.com>
---
 include/linux/memcontrol.h |   13 -------------
 mm/memcontrol.c            |    2 +-
 mm/rmap.c                  |    6 ++++--
 3 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -20,9 +20,6 @@
 #ifndef _LINUX_MEMCONTROL_H
 #define _LINUX_MEMCONTROL_H
 
-#include <linux/rcupdate.h>
-#include <linux/mm.h>
-
 struct mem_cgroup;
 struct page_cgroup;
 struct page;
@@ -51,11 +48,6 @@ extern int mem_cgroup_cache_charge(struct page *page, struct mm_struct *mm,
 					gfp_t gfp_mask);
 int task_in_mem_cgroup(struct task_struct *task, const struct mem_cgroup *mem);
 
-static inline struct mem_cgroup *mm_cgroup(const struct mm_struct *mm)
-{
-	return rcu_dereference(mm->mem_cgroup);
-}
-
 extern int mem_cgroup_prepare_migration(struct page *page);
 extern void mem_cgroup_end_migration(struct page *page);
 extern void mem_cgroup_page_migration(struct page *page, struct page *newpage);
@@ -123,11 +115,6 @@ static inline int mem_cgroup_cache_charge(struct page *page,
 	return 0;
 }
 
-static inline struct mem_cgroup *mm_cgroup(const struct mm_struct *mm)
-{
-	return NULL;
-}
-
 static inline int task_in_mem_cgroup(struct task_struct *task,
 				     const struct mem_cgroup *mem)
 {
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -399,7 +399,7 @@ int task_in_mem_cgroup(struct task_struct *task, const struct mem_cgroup *mem)
 	int ret;
 
 	task_lock(task);
-	ret = task->mm && mm_cgroup(task->mm) = mem;
+	ret = task->mm && rcu_dereference(task->mm->mem_cgroup) = mem;
 	task_unlock(task);
 	return ret;
 }
diff --git a/mm/rmap.c b/mm/rmap.c
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -321,7 +321,8 @@ static int page_referenced_anon(struct page *page,
 		 * counting on behalf of references from different
 		 * cgroups
 		 */
-		if (mem_cont && (mm_cgroup(vma->vm_mm) != mem_cont))
+		if (mem_cont && mem_cont !+		    rcu_dereference(vma->vm_mm->mem_cgroup))
 			continue;
 		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
@@ -382,7 +383,8 @@ static int page_referenced_file(struct page *page,
 		 * counting on behalf of references from different
 		 * cgroups
 		 */
-		if (mem_cont && (mm_cgroup(vma->vm_mm) != mem_cont))
+		if (mem_cont && mem_cont !+		    rcu_dereference(vma->vm_mm->mem_cgroup))
 			continue;
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
 				  = (VM_LOCKED|VM_MAYSHARE)) {

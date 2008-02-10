From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 10 Feb 2008 15:33:55 +0000
Subject: Re: sparc compile error
Message-Id: <20080210153355.GA6737@palantir8>
List-Id: <sparclinux.vger.kernel.org>
References: <20080207231230.GE7198@cs181133002.pp.htv.fi> <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.1.00.0802071538440.15050@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Rientjes <rientjes@google.com>
Cc: Adrian Bunk <bunk@kernel.org>, wli@holomorphy.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

This still gives build errors with CGROUP_MEM_CONT off.
Some ifdef-ing will fix that.

 Martin

	 Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

Index: sparc-2.6.git/mm/rmap.c
=================================--- sparc-2.6.git.orig/mm/rmap.c	2008-02-10 13:01:37.000000000 +0000
+++ sparc-2.6.git/mm/rmap.c	2008-02-10 14:16:34.000000000 +0000
@@ -321,8 +321,11 @@
 		 * counting on behalf of references from different
 		 * cgroups
 		 */
-		if (mem_cont && (mm_cgroup(vma->vm_mm) != mem_cont))
+#ifdef CONFIG_CGROUP_MEM_CONT
+		if (mem_cont && mem_cont !+		    rcu_dereference(vma->vm_mm->mem_cgroup))
 			continue;
+#endif
 		referenced += page_referenced_one(page, vma, &mapcount);
 		if (!mapcount)
 			break;
@@ -382,8 +385,11 @@
 		 * counting on behalf of references from different
 		 * cgroups
 		 */
-		if (mem_cont && (mm_cgroup(vma->vm_mm) != mem_cont))
+#ifdef CONFIG_CGROUP_MEM_CONT
+		if (mem_cont && mem_cont !+		    rcu_dereference(vma->vm_mm->mem_cgroup))
 			continue;
+#endif
 		if ((vma->vm_flags & (VM_LOCKED|VM_MAYSHARE))
 				  = (VM_LOCKED|VM_MAYSHARE)) {
 			referenced++;

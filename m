From: David Miller <davem@davemloft.net>
Date: Thu, 25 Oct 2007 06:41:13 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071024.234113.141236196.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Josip, give this debugging patch a try.  It is against 2.6.23.1
but it should apply to most recent kernels.

It should give you debugging messages in the kernel log that
start with "FUTEX_BUG" if the debugging code triggers.

Please post just a few samples of whatever it spits out.

Thanks!

diff --git a/kernel/futex.c b/kernel/futex.c
index fcc94e7..6da8b3c 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -1874,6 +1874,25 @@ err_unlock:
 	return ret;
 }
 
+static void log_futex_bug(u32 __user *uaddr, struct task_struct *curr, int pi)
+{
+	struct mm_struct *mm = curr->mm;
+	struct vm_area_struct *vma;
+	unsigned long addr;
+
+	printk(KERN_ERR "FUTEX_BUG: Looping too much in futex death\n");
+	printk(KERN_ERR "FUTEX_BUG: uaddr[%p] task[%s:%d] pi(%d)\n",
+	       uaddr, curr->comm, curr->pid, pi);
+
+	addr = (unsigned long) uaddr;
+	vma = find_vma(mm, addr);
+	if (vma)
+		printk(KERN_ERR "FUTEX_BUG: VMA start[%lx] end[%lx] flags[%lx]\n",
+		       vma->vm_start,
+		       vma->vm_end,
+		       vma->vm_flags);
+}
+
 /*
  * Process a futex-list entry, check whether it's owned by the
  * dying task, and do notification if so:
@@ -1881,6 +1900,7 @@ err_unlock:
 int handle_futex_death(u32 __user *uaddr, struct task_struct *curr, int pi)
 {
 	u32 uval, nval, mval;
+	int limit = 0;
 
 retry:
 	if (get_user(uval, uaddr))
@@ -1903,8 +1923,12 @@ retry:
 		if (nval = -EFAULT)
 			return -1;
 
-		if (nval != uval)
-			goto retry;
+		if (nval != uval) {
+			if (++limit < 100)
+				goto retry;
+			log_futex_bug(uaddr, curr, pi);
+			put_user(mval, uaddr);
+		}
 
 		/*
 		 * Wake robust non-PI futexes here. The wakeup of

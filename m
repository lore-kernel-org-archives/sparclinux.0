From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 24 Jun 2008 05:55:15 +0000
Subject: [1/10 PATCH] inline __queue_work
Message-Id: <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: davem@davemloft.net

Make __queue_work inlined. It just takes spinlock and calls another function.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6.26-rc7-devel/kernel/workqueue.c
=================================--- linux-2.6.26-rc7-devel.orig/kernel/workqueue.c	2008-06-24 07:28:15.000000000 +0200
+++ linux-2.6.26-rc7-devel/kernel/workqueue.c	2008-06-24 07:37:08.000000000 +0200
@@ -141,8 +141,8 @@
  }

  /* Preempt must be disabled. */
-static void __queue_work(struct cpu_workqueue_struct *cwq,
-			 struct work_struct *work)
+static __always_inline void __queue_work(struct cpu_workqueue_struct *cwq,
+					 struct work_struct *work)
  {
  	unsigned long flags;



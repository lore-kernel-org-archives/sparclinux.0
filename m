From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 24 Jun 2008 06:03:14 +0000
Subject: [10/10 PATCH] inline dispatch_job
Message-Id: <Pine.LNX.4.64.0806240201530.27784@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
 <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: davem@davemloft.net, Alasdair G Kergon <agk@redhat.com>

Inline dispatch_job. It is called at two places, but it is quite small.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6.26-rc7-devel/drivers/md/dm-kcopyd.c
=================================--- linux-2.6.26-rc7-devel.orig/drivers/md/dm-kcopyd.c	2008-06-24 07:37:54.000000000 +0200
+++ linux-2.6.26-rc7-devel/drivers/md/dm-kcopyd.c	2008-06-24 07:37:59.000000000 +0200
@@ -433,7 +433,7 @@
   * to do the copy, otherwise the io has to be split up into many
   * jobs.
   */
-static void dispatch_job(struct kcopyd_job *job)
+static __always_inline void dispatch_job(struct kcopyd_job *job)
  {
  	struct dm_kcopyd_client *kc = job->kc;
  	atomic_inc(&kc->nr_jobs);

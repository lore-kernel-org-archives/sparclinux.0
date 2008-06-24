From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 24 Jun 2008 06:01:47 +0000
Subject: [9/10 PATCH] inline dm-kcopyd-inline-wake.patch
Message-Id: <Pine.LNX.4.64.0806240201110.27784@engineering.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0806240136200.27784@engineering.redhat.com>
 <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0806240154140.27784@engineering.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc: davem@davemloft.net, Alasdair G Kergon <agk@redhat.com>


Inline wake. Just passes arguments around.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

Index: linux-2.6.26-rc7-devel/drivers/md/dm-kcopyd.c
=================================--- linux-2.6.26-rc7-devel.orig/drivers/md/dm-kcopyd.c	2008-06-24 07:28:06.000000000 +0200
+++ linux-2.6.26-rc7-devel/drivers/md/dm-kcopyd.c	2008-06-24 07:37:54.000000000 +0200
@@ -61,7 +61,7 @@
  	struct list_head pages_jobs;
  };

-static void wake(struct dm_kcopyd_client *kc)
+static __always_inline void wake(struct dm_kcopyd_client *kc)
  {
  	queue_work(kc->kcopyd_wq, &kc->kcopyd_work);
  }

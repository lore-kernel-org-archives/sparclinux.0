From: john.hubbard@gmail.com
Date: Wed, 07 Aug 2019 01:33:04 +0000
Subject: [PATCH v3 05/41] net/ceph: convert put_page() to put_user_page*()
Message-Id: <20190807013340.9706-6-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, Sage Weil <sage@redhat.com>, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Acked-by: Jeff Layton <jlayton@kernel.org>

Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: ceph-devel@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 net/ceph/pagevec.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/ceph/pagevec.c b/net/ceph/pagevec.c
index 64305e7056a1..c88fff2ab9bd 100644
--- a/net/ceph/pagevec.c
+++ b/net/ceph/pagevec.c
@@ -12,13 +12,7 @@
 
 void ceph_put_page_vector(struct page **pages, int num_pages, bool dirty)
 {
-	int i;
-
-	for (i = 0; i < num_pages; i++) {
-		if (dirty)
-			set_page_dirty_lock(pages[i]);
-		put_page(pages[i]);
-	}
+	put_user_pages_dirty_lock(pages, num_pages, dirty);
 	kvfree(pages);
 }
 EXPORT_SYMBOL(ceph_put_page_vector);
-- 
2.22.0

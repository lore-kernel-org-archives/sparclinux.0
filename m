From: john.hubbard@gmail.com
Date: Wed, 07 Aug 2019 01:33:38 +0000
Subject: [PATCH v3 39/41] mm/mlock.c: convert put_page() to put_user_page*()
Message-Id: <20190807013340.9706-40-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Daniel Black <daniel@linux.ibm.com>, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org, Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@list

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Daniel Black <daniel@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Jérôme Glisse <jglisse@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Mike Kravetz <mike.kravetz@oracle.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/mlock.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/mlock.c b/mm/mlock.c
index a90099da4fb4..b980e6270e8a 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -345,7 +345,7 @@ static void __munlock_pagevec(struct pagevec *pvec, struct zone *zone)
 				get_page(page); /* for putback_lru_page() */
 				__munlock_isolated_page(page);
 				unlock_page(page);
-				put_page(page); /* from follow_page_mask() */
+				put_user_page(page); /* from follow_page_mask() */
 			}
 		}
 	}
@@ -467,7 +467,7 @@ void munlock_vma_pages_range(struct vm_area_struct *vma,
 		if (page && !IS_ERR(page)) {
 			if (PageTransTail(page)) {
 				VM_BUG_ON_PAGE(PageMlocked(page), page);
-				put_page(page); /* follow_page_mask() */
+				put_user_page(page); /* follow_page_mask() */
 			} else if (PageTransHuge(page)) {
 				lock_page(page);
 				/*
@@ -478,7 +478,7 @@ void munlock_vma_pages_range(struct vm_area_struct *vma,
 				 */
 				page_mask = munlock_vma_page(page);
 				unlock_page(page);
-				put_page(page); /* follow_page_mask() */
+				put_user_page(page); /* follow_page_mask() */
 			} else {
 				/*
 				 * Non-huge pages are handled in batches via
-- 
2.22.0

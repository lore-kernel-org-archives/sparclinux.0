From: john.hubbard@gmail.com
Date: Wed, 07 Aug 2019 01:33:39 +0000
Subject: [PATCH v3 40/41] mm/mempolicy.c: convert put_page() to put_user_page*()
Message-Id: <20190807013340.9706-41-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Vlastimil Babka <vbabka@suse.cz>, David Rientjes <rientjes@google.com>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, Andrea Arcangeli <aarcange@redhat.com>, Anshuman Khandual <anshuman.khandual@arm.com>, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, Dominik Brodowski <linux@dominikbrodows>

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: zhong jiang <zhongjiang@huawei.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f48693f75b37..76a8e935e2e6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -832,7 +832,7 @@ static int lookup_node(struct mm_struct *mm, unsigned long addr)
 	err = get_user_pages_locked(addr & PAGE_MASK, 1, 0, &p, &locked);
 	if (err >= 0) {
 		err = page_to_nid(p);
-		put_page(p);
+		put_user_page(p);
 	}
 	if (locked)
 		up_read(&mm->mmap_sem);
-- 
2.22.0

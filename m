From: john.hubbard@gmail.com
Date: Fri, 02 Aug 2019 02:19:38 +0000
Subject: [PATCH 07/34] drm/radeon: convert put_page() to put_user_page*()
Message-Id: <20190802022005.5117-8-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190802022005.5117-1-jhubbard@nvidia.com>
In-Reply-To: <20190802022005.5117-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, David Airlie <airlied@linux.ie>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, David Zhou <David1.Zhou@amd.com>, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-kernel@lists.infradead.org

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
Cc: David (ChunMing) Zhou <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/r=
adeon_ttm.c
index fb3696bc616d..4c9943fa10df 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -540,7 +540,7 @@ static int radeon_ttm_tt_pin_userptr(struct ttm_tt *ttm)
 	kfree(ttm->sg);
=20
 release_pages:
-	release_pages(ttm->pages, pinned);
+	put_user_pages(ttm->pages, pinned);
 	return r;
 }
=20
--=20
2.22.0

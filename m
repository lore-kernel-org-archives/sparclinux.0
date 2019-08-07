From: john.hubbard@gmail.com
Date: Wed, 07 Aug 2019 01:33:36 +0000
Subject: [PATCH v3 37/41] security/tomoyo: convert put_page() to put_user_page*()
Message-Id: <20190807013340.9706-38-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190807013340.9706-1-jhubbard@nvidia.com>
In-Reply-To: <20190807013340.9706-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Dan Williams <dan.j.williams@intel.com>, Dave Chinner <david@fromorbit.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ira Weiny <ira.weiny@intel.com>, Jan Kara <jack@suse.cz>, Jason Gunthorpe <jgg@ziepe.ca>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx@lists.freedesktop.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, devel@lists.orangefs.org, dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.or

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Acked-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Cc: Kentaro Takeda <takedakn@nttdata.co.jp>
Cc: linux-security-module@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 security/tomoyo/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 8526a0a74023..6887beecfb6e 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -931,7 +931,7 @@ bool tomoyo_dump_page(struct linux_binprm *bprm, unsigned long pos,
 	}
 	/* Same with put_arg_page(page) in fs/exec.c */
 #ifdef CONFIG_MMU
-	put_page(page);
+	put_user_page(page);
 #endif
 	return true;
 }
-- 
2.22.0

From: john.hubbard@gmail.com
Date: Sun, 04 Aug 2019 22:48:45 +0000
Subject: [PATCH v2 04/34] x86/kvm: convert put_page() to put_user_page*()
Message-Id: <20190804224915.28669-5-jhubbard@nvidia.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190804224915.28669-1-jhubbard@nvidia.com>
In-Reply-To: <20190804224915.28669-1-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fbdev@vger.kernel.org, Jan Kara <jack@suse.cz>, kvm@vger.kernel.org, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Dave Chinner <david@fromorbit.com>, dri-devel@lists.freedesktop.org, linux-mm@kvack.org, "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, ceph-devel@vger.kernel.org, devel@driverdev.osuosl.org, rds-devel@oss.oracle.com, linux-rdma@vger.kernel.org, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, amd-gfx@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, xen-devel@lists.xenproject.org, devel@lists.orangefs.org, linux-media@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>, intel-gfx@lists.freedesktop.org, linux-block@vger.kernel.org, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-rpi-k

From: John Hubbard <jhubbard@nvidia.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: x86@kernel.org
Cc: kvm@vger.kernel.org
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
---
 arch/x86/kvm/svm.c  | 4 ++--
 virt/kvm/kvm_main.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 7eafc6907861..ff93c923ed36 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -1827,7 +1827,7 @@ static struct page **sev_pin_memory(struct kvm *kvm, unsigned long uaddr,
 
 err:
 	if (npinned > 0)
-		release_pages(pages, npinned);
+		put_user_pages(pages, npinned);
 
 	kvfree(pages);
 	return NULL;
@@ -1838,7 +1838,7 @@ static void sev_unpin_memory(struct kvm *kvm, struct page **pages,
 {
 	struct kvm_sev_info *sev = &to_kvm_svm(kvm)->sev_info;
 
-	release_pages(pages, npages);
+	put_user_pages(pages, npages);
 	kvfree(pages);
 	sev->pages_locked -= npages;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 887f3b0c2b60..4b6a596ea8e9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1499,7 +1499,7 @@ static int hva_to_pfn_slow(unsigned long addr, bool *async, bool write_fault,
 
 		if (__get_user_pages_fast(addr, 1, 1, &wpage) = 1) {
 			*writable = true;
-			put_page(page);
+			put_user_page(page);
 			page = wpage;
 		}
 	}
@@ -1831,7 +1831,7 @@ EXPORT_SYMBOL_GPL(kvm_release_page_clean);
 void kvm_release_pfn_clean(kvm_pfn_t pfn)
 {
 	if (!is_error_noslot_pfn(pfn) && !kvm_is_reserved_pfn(pfn))
-		put_page(pfn_to_page(pfn));
+		put_user_page(pfn_to_page(pfn));
 }
 EXPORT_SYMBOL_GPL(kvm_release_pfn_clean);
 
-- 
2.22.0

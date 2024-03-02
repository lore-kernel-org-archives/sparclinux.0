Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C225C6FCB
	for <sparclinux@vger.kernel.org>; Sat,  2 Mar 2024 00:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338654; cv=none; b=Z7WSRtoBfdIOsdFVh4VFOm4GfZYTsr+wwmfQC6LYyjt76NvygKiUYEZ7ZEuP+2MV9gA4LynvqPQ7cx1EZuQ/MLDjg9hLqrSyjDHtJiE4bBEXuZUUkn4jTCVxApwjAxGsvTDIvYz4jcCQmp/tQFudsBBo1u8cHl7IHmCRbGEeaBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338654; c=relaxed/simple;
	bh=aUPn2kr2ywGgbEfcgtrb26nDcn4EKmG6jav1jyMSZgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qWNS7ZM6ywiUTSBGW6BDxozJxJpmtgW0VEzDd0yWxdCRyGPb44X7+NoLxljknwYIXBKT3MIJx0hPFkyFCpoax91qnO234tX0sv2aiiGityO+fixF5OOUEJxntrVQaCntf6V6iphyORGIFwXDktxgpxPMyBnwGyi/IoR31XG7YZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VIikdHGe; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VIikdHGe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338652; x=1740874652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aUPn2kr2ywGgbEfcgtrb26nDcn4EKmG6jav1jyMSZgw=;
  b=VIikdHGein+4kvcMtELdq9pT6FCTR851BIVaVVP/efxdYSO4+JhIhXqN
   seGJepXkbG90WN5aaHOdq6zeg6zOqc8Ad/hqplnKtIMlFmhcQyvILMGZ0
   m/CQWP1iYdq52iauMVZwL15Dt0qydkYVdQRd63iaO18xtKgaK3/REchAD
   S8jlj9dB/w0Qsf7LrrQuPiwt+fcKlAr1hunoUbql+yULsfbvW8b+XFuOv
   mf+BD67nv3iU97I14oyJ8hiEgKPNp7xNCIwhe+fuP32+AnC/qIdLhl3Ek
   ijmGELvTy4txLbqqxTLV3S+IWzAt0wlN2E9vXrGwgbSVlMmXzoKhO09IH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7715813"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="7715813"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8496003"
Received: from thwood-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.7.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:31 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: rick.p.edgecombe@intel.com
Cc: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	bp@alien8.de,
	broonie@kernel.org,
	dave.hansen@linux.intel.com,
	debug@rivosinc.com,
	hpa@zytor.com,
	keescook@chromium.org,
	kirill.shutemov@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	peterz@infradead.org,
	sparclinux@vger.kernel.org,
	tglx@linutronix.de,
	x86@kernel.org,
	Muchun Song <muchun.song@linux.dev>,
	linux-mm@kvack.org
Subject: [RFC v2.1 12/12] hugetlbfs: Use initializer for struct vm_unmapped_area_info
Date: Fri,  1 Mar 2024 16:17:14 -0800
Message-Id: <20240302001714.674091-12-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240302001714.674091-1-rick.p.edgecombe@intel.com>
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Future changes will need to add a new member to struct
vm_unmapped_area_info. This would cause trouble for any call site that
doesn't initialize the struct. Currently every caller sets each field
manually, so if new fields are added they will be unitialized and the core
code parsing the struct will see garbage in the new field.

It could be possible to initialize the new field manually to 0 at each
call site. This and a couple other options were discussed, and the
consensus (see links) was that in general the best way to accomplish this
would be via static initialization with designated field initiators.
Having some struct vm_unmapped_area_info instances not zero initialized
will put those sites at risk of feeding garbage into vm_unmapped_area() if
the convention is to zero initialize the struct and any new field addition
misses a call site that initializes each field manually.

It could be possible to leave the code mostly untouched, and just change
the line:
struct vm_unmapped_area_info info
to:
struct vm_unmapped_area_info info = {};

However, that would leave cleanup for the fields that are manually set
to zero, as it would no longer be required.

So to be reduce the chance of bugs via uninitialized fields, instead
simply continue the process to initialize the struct this way tree wide.
This will zero any unspecified members. Move the field initializers to the
struct declaration when they are known at that time. Leave the fields out
that were manually initialized to zero, as this would be redundant for
designated initializers.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: linux-mm@kvack.org
Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
---
Hi,

This patch was split and refactored out of a tree-wide change [0] to just
zero-init each struct vm_unmapped_area_info. The overall goal of the
series is to help shadow stack guard gaps. Currently, there is only one
arch with shadow stacks, but two more are in progress. It is 0day tested
only.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecombe@intel.com/
---
 fs/hugetlbfs/inode.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index a63d2eee086f..510e66598991 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -165,14 +165,13 @@ hugetlb_get_unmapped_area_bottomup(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.length = len,
+		.low_limit = current->mm->mmap_base,
+		.high_limit = arch_get_mmap_end(addr, len, flags),
+		.align_mask = PAGE_MASK & ~huge_page_mask(h),
+	};
 
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = current->mm->mmap_base;
-	info.high_limit = arch_get_mmap_end(addr, len, flags);
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -181,14 +180,14 @@ hugetlb_get_unmapped_area_topdown(struct file *file, unsigned long addr,
 		unsigned long len, unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.flags = VM_UNMAPPED_AREA_TOPDOWN,
+		.length = len,
+		.low_limit = PAGE_SIZE,
+		.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base),
+		.align_mask = PAGE_MASK & ~huge_page_mask(h)
+	};
 
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = arch_get_mmap_base(addr, current->mm->mmap_base);
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.34.1


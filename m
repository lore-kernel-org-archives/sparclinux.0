Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D66C6D39
	for <sparclinux@vger.kernel.org>; Sat,  2 Mar 2024 00:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338653; cv=none; b=kDfIyTwVRolXdq7MpG3DMpM79sPP6hY487os+2xBZVJ/JIOK8g1wDD4okJR12wduah01q9S7emohRz6fmHuthR9EFUYtvLcrqzo5oreFTBQstqKL7JSsNd4ji3OA8/wHS9lEmrQ7jv5kVjlNQxq4M9BtXpMORVrunt57iTlXJME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338653; c=relaxed/simple;
	bh=fc/KpDACABRG4K64+sCv/63i/EnlJSw2Mk0x59TN6LU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p+eswAmO6W8ewJQNnIjIUU8YldpTY8hCrr5EAAA/889+ahC4NIs5/14cycIAwG9gTsxUMyPT3KvqqBlcSAQqFoPEOKfPkhKA6uNp92ea0X1tVNoVK+i4nMV2PYemSIHsG6JFoCunuHXllPf/bVcgqbm3VSIDuHKun/gs4/6bBMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmBO2mxM; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmBO2mxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338651; x=1740874651;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fc/KpDACABRG4K64+sCv/63i/EnlJSw2Mk0x59TN6LU=;
  b=BmBO2mxMEkVUTcCUx85DnzXLNHoS0pGgcqcA1MDR1pEiXO/KW7z+giOx
   ax1iYESNRw3Rqp3kvpQNVNS1WlR4V3C0XvOp8Xz3g3HV55vgdKaN3YPjk
   WwOr8ft1d5pKjjDxNHlQT+0DYM+BwuuqMg417KE9ym21JByJBdGFpH3md
   csfdzSDK68C4iD62dIP9csquoiOepDOAcE9NESBRMUIeXXNgBiPObtm5U
   nJU4W+vZ9oj98Gp13jCkXyHN5dFk8AQgvCoLmD2mn5v00m7WaS87pgBLP
   hYO8GQfnzl1diaVoXtTnvT6fJkl+cNhkdTyiNxfWjXvEXzUQazz692wsH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7715802"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="7715802"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8495999"
Received: from thwood-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.7.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:30 -0800
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
	x86@kernel.org
Subject: [RFC v2.1 11/12] x86/mm: Use initializer for struct vm_unmapped_area_info
Date: Fri,  1 Mar 2024 16:17:13 -0800
Message-Id: <20240302001714.674091-11-rick.p.edgecombe@intel.com>
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
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6tcghhfh3rhmzi@wzlcoecgy5rs/
---
Hi,

This patch was split and refactored out of a tree-wide change [0] to just
zero-init each struct vm_unmapped_area_info. The overall goal of the
series is to help shadow stack guard gaps. Currently, there is only one
arch with shadow stacks, but two more are in progress.

Thanks,

Rick

[0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecombe@intel.com/
---
 arch/x86/kernel/sys_x86_64.c | 22 ++++++++++------------
 arch/x86/mm/hugetlbpage.c    | 27 ++++++++++++---------------
 2 files changed, 22 insertions(+), 27 deletions(-)

diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index c783aeb37dce..2c0d75ead631 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -125,7 +125,10 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.length = len,
+		.align_offset = pgoff << PAGE_SHIFT
+	};
 	unsigned long begin, end;
 
 	if (flags & MAP_FIXED)
@@ -144,12 +147,8 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
-	info.length = len;
 	info.low_limit = begin;
 	info.high_limit = end;
-	info.align_mask = 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
@@ -165,7 +164,12 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct vm_area_struct *vma;
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.flags = VM_UNMAPPED_AREA_TOPDOWN,
+		.length = len,
+		.align_offset = pgoff << PAGE_SHIFT,
+		.high_limit = get_mmap_base(0),
+	};
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE)
@@ -191,15 +195,11 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	}
 get_unmapped_area:
 
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
 	if (!in_32bit_syscall() && (flags & MAP_ABOVE4G))
 		info.low_limit = SZ_4G;
 	else
 		info.low_limit = PAGE_SIZE;
 
-	info.high_limit = get_mmap_base(0);
-
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
 	 * in the full address space.
@@ -210,8 +210,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
-	info.align_mask = 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 	if (filp) {
 		info.align_mask = get_align_mask();
 		info.align_offset += get_align_bits();
diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 6d77c0039617..ddbcc242d78a 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -51,11 +51,11 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
-
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = get_mmap_base(1);
+	struct vm_unmapped_area_info info = {
+		info.length = len,
+		info.low_limit = get_mmap_base(1),
+		info.align_mask = PAGE_MASK & ~huge_page_mask(h)
+	};
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -64,8 +64,6 @@ static unsigned long hugetlb_get_unmapped_area_bottomup(struct file *file,
 	info.high_limit = in_32bit_syscall() ?
 		task_size_32bit() : task_size_64bit(addr > DEFAULT_MAP_WINDOW);
 
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	return vm_unmapped_area(&info);
 }
 
@@ -74,12 +72,13 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 		unsigned long pgoff, unsigned long flags)
 {
 	struct hstate *h = hstate_file(file);
-	struct vm_unmapped_area_info info;
-
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = get_mmap_base(0);
+	struct vm_unmapped_area_info info = {
+		.flags = VM_UNMAPPED_AREA_TOPDOWN,
+		.length = len,
+		.low_limit = PAGE_SIZE,
+		.high_limit = get_mmap_base(0),
+		.align_mask = PAGE_MASK & ~huge_page_mask(h)
+	};
 
 	/*
 	 * If hint address is above DEFAULT_MAP_WINDOW, look for unmapped area
@@ -88,8 +87,6 @@ static unsigned long hugetlb_get_unmapped_area_topdown(struct file *file,
 	if (addr > DEFAULT_MAP_WINDOW && !in_32bit_syscall())
 		info.high_limit += TASK_SIZE_MAX - DEFAULT_MAP_WINDOW;
 
-	info.align_mask = PAGE_MASK & ~huge_page_mask(h);
-	info.align_offset = 0;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.34.1


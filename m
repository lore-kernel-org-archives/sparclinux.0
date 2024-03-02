Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B777163CB;
	Sat,  2 Mar 2024 00:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338651; cv=none; b=vE07EeAPh0ed6LkvHIcf6xO1AnzECpx2WP1W7zOjb4iHm6soUZvvFLmofVbjK3fwE1y6j8sDS02PKu+mUiV4UG+7zP1IkfmQIpbsisvn3fgfNKuNHA1xtLZqyoAHKftJOjjxhBwN16VVIbWy0e35AmkRXP/DixI9dCHLSPsWCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338651; c=relaxed/simple;
	bh=xbWkxQYQam1S+ncDPTZ2nNpXwaU0bA5k+3cegEBrWhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f7XrE8iKfdoo0p6rgCyBAzhlCNeoCFKMp7Gn+J9OQecq7J0BlOG2zuw432RTPwKHwtIP8dqBg0naCV6OugeQqY+osfqtjh1GshTS5N6YaHG7IGxYYUD7MZtF08MDXKOZWP0KXQdd3ckllhRppKOqtMvnca3/IrlMXcoXZ2mQd5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MaAP4KNP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MaAP4KNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338649; x=1740874649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xbWkxQYQam1S+ncDPTZ2nNpXwaU0bA5k+3cegEBrWhU=;
  b=MaAP4KNPIX1IZ90su3zqAi0C2rEjhqoorZlR//BBjRkVJAM01MSexq4S
   4tM8WCLjKtFCTUi4x78tSadt+HX+hg4Rbl9RWhZKxyzbdPRXGp0RjpDr0
   mky2GJ/vAO++L1NDZdYvzG6AkSyAggeVjYRnpK9rS6zGxN2OpmJXeTG0r
   IA9dDtYvlj/2hwGxI7jcilIMFU9xvwo564liFO4z8KnBCavKRU+6fqYAO
   WSOS9NCjoYM8jvKVMYLgzBfFwKyXjFph7DSJResy6cevOQA0w+UaDP2ux
   rXO+WlDYs6Fu0tyatZ38uYDHDHHdPeg3c0n0/KpL5/nWKv3B8dIXV7e6R
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7715777"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="7715777"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8495990"
Received: from thwood-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.7.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:28 -0800
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
	Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Subject: [RFC v2.1 09/12] sh: Use initializer for struct vm_unmapped_area_info
Date: Fri,  1 Mar 2024 16:17:11 -0800
Message-Id: <20240302001714.674091-9-rick.p.edgecombe@intel.com>
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
Cc: Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
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
 arch/sh/mm/mmap.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/sh/mm/mmap.c b/arch/sh/mm/mmap.c
index b82199878b45..000a86c752c1 100644
--- a/arch/sh/mm/mmap.c
+++ b/arch/sh/mm/mmap.c
@@ -57,7 +57,12 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	int do_colour_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.length = len,
+		.low_limit = TASK_UNMAPPED_BASE,
+		.high_limit = TASK_SIZE,
+		.align_offset = pgoff << PAGE_SHIFT,
+	};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -88,12 +93,7 @@ unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	info.flags = 0;
-	info.length = len;
-	info.low_limit = TASK_UNMAPPED_BASE;
-	info.high_limit = TASK_SIZE;
 	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
 
@@ -106,7 +106,13 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	int do_colour_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.flags = VM_UNMAPPED_AREA_TOPDOWN,
+		.length = len,
+		.low_limit = PAGE_SIZE,
+		.high_limit = mm->mmap_base,
+		.align_offset = pgoff << PAGE_SHIFT
+	};
 
 	if (flags & MAP_FIXED) {
 		/* We do not accept a shared mapping if it would violate
@@ -138,12 +144,7 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
-	info.length = len;
-	info.low_limit = PAGE_SIZE;
-	info.high_limit = mm->mmap_base;
 	info.align_mask = do_colour_align ? (PAGE_MASK & shm_align_mask) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
 	/*
-- 
2.34.1


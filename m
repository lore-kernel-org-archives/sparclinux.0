Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D75ECC
	for <sparclinux@vger.kernel.org>; Sat,  2 Mar 2024 00:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709338646; cv=none; b=PFKbFaDT/TsRrVrlQd2MF6eYrs/imlNS1UmD7xy+Knt/7oPNunStdM/Qy7mETEZeozcf2EtkmFZ+6St/dWjuD1zCTvOAFMEK2x7Wgc8ZX6wfjotxI7oFQPDJ9DvK2sTsn8yLmpsY1TaJRbWx4qaQ1Ig0fa3V7Z9bUBEpJKVj8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709338646; c=relaxed/simple;
	bh=o4PnmzIktc1EZvQ94I+XKlSaEBl1YbcP4E3fu8hkQ90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DVNDql+SwYHBBR/qbTwvCUtflz60KYuzMV7MEqp3s+Ee3Krw6Qn/E1ujjfyRwW0scjf7N5/zJO7+BfEYhd/cJHAQW2l+LctWa4zkNv0ZozyNHSaBFdT4XX8XzMMop7pmn9QinBuP6M4t4Vz8+i+/g08gt/g4s5sPSmu+ggcNclY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gkVJvK3j; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gkVJvK3j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709338645; x=1740874645;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o4PnmzIktc1EZvQ94I+XKlSaEBl1YbcP4E3fu8hkQ90=;
  b=gkVJvK3j0ytz602wYKQFHvIclYXH4JZuNvcziaPlJJ/KtzbjzlqUWQ5d
   mZeQtN7bGDYPKq1xBdnf09yQNe0PQ0ABDkDWeQ8ZlwHWp0jYR2ZMrlKlG
   WjRj8IAL0v84H/5ERaJl6hpSQSsBcwZsi8KZmhyZcFp0YInIoHOgbteRL
   N7BgjmleeMnmsmjZZspMJ/XLfdBFLDFIxt9kUsd0qIyUy+rgHPWdIRccm
   oPjyPFL6oC0H4omC7ABgMXAsAtZdGr+FWxWSlDs287BNOPKHdkP0uC5dQ
   CxquDijAuCoWcsyfYHlxJoJ8uvJGOcG5SE1K/1ovR4AUvrcgHQ9oRh27c
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7715707"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="7715707"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8495965"
Received: from thwood-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.251.7.75])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 16:17:23 -0800
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
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	loongarch@lists.linux.dev
Subject: [RFC v2.1 04/12] LoongArch: Use initializer for struct vm_unmapped_area_info
Date: Fri,  1 Mar 2024 16:17:06 -0800
Message-Id: <20240302001714.674091-4-rick.p.edgecombe@intel.com>
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
Cc: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>
Cc: loongarch@lists.linux.dev
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
 arch/loongarch/mm/mmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/mm/mmap.c b/arch/loongarch/mm/mmap.c
index a9630a81b38a..aa028b25c461 100644
--- a/arch/loongarch/mm/mmap.c
+++ b/arch/loongarch/mm/mmap.c
@@ -24,7 +24,12 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 	struct vm_area_struct *vma;
 	unsigned long addr = addr0;
 	int do_color_align;
-	struct vm_unmapped_area_info info;
+	struct vm_unmapped_area_info info = {
+		.low_limit = mm->mmap_base,
+		.high_limit = TASK_SIZE,
+		.length = len,
+		.align_offset = pgoff << PAGE_SHIFT
+	};
 
 	if (unlikely(len > TASK_SIZE))
 		return -ENOMEM;
@@ -61,9 +66,7 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 			return addr;
 	}
 
-	info.length = len;
 	info.align_mask = do_color_align ? (PAGE_MASK & SHM_ALIGN_MASK) : 0;
-	info.align_offset = pgoff << PAGE_SHIFT;
 
 	if (dir == DOWN) {
 		info.flags = VM_UNMAPPED_AREA_TOPDOWN;
@@ -82,9 +85,6 @@ static unsigned long arch_get_unmapped_area_common(struct file *filp,
 		 */
 	}
 
-	info.flags = 0;
-	info.low_limit = mm->mmap_base;
-	info.high_limit = TASK_SIZE;
 	return vm_unmapped_area(&info);
 }
 
-- 
2.34.1


Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779C628
	for <sparclinux@vger.kernel.org>; Wed, 17 Jul 2024 22:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721253747; cv=none; b=cLbqExdEQXi3qpjSuc5KIsv86wcVk0Iz11D24j2pbfwiqTD8xk1Ugn7TLTVfJljV61qSwjq3TUc6jyVWs4X2Ag3AzSuFzNe/MAkyjQsl01QuTx9CU6dFZmXVEs51BgFsiP0NIIB2zEsz9dmkX4J67fwGKJWwdoafgTWciHl1CK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721253747; c=relaxed/simple;
	bh=h4xl6b3PoYqvLzNlz0SM88ksOLWtGLD4AUDpTlKuruA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Sszc//wmPnz1pKYMplZDsZkQHWBO6CgHOK7xkV3TkUazTNN/j75aEaUbv+VgtQdwvHKDmnZmqs0vaxYj63b2JNudSlSLq9R0ED/7wNMko3Q7bh6WlO6i+zqoS4+3McSHw81JQN+Oh0xiO3X7WyJGhwv/Oyhh8WRFqZkQ5RulCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYDI7PP3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYDI7PP3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721253744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=22URfq8NjvGndByOojJP9eQog6fnp2xGbHVHJb+hEIw=;
	b=UYDI7PP3nw4yWBbXJRnYbtVspD6KPrlcuZuMhF+KNBm3EKN+mRdTF+h3aN2QZWicfhotxU
	i7/6eje1qrOWyzi+3f6B4OqH9znwsD/DfEA/J0n5q0sfxXbBSCaOqEEwkm6RYEhhwuxa/7
	xF5epAb7ztJbMD5tGWH+61PfLZDWnPA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Ydzk7rDMN_uMPhNCIOBI1Q-1; Wed, 17 Jul 2024 18:02:23 -0400
X-MC-Unique: Ydzk7rDMN_uMPhNCIOBI1Q-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-6b792d6fe5bso617916d6.2
        for <sparclinux@vger.kernel.org>; Wed, 17 Jul 2024 15:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721253743; x=1721858543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=22URfq8NjvGndByOojJP9eQog6fnp2xGbHVHJb+hEIw=;
        b=KiXzbU56GkykWxtXCbHsnkOXlXHmj7hRSMd5CTFqugfYjr7TAfcXgsvK2xBOw9yMgt
         mj2ChDcYH0l4LNUHGgaplDcv+oL7PUUMELajCWrHKwBv/iBxy5wxoWDRQzEoBGp48abJ
         cgj3pHtsLS5hdxBrZfRh9J3Dbcp9Q7q4v+/GUaeZ6QqVzhwC9bYoWHS4alKkBW8dPGln
         vgkCDLlXs5HcuAqGBo8ANb45rAbCdbqDaR9nP9MF0AjDH1K4pbRvxfxcUanJSOkr3AbZ
         cgW4VZNXlUnmWwtucwpF/4S4Kv2PUkMbZprHaxJNWid4T04nBDaFenNmXRCeAJXENsot
         Z+DA==
X-Forwarded-Encrypted: i=1; AJvYcCVbHQYy/2nafdkBZgbkH3xWvX8Yp3RFBDcicWvuwU0Hz3mNQ7L22WAaaB7tUDi9G/vPi7DXZ/7pPuiB@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/mLA8rGqau/r5YFewNH+TkPGmfK8LxS65+HghodZQws25fsFp
	IrzTMYvX+GtTm2hECuOLW/OMtL3XKdhryfdhFf+RHGGbyjrbdTI/eIdrAq6knyIKSF4n50Z9sGv
	I14pkwe74lkP0wWd0fWPn0zwfcIrNtE9pFczBzLkJk4L9oOPwznlkyRg8nFk=
X-Received: by 2002:ac8:5e4e:0:b0:44f:89e3:e8d2 with SMTP id d75a77b69052e-44f89e3ec09mr15923421cf.12.1721253742635;
        Wed, 17 Jul 2024 15:02:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH030U/0PuH20CJyPZJMzLVzXnymjVCbugSgXnKR5JUMtRiVtVl+1d1cBUhmI+Iq8e7T2bLTA==
X-Received: by 2002:ac8:5e4e:0:b0:44f:89e3:e8d2 with SMTP id d75a77b69052e-44f89e3ec09mr15923181cf.12.1721253742192;
        Wed, 17 Jul 2024 15:02:22 -0700 (PDT)
Received: from x1n.redhat.com (pool-99-254-121-117.cpe.net.cable.rogers.com. [99.254.121.117])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f5b83f632sm53071651cf.85.2024.07.17.15.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 15:02:21 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Vlastimil Babka <vbabka@suse.cz>,
	peterx@redhat.com,
	David Hildenbrand <david@redhat.com>,
	Oscar Salvador <osalvador@suse.de>,
	linux-s390@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michal Hocko <mhocko@kernel.org>,
	linux-riscv@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	x86@kernel.org,
	Alistair Popple <apopple@nvidia.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Ryan Roberts <ryan.roberts@arm.com>,
	Hugh Dickins <hughd@google.com>,
	Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH RFC 0/6] mm: THP-agnostic refactor on huge mappings
Date: Wed, 17 Jul 2024 18:02:13 -0400
Message-ID: <20240717220219.3743374-1-peterx@redhat.com>
X-Mailer: git-send-email 2.45.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an RFC series, so not yet for merging.  Please don't be scared by
the code changes: most of them are code movements only.

This series is based on the dax mprotect fix series here (while that one is
based on mm-unstable):

  [PATCH v3 0/8] mm/mprotect: Fix dax puds
  https://lore.kernel.org/r/20240715192142.3241557-1-peterx@redhat.com

Overview
========

This series doesn't provide any feature change.  The only goal of this
series is to start decoupling two ideas: "THP" and "huge mapping".  We
already started with having PGTABLE_HAS_HUGE_LEAVES config option, and this
one extends that idea into the code.

The issue is that we have so many functions that only compile with
CONFIG_THP=on, even though they're about huge mappings, and huge mapping is
a pretty common concept, which can apply to many things besides THPs
nowadays.  The major THP file is mm/huge_memory.c as of now.

The first example of such huge mapping users will be hugetlb.  We lived
until now with no problem simply because Linux almost duplicated all the
logics there in the "THP" files into hugetlb APIs.  If we want to get rid
of hugetlb specific APIs and paths, this _might_ be the first thing we want
to do, because we want to be able to e.g., zapping a hugetlb pmd entry even
if !CONFIG_THP.

Then consider other things like dax / pfnmaps.  Dax can depend on THP, then
it'll naturally be able to use pmd/pud helpers, that's okay.  However is it
a must?  Do we also want to have every new pmd/pud mappings in the future
to depend on THP (like PFNMAP)?  My answer is no, but I'm open to opinions.

If anyone agrees with me that "huge mapping" (aka, PMD/PUD mappings that
are larger than PAGE_SIZE) is a more generic concept than THP, then I think
at some point we need to move the generic code out of THP code into a
common code base.

This is what this series does as a start.

In general, this series tries to move many THP things (mostly resides in
huge_memory.c right now) into two new files: huge_mapping_{pmd|pud}.c.
When I move them out, I also put them separately into different files for
different layers.  Then if an arch supports e.g. only PMD, it can avoid
compile the PUD helpers, with things like:

        CONFIG_PGTABLE_HAS_PUD_LEAVES=n
        obj-$(CONFIG_PGTABLE_HAS_PUD_LEAVES) += huge_mapping_pud.o

Note that there're a few tree-wide changes into arch/, but that's not a
lot, to make this not disturbing too much people, I only copied the open
lists of each arch not yet the arch maintainers.

Tests
=====

My normal 19-archs cross-compilation tests pass with it, and smoke tested
on x86_64 with a local config of mine.

Comments welcomed, thanks.

Peter Xu (6):
  mm/treewide: Remove pgd_devmap()
  mm: PGTABLE_HAS_P[MU]D_LEAVES config options
  mm/treewide: Make pgtable-generic.c THP agnostic
  mm: Move huge mapping declarations from internal.h to huge_mm.h
  mm/huge_mapping: Create huge_mapping_pxx.c
  mm: Convert "*_trans_huge() || *_devmap()" to use *_leaf()

 arch/arm64/include/asm/pgtable.h             |   11 +-
 arch/powerpc/include/asm/book3s/64/pgtable.h |    7 +-
 arch/powerpc/mm/book3s64/pgtable.c           |    2 +-
 arch/riscv/include/asm/pgtable.h             |    4 +-
 arch/s390/include/asm/pgtable.h              |    2 +-
 arch/s390/mm/pgtable.c                       |    4 +-
 arch/sparc/mm/tlb.c                          |    2 +-
 arch/x86/include/asm/pgtable.h               |    5 -
 arch/x86/mm/pgtable.c                        |   15 +-
 include/linux/huge_mm.h                      |  332 ++++--
 include/linux/mm.h                           |   18 +
 include/linux/mm_types.h                     |    2 +-
 include/linux/pgtable.h                      |   61 +-
 include/trace/events/huge_mapping.h          |   41 +
 include/trace/events/thp.h                   |   28 -
 mm/Kconfig                                   |    6 +
 mm/Makefile                                  |    2 +
 mm/gup.c                                     |    2 -
 mm/hmm.c                                     |    4 +-
 mm/huge_mapping_pmd.c                        |  976 +++++++++++++++
 mm/huge_mapping_pud.c                        |  235 ++++
 mm/huge_memory.c                             | 1125 +-----------------
 mm/internal.h                                |   33 -
 mm/mapping_dirty_helpers.c                   |    4 +-
 mm/memory.c                                  |   16 +-
 mm/migrate_device.c                          |    2 +-
 mm/mprotect.c                                |    4 +-
 mm/mremap.c                                  |    5 +-
 mm/page_vma_mapped.c                         |    5 +-
 mm/pgtable-generic.c                         |   37 +-
 30 files changed, 1595 insertions(+), 1395 deletions(-)
 create mode 100644 include/trace/events/huge_mapping.h
 create mode 100644 mm/huge_mapping_pmd.c
 create mode 100644 mm/huge_mapping_pud.c

-- 
2.45.0


Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE239C433B4
	for <sparclinux@archiver.kernel.org>; Wed, 12 May 2021 05:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 873B4613E9
	for <sparclinux@archiver.kernel.org>; Wed, 12 May 2021 05:20:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhELFVk (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 12 May 2021 01:21:40 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:36271 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhELFVk (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 12 May 2021 01:21:40 -0400
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Fg2gH0m2Rz9sdy;
        Wed, 12 May 2021 07:00:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XsPm6W350ZRE; Wed, 12 May 2021 07:00:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Fg2gG6sQxz9sdw;
        Wed, 12 May 2021 07:00:58 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 79F568B7D6;
        Wed, 12 May 2021 07:00:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xwiuG9ynOkOh; Wed, 12 May 2021 07:00:58 +0200 (CEST)
Received: from po15610vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 015118B769;
        Wed, 12 May 2021 07:00:57 +0200 (CEST)
Received: by po15610vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id AE30264164; Wed, 12 May 2021 05:00:57 +0000 (UTC)
Message-Id: <cover.1620795204.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 0/5] Implement huge VMAP and VMALLOC on powerpc 8xx
To:     Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 12 May 2021 05:00:57 +0000 (UTC)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

This series implements huge VMAP and VMALLOC on powerpc 8xx.

Powerpc 8xx has 4 page sizes:
- 4k
- 16k
- 512k
- 8M

At the time being, vmalloc and vmap only support huge pages which are
leaf at PMD level.

Here the PMD level is 4M, it doesn't correspond to any supported
page size.

For now, implement use of 16k and 512k pages which is done
at PTE level.

Support of 8M pages will be implemented later, it requires use of
hugepd tables.

To allow this, the architecture provides two functions:
- arch_vmap_pte_range_map_size() which tells vmap_pte_range() what
page size to use. A stub returning PAGE_SIZE is provided when the
architecture doesn't provide this function.
- arch_vmap_pte_supported_shift() which tells __vmalloc_node_range()
what page shift to use for a given area size. A stub returning
PAGE_SHIFT is provided when the architecture doesn't provide this
function.

The main change in v2 compared to the RFC is that powerpc 8xx
specificities are not plugged anymore directly inside vmalloc code.

Christophe Leroy (5):
  mm/hugetlb: Change parameters of arch_make_huge_pte()
  mm/pgtable: Add stubs for {pmd/pub}_{set/clear}_huge
  mm/vmalloc: Enable mapping of huge pages at pte level in vmap
  mm/vmalloc: Enable mapping of huge pages at pte level in vmalloc
  powerpc/8xx: Add support for huge pages on VMAP and VMALLOC

 arch/arm64/include/asm/hugetlb.h              |  3 +-
 arch/arm64/mm/hugetlbpage.c                   |  5 +--
 arch/powerpc/Kconfig                          |  2 +-
 .../include/asm/nohash/32/hugetlb-8xx.h       |  5 +--
 arch/powerpc/include/asm/nohash/32/mmu-8xx.h  | 43 +++++++++++++++++++
 arch/sparc/include/asm/pgtable_64.h           |  3 +-
 arch/sparc/mm/hugetlbpage.c                   |  6 +--
 include/linux/hugetlb.h                       |  4 +-
 include/linux/pgtable.h                       | 26 ++++++++++-
 include/linux/vmalloc.h                       | 15 +++++++
 mm/hugetlb.c                                  |  6 ++-
 mm/migrate.c                                  |  4 +-
 mm/vmalloc.c                                  | 34 +++++++++++----
 13 files changed, 126 insertions(+), 30 deletions(-)

-- 
2.25.0


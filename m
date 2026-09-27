Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05504363C6F;
	Sun, 27 Sep 2026 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790506604; cv=none; b=KjNTS9eaOStYnu2QTyTgIV1gZGVzhJDEypJrFjWVq8h+NpnVme8z1Bc54vHI5vV/y/lKHvoGhok+0Le8myEeOFCvltzYfUX/oPM7cp8dtPgayjZI4c5yK53celPul0hL/qsVlzUGbhHCnjfFLElQg5R183rWoKNji3VPSGCekLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790506604; c=relaxed/simple;
	bh=UcrJgdpdQLC9ZdEeb7MW56VYLsUkf6z26/M9HDLLcdk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nHM19qa8Qq/7y9wn/A6+cA7EsyG58Gm5HGJjEO8ZXoH5KQEHbqyw+qcDuksY8SO/UbpyREidp0xbP9hXy53t9lIuulHEG0lqlVV5TWOhvRBLf/ANYepzmK6INq8I12bVbtC4Rf9VkYx1bwqnpIPbHbl8Tu2wMSDPAPl5m57N0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWcSAgdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWcSAgdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1C621F000FF;
	Sun, 27 Sep 2026 10:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790506602;
	bh=VOjjQFg2UtRtCyz8OPhKFZnWo1aH+BWGzVt++4NvhyM=;
	h=From:To:Cc:Subject:Date;
	b=nWcSAgdZb0viVB4AZCn4Zm/ZkbjbT0XDdMA+6UIf7WnCdVUQZ4LRBDbxP28BS08Si
	 HJ6INo9V7A2nIbChxdI3PRePCwhudW5tJBKSf4Bufk4X5Nh7yUTZ5aZkpASvj1kT1j
	 p/WCDz+L7VEt4J0RVyBKguOepqUJGuR4U2R8jWhK0rWx7rhqp8smQ5Fwp9oxlqc7Rt
	 e7rOp/C/WSfH2iFsNEdJsXn2ECzfrhwUHMH0M/5mLnud9876ozh+VJ4eChjc/qmG9l
	 ZulhZVO1myEeDlg3Rj9t+nK3wH7LkcVeaqrlem479mtqmCFofCcuBUfkd0K6uTEKJK
	 VayL+sGHDSl/w==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] sparc64: D-cache alias flushing fixes
Date: Sun, 27 Sep 2026 12:55:37 +0200
Message-ID: <20260927105539.8742-1-kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two fixes to D-cache alias flushing on sparc64 CPUs with a virtually
indexed L1 D-cache.

Patch 1 makes move_pte() and tlb_batch_add() flush only the page a PTE
maps, instead of every page of its folio once per PTE, so the number
of cross-calls for an mremap() of a large folio no longer grows with
the square of its size.

Patch 2 implements flush_cache_vmap() and flush_cache_vunmap(), which
have been no-ops on sparc64.  Stale lines left by a vmalloc mapping
corrupt BPF programs and module data on UltraSPARC III.  It uses
flush_dcache_page_all() as patch 1 restores it.

Both patches are tagged for stable.  Tested on a Sun Ultra 45.

Imre Kaloz (2):
  sparc64: flush only the aliased page, not its whole folio
  sparc64: flush vmalloc ranges from the D-cache on map and unmap

 arch/sparc/include/asm/cacheflush_64.h |  9 ++--
 arch/sparc/include/asm/pgtable_64.h    |  7 ++-
 arch/sparc/kernel/smp_64.c             | 42 ++++++++++++-----
 arch/sparc/mm/init_64.c                | 64 ++++++++++++++++++++++++++
 arch/sparc/mm/tlb.c                    |  2 +-
 arch/sparc/mm/ultra.S                  | 25 ++++++++++
 6 files changed, 131 insertions(+), 18 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.47.3


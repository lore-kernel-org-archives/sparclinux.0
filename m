Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5884BD35B;
	Mon, 28 Sep 2026 13:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601727; cv=none; b=sqvjAjHV/IZA8aX0NhtArwA93Djp6WWgkaOEEW4CwVwfxmNxJWRXzZbCJHfN8FjnWO9nD5gzzGkmYg5+SlgwGht4AA2eFuHSNAvLMjtd8FWru8rnYiCM/3S+JrBCgWVlAx3gSOuOdG7DZKC8UDzA74r8/bve3sQ9fqRJiPSBcI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601727; c=relaxed/simple;
	bh=nKQyMhd0foCzHZCcCIvelwTwDeBhlaDqyxLYqBUtErQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BT+wIxtE+wTFjZHThdqIuieywiPVIq5rsBngdhfMR1pXhkwkpQdsXbksHmqqGYPadJBblMRK0cRwcwNXA7rRflQ5m7H8LE5NsPkAIkXWrzdAMfQlpKgAGm/JBd2oqrNJNDafvGvnOMQq/Tp0K9qTXuGvN0CuMJjBw3Gi5QGIk40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQj3iEMm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQj3iEMm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111251F000FF;
	Mon, 28 Sep 2026 13:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790601725;
	bh=/u2CURVXbiusjvmPUFP0SvTtoVbVxBD9xYF3kP6lWrk=;
	h=From:To:Cc:Subject:Date;
	b=GQj3iEMm1AXHCxPjKUijm+KH/4Bhv5WN8KFOpn2vGtCz84kZmWAbxcl5jTQBguMda
	 bWkjV4RQn+YSJL+0dZLEtgvV8xY0sEGkhnzpSTQH3pqmWPueP2CN4Qlt1qQRudVQ/p
	 WDYDg+IDH/1LWn5yFmnwzfcbjD4h80tUuWF66MD5KgswqdcVWYeNx4Ucb2iJOOH2z2
	 xAsq5kOgFrOO3rodwEq8UEcDdyPNqLQ8iPsOgYyN7mYR/2XoW6ppGSQi+5CXPV1Kxe
	 ZGBEI/MNxdJJUf0P6FVPBqfNblNkKyZf957qP8SEtAKVkt+NUm73RJrfw1XMxPnP1f
	 HTYMbQdnQZxiA==
From: Imre Kaloz <kaloz@kernel.org>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] sparc64: D-cache alias flushing fixes
Date: Mon, 28 Sep 2026 15:21:00 +0200
Message-ID: <20260928132102.1707-1-kaloz@kernel.org>
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

Changes in v2:
- Patch 2: flush_cache_vmap() also runs on the vmemmap, from
  sparse_init() before init_IRQ() sets up the cross-call mondo
  blocks; skip addresses outside vmalloc and module space, since the
  vmemmap has no aliases to flush.  Picked up Stian Halseth's
  Tested-by.

Imre Kaloz (2):
  sparc64: flush only the aliased page, not its whole folio
  sparc64: flush vmalloc ranges from the D-cache on map and unmap

 arch/sparc/include/asm/cacheflush_64.h |  9 ++--
 arch/sparc/include/asm/pgtable_64.h    |  7 ++-
 arch/sparc/kernel/smp_64.c             | 42 ++++++++++++-----
 arch/sparc/mm/init_64.c                | 65 ++++++++++++++++++++++++++
 arch/sparc/mm/tlb.c                    |  2 +-
 arch/sparc/mm/ultra.S                  | 25 ++++++++++
 6 files changed, 132 insertions(+), 18 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
--
2.47.3


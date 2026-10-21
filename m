Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625695;
	b=GBP7Y252mUoraV6xGe4Hc3QwcIJibt5G8+gSjG1b3jGKKp/fNtmd28sFeiEhQI8Bkzev
	 zvMkj0Ij3MAHN2CiPnhAKRaKDQ2XlgxQq+CVvEotPCXjVWV9PI9E0eAMSuEL/WrwnqFrn
	 tHoIitci3QGZtGB0+yptana6F56UPxeGlAlr4nN9ohHqCXFVjoV4l87n5u+WvNzu+Yvb9
	 uGIILPsp68hekWPtRYeMSz6riLXIVRowjMABNA3F7+VW1DE58ZMAHot5RWoV9k1QD3nl0
	 XTFcf9jWWh8NpMdvi38nslYiJjCUKtyOV1wd8FIwKnfBnZ8Sd90U8uPf42qbBk/Sj6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=s5GCFuOcmjehv03gf2ljnWIxHgzVxKtBI4zuJ/1eB5M=;
	b=HO/n6cs0iqdA4AUmjkpNqu6kKIACdNsuFrb7DB3gzJxdcgcH5NJfJFMSRSHaG3Ur4KQP
	 wnQAU1mlaxZyRQmP+vafs7NYkE09/dsPfUvF9mfu2pdjNXibky20o1Gf6+npEd7u2yidd
	 Sv0PfpGVYOLDh9umXP9MZVbWvcNqpqYLmbS1uoRJf/Q8MpRvP1eKF5v6z1agpO7hEkPAj
	 ADAbUqALVG+3jKcvhNTqmJpv3pS9xYTMwjLs8BTcNJXKaO2AxKSQufDCADoFIvFQVITWc
	 rBjk+ONhkZSZ6npzBZmG7LEChy+Y+zQHJjd6U61ox6xln4ta42JEpwH/HDOjd/7kHIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7QSiiX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80940606A31A;
	Wed, 21 Oct 2026 23:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7QSiiX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E49211F000C1;
	Wed, 21 Oct 2026 23:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625695;
	bh=s5GCFuOcmjehv03gf2ljnWIxHgzVxKtBI4zuJ/1eB5M=;
	h=From:To:Cc:Subject:Date;
	b=g7QSiiX5u84k62YLZ3c1x3+ueZUgWrw+FaS8iLWpFy0ypur0rpeshW6hISOU3LpYX
	 q3LMdDTnMxORG/nxYgtnD0CXjNK8MnxAqtqbWxg2MKfUZuBonSM6Qr4rQFgK80bn3W
	 ZXOfZwioE33FPbSA7dgVdF4F/+gOyhGEXfpso+uOr/gnugw3cI15IifZZ6Xa0rI84d
	 Z8/oljAK0C56CAxKlujvNRho9+H+tS3+1hH9PqcAKAl4t0ex3rl2ORUxbxj+EdygHm
	 g12QQU5IEvMSlmKsEbOwIj5paUUVN/lUxzNfgfeoO+vCq9caYtyD8jyXZwdrmX0MCd
	 vCT6K/814OCtQ==
From: Imre Kaloz <kaloz@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v3 0/4] sparc64: D-cache alias flushing fixes
Date: Thu, 22 Oct 2026 01:33:36 +0200
Message-ID: <cover.1792609488.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These fix D-cache alias flushing on sparc64 CPUs with a virtually
indexed L1 D-cache (Spitfire and Cheetah).

1/4 makes xcall_deliver() bail out before it touches the trap block
when there is no other CPU to call, so an early cross call, before
init_IRQ() sets up the mondo blocks, can't end up writing to physical
address 0.

2/4 flushes only the page a PTE maps instead of its whole folio, which
removes about a million redundant page flushes from a colour-changing
mremap() of a large folio (7.3 s on a Sun Fire V240).

3/4 implements flush_cache_vmap() and flush_cache_vunmap(), which have
been no-ops. Stale vmalloc lines corrupt BPF programs and module data
on UltraSPARC III.

4/4 passes the number of PTEs to move_pte(), as Andreas suggested. It
touches mm/mremap.c and include/linux/pgtable.h, so it needs an ack
from the mm folks.

1-3 don't depend on 4 and can go in on their own. 2 and 3 are for
stable (3 needs 2), 1 and 4 aren't. The series is on top of the sparc
for-next branch.

Changes in v3:
- new 1/4 and 4/4, following Andreas' review
- 2/4: reworded the message and the move_pte() comment, marked the
  UP #endif
- 3/4: reworded the message, dropped the Suggested-by (I have no
  email address for nsafran1217, the Link credits them), noted the
  stable dependency on 2/4
- picked up Stian's and Adrian's Tested-by tags

v2: https://lore.kernel.org/r/20260928132102.1707-1-kaloz@kernel.org

Imre Kaloz (4):
  sparc64: skip the trap block in xcall_deliver() when there is no
    target
  sparc64: flush only the aliased page, not its whole folio
  sparc64: flush vmalloc ranges from the D-cache on map and unmap
  mm: pass the number of PTEs to move_pte()

 arch/sparc/include/asm/cacheflush_64.h |  9 ++--
 arch/sparc/include/asm/pgtable_64.h    | 14 ++++--
 arch/sparc/kernel/smp_64.c             | 51 +++++++++++++++-----
 arch/sparc/mm/init_64.c                | 65 ++++++++++++++++++++++++++
 arch/sparc/mm/tlb.c                    |  2 +-
 arch/sparc/mm/ultra.S                  | 25 ++++++++++
 include/linux/pgtable.h                |  2 +-
 mm/mremap.c                            |  2 +-
 8 files changed, 148 insertions(+), 22 deletions(-)


base-commit: 2bc58762a3d74e42de129d717ae3ba10ecf0ab96
-- 
2.47.3


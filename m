Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9797C312815;
	Sun, 27 Sep 2026 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544165; cv=none; b=qaevDAwb158Rc0Ina90Hs9PpUWguZeSGf+0a+AgVJfcP8VmFVXw84gql7JmekESPnJmIfJZTIfCm/Ub7/pwfAYQfuq7vLQY+2yX2YnzHXSGvrNmDORqWqZZEAtR50xRFgrUU7ZCR4m8KJvlXZn3ZbWwX85q10CPprdL/1QAJOGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544165; c=relaxed/simple;
	bh=k3m2nIZpQeVSQJToCQKSER6uVDRvnOBt7Ydh0R1PGvI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nxJvsOH2ddmrqq9/HNUW/PDsMgizAmxHpBTBAOI8Xykz/Ar/mZOteDSA6kRUSXugqhmiCayAOjIlOEYepn/449ePnJN4Eikce7ZWjAsHAseWEFcFs8VcLV7lLQ1wnHCE+wtbw/7JJ9nyY0C0uu15HptTTK44USksDXzbj1AUnNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=CcTwCaq9; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="CcTwCaq9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Or92qZZwHgX14AhwYdoKqIi977L3gG1Yn5r0Mc2KJno=; t=1790544161;
	x=1791148961; b=CcTwCaq91QIu2D7g7OfUsMlOFRi08cjt1hgkBQyYbXl4uUSm93XJohJdaZ9BZ
	kjnaW/h3WWt00rCmNKcu/UcyBZ8a7UvluXDLzevk28kuP45r5AvLPA9kUWBpxivUAUmm8Nr1Z8pqb
	uRch4623DLf4avm3d8zY4sFLDx6KvamXHYhELOKKSdb+QsDLDSQ7llCpA8Iih2gJsTO27sHlfoWGx
	ZpscCU245e5hG3BvbeT3/yZ5e81bXVDnRvbem1wpAmi5LcPDb8InpgyFzbHWNa4rxnC2TAaKojfFQ
	oH4zsuF0N8+LYQaoOKLjkJb/Rb+DqUgfdCktHwYcqezj0cVmaA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xAwKT-00000000OFD-3jHU; Sun, 27 Sep 2026 23:22:37 +0200
Received: from dynamic-077-183-200-086.77.183.pool.telefonica.de ([77.183.200.86] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xAwKT-00000002YQG-2k7Q; Sun, 27 Sep 2026 23:22:37 +0200
Message-ID: <3d0f0b6aa7ccaad25d04c5cdf0475d2d030c78e9.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/2] sparc64: D-cache alias flushing fixes
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Imre Kaloz <kaloz@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, "Mike Rapoport (IBM)"
	 <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 23:22:36 +0200
In-Reply-To: <20260927105539.8742-1-kaloz@kernel.org>
References: <20260927105539.8742-1-kaloz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Imre,

On Sun, 2026-09-27 at 12:55 +0200, Imre Kaloz wrote:
> Two fixes to D-cache alias flushing on sparc64 CPUs with a virtually
> indexed L1 D-cache.
>=20
> Patch 1 makes move_pte() and tlb_batch_add() flush only the page a PTE
> maps, instead of every page of its folio once per PTE, so the number
> of cross-calls for an mremap() of a large folio no longer grows with
> the square of its size.
>=20
> Patch 2 implements flush_cache_vmap() and flush_cache_vunmap(), which
> have been no-ops on sparc64.  Stale lines left by a vmalloc mapping
> corrupt BPF programs and module data on UltraSPARC III.  It uses
> flush_dcache_page_all() as patch 1 restores it.
>=20
> Both patches are tagged for stable.  Tested on a Sun Ultra 45.
>=20
> Imre Kaloz (2):
>   sparc64: flush only the aliased page, not its whole folio
>   sparc64: flush vmalloc ranges from the D-cache on map and unmap
>=20
>  arch/sparc/include/asm/cacheflush_64.h |  9 ++--
>  arch/sparc/include/asm/pgtable_64.h    |  7 ++-
>  arch/sparc/kernel/smp_64.c             | 42 ++++++++++++-----
>  arch/sparc/mm/init_64.c                | 64 ++++++++++++++++++++++++++
>  arch/sparc/mm/tlb.c                    |  2 +-
>  arch/sparc/mm/ultra.S                  | 25 ++++++++++
>  6 files changed, 131 insertions(+), 18 deletions(-)
>=20
>=20
> base-commit: fe2ec83746e501645709761605c2464a44fd2929

Would you mind reporting the bugs that these patches fix in the sparclinux
issue tracker on GitHub [1]? The reason I'm asking is that there has been
recently a strong uptick of patches for SPARC and I want to make sure we're
not missing any when Andreas gets back to reviewing patches.

Adrian

> [1] https://github.com/sparclinux/issues/issues

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

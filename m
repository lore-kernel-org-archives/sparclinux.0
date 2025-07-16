Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DAA20EB;
	Wed, 16 Jul 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646740; cv=none; b=qkg9i0x9cu46VPM97L8OBJq1mh/r8X8oenXnZqcZFJdPYYt1XZGavrkvC7Y6x4FOWz8G4xnoiYJyFL9EL0wMeME/FVtxjMksEdfSscr5TtbOzjDxjHURsjEVplmy6/UWcp36tD7NjFaayIIcS/BVvb9fznSAO25qWXHorrLKa7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646740; c=relaxed/simple;
	bh=qjPrwqF9/I2x8Qf6rZVsKDPcqEE/qYpZvKlRBCnYWto=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gIjIT/XNRtHr7OzxuO4VR8ICanVoJEJu8uz14VBrVU8DtESRXGJ9CLh+XmnHj9k617Lw8OeYUf37Ic/25NffMutjOSpSszntGsnvVXtYlOVYkZpuvN5Hf7qb/q1QkEiA7zCTYbJjKNaWaF6CzSUt1/krbFx05Qgp5+keW1PYM9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=jB7bcGfa; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="jB7bcGfa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=qIHKtqHYhjFHDqLB5xdZ5o+B+hj8vWTNDrAvtMdcHZU=; t=1752646736; x=1753251536; 
	b=jB7bcGfaLpeq5netKPCvVfANUs+PKESUZqZicypf5Lz6z+WeR3Docbchgj5vGgXIF2ME1H13I6R
	boSHjAKJP8rAeIHafWn+hDODxvRDEZI0Ktl7rMDtxIpCmD96sMPP9GFCRETvTynKDZq0+aqDbK2/2
	gD7+6+4ezexBSAHFWEnqH7h92uJ2aI1XbHd1RngJCaQu2S/Y9H7NzxuSo4kajipQuzKh2TlqkHhwR
	5sq/frkrSjYmtsivMya6TDqD8m+k1XXTtzmw1EKhaexLbb67KmpztO9KER7GOqApxAiTY5o21a+Hv
	vwDI2aT76XtKejJdZKL7tByybaxYiRUvXKJQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ubvTb-00000003Tv0-0wKq; Wed, 16 Jul 2025 08:18:47 +0200
Received: from p57bd96d0.dip0.t-ipconnect.de ([87.189.150.208] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ubvTa-00000001iiC-4A3T; Wed, 16 Jul 2025 08:18:47 +0200
Message-ID: <7531c897d8a4dc874bc226f5cb724eb66ee17974.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Wed, 16 Jul 2025 08:18:46 +0200
In-Reply-To: <20250716012446.10357-1-anthony.yznaga@oracle.com>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Anthony,

On Tue, 2025-07-15 at 18:24 -0700, Anthony Yznaga wrote:
> An attempt to exercise sparc hugetlb code in a sun4u-based guest
> running under qemu results in the guest hanging due to being stuck
> in a trap loop. This is due to invalid hugetlb TTEs being installed
> that do not have the expected _PAGE_PMD_HUGE and page size bits set.
> Although the breakage has gone apparently unnoticed for several years,
> fix it now so there is the option to exercise sparc hugetlb code under
> qemu. This can be useful because sun4v support in qemu does not support
> linux guests currently and sun4v-based hardware resources may not be
> readily available.

It has actually been observed for a long time that newer kernels are
unstable on sun4u while there are no stability issues on sun4v.

I'm not sure though whether the Debian kernel enables hugetlb by default.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

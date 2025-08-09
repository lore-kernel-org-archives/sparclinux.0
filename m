Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BF91D8DFB;
	Sat,  9 Aug 2025 06:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754720765; cv=none; b=R65RrUvNY/GaJ3HtR9z9kJ300Rtsbhs8ctjhfxhBr64KkJKCAXGGuBahBzQQWTth+kohxiI+ZkzVBmMZE3WQKdp3tlEKiZM5+tC8WL3/wS9wdAgIIPICNUs+BT1xw+N7ScUyhabUAohjheeG84A4/EbR5Dqdb5yqhvHayaAqqFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754720765; c=relaxed/simple;
	bh=tMqbYmacOxDEaXLD8hTG/RObRnBl5VNq06fV8/PeOgs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RkalLK5aPQP6jEL5na5VIOcGHCDmXtbxHVfibRv3oln/FyeuZ3SZ9sbRggr9VhFaw+Fbkel7zrevqdmbOosDajIcExvIRrN8Pufl/R5HMpTiQptTeP9oGk24At7GA4YmDiD+Cm4YVTCQFpT+rbiFwhn2NovFalU6X3otmmMdIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=kC1oblFl; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="kC1oblFl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=/CeKL7+I9vmFu3DDvcbqSSJvc4ojZh4QpeoPQSOmkbc=; t=1754720763;
	x=1755325563; b=kC1oblFlmuTQMmI8284zeZLV94XiWGMtXHegnqwsJJWROsaRGZCf27r/9ziFn
	j0bl/PANYdDbeaOmaqDPOa9L9HouN3qYYvH2Wc0wV+1hiFDI8FyuklPA9jZ32dKRv8K/ugc47uS1P
	ATdC3ZKSp+EU4/xo/UPih21tZiKlUn2VuOwpDXjE0zmr2wjmI4sI+9hH/8HV6bnAJC/W39x3EyXqO
	35+HuxCloALzgqyQ8mBZG8nR6AjWpjJQIULLxs5r0HJgN69FXC4xe6Q4oNW4OKfhqd1CA/ThMp/ty
	RuLRhZWr6LB7tVS04KAR9TDEftLcLGb+mGyokfJ/F9frtnCOrg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1ukd1l-00000000sIR-1Fdj; Sat, 09 Aug 2025 08:26:01 +0200
Received: from dynamic-002-245-158-117.2.245.pool.telefonica.de ([2.245.158.117] helo=[192.168.178.50])
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1ukd1l-00000002W7Z-0Lnb; Sat, 09 Aug 2025 08:26:01 +0200
Message-ID: <fc1555550f7a9b3c9aa5fb651769cf41ed859c77.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc64: fix hugetlb for sun4u
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Anthony Yznaga <anthony.yznaga@oracle.com>, sparclinux@vger.kernel.org, 
	davem@davemloft.net, andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org, agordeev@linux.ibm.com, will@kernel.org, 
	ryan.roberts@arm.com, david@redhat.com, osalvador@suse.de
Date: Sat, 09 Aug 2025 08:26:00 +0200
In-Reply-To: <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
References: <20250716012446.10357-1-anthony.yznaga@oracle.com>
			 <35f5ec4eda8a7dbeeb7df9ec0be5c0b062c509f7.camel@physik.fu-berlin.de>
			 <7e1e9aa5-0529-4fb5-84fb-557b5cc1cd50@oracle.com>
		 <38f4469f48e6d36fa92b445c8ecef7a440be43e6.camel@physik.fu-berlin.de>
	 <b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de>
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

On Sat, 2025-08-09 at 08:23 +0200, John Paul Adrian Glaubitz wrote:
> Hi Anthony,
>=20
> On Sat, 2025-08-09 at 00:37 +0200, John Paul Adrian Glaubitz wrote:
> > > Maybe try enabling CONFIG_DEBUG_VM_IRQSOFF, CONFIG_DEBUG_VM, and perh=
aps=20
> > > CONFIG_DEBUG_VM_PGFLAGS. That might help detect a problem closer to t=
he=20
> > > source. You can also try adding transparent_hugepage=3Dnever to the k=
ernel=20
> > > boot line to see if compiling in THP support but not using it is okay=
.
> >=20
> > OK, I will try that. But not today anymore. It's half past midnight now=
 here in Germany
> > and I was debugging this issue almost all day long. I'm glad to have fi=
nally been able
> > to track this down to THP support being enabled.
> >=20
> > Maybe you can try whether you can reproduce this in QEMU as well.
>=20
> OK, first data point: Setting CONFIG_TRANSPARENT_HUGEPAGE_NEVER=3Dy cause=
s the backtrace during
> boot to disappear with CONFIG_TRANSPARENT_HUGEPAGE=3Dy. However, it still=
 disappears later when
> running "apt update && apt -y upgrade" again:

That was meant to say "it appears later", of course.

So, again. No backtrace during boot with CONFIG_TRANSPARENT_HUGEPAGE_NEVER=
=3Dy but later when
running apt.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

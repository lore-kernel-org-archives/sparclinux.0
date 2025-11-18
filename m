Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1852AD00
	for <sparclinux@vger.kernel.org>; Tue, 18 Nov 2025 15:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481344; cv=none; b=IUQ13OtBodBYf25piBBkLfPHbX0zZ9TjncK6zUjGe9++d3zsKsVzijvxwyPOL4B3WTLqXcT03OoLl9oeCACQD5+qoWHo8/Xke6NAhKBJHXh2FeVyNKPPZ12I+F79d8QGH2QvbFFI+58rG54RdaClidIq37TVGpMvquWeNj8pe70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481344; c=relaxed/simple;
	bh=bf7Sn+bBMVXQNyZ19L3RgdpaHpaUlCI5A/pkoWsH1z0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+knYknQErzXQGj5ucVZKb3oVuqWBp6pDsFZOFmVzgjZ4EFmpB7lyXv349F9j1cyH1n9UBiZCLA3XnrU9GovxKI/40eT2sMc0FaQxknQlm80C+vwkLnKXCnu5XevZBiUjf/8u0M1scRd7Jws3uVu8qKUYuUCovFmpXZ9YHEWo0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=X4T0Lnry; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="X4T0Lnry"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=MSQjZYGjxmHoqyC1/epkXGCr2/PqTp/r73ts7qR++mI=; t=1763481341;
	x=1764086141; b=X4T0LnrypgWlkH3dB7LbrkpAkt7G/zZfbKKbTLvcg5vTKlc94bFqmEsmnDEJF
	Dt7Vx35/aD3adjBj5N1G41fCrAqg0kOhzFBL6Q9aTuGRxHRVkwp9uDWiKeoJtkFvdMfuKPHECLgXh
	eP9Ojqx9KKxaX8Os8B6a3hRwDJ0L0XV4fKPiMsyYtP9dnB/O9WUkKTFu/6Z+q8fzIOe7ldN5NHXvu
	9h719VrhgN5AaYyBtNLSUphCgB2DiZ59103w8IARcCSgK3yG+Il9CUgta16M9+IV7DzJKVdXhmH6X
	oQgtNgfbN7rNjUHt7GVu5HCgX4y5Qh+kqv1WiknQir3Tt0dyYg==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.98)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1vLO0D-000000013RG-2HJo; Tue, 18 Nov 2025 16:52:21 +0100
Received: from p5b13aa34.dip0.t-ipconnect.de ([91.19.170.52] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.98)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1vLO0D-00000003QvV-1EKz; Tue, 18 Nov 2025 16:52:21 +0100
Message-ID: <4eb320510cf615a84db959cce8f73bc755dbf712.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: Correctly recognize Sonoma S7/S8 cpus and perf
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>
Cc: sparclinux@vger.kernel.org, joe.moriarty@oracle.com, 
	david.j.aldridge@oracle.com, allen.pais@oracle.com, davem@davemloft.net, 
	andreas@gaisler.com
Date: Tue, 18 Nov 2025 16:52:20 +0100
In-Reply-To: <20251118.162529.193664192018749438.rene@exactco.de>
References: <20251118.142521.973960159957848254.rene@exactco.de>
		<baf12ef8dcf7ec72423bc2795d4824c06ed32adf.camel@physik.fu-berlin.de>
	 <20251118.162529.193664192018749438.rene@exactco.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hello,

On Tue, 2025-11-18 at 16:25 +0100, Ren=C3=A9 Rebe wrote:
> Thank you for taking a look and bringing this up. IMHO they modified
> the GPL licensed Linux kernel and thereby agreed the GPL license
> terms, shipped and Signed-off-by it. I don't really see any legal
> issue here and as Guenter Roeck lectured me the other day, there is no
> real Copyright for few lines changes[1], anyway ...

Oracle started a copyright litigation over Java headers which were GPL
licensed, please keep that in mind. Although they lost the case in the
end, Google had to spend considerable amounts of money to win the lawsuit.

> I also significantly re-based and fixed this S7 patch and if it was
> for me we could remove the SN/S8 bits as this appears to be unreleased
> hardware that nobody probably ever had? I or a friend could also
> retype the SN to S7 rename perf and asm wire-up, it really is just one
> hex number and sed, ...

I understand all that. Yet, there is nothing urgent about these patches
to get a formal clarification first so that we don't run into any possible
problems in the future.

Having an official approval will also enable use to upstream all the other
patches such as the one for kexec support or Linux LDOM server support.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

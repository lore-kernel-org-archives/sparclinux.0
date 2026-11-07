Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794086045;
	b=Bb3tDB4diAZgRqU+ih3u5L/hzxiX28uag+uA92eJmx6jpAmb6W7Hfcqcic9zgfkcWCIV
	 ndBP9a+vJxbQClKxA3j4rXGaMjfWANGRT2ib1nJHWtbqHb+Vkv9uM5tF18NnAbzFsv/WE
	 +l+B3DMf9f+NJTTDIZktW6XsUMybJvGSn4PoimTDfo3I864ekLQtWdZgX9gRJAwsZDWL+
	 clPh/Ih388WYyAdACOXG8CRJi9pYJ3ZlF7Wat5pw/JYLcRzreZ8zKTkyEBJYKysHl1vpV
	 skV/GIsVZfEap2ZYpEE+oxc+uuftm33nG2R4T61ndIKss7IDeKH36KWuylObjle6dwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794086045;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=aqbNZDFl3W7nMuL0eYped16qZaf0LUkCZcoL0Ki7p6U=;
	b=bYc3LVMUfNQI0JlFLkcaNEMKVISOYuIWGdsIysXW52ENwsXj+WEbKA2rPDHwG61Uyq6f
	 l5PxjPK9bmnR1pGgHtvtekhN63s/nlRk3OS0o23wPd5Q9TggMQ91J9AGfYZdEqR0xcOe4
	 v7y8nygUyl+D2Zw5klZjSIdmpEywfxQ+9k5wGkJeouePlDnHXTZX76eCr1rCrMPFNSY9n
	 T/umOPlnyOwq1knInLQGAtQqO7rQf1NPHGNyKT6zbHZ8waJE4++JcWoh0HIJaSFUlprBd
	 m/heBCuiFOFCEOR+vFjZJHXumP0sEH7pnvBX9AfDyFzrlac2NeocVyIv9Q73Xr7iVkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=iG8QVk3F;
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7596606A326;
	Sat,  7 Nov 2026 21:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7596606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=iG8QVk3F
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=aqbNZDFl3W7nMuL0eYped16qZaf0LUkCZcoL0Ki7p6U=; t=1794086043;
	x=1794690843; b=iG8QVk3FgThLaDy1/JWn38nzMtk7uhTkxIm1Cj0Ht2YPfYnyFSod0+eoD5TEb
	Ex8r/UVawq/O/jk15WcaCwbh6ZcWo9H/hIjiuwRHkduaf4WrCIvSJLmASjHUMz/zYjdVc+Str7eEl
	eWAyQKZTCm7MnK8LN4hla8joZzbXXxQIvKkUqUsKo708I3khtFw//oUk3iRzhkEDm+sgETNgeUwYX
	eisdYLKjc/DKRXhfLaqBBZwmEuJ069rv42VX5bGSg8QXfzaCRaUmLrRquFMTHpWcm4n4ms8KRGfbR
	hzENrG/q9nJt42WZt5PTa3Z5kFfGwdFkm3wCOwLjQ5KIx1dPhQ==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xPnjU-00000003pWH-25CG; Sat, 07 Nov 2026 22:13:52 +0100
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xPnjU-000000010QH-0aj4; Sat, 07 Nov 2026 22:13:52 +0100
Message-ID: <155ec5c6c5f6d4287a420191cb3927eba1d97526.camel@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc/iommu: Use raw_cpu_read() for iommu_hash_common
 in iommu_tbl_range_alloc()
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Karl Mehltretter <kmehltretter@gmail.com>, "David S. Miller"
	 <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 22:13:51 +0100
In-Reply-To: <20261107195147.70084-1-kmehltretter@gmail.com>
References: <20261107195147.70084-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Karl,

On Sat, 2026-11-07 at 20:51 +0100, Karl Mehltretter wrote:
> Fixes: ff7d37a50202 ("Break up monolithic iommu table/lock into finer gra=
ularity pools and lock")
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
> Assisted by an LLM.
>=20
> Tested on v7.4-rc1 (d48723711bae) under QEMU sparc64 (sun4u, -smp 2)
> with PREEMPT and DEBUG_PREEMPT. Without this patch, two consecutive
> boots emit three "BUG: using __this_cpu_read() in preemptible
> [00000000] code: swapper/0/1" diagnostics in iommu_tbl_range_alloc().
> With this patch, two consecutive boots complete without the
> __this_cpu_read() preemption diagnostic.

According to your Fixes tag, this bug was introduced in 2015. However,
I have to admit I have never seen this message, neither on sun4u nor
on sun4v machines.

Is there a reliable way to reproduce this bug?

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

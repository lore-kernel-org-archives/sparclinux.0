Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=144.76.212.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685830;
	b=Cn5aIJxiMrqJnH3rf4+hHHWK46DHgsGGC5ZBm/frCeb1VaXzYa/bfxbS1oVmLrGIt5PO
	 SvUccUd105sfslme4J+gcWMj8lcnh705sSezY31hkYdWVTeou/BAZpGEUT//AIhqKOdyG
	 B1GaTd4b/50lq5UzMFSAnAM111x/DqpsOwGIObBkEOuj132biNgEu1+eBbaFHKkPmShHI
	 +QTFed+fU1NtLW9W7caAlGW17ISyusIrearyTU/mUj30Sc2RYLrd4E7eiI9BRspWIphEZ
	 /i21YDPkT6OX0TzOgnwwFK45btQRv7/iEAT/3IF1P2F8CMQ9+cdEINzrt+zL3FUwU4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685830;
	h=Received:Received:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:User-Agent:MIME-Version:Content-Type;
	bh=dySdZErp2cxtgCmjNL3MOLQ5C3PwLjarIMbiSXRprSc=;
	b=hGlO4NQsNKliefbo1PedoWGDHnOwXyC5KxVAKOxPh7uq1oB3+/AdffmdMXDPdve/nOPC
	 UjAh5H3OV5bmCxYRZNtEiZbE5i6YIjDjyki6Yie7woQthyW1vbQnTUa+BdNLWYaIXYB/D
	 2Nl/Otq5cCO9TM/6uQr1VkmmlKwkFgEa8UH3vu4GLBeDE86YPQdcBfH04wkEstzkHXLTj
	 H8lMRjMzhI0gRX/r3Z95y9A0NsOaKDyzoI9MvNzCvTyY1uOsnpLkRvjHsZORH5sWPvq2r
	 V2BGe/nzN768zV1A9NBe8LmlJEhwphJHI+NxZrfL/HKoDYtMvI/Fapx2mcyFWRefExQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=permerror header.from=inai.de;
	spf=pass smtp.mailfrom=inai.de;
	arc=none smtp.remote-ip=144.76.212.145
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB29F606A319;
	Thu, 22 Oct 2026 16:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id B59CC1016BF282; Thu, 22 Oct 2026 18:17:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id B4DE31108E606F;
	Thu, 22 Oct 2026 18:17:01 +0200 (CEST)
Date: Thu, 22 Oct 2026 18:17:01 +0200 (CEST)
From: Jan Engelhardt <ej@inai.de>
To: Stian Halseth <stian@itx.no>
cc: davem@davemloft.net, sparclinux@vger.kernel.org, 
    linux-kernel@vger.kernel.org, 
    John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH] sparc: populate sysfs cache topology information on
 sun4v
In-Reply-To: <156ed58445e869ffb783bfee0c07bc784f6178ad.camel@itx.no>
Message-ID: <oo23630s-96q9-69n0-9457-764233rs5496@vanv.qr>
References: <20261018222723.43442-1-jengelh@inai.de> <156ed58445e869ffb783bfee0c07bc784f6178ad.camel@itx.no>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Monday 2026-10-19 11:49, Stian Halseth wrote:
>Hi Jan, thanks for looking into this!
>
>On Mon, 2026-10-19 at 00:27 +0200, Jan Engelhardt wrote:
>> +int init_cache_level(unsigned int cpu)
>> +{
>> +	struct cpu_cacheinfo *i = get_cpu_cacheinfo(cpu);
>> +	i->num_levels = 2;
>> +	i->num_leaves = 3;
>
>Using the MD node as the cache id with CACHE_ID set looks to me like
>the right way to do it. I tried it on my T4-1 and V240 and have a few
>comments.

I did not even expect this to do anything sensible on V240.
That is just an accident - and multicore-per-package (MC)
sun4u are expected to be still misreported. That needs again 
different logic.

>Maybe it's simpler to just walk the MD directly in init_cache_level()
>and populate_cache_leaves(), following the same arcs as
>fill_in_one_cpu(), and add one leaf per cache node?

After some pondering and in anticipation of MC sun4u, I think
re-walking is sensible. I expect there to be a few savings
(just 24 per strand) and a bunch of LOC removals.

More later.

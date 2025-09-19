Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E30E1A2392;
	Fri, 19 Sep 2025 18:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305036; cv=none; b=RL34hcaM5hIxn7/CvDsR6WU1Xo+LFhkmeGgFRJzTFDn4qq+I9cCM2w4JQ0OwXxPNIvoeOJwvFtN4nrTS5mFp4PVNTsgCv20+yumIXzDAH7qC+9LadObgtxA2sUTVfNwkhEDReLKKqNQgHToo7dVkKmV/k+bcuu/7W6xeoRdhkms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305036; c=relaxed/simple;
	bh=+vfFD0ksVBgDxGvIVOQTciLG+bWf6363nTSY63/+W58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mwz/Ue9QrnwnYcKmMZzENIxCALpFf9Hh/PDcBz3VBS5boXV682qBgscBlQEXac6RWHEklG/r+HE5A2Haf6qTNhXLuyRm+nIfX6At5vZB3WtCwcD3qvhQ2n0ynbdq4I+azXKJc+8Y0e2wdKbxuj9bc/2Ld3vqZJk33GaBI/yLF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=hDLzIyHf reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="hDLzIyHf"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0kJ0dncz1FZPj;
	Fri, 19 Sep 2025 20:03:52 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0kH3N94z1DDBW;
	Fri, 19 Sep 2025 20:03:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758305031;
	bh=B3SCEV+fNn/h4NElp2MlmrRvOvxvwaw75GPNbscASAI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hDLzIyHfeogJAt4ydFcTzgxoAt2YqWNyBh/kvkdMvtPtQMKpRuTcGeV6y0s7U+KC9
	 lT4o1Gz6qtNRiobb3BcJRdlfiTkUvUsm5f4iRhBCUy/c6zdM7bA4rtLSX5plQ2TP1B
	 hOrhbhbxjSBDi76KpGjCCQ5i59j4H0cwCm87TIV1X/OiplGAYS4IPN8U7kOWLj2NTT
	 ht75V7/PlsITo01JJy2vWLqmvZprLM/d79kV/rq/ugwn8/SMu3rg4dhhGJAiK+VijY
	 BN+JBvUtJZOKl2++OnQeiHFdL8JQ8DZGU1upEV0TD1qnkvqlBP2w0NMdHesmsCpZwU
	 CxwofrV++XriQ==
Message-ID: <8d32507a-dd01-4785-946d-00ad28b1fd58@gaisler.com>
Date: Fri, 19 Sep 2025 20:03:50 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Fix accurate exception reporting in SPARC assembly
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, =?UTF-8?Q?Ren=C3=A9_Rebe?=
 <rene@exactcode.com>, Jonathan 'theJPster' Pallant
 <kernel@thejpster.org.uk>, Magnus Lindholm <linmag7@gmail.com>,
 Tony Rodriguez <unixpro1970@gmail.com>
References: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250905-memcpy_series-v4-0-1ca72dda195b@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-05 00:03, Michael Karcher wrote:
> In 2018, David Miller implemented accurate exception reporting in
> copy_from_user and copy_to_user by handling exceptions on each load
> or store instruction that accesses userspace memory and calculating
> the remaining bytes from the processor context. As issues with
> transparent huge page support and folio support in ext4 were due
> to a bogus return value from copy_from_user, I wrote a comprehensive
> testsuite for the generic variant, and the machine-specific variants
> for UltraSPARC I/II, UltraSPARC III, Niagara, Niagara 2/3,
> Niagara 4 and M7, see
> 
> https://github.com/karcherm/sparc-cfu-bug-reproducer
> 
> despite the name of the project, it does not only test copy_from_user,
> but also copy_to_user, and it also contains fixes to a very small amount
> of exception handler references that were calculating the result in
> a wrong way.
> 
> For UltraSPARC III, I chose to adjust the memcpy code itself instead of
> adding complexity to multiple exception handlers. That fix has already
> been tested to fix stability issues observed by Adrian Glaubitz which
> kicked off the investigation. On all other architectures, the changes
> are just to the exception handlers.
> 
> Kind regards,
>   Michael Karcher
> 
> Signed-off-by: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>
> ---
> Changes in v4:
> - Add further credit for running tests on machines with this patch applied
> - Link to v3: https://lore.kernel.org/r/20250904-memcpy_series-v3-0-906655a5a7ad@mkarcher.dialup.fu-berlin.de
> 
> Changes in v3:
> - Fix bad formatting in commit messages (missing line wrap,
>   extra empty line after Fixes:)
> - Consistently add hardware to Tested-By lines
> - Link to v2: https://lore.kernel.org/r/20250904-memcpy_series-v2-0-9806dd1784e7@mkarcher.dialup.fu-berlin.de
> 
> Changes in v2:
> - More verbose description on how these issues were found
> - Add M7 change, previously separate in
>   https://lore.kernel.org/r/20250828121844.2250-1-kernel@mkarcher.dialup.fu-berlin.de
> - Link to v1: https://lore.kernel.org/r/20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de
> 
> ---
> Michael Karcher (5):
>       sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC
>       sparc: fix accurate exception reporting in copy_{from_to}_user for UltraSPARC III
>       sparc: fix accurate exception reporting in copy_{from_to}_user for Niagara
>       sparc: fix accurate exception reporting in copy_to_user for Niagara 4
>       sparc: fix accurate exception reporting in copy_{from,to}_user for M7
> 
>  arch/sparc/lib/M7memcpy.S     | 20 ++++++++++----------
>  arch/sparc/lib/Memcpy_utils.S |  9 +++++++++
>  arch/sparc/lib/NG4memcpy.S    |  2 +-
>  arch/sparc/lib/NGmemcpy.S     | 29 ++++++++++++++++++-----------
>  arch/sparc/lib/U1memcpy.S     | 19 ++++++++++---------
>  arch/sparc/lib/U3memcpy.S     |  2 +-
>  6 files changed, 49 insertions(+), 32 deletions(-)
> ---
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0
> change-id: 20250902-memcpy_series-b3bdd5542ca7

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


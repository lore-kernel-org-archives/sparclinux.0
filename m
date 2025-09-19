Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0241A2392;
	Fri, 19 Sep 2025 18:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758305307; cv=none; b=QqNy0xYYGPQd4VUcNN2XKsqVUr7NdjAJxNhAWmksblJQ9Kugu14QePLSgzFuP/BQt4Q87d8a8Za3Yhq+iWR2/axCtK3dPxxNNTgpnMegFTjQHwil5b34nvQ6ol5qjc4ghE1miQTU/eLpIqvaHyrMvKy+49oppfZ0CwkMsolYgrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758305307; c=relaxed/simple;
	bh=GmHbu8ynTyd173pmgmhNrvCDGzhcTmBxNkeN59Ta6ck=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FYLtb2zaaHoizcYSrQs9EbPUwRFXOT21sjdL7+r9cY/JpTNne/4z1XIFIBEYJXFHSDXVzAPjcqYKZK5xcemUjJtq7H8ggSmN3HHlDetORglbFWEaPhja4a9NwXzo184MqqGJwH6XMYeJAN6seOaXJjL7MZBTrqpkZRlViDJDj1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=KDV7vTlj reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="KDV7vTlj"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0qW332yz1DDBW;
	Fri, 19 Sep 2025 20:08:23 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0qV6rfxz1DDgW;
	Fri, 19 Sep 2025 20:08:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758305303;
	bh=or5FSHJv8FvEukdP9GhqjsDqbG7dhF0bL0g3d2UeTB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KDV7vTljLwb+U84dNx5bw5/mG977ff9eb8i7H/19aT7tExv8goUmNapCyoYYthnMF
	 zoDWJ05ed6TK6r1SBTnf5SpSJeI9UnzCmEG4ZNo8/IDJ/qS+8lyBdEowZvgTrD+1ff
	 g+Slr/H7M9RdLrn7zsLlwePuIoiyIORMq182yDSSGtTpW80cHYhhpiNr9NXzz2jyl5
	 HiftCd+t944o53UUW+k85y/tUGrNYGW3n9x69u/7eCCV8dLsiKiwUCkaHLnhasl/DP
	 P4/16c/UssiTKMgXS0WT+4XgJUG0ZKteUBsdwigDj9a8caLBiV/LD4k5QHGNSFd/1J
	 YLg2FycxEQ0cg==
Message-ID: <932cf31f-84ca-4298-832c-98579f8b37bd@gaisler.com>
Date: Fri, 19 Sep 2025 20:08:22 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] sparc: fix error handling in scan_one_device()
To: Ma Ke <make24@iscas.ac.cn>, davem@davemloft.net
Cc: akpm@linux-foundation.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250718093205.3403010-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250718093205.3403010-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-18 11:32, Ma Ke wrote:
> Once of_device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
> So fix this by calling put_device(), then the name can be freed in
> kobject_cleanup().
> 
> Calling path: of_device_register() -> of_device_add() -> device_add().
> As comment of device_add() says, 'if device_add() succeeds, you should
> call device_del() when you want to get rid of it. If device_add() has
> not succeeded, use only put_device() to drop the reference count'.
> 
> Found by code review.
> 
> Cc: stable@vger.kernel.org
> Fixes: cf44bbc26cf1 ("[SPARC]: Beginnings of generic of_device framework.")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> Changes in v2:
> - retained kfree() manually due to the lack of a release callback function.
> ---
>  arch/sparc/kernel/of_device_64.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
> index f98c2901f335..f53092b07b9e 100644
> --- a/arch/sparc/kernel/of_device_64.c
> +++ b/arch/sparc/kernel/of_device_64.c
> @@ -677,6 +677,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
>  
>  	if (of_device_register(op)) {
>  		printk("%pOF: Could not register of device.\n", dp);
> +		put_device(&op->dev);
>  		kfree(op);
>  		op = NULL;
>  	}

Thank you and sorry for the late feedback, but could you also fix the
same problem in arch/sparc/kernel/of_device_32.c?

Thanks,
Andreas


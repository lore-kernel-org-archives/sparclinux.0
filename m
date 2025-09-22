Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D654627455;
	Mon, 22 Sep 2025 05:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758520151; cv=none; b=uQxhfaXBbJ0AYQOVjPvdVE/lx6qQZ/e1BUoSgr696dPYRuP5TfOSQx3qvPi1apEv2CKYfU/3YW/IoEiAykHNQU9y+dkpae+fm+neIjgw6sO1WbIEpMi4QSbDvEFNcPfgPKOo60q5eCipFqHn8PQ9NsSRG+eztuR7MJj4sCGoScg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758520151; c=relaxed/simple;
	bh=xLznKOPCZJxUINUg6ogY4rcZGSnCqCh6PHSXO/zoNl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2WpOsTlFarF1LUswV35NCGAL93iKkuBEKCRfywDv2QmBftPYH4WjRmiUdYSPr7wCVQgCsMMgQZ0EjIgPGUkfYZRc5r4+SZlRrZWJuobLfsd9dLYRJntqijLS9AbDyApsElsjgctazFisro8ohvlRyH42uq+8kTf4etwHcAWv38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=C7CF/riN reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="C7CF/riN"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cVXGz2Gfbz1FXSV;
	Mon, 22 Sep 2025 07:48:59 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cVXGz0Gx3z1FXSX;
	Mon, 22 Sep 2025 07:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758520139;
	bh=OtRjZMliMamb/V4HMei//Y9bvbkSRWDtwSqjtwGbWTM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=C7CF/riNw5nkFMWvCk6RcdVD4xQcy5Q03qeD27YEPK2pxwJEmm2cJWOulwfd57C1q
	 bLUMKTWcHAZZ7G9bF8wZougelLI7Xe0CZXKSGXKSpFR8R3zW5iQBFgW6aQ8RkiY/Kd
	 QlXnEMn4epa4CliUeOcTeHPpI/pxJFnxfYrF1/5cMdbhzKhbQ6zHJldd/pYJTE+0dL
	 ZkSJGNBLcM5wSTfGqdTnxWmKRNsWIQdGcBcivNFzaj5fTjQqKQMFBPbXZXBbUL5O8P
	 6sFWcqBiiYpYUYo0gxTr2s2RJZzPn8Ft2NRfLLr4w8Rts+Q94ukPZClxJNcaZxsPPE
	 eonlLD/dp9qKw==
Message-ID: <93a6baf0-bafe-4855-8679-aec375debaa6@gaisler.com>
Date: Mon, 22 Sep 2025 07:48:58 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] sparc: fix error handling in scan_one_device()
To: Ma Ke <make24@iscas.ac.cn>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20250920125312.3588-1-make24@iscas.ac.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250920125312.3588-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-09-20 14:53, Ma Ke wrote:
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
> Changes in v3:
> - also fixed the same problem in arch/sparc/kernel/of_device_32.c as suggestions.
> Changes in v2:
> - retained kfree() manually due to the lack of a release callback function.
> ---
>  arch/sparc/kernel/of_device_32.c | 1 +
>  arch/sparc/kernel/of_device_64.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
> index 06012e68bdca..284a4cafa432 100644
> --- a/arch/sparc/kernel/of_device_32.c
> +++ b/arch/sparc/kernel/of_device_32.c
> @@ -387,6 +387,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
>  
>  	if (of_device_register(op)) {
>  		printk("%pOF: Could not register of device.\n", dp);
> +		put_device(&op->dev);
>  		kfree(op);
>  		op = NULL;
>  	}
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


Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


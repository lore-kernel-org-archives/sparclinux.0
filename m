Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB4629824B;
	Fri, 18 Jul 2025 13:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845151; cv=none; b=jG7LOd1txSc6O+wkOUoWMD94yqDXpogd6mmIDAiZ9nSKRGuUmRXTUrKMFevXqijcse/9LYqty5oLOcmgbgnoNMyieyh/72w+j6dqM23HjLvecdrLV7Ueh1GvR5SaymdDhhxvR4y4hUsG1SNlW7hjj4/QeopyGLzVHR0v1A3hduM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845151; c=relaxed/simple;
	bh=6CyGLV/s+uTT8NLeaa+qwpOtv57DAGRIt+JkVt7UivU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OE3u+CEvThPTT0rHBveB+bgj+MuNLfqVuTkuGkEBAAS833FUAtDEwjD5cGQwyNGeUSHiIbdeaJ063CP+UBZbK5qbIqdQF6dsdXO2jV9s49HOlDbrQH2w/sLzFyRkjiULVuZ1V+vOYO3lUUMlL03raVvKzljGpjzkFqeNlzZLkMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfAjnd5s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FfAjnd5s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE76C4CEEB;
	Fri, 18 Jul 2025 13:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752845150;
	bh=6CyGLV/s+uTT8NLeaa+qwpOtv57DAGRIt+JkVt7UivU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfAjnd5sC8/1cLxF4OjqtOxB/8XuptQw/3w+TmL00An7iERiS1BnnRQWy5Meaq/KS
	 j5EERfblCawGxplk+54gFELuzHajUMVDp+ISHuMrQZbE7WEYcTcjJ+tglPE6P5ps/t
	 CLsxiywEyQG1M4VHH8lofCRakq405ZqEBa+AnN8uQ6/7TXkuXDTX4foQH9kcx77ZdO
	 SxFj6OfuygnJgLTAVa5O8O+pwLQjZG5nTIP8jRiULaJO3DsRFs96yZ1e6qndk6Cc0e
	 JLuf9kz4U5rvMdbNc6ymZBLYwDAn+K5p8K8Ojne6/NIphSk2WPjWSSVWMTyNoQwPPZ
	 JLCBHNXEtm3ew==
Message-ID: <25e7455e-816c-448a-b78b-94fe9437e3c8@kernel.org>
Date: Fri, 18 Jul 2025 15:25:47 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arch: fix resource leak in chmc.c
To: Jacky Liu <1972843537@qq.com>, davem@davemloft.net
Cc: andreas@gaisler.com, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <tencent_C3DEC6F98F25C1BF6F35F3A1B0A629E0EA0A@qq.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <tencent_C3DEC6F98F25C1BF6F35F3A1B0A629E0EA0A@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/07/2025 11:22, Jacky Liu wrote:
> From: Siyang Liu <1972843537@qq.com>
> 
> In the jbusmc_probe function, the device node mem_node fetched 
> via of_find_node_by_path("/memory") is not properly freed 
> on all code paths. 
> This can lead to leakage of device node reference counts, 
> which may result in kernel resources not being released.
> 
> This issue was detected by rule based static tools 
> developed by Tencent.


Last time you were using AI, so I have doubts this is "static tools".
Please describe it properly, so we can make informed decision whether to
allocate time on this.

> 
> Signed-off-by: Siyang Liu <1972843537@qq.com>
> ---
>  arch/sparc/kernel/chmc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
> index d4c74d6b2e1b..a7040ee7e5bc 100644
> --- a/arch/sparc/kernel/chmc.c
> +++ b/arch/sparc/kernel/chmc.c
> @@ -4,6 +4,7 @@
>   * Copyright (C) 2001, 2007, 2008 David S. Miller (davem@davemloft.net)
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/types.h>
> @@ -397,14 +398,14 @@ static void jbusmc_construct_dimm_groups(struct jbusmc *p,
>  static int jbusmc_probe(struct platform_device *op)
>  {
>  	const struct linux_prom64_registers *mem_regs;
> -	struct device_node *mem_node;
> +	struct device_node *mem_node __free(device_node) =
> +			of_find_node_by_path("/memory");


Nah, just free it immediately after user. Don't over complicate this.


Best regards,
Krzysztof

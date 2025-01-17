Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E21185939;
	Fri, 17 Jan 2025 14:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737125575; cv=none; b=GJZoCehOPYrLvNVSby4s8s+SdEXqQwJZJipukffsprm7wYr+m9++ZaQ+zPwAHs3KEIOnwktJEes4OEl3Zw40Gpy4KZUaRbnTYxuFcgiqZGx7x234fcbzcaYU/wK4kkH/ms2VCI0qmeXSWAwq4dIAxwk4vFEJiMANtEmpf027NNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737125575; c=relaxed/simple;
	bh=qZWtXt+OdxmPceZcotBAjiXxRxk+cEaTdo/kWIaq8Wo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/LImJ0aFHoC8q7J4zuKi/CfYZ1tep8nLTuzUfHMJTua+Szq94OJ/wRhcv7LvJENqViPZ7yfZTQ2M7sobZt+YQkHbXAFO1vBcC88ncQqTOg/u56YQTBlhPE/cqnXpKDykKz+VIxERaQROaYSY64pfepaFd4uWiD7Kdk4neyT208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=EOGKdjSV; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="EOGKdjSV"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YZMt435HPz1DDgW;
	Fri, 17 Jan 2025 15:43:24 +0100 (CET)
Received: from [10.10.15.35] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YZMt408RJz1DHcM;
	Fri, 17 Jan 2025 15:43:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1737125004;
	bh=jFFXSG1NJCcuPU+IKCfo4W5xhKjfnNV3DPQxHc/EJJA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EOGKdjSVNqx+JS90IdNE1cGEUoNmq0EQ8DRILh+1oNN9FdU+SEtqAE+TbOeLz9nbk
	 6QUeMdt7qF2Nkrcbd1WiKvVPgb8l3c75LsnnTy75ZZrLVoYIEqwYJxceNwGk/slHNq
	 oH9HD0q6Kma7NTuKiOoJ9WtJPUJjRKQAXEqdkbf8=
Message-ID: <f321ef65-fbbc-4bad-ad95-f2287bd82a32@gaisler.com>
Date: Fri, 17 Jan 2025 15:43:23 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] sparc: replace zero-length array with
 flexible-array member
To: Zhang Kunbo <zhangkunbo@huawei.com>, davem@davemloft.net,
 rdunlap@infradead.org, bhelgaas@google.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 chris.zjh@huawei.com, liaochang1@huawei.com
References: <20241218074439.3271397-1-zhangkunbo@huawei.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20241218074439.3271397-1-zhangkunbo@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-18 08:44, Zhang Kunbo wrote:
> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1],
> introduced in C99:
> 
> struct foo {
> 	int stuff;
> 	struct boo array[];
> };
> 
> By making use of the mechanism above, we will get a compiler warning
> in case the flexible array does not occur last, which is beneficial
> to cultivate a high-quality code.[2]
> 
> This issue was found with the help of Coccinelle.
> 
> [1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
> [2] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")
> 
> Signed-off-by: Zhang Kunbo <zhangkunbo@huawei.com>
> ---
>  arch/sparc/kernel/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
> index 50a0927a84a6..ddac216a2aff 100644
> --- a/arch/sparc/kernel/pci.c
> +++ b/arch/sparc/kernel/pci.c
> @@ -932,7 +932,7 @@ static void pci_bus_slot_names(struct device_node *node, struct pci_bus *bus)
>  {
>  	const struct pci_slot_names {
>  		u32	slot_mask;
> -		char	names[0];
> +		char	names[];
>  	} *prop;
>  	const char *sp;
>  	int len, i;

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

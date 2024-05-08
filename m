Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2FF128806;
	Wed,  8 May 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715189571; cv=none; b=usIEm1klYeprFes6Aa521qRopCWFRiYOC66A+/I98DI/w33vv238NOGel8my76JayE5M90Y+5pRzNwgZvJJX19W9JH0E1en8cOIXWOZCo/3h7DsjBiWAt14CugsAZB/+BlDmJpm9p3HlAFgIpIdRkqi3qlMEKCdpBAkvBtUM+JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715189571; c=relaxed/simple;
	bh=PxR5CNx0YeCBV12sK3NEaQgIkG5iTrz7NBVUDZ1Z6l8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NpNggZo8thCs3ZYKpOJ2MLBuzsXT/MYCklWVT2ZQ+2CLCIzylmYm/728ZsX9wHentuB8w/X6lsnraiArMyVaDlLEmWzCLZmUHev7y2vKfs74iCfEkzaMoCB4BhZx5Gf//r9VJhLmji+kkJvIRIwog/i9Ao4v9rdh+G6GjXBD8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=EMdtwJpD; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="EMdtwJpD"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VZMfg4H7Xz683x;
	Wed,  8 May 2024 19:32:43 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VZMfg2360z683f;
	Wed,  8 May 2024 19:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1715189563;
	bh=qFLJ8C/vJOy8ztY+ErSoPE9hPN1aNMGglndtw+goyc4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=EMdtwJpDLqaCLEUY9rcA4LKsuJBXljK6a+sSvt71da1bFK7iyJPuiPzQhOHvokuJm
	 YrBWAJColD+H5mvb3FJOFhUipfhklisGeh29JpgZQbqcEDQIGM5C1o/W/j31R1xbfL
	 +kU3aV1ZOmG7VcLoXxTVaQrlc5Or2HExzgHfI3Nk=
Message-ID: <b7ae0457-2663-4f8d-a6f7-b79dd60623d1@gaisler.com>
Date: Wed, 8 May 2024 19:32:42 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] sparc/leon: Remove on-stack cpumask var
To: Dawei Li <dawei.li@shingroup.cn>, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, sam@ravnborg.org
References: <20240424025548.3765250-1-dawei.li@shingroup.cn>
 <20240424025548.3765250-6-dawei.li@shingroup.cn>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20240424025548.3765250-6-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-04-24 04:55, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_subset() and cpumask_first_and() to avoid the need for a
> temporary cpumask on the stack.
> 
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  arch/sparc/kernel/leon_kernel.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> index 4c61da491fee..a43cf794bb1e 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -106,13 +106,12 @@ unsigned long leon_get_irqmask(unsigned int irq)
>  #ifdef CONFIG_SMP
>  static int irq_choose_cpu(const struct cpumask *affinity)
>  {
> -	cpumask_t mask;
> +	unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
>  
> -	cpumask_and(&mask, cpu_online_mask, affinity);
> -	if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
> +	if (cpumask_subset(cpu_online_mask, affinity) || cpu >= nr_cpu_ids)
>  		return boot_cpu_id;
>  	else
> -		return cpumask_first(&mask);
> +		return cpu;
>  }
>  #else
>  #define irq_choose_cpu(affinity) boot_cpu_id

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

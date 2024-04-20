Received: from mailrelay5-1.pub.mailoutpod3-cph3.one.com (mailrelay5-1.pub.mailoutpod3-cph3.one.com [46.30.211.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D5CEAD0
	for <sparclinux@vger.kernel.org>; Sat, 20 Apr 2024 08:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.244
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601441; cv=none; b=ar4Ub4ELYmF4DCVEHrOgwXe7/xpZmOW9SpI2nmRQdFwfvh3BnPBwIEHG8ZjCNe6g1hOw9Q5Hnf8cdVtVIbZrIymzw3DlrR3pHVhIK/9VtsVXZws1qfioyZG2ARMG7thZ2uDLJN9BzWQXwFclcZzHGRp5qX3e6II4zaeuFk2LPto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601441; c=relaxed/simple;
	bh=nS3ey3049+WlxKQkhVMTi0rBQq5ENKMLDgGgeTYIWLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmzXhcTZCzJut4Xg8MOeTIYxpN6g8fKcn8a92NTSjmACXs5ITdch5qd7kpXvbdd9zXOMek1Qfjq90l9f3zc7x+noCCx7ck+Pn6eoV7UQiA8bVgxVOK9Sd2hQB2FaRuQb/bkxfsron9SxiFLPx2s0JSnJX2ocUeQTAWDdD2VyZeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=JGcU8aXN; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=1nC9nM3t; arc=none smtp.client-ip=46.30.211.244
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="JGcU8aXN";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="1nC9nM3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=hyOTvAwW7LUhQz0hK6HLJgpu4ROvl5AjMdCeXnr5Bss=;
	b=JGcU8aXNKDt7uwhpzmCnmuGxLzBqrGFlZwdv8+DMg349ArodYUUeWBv5XN+KQGj/iewYBp8MIbTQx
	 sbstisQhyvYYPx3DKdPCxNYk7sjQIEb9ATQEkn5q3XJggc2c965U6s7gqcyYsrzN+R3AOci65IB00I
	 8dIyzID/5itTkHqTpaj1MaNI9vpYAOSBGpG+ZpJC59fkGpWjlscpvjxazOoRGnbJKDbydYLf9o/KY2
	 +cJ12QNeL21yqgmb8tWQfG7/kOTKvciQkQaTE50l9JdlrxkaQd94y1A7rnNuB9hiu3zkNL7JD//H/m
	 pI0upf7zm1EsIMNAsVy6QpSvwT61Yzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=hyOTvAwW7LUhQz0hK6HLJgpu4ROvl5AjMdCeXnr5Bss=;
	b=1nC9nM3tLBIs69vS1YlPRebIaVTB1fKRose4yyoMyQEYIPZJT9uRk0syRJxf3kZzDih4GOAwp9mgT
	 O5vYaqhBA==
X-HalOne-ID: 26a75d51-feef-11ee-b264-e973630cf47d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay5.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 26a75d51-feef-11ee-b264-e973630cf47d;
	Sat, 20 Apr 2024 08:22:48 +0000 (UTC)
Date: Sat, 20 Apr 2024 10:22:39 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] sparc/irq: Remove on-stack cpumask var
Message-ID: <20240420082239.GB614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-3-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-3-dawei.li@shingroup.cn>

On Sat, Apr 20, 2024 at 01:15:42PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> - Both 2 arguments of cpumask_equal() is constant and free of change, no
>   need to allocate extra cpumask variables.
> 
> - Merge cpumask_and(), cpumask_first() and cpumask_empty() into
>   cpumask_first_and().
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>  arch/sparc/kernel/irq_64.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
> index 5280e325d4d6..01ee800efde3 100644
> --- a/arch/sparc/kernel/irq_64.c
> +++ b/arch/sparc/kernel/irq_64.c
> @@ -349,17 +349,13 @@ static unsigned int sun4u_compute_tid(unsigned long imap, unsigned long cpuid)
>  #ifdef CONFIG_SMP
>  static int irq_choose_cpu(unsigned int irq, const struct cpumask *affinity)
>  {
> -	cpumask_t mask;
>  	int cpuid;
>  
> -	cpumask_copy(&mask, affinity);
> -	if (cpumask_equal(&mask, cpu_online_mask)) {
> +	if (cpumask_equal(affinity, cpu_online_mask)) {
>  		cpuid = map_to_cpu(irq);
>  	} else {
> -		cpumask_t tmp;
> -
> -		cpumask_and(&tmp, cpu_online_mask, &mask);
> -		cpuid = cpumask_empty(&tmp) ? map_to_cpu(irq) : cpumask_first(&tmp);
> +		cpuid = cpumask_first_and(affinity, cpu_online_mask);
> +		cpuid = cpuid < nr_cpu_ids ? cpuid : map_to_cpu(irq);
>  	}
>  
>  	return cpuid;
> -- 
> 2.27.0

Received: from mailrelay4-1.pub.mailoutpod3-cph3.one.com (mailrelay4-1.pub.mailoutpod3-cph3.one.com [46.30.211.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C2638C
	for <sparclinux@vger.kernel.org>; Sat, 20 Apr 2024 08:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.243
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601996; cv=none; b=VSbbBnKhZbkpQtg7qLCVO6huq0QgH0bpl6dabwgB6jvtT2YknLk9F+GVy0bTbbYsmghkgIxTXf/h1Sw5SbZ3LkIsMEAcV0QmL6SwWEv5OeIkKH4UH+QuFNmRhCHxSqfJo/1P4fipI28lEwo1nK1FL3+QbmIjJi6oQ9qERbtai4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601996; c=relaxed/simple;
	bh=4x68Wh4z9wJz89EDOwn5nMgn6u9lCHiLHM+sU2wqKNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WQFIzhWJMgvXl+NyAkv5azuloGsEfo2+aDcmCq76BNjC3HiWA/BJH9fSswAhsD2YHCf6djU6sB6qGrVyS5hG0sk5fnssY626yzX6UL91S0DJjvgdLcxLiZo3RLeUWWtVz8NV7OZuMDtdAq3EHINqx8JcjfDHP/hPptBFmAE35yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=coeI7fYn; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=8IoaAiqw; arc=none smtp.client-ip=46.30.211.243
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="coeI7fYn";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="8IoaAiqw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nWCbwvo1uo83UNZFGd9WmKa4miqwEJNzC1UhPZb6JUo=;
	b=coeI7fYnLnH6DhNSuoGk9V3zCKSEMFHvx0g7KTK7JSsvvAF1M3Pu8VaWpseIskFGCAd73NWOmVgMt
	 lbpQq9XRU0wsmfUbN5RGu9zdADJ82cLSbMIADzFW94YysrGkUjDK9+/fHj+zE+NVLhtZ1p0w+yE0dj
	 DPX2Q8SOK50bdMFSHbyVqRJ7PnMPa1HUYDDeI8CDSzlGJKeLRgc0BAreTp/TCoMXTLE8SbNR7495no
	 UHgUrsBHg94NAa7zP4Rt3X5r1BmIlKrxyljqqQ6XWFF/JGrLbfHeuBfgHp74ln6NeXLjeaiCnLu57t
	 UiCYpFTKjvaHHYqazaqDRZLbZHvT1Tw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=nWCbwvo1uo83UNZFGd9WmKa4miqwEJNzC1UhPZb6JUo=;
	b=8IoaAiqwyBghZ/zBs/cDDTHZvwCqyzoaRearXX+FsuFHNMVBA6zwSme9IXgWDCA2cUvcxDJ3Dj56Q
	 fP3uPs/Dg==
X-HalOne-ID: 7563e990-fef0-11ee-a0f9-591fce59e039
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay4.pub.mailoutpod3-cph3.one.com (Halon) with ESMTPSA
	id 7563e990-fef0-11ee-a0f9-591fce59e039;
	Sat, 20 Apr 2024 08:32:03 +0000 (UTC)
Date: Sat, 20 Apr 2024 10:32:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/7] sparc/leon: Remove on-stack cpumask var
Message-ID: <20240420083202.GF614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-7-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-7-dawei.li@shingroup.cn>

On Sat, Apr 20, 2024 at 01:15:46PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Use cpumask_subset() and cpumask_first_and() to avoid the need for a
> temporary cpumask on the stack.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  arch/sparc/kernel/leon_kernel.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
> index 4c61da491fee..0070655041bb 100644
> --- a/arch/sparc/kernel/leon_kernel.c
> +++ b/arch/sparc/kernel/leon_kernel.c
> @@ -106,13 +106,10 @@ unsigned long leon_get_irqmask(unsigned int irq)
>  #ifdef CONFIG_SMP
>  static int irq_choose_cpu(const struct cpumask *affinity)
>  {
> -	cpumask_t mask;
> +	unsigned int cpu = cpumask_first_and(affinity, cpu_online_mask);
>  
> -	cpumask_and(&mask, cpu_online_mask, affinity);
> -	if (cpumask_equal(&mask, cpu_online_mask) || cpumask_empty(&mask))
> -		return boot_cpu_id;
> -	else
> -		return cpumask_first(&mask);
> +	return cpumask_subset(cpu_online_mask, affinity) || cpu >= nr_cpu_ids ?
> +	       boot_cpu_id : cpu;

This looks wrong - or if it is correct is is hard to parse.
Drop ?: and use an if so the code is more readable.

	Sam

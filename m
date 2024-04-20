Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [46.30.211.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C4520EB
	for <sparclinux@vger.kernel.org>; Sat, 20 Apr 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.30.211.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713601691; cv=none; b=tGjo93kfHk6NFRvNRJ6Z1Mcdk28slWCZoe03y1XMifjfwSQYQboKSIjMSYEG740ehsKTAZtgc9o3tnrQ1T7xl8P8OZpvE5jxVLzP7xlMZ7INLz/KbM8XUfbK/vPpOKJ3VhpwstbtTgpyHGVr41bCawOqmy4Iert2jcjksBnM6b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713601691; c=relaxed/simple;
	bh=k1xWFh4TRAc9MCWBBo1o9nJQfuFd13pcc/G8DbAQlwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YFscydGZVH9iFHVhfE6QmobXNIxiGy0j/2v28kOamOxugVYtNnXgZrLzJHADYoITeGjxcO+ce9sXp7b4z0NyeWSBAOmwDgKJHP+wia5fSVRvvuIiklmyIT6mEjqpaTDYbya1J1gxL4jpbVi8V4xRgCnyToFxoy5dA6pHjWPwbtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org; spf=none smtp.mailfrom=ravnborg.org; dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=KM6mgeJt; dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b=0ydftlsH; arc=none smtp.client-ip=46.30.211.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="KM6mgeJt";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="0ydftlsH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=FXTB4rEe4qhEacn+PwBuQGN1qwr6gJYFT8ntHLzuU0o=;
	b=KM6mgeJtI0eXankwF9sm84g63nZpwU8xNNlDIxz00NVQd635iTGIjEJi7Qzo/Eo5IOjjBGxQSnC1H
	 fCWA9gMD88MG4FdHsx5MN1zwwUSN6x9yYuUqcePiLM8LKYyTj+kE9FQ3FuURtMvnaKGurVKPuhBWwE
	 /wGOwk3rfrImBPFkJgHASYlyOWg1dVekrlgU7kgsvX/+dnkJ/vXhUjKmNk9Be3b1DATosyqkIdleLB
	 HrmnLy1pgsIRlQby+W6jFrynDHs26uDCTBfWusiXkaLccZSN1gmePgrKUBPlqJo6SCqfRmt5ouKUHj
	 oa4ZqhaK6Mab68iJR3v7yAMaMAsYZHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed1;
	h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
	 from:date:from;
	bh=FXTB4rEe4qhEacn+PwBuQGN1qwr6gJYFT8ntHLzuU0o=;
	b=0ydftlsH7NLweRxEgl4Q6I07QvPQWu6UwQQ6/QYtpVqnZgKi7nTc5cYa0g3+MG/DSvQ0+22uERIkh
	 58xBReyDg==
X-HalOne-ID: e828f4f3-feef-11ee-aead-79f4c2873f57
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id e828f4f3-feef-11ee-aead-79f4c2873f57;
	Sat, 20 Apr 2024 08:28:06 +0000 (UTC)
Date: Sat, 20 Apr 2024 10:28:05 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: davem@davemloft.net, andreas@gaisler.com, sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7] sparc: Remove on-stack cpumask var
Message-ID: <20240420082805.GE614130@ravnborg.org>
References: <20240420051547.3681642-1-dawei.li@shingroup.cn>
 <20240420051547.3681642-6-dawei.li@shingroup.cn>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240420051547.3681642-6-dawei.li@shingroup.cn>

On Sat, Apr 20, 2024 at 01:15:45PM +0800, Dawei Li wrote:
> In general it's preferable to avoid placing cpumasks on the stack, as
> for large values of NR_CPUS these can consume significant amounts of
> stack space and make stack overflows more likely.
> 
> Since the cpumask var resides in __init function, which means it's free
> of any concurrenct access, it can be safely marked with static to get
> rid of allocation on stack.
> 
> while at it, mark it with __initdata to keep it from persistently
> consumed memory.

I do not see the need for this - it does not fix a bug and it
complicates things.
If the size is a real concern the normal pattern is to allocate
and not declare it __initdata.

Yes - __initdata is used in some place.
I suggest to leave it as is unless we are fixing a real bug here.

	Sam

> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---
>  arch/sparc/mm/init_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 1ca9054d9b97..088d9c103dcc 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -1438,7 +1438,7 @@ static int __init numa_attach_mlgroup(struct mdesc_handle *md, u64 grp,
>  static int __init numa_parse_mdesc_group(struct mdesc_handle *md, u64 grp,
>  					 int index)
>  {
> -	cpumask_t mask;
> +	static cpumask_t mask __initdata;
>  	int cpu;
>  
>  	numa_parse_mdesc_group_cpus(md, grp, &mask);
> -- 
> 2.27.0

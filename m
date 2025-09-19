Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B4D1A2392;
	Fri, 19 Sep 2025 18:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304930; cv=none; b=jVrOu7YHG3FcA6GhY10FSpaFnkHkJX37XRoMnF6/oXl5eH2N2rEn3v87T7AtW0SUIxwjAN49pzDgrIWZQbZntRFyyptTRWcirf/lKVOmE7TjxnULJafjMrCZ0JSBrNQSlESFB7D+dfmpwivTK4BLXWzmRBokuYDwVEP1S88NJfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304930; c=relaxed/simple;
	bh=Kv8tVZ5QGRSoE/2tTBbcFK/Y/BNWBQpFXhXA6lkMnx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=G8bfXiGrPw+chKv7zmVSRctE0KiqzMYMV05KjctO8FGQhDw8cXgWFfJzkB1pGtV6Ssy3dt1HLte1ZIzbliLrykTV7UEhbntWZNB/nOI/6egoYWSJhi5yagt8Q9v19YvlW5H7GFiFwhBAdczF6Qno8gk7hXBcd9jprh+mBM9fPOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Fd1k4+bH reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Fd1k4+bH"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0hD56wqz1DDgy;
	Fri, 19 Sep 2025 20:02:04 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0hD2RMJz1DHVd;
	Fri, 19 Sep 2025 20:02:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758304924;
	bh=DBzJOhnpJBpulp67VccJ4/RJEuU8T0Ngryy4g7xPDow=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=Fd1k4+bHIOtGVhulqsAZ/d6mXEt9Vn8vvVo9iW/+wTGhP3dlpT9ma4z3/cmKf+Q00
	 5VH4bf1+5NOu1Bq39YHe50ciACJRMIYiDDrGmZXcrrbsE5nxxkL1/n30It8hBVzV4s
	 8+GHOq8SgrZ2Qob9LixhQwpEIBfziBRAkfUoMB6o8WAiNVVCLvKwYrFxLCYd9E7Y2f
	 Mi/B96m6RaWvs6x+itr/6Fm1ptdI5bkFkf4ogJrQ5Gamb3PiLfvUTmw7145kZYgSdq
	 CGesKj0KiAmMQaya7+B+mCCmezCNwgoxWYlxnoYr633BSxNWJVTYvA+p/uWHHwVrly
	 DCFt+/e+zZjZQ==
Message-ID: <139d8db9-1c70-4e33-9e52-a1437b7a8c87@gaisler.com>
Date: Fri, 19 Sep 2025 20:02:03 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc64: Remove redundant __GFP_NOWARN
To: Qianfeng Rong <rongqianfeng@vivo.com>,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250809143303.179922-1-rongqianfeng@vivo.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250809143303.179922-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-09 16:33, Qianfeng Rong wrote:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
> ---
>  arch/sparc/kernel/adi_64.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sparc/kernel/adi_64.c b/arch/sparc/kernel/adi_64.c
> index e0e4fc527b24..18036a43cf56 100644
> --- a/arch/sparc/kernel/adi_64.c
> +++ b/arch/sparc/kernel/adi_64.c
> @@ -202,7 +202,7 @@ static tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
>  
>  	} else {
>  		size = sizeof(tag_storage_desc_t)*max_desc;
> -		mm->context.tag_store = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
> +		mm->context.tag_store = kzalloc(size, GFP_NOWAIT);
>  		if (mm->context.tag_store == NULL) {
>  			tag_desc = NULL;
>  			goto out;
> @@ -281,7 +281,7 @@ static tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
>  		size = (size + (PAGE_SIZE-adi_blksize()))/PAGE_SIZE;
>  		size = size * PAGE_SIZE;
>  	}
> -	tags = kzalloc(size, GFP_NOWAIT|__GFP_NOWARN);
> +	tags = kzalloc(size, GFP_NOWAIT);
>  	if (tags == NULL) {
>  		tag_desc->tag_users = 0;
>  		tag_desc = NULL;

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


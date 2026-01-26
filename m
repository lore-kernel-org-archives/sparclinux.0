Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DD4331A5E;
	Mon, 26 Jan 2026 15:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442182; cv=none; b=mvv7eJ97XmzoXsGvOhC9dgOvNgWFUWCY1ZTGcyQIHcXuxf9ATnJ9lBLefGHZlEAsgJ+luhDMMNlwHZT33YW2AxdJkdQ3cTWZRFVs+cF9HiYFljtdnghrwe4q+4ou1JCuua9frS3cPBEQUuNy5nXqdEtWW5cZwI2ayheHlFmqlUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442182; c=relaxed/simple;
	bh=COWh8frusI/Lq/vw4Fa++jxFRASa6nB88j17HA8FRkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ijPqee1dgzc2MyUBvSfzz3hk5gkJLvDegNx6L7tqypMSxlleVBp3iltaS6fsMZ5TwK0CDtcmY+KG72KV/Rtg65NB9S+lFeKiuutqZQVwrA99Wx4lLDngA7Ap+zQuEopELYTsjnaAWXMIbodafmKpYgrgT12wQ1WqqgfAO6Dkims=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=hyCdY0dF reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="hyCdY0dF"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4f0CVB29fqz1DPjv;
	Mon, 26 Jan 2026 16:42:58 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4f0CV96zMTz1DDdl;
	Mon, 26 Jan 2026 16:42:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1769442178;
	bh=SiiwUhT+Lzir5dLiNMY6ZkxpBKcH5y+5eABSM+VyhbI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hyCdY0dFrBzkcI9DFtdinJxtjaiejquKAELk5KWfkbyXTo9OmbK36dnmm6RffImJV
	 BkS1tGAWkrZ8MO6uw5W6t1+QDYPhlWVQiBLMKNOpq3/g7OCO31gZJlinGYL3N3VMQy
	 j5rXMwkGNqlR0XKH4Uf8mMaShJlfX/QnXqnygYKtO94Jbuk+d8rJ9SIev6tOxSQa0+
	 ZkEXQNrk2SPoJNLkGaLPJF2OoG77IpMOFa2bB1/29PgYIEqlMzP7eRYBZSwA6771WN
	 ykHfybppL6daxdqMCzkp9/9SPRuxxKtif4t5ZF6o23RGHuqOqquG0Kukkm5fWPr3BY
	 KusHX5bWdvsaA==
Message-ID: <f8c1d2e1-b792-4c65-8e17-f31febe5e08d@gaisler.com>
Date: Mon, 26 Jan 2026 16:42:57 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Implement ARCH_HAS_CC_CAN_LINK
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251222-cc-can-link-sparc-v1-1-1823e4f49480@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20251222-cc-can-link-sparc-v1-1-1823e4f49480@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-12-22 09:29, Thomas Weißschuh wrote:
> The generic CC_CAN_LINK detection does not work for all architectures.
> 
> Make the logic easier to understand and allow the simplification of the
> generic CC_CAN_LINK by using a tailored implementation.
> 
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>  arch/sparc/Kconfig | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
> index a630d373e645..68b553a47d03 100644
> --- a/arch/sparc/Kconfig
> +++ b/arch/sparc/Kconfig
> @@ -13,6 +13,7 @@ config 64BIT
>  config SPARC
>  	bool
>  	default y
> +	select ARCH_HAS_CC_CAN_LINK
>  	select ARCH_HAS_CPU_CACHE_ALIASING
>  	select ARCH_HAS_DMA_OPS
>  	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
> @@ -475,4 +476,14 @@ config COMPAT
>  	select ARCH_WANT_OLD_COMPAT_IPC
>  	select COMPAT_OLD_SIGACTION
>  
> +config ARCH_CC_CAN_LINK
> +	bool
> +	default $(cc_can_link_user,-m64) if 64BIT
> +	default $(cc_can_link_user,-m32)
> +
> +config ARCH_USERFLAGS
> +	string
> +	default "-m64" if 64BIT
> +	default "-m32"
> +
>  source "drivers/sbus/char/Kconfig"
> 
> ---
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> change-id: 20251222-cc-can-link-sparc-153eb7ecb0b5
> 
> Best regards,

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


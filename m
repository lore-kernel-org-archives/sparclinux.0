Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE365B03A
	for <sparclinux@vger.kernel.org>; Fri,  8 Mar 2024 20:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709928759; cv=none; b=EdciaoZDJHxK8ZLOWz6BY/lJ0KsQLesxU+sDlmpPkUSsdzkV4rQKBdy7qQn+Zg+xrpenXh9gd15T1U8vFObASeA+nxMUS06QNPAJO2rgKQGhGaTkdoFgK1ecoy/DElguwMc/M35HvGEEJwu12hsM+W+/SNJRkg3H2XS5oRxUiGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709928759; c=relaxed/simple;
	bh=NC0XolJdpbF5oGmt0dcVHr83ViffY7S5frRRBBWqsvQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BbMmAMkNxoNUXUULhBUQ7KWlX19G7uxKhxbLK6PkwkVEH566R5dhmCam85BEn6jpbwGN6SDrOfdnMMIMbM5toxUprK4ddty/i56kZ4Mw2bBrjleOiQbM9ZjnsFZwKG/j3WKsq73+tubzvhUw23deDY4M623XpsC+YU7i/exxXQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZN0fLO+m; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZN0fLO+m"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4Try5H4p4tz6848;
	Fri,  8 Mar 2024 21:12:35 +0100 (CET)
Received: from [10.10.15.2] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4Try584tpRz683p;
	Fri,  8 Mar 2024 21:12:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1709928755;
	bh=OTn4yVKFGIE0PpHEvUMiJymo6XoCcLHPj65d/rk7rSE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZN0fLO+mx2FVwl0UmY2adVsJAwdV5MjTrydzh9XDEecH7ETxfbt89MdT+NaoppHKC
	 xmOauZXVFsFJuel4bBh0X90Dj16B1T7KhrRVDvkYEZ4V0hi33oiIMND2BGvGimxe8a
	 3OcZyiB2DSou2bdETletTc4qjznqbClAFpj+g6js=
Message-ID: <5d6d6ab9-58a8-4bf7-abed-b620b28468c7@gaisler.com>
Date: Fri, 8 Mar 2024 21:12:27 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] sbus: Convert to platform remove callback returning
 void
Content-Language: en-US
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>
Cc: Rob Herring <robh@kernel.org>, Sam Ravnborg <sam@ravnborg.org>,
 sparclinux@vger.kernel.org, kernel@pengutronix.de
References: <cover.1709591118.git.u.kleine-koenig@pengutronix.de>
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <cover.1709591118.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-03-04 23:30, Uwe Kleine-König wrote:
> Hello,
> 
> this series converts all platform drivers below drivers/sbus/platform to
> struct platform_driver::remove_new(). See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> The first commit is a build fix. The remaining patches implement that
> actual conversion. All conversations are trivial, because their
> .remove() callbacks returned zero unconditionally.
> 
> Apart from patch #2 building on top of #1, there are no
> interdependencies between these patches, so they could be picked up
> individually. But I'd hope that they get picked up all together by
> Andreas (or Dave?).
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (6):
>   sbus: Add prototype for bbc_envctrl_init and bbc_envctrl_cleanup to
>     header
>   sbus: bbc_i2c: Convert to platform remove callback returning void
>   sbus: display7seg: Convert to platform remove callback returning void
>   sbus: envctrl: Convert to platform remove callback returning void
>   sbus: flash: Convert to platform remove callback returning void
>   sbus: uctrl: Convert to platform remove callback returning void
> 
>  drivers/sbus/char/bbc_i2c.c     | 9 ++-------
>  drivers/sbus/char/bbc_i2c.h     | 3 +++
>  drivers/sbus/char/display7seg.c | 6 ++----
>  drivers/sbus/char/envctrl.c     | 6 ++----
>  drivers/sbus/char/flash.c       | 6 ++----
>  drivers/sbus/char/uctrl.c       | 5 ++---
>  6 files changed, 13 insertions(+), 22 deletions(-)
> 
> base-commit: 67908bf6954b7635d33760ff6dfc189fc26ccc89

For the whole series,

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas

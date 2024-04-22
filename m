Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EF615217D
	for <sparclinux@vger.kernel.org>; Mon, 22 Apr 2024 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713797430; cv=none; b=eIXvjgBn4nGYAvjuDH6BZdQ1BW99ZrXRpmjaJTE97XoviY/HuDoFNwu6upgdFM5ks/YGQhMFA22pOn+z703pvRm/S+poT++DZ/eJ+/LV45uWIaFMaLrJaNnTmZxKlVcz4Z/sWb0sw0mfARKAk450NGn85AxaZhyn2HDztuCSFfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713797430; c=relaxed/simple;
	bh=DVPk3sOit0rofaUhN3jade1AwRh8rsZzkCNVDSGUhpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oOBeGvqzK8vaXqylAiyRlHT5Bj6TuNtWrDo05Q6+DxtJrvb5VS8zyeSmnLMtvsYQzf5mn+n/5AFgnv6xXRhrSdzy0fnawMXO3LuIVHKDVs9PyDuIg06hwHRrdAEtBmFZ1a1wwwXp5i67wG93Y+gdQsgxYQtHWxyL+Ld354E85wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=YrbO/b1P; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="YrbO/b1P"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4VNSpq3dD0z680g;
	Mon, 22 Apr 2024 16:50:27 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4VNSpq0b2wz67y6;
	Mon, 22 Apr 2024 16:50:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1713797427;
	bh=ZIx5cExMutM/dGxREYaXdVeFKQSvj3vJxzOdrYJvHfY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YrbO/b1PyTTvWfV6equPivfRUfM/b0lde9eQj32MK5ZL3Hw314xhH3htwypfZR5/e
	 WCVTgiufPqaBlYbsm+sgC/N6wKcFk8WVXvKGBj3Fcw8gB6UGjuVWQGOAgdtD0XLsaq
	 wIKgYkhYLfklPgL+qbrNyXIvdHFc4F5COeGAHM4g=
Message-ID: <1a8f87ef-bc48-4c53-b1b0-d5e68d032261@gaisler.com>
Date: Mon, 22 Apr 2024 16:50:26 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] sparc: Convert to platform remove callback returning
 void
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>,
 Rob Herring <robh@kernel.org>,
 =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org, kernel@pengutronix.de
References: <cover.1712755381.git.u.kleine-koenig@pengutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <cover.1712755381.git.u.kleine-koenig@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-04-10 15:35, Uwe Kleine-König wrote:
> Hello,
> 
> this series converts the two platform drivers that have a remove callback below
> arch/sparc to implement remove_new instead. See commit 5c5a7680e67b
> ("platform: Provide a remove callback that returns no value") for an
> extended explanation and the eventual goal.
> 
> All conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally already.
> 
> There are no interdependencies between the two patches, so they could be picked
> up individually if need be. This is merge window material.
> 
> Best regards
> Uwe
> 
> Uwe Kleine-König (2):
>   sparc: parport: Convert to platform remove callback returning void
>   sparc: chmc: Convert to platform remove callback returning void
> 
>  arch/sparc/include/asm/parport_64.h | 6 ++----
>  arch/sparc/kernel/chmc.c            | 5 ++---
>  2 files changed, 4 insertions(+), 7 deletions(-)
> 
> base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking the series up to my for-next

Thanks,
Andreas

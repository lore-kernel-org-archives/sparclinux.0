Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2B2303C9D;
	Thu,  4 Sep 2025 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994711; cv=none; b=Fk1sOOZJgKHFQrHMwAtyQjcWEq08B9jbu5kvUM1aTcxed2XGw964ArWhRVQR8DW/0CYENtU/FadwuZA+epLfXJx5PI9AyUfxGHD9uva8MbSpYWd1uLBCxoksUa/L5TgdNdbt4Q1T+uGUVDWCX8x4rvtKNVEoA2Fg7A7ZuGDdtzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994711; c=relaxed/simple;
	bh=9UGYpN5Lego2P4czss4c+ufIK4ScIbTQMOH52X2qv+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYzy5+WvbOORVgvTa7znn5gYNmVXhNxJ445CnI+sysin4g4HcVAatZlXwNz/IIbnEP87agk3UsLbnDPbWR74V7rlazaWhJ7sezAVISe3Osm1CIXrSJ8CeBWQoMjw5yGji4OUuSan/8KYnhmuyl03rn38EqK+oVh7kzS9hu3XraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=LAlcubKS reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="LAlcubKS"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cHh7j05L9z1FXhv;
	Thu,  4 Sep 2025 16:05:05 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cHh7h5kSYz1FXSw;
	Thu,  4 Sep 2025 16:05:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756994704;
	bh=J4tJiqKaK/wPgbe9np5CLuawS4hkf0a+JOKMhBWenco=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LAlcubKSl7KTkISuJ1TFhgZvOgUKn5EaOG46fo1kJg0v6Uk+igNjGK8oEcK7lUU7p
	 OQZTEM/NXLhZxOj4Iu9nF7t6dGoduFIX/qTAehBpa4Nm1xNsEk/aB8poAzpiJGSrta
	 tDGpNMneBggVvxdANWsW9lkZJb4MKoNWSGkdyuk2V3dKLiUali6kSLv/nPabubGiH2
	 ESHbWMQR5WIgg8Kh8sfKxPqEpFvraGYa1GIDUgI1d3ywS8ykoi20tS2VY3HQnvTYch
	 zYAjMn0wjG8RFSWvop3gVCObWS++V/DBBTmnUuueBTmkAoIwMde0HOvT6q623mrzKf
	 AnH3SiBlLsx1Q==
Message-ID: <8403ac15-bb3a-4e88-97ef-6eaff26cc8db@gaisler.com>
Date: Thu, 4 Sep 2025 16:05:04 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] sparc: fix accurate exception reporting in
 copy_{from_to}_user for UltraSPARC III
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250826160312.2070-3-kernel@mkarcher.dialup.fu-berlin.de>
 <528a5d4b-1e07-4379-afd6-7e58d423e713@oracle.com>
 <C90C7694-C913-499B-8426-8DEC42137066@mkarcher.dialup.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <C90C7694-C913-499B-8426-8DEC42137066@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-30 10:35, Michael Karcher wrote:
> 
>> I think there should be a little more text about the nature of the failure. Maybe:
> 
> I will add something like that in v2 of the series.
> Do you think it is useful to add the message ID
> b14f55642207e63e907965e209f6323a0df6dcee.camel@physik.fu-berlin.de
> as well, or an abbreviated backtrace from that message?
> I suppose, that is the BUG_ON you are referring to.

If that is the message referred to, I think it is a good idea to refer
to it, in addition to a description. If so, please do it on the form of
a lore link, like this:

https://lore.kernel.org/r/<message-id>

Cheers,
Andreas


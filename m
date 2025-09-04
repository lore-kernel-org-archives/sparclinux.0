Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC41156CA;
	Thu,  4 Sep 2025 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756995575; cv=none; b=J3nhKwIt6K6dFVC1RnNoqJIKqbCsERM21aNX3q/LvGl+5Jrn3uVTD0p9V1CDmbcSu18K5VqO85p6ksqB8hIGEXYTgdIiqCIcHg6HUg92Dfq73sZb79R5sxco4+ednIVJlf04VW6h5H9r7NFjJ1SqBPEXzssx5B56cScSYwFd+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756995575; c=relaxed/simple;
	bh=xQjO6a5Pg4Q0fgwKrmWyvONnrVhzwwV8TXmBqQYx1BU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rgy0v7mYpuBeNIMuHVcrxWV7AwLbRCZgz7n313dQIygbUzKyEBKhbcEg3YXHE3SN6bpDCms9VDMc0nELGAskS92NfFT2xzMrgUW/AEiqwwWwwai6fJVO0mSYhAGiNKhd5/NDJovfD9TgGNdfRq4wqxs+VfNYYJ7Ct8kHCI/x3bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=n/VEMu1/ reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="n/VEMu1/"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cHhSL086Nz1FXjR;
	Thu,  4 Sep 2025 16:19:30 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cHhSK5Pvdz1FXhh;
	Thu,  4 Sep 2025 16:19:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756995569;
	bh=mslweSrfmXabx1YgQt4A/4EOSYL8p4FN2EjKHy/L5Z8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n/VEMu1/EOuMDOZ3PHSUwVwOw5EutkQW1zgA4mdi4PrapHPP1mdde2sKZf8AvnZjH
	 Rt5osP1xto9wNA1m2LW3FPIityzFhznRPrWxgHiEUpBtJn1oyK5Ss54M+G3BtljnR4
	 oK7Jcw26glhlCMOVnWdodbIYFHVe2nav94wW4dBGL0LOu1qEDicbS97tGarjmJIia2
	 1e99mes0/V3ABE/mogJTSnNc/2kX8nFEW6ZoUi6+PcWgGizpIyX4NyrCxwj2snpAba
	 uXdnTKnwc4yPylKma4pfRKIJoCEIlQkBawJcc5Oyjp973i0HP5xG//f6wCZZYOp9Jr
	 qvpNCX+ZCCU3A==
Message-ID: <e06f1fba-cf85-4f12-ac1d-1c1b161da9b6@gaisler.com>
Date: Thu, 4 Sep 2025 16:19:29 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sparc: fix accurate exception reporting in
 copy_{from_to}_user for M7
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
References: <20250828121844.2250-1-kernel@mkarcher.dialup.fu-berlin.de>
 <20250828121844.2250-2-kernel@mkarcher.dialup.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250828121844.2250-2-kernel@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-28 14:18, Michael Karcher wrote:
> ---
>  arch/sparc/lib/M7memcpy.S     | 20 ++++++++++----------
>  arch/sparc/lib/Memcpy_utils.S |  9 +++++++++
>  2 files changed, 19 insertions(+), 10 deletions(-)

I think putting this patch together with the first four in the v2 of the
"Fix accurate exception reporting in SPARC assembly" series would be
good so that they all are under the same cover letter that has the
larger context. A lore link in the v2 letter to both these v1 threads
would allow tracking back the discussion history for both threads.

Cheers,
Andreas


Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE3623B616;
	Thu,  4 Sep 2025 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756993780; cv=none; b=Y5hBSGbXg5dnSkMR191ohPPXm9DTjOBAbSVkyX0d0xci/bhD2zxjbdGaav0rFqYKOS/m1/z3bcOugwL1T41KV1CbLxfzkezLmPPLdJkxHf+ZXnyJQwgSzTSMz1b1aXa9jOx4XXPXNY6C6kDo7oACJz47LUSAilc+4SFkaiIJQ4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756993780; c=relaxed/simple;
	bh=1+RmBjkLJxr3tjr4SwWahsm6T9z+16UTmNktO1t0Y1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fw9/n01sVtF6WmJQi/+NtpOM5GDz2B+kzNmtTlab9g3mdIMvzTO8lQ6RAJ/9xXNs/kY3vkMpEBLmzI2ZLkQgqsFbcnBwmNefV0IYm+3sP4ELGujTlvSEAfmztAPIVzQHcagyUkhsg3FdV3vpJoPqjRnnYADMzZMJNbwjDtK3EL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=m503c1kt reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="m503c1kt"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cHgnh1KMzz1FXZv;
	Thu,  4 Sep 2025 15:49:28 +0200 (CEST)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cHgng7305z1FXhW;
	Thu,  4 Sep 2025 15:49:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756993768;
	bh=kKissGMh75GslfHEsQZRmULySpZwoZ7dxQ49rEQapCA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=m503c1ktfDPE8biqkrY1Qdu1aHpNNHvECXN3OsfhpzzjDz3XXQXltrRKBM/nhJ8kZ
	 ilNYta4tr0LD9PAZ5QVtgtanfLrjivNUqtmLjA3viXUoF/vWwUX8ZeQBc8jVPrkY3l
	 u4iZl3IRoIU3qu9rYwKOeZnEhwqEhyNX07hCXv9kWzxl40vBcWN5pCXd23hjgVcd5q
	 ZdAoOzd/7ri/yggI0zRLh7YlZrBzf5NeonuU81dZLsqnSyZeXsfn/VTUZgwgs9WqNJ
	 8tnh/wtjIyX8HnPnHHjeCENlcGsmUbtci/U0iRzqUKl/ihVCM3R0sqGbKnfd2RFJfS
	 B3ChWlQ/jzHug==
Message-ID: <0253d6fe-dafe-492f-b7ad-12f98ba3c507@gaisler.com>
Date: Thu, 4 Sep 2025 15:49:27 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fix accurate exception reporting in SPARC assembly
To: Michael Karcher <kernel@mkarcher.dialup.fu-berlin.de>,
 linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Anthony Yznaga <anthony.yznaga@oracle.com>
References: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250826160312.2070-1-kernel@mkarcher.dialup.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-26 18:03, Michael Karcher wrote:
> In 2018, David Miller implemented accurate exception reporting in
> copy_from_user and copy_to_user by handling exceptions on each load
> or store instruction that accesses userspace memory and calculating
> the remaining bytes from the processor context. As issues with
> transparent huge page support and folio support in ext4 were due
> to a bogus return value from copy_from_user, I wrote a comprehensive
> testsuite for the generic variant, and the machine-specific variants
> for UltraSPARC I/II, UltraSPARC III, Niagara, Niagara 2/3 and
> Niagara 4, see
> 
> https://github.com/karcherm/sparc-cfu-bug-reproducer
> 
> despite the name of the project, it does not only test copy_from_user,
> but also copy_to_user, and it also contains fixes to a very small amount
> of exception handler references that were calculating the result in
> a wrong way.
> 
> For UltraSPARC III, I chose to adjust the memcpy code itself instead of
> adding complexity to multiple exception handlers. That fix has already
> been tested to fix stability issues observed by Adrian Glaubitz which
> kicked of the investigation. On all other architectures, the changes
> are just to the exception handlers.

Hi Michael,

Thank you very much for this series as well as the followup patch for M7!

This cover letter for this series gives good contextual information for
the series, but when looking at the commit message for a single patch in
isolation it is not clear at a glance what is being fixed. Do you think
you could put in a short description in each patch in this series, and
also in the followup M7 patch, on what it is doing and what it is
solving?

Cheers,
Andreas


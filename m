Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4E2557A;
	Fri, 26 Sep 2025 14:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758895356; cv=none; b=K1iYdOEV3YZQA2VGdDZcAI5okVnfQoRwXxdKO46K7RX7Zn4xdSvL+bGcF9A1rddxM4sgIufRfIpTyuWr9Sz69WJP1CtIJ2UyiBgTIQzbH9T4N3ufKJZ53POBCDjfME0eX1YinTu2rdP0OteUu68m7UFTkCj6+hRAxSX06zaX1Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758895356; c=relaxed/simple;
	bh=4O+XjLusmWEvFD/qG2aTu8mg8JV7NRlYc2aNyINf6To=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rBnDQEV+JzHFnDityTCH+nmu2JOLPz8xJTb1Z4b/NsyjpkxWj9R/IsHWxaWlzpbUEA0Gz77OkNbQ6XY7u5PtUSVj/OdcKpIyCY4uMNc0ILv2QrweJTf6Tqd+1c8UtknJr9yujaGQU00TozPwz5gqDJ5+KfCNC3iKkgFss3rJBkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=A+4kWaAc reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="A+4kWaAc"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cYC2b37wsz1Fb3l;
	Fri, 26 Sep 2025 16:02:31 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cYC2b0hklz1FbZW;
	Fri, 26 Sep 2025 16:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758895351;
	bh=wBgYM7ISW0uwVz/nteJtR0UPPvAgjjEqMvz+k6kur58=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=A+4kWaAco98Q0vf/BYFfmxNEoji2OTm8IafHAphSQZjMSkQ5CCb9cNzsWw2oHHf2i
	 5mKrEaQpri7zW2FaxiBMQO8dyIMXVgA7MqUZr+aS05alObTauUykfLt4MqxaWVF8kg
	 rvpWAh3ESZ7QHfSbH3jVNv9HE4xUDp7J9O1j4iOXXesVupR7bfZB+yJyqbG6rwinLe
	 Snx82IaU/R+JOlskJ/SrAycopB7ToI6IxZLBDZQpVGiRKgcGLkUXiRJIDv6n+9Sa7B
	 LRxks/Xw9uSYNSpuU0ESBH1P3oC74h0Zc0INyfAjySLxVk4Njcmj2k1xnO0VFPKrz7
	 LWau4YD/S4K4Q==
Message-ID: <969ed791-8cec-410d-91e1-a2e509f1ec8c@gaisler.com>
Date: Fri, 26 Sep 2025 16:02:30 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sparc: Drop the "-ansi" from the asflags
To: Thomas Huth <thuth@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, David Laight <david.laight.linux@gmail.com>
References: <20250805092540.48334-1-thuth@redhat.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250805092540.48334-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-05 11:25, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> In the very early kernel 1.x days, assembler files were pre-processed
> with the "-traditional" flag. With kernel 1.1.85, the sparc subsystem
> was changed to use "-ansi" instead while the other parts of the kernel
> continued to use "-traditional". That "-traditional" got removed from
> the other architectures in the course of time, but the sparc part
> kept the "-ansi" until today.
> 
> This is bad since it comes with some disadvantages nowadays: You have
> to make sure to not include any header that contains a "//" C++ comment
> by accident (there are now some in the tree that use these for SPDX
> identifiers for example), and with "-ansi" we also do not get the
> pre-defined __ASSEMBLER__ macro which we'd like to use instead of the
> kernel-only __ASSEMBLY__ macro in the future.
> 
> Since there does not seem to be any compelling reason anymore to use
> "-ansi" nowadays, let's simply drop the "-ansi" flag from the sparc
> subsystem now to get rid of those disadvantages.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: I've only compile-tested this patch. No runtime testing done.
> 
>  arch/sparc/kernel/Makefile | 2 --
>  arch/sparc/lib/Makefile    | 2 +-
>  arch/sparc/mm/Makefile     | 2 --
>  arch/sparc/prom/Makefile   | 1 -
>  4 files changed, 1 insertion(+), 6 deletions(-)

Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Tested-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


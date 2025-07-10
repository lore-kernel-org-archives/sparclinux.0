Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453627145E;
	Thu, 10 Jul 2025 16:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752164551; cv=none; b=h/97OPJMBmufFz8elXRYCvArfLqxnhL51CZOyajNcvhOZVmSqZTpntqr09XqTNYzeNEe0+qM0fJvc1RMyJO+gk1O1VUd1vsJYW2HR6VS/dxlQWNefitzuONP19kYr1coU42TXdM3vYpPz2UTiJMoRc8cfXAfOtrUnQ27LQuItoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752164551; c=relaxed/simple;
	bh=aUaUdXmgfEz/J4CHZ1aeskJ1/eiodRiKVxi2W45AKOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FL8Ojrbuu905cfWBeB60cPGzNYWBh/kqDZOmA62Zqm5NTfEAQsukMgaiqGRcXZkmWZYfd5yR1MHM+f+d0CcaQwCdBgLDQrvbxWt96r62iwMz3Qxw4nnX9JAS9j5A6iJl5GcHSPqDuvwqW5FD2PjZkn0l43WOwEHEZkxDcQPVwY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=HjHwwO3G reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="HjHwwO3G"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4bdKqt3y99z1DHpX;
	Thu, 10 Jul 2025 18:22:18 +0200 (CEST)
Received: from [10.10.15.6] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4bdKqs5zqDz1DDgR;
	Thu, 10 Jul 2025 18:22:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1752164538;
	bh=7fypJcrfp+M+uM5XoEPrfg5Td9bMlUQMryEziGIxvBU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HjHwwO3GC5QxTbnPKiVKQxrNHexHJJw1Bo+FdrPM7kXtD55zZj/QLnTDLkGctCIZO
	 IHzAwKaDlAZx99JittOZ2HDnVivhCwUiCKCDzs8twF1Csa+JmkshgVUjfTOPIBxTQL
	 6Vx7yR/+MYhzKPgDjm9/0OLVaL4EFfy4g/OlGJm5WPgIGBLVhCabANBHI8W/woIKsP
	 HZt5x9fsWGQRYvhfUXADAqrYPOJwGzU3MpKT9Q80SIn2VXuSOibLRzXT66v5q+3RzM
	 rcCEjFGAANBc1GMsPvPqnihwy62JpBCaawX8yVooz2fhz6qBmSNbEhemWC8/9B2ZWA
	 w6vkX41WLbnBA==
Message-ID: <7e29bcc1-3dc7-40f8-84f0-fbe497fb01bf@gaisler.com>
Date: Thu, 10 Jul 2025 18:22:16 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>
Cc: Andy Lutomirski <luto@kernel.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 Anna-Maria Gleixner <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Eric Biggers <ebiggers@google.com>,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250707144726.4008707-1-arnd@kernel.org>
 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
 <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
 <6b77e7da8c0bd6f211685bda9f624f8db971bbe1.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <6b77e7da8c0bd6f211685bda9f624f8db971bbe1.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-07-07 18:05, John Paul Adrian Glaubitz wrote:
> Hi,
> 
> On Mon, 2025-07-07 at 17:45 +0200, Arnd Bergmann wrote:
>> On Mon, Jul 7, 2025, at 17:22, John Paul Adrian Glaubitz wrote:
>>> Hello Arnd,
>>>
>>> On Mon, 2025-07-07 at 16:46 +0200, Arnd Bergmann wrote:
>>>> Rip out the whole thing and replace it with a minimal stub as we do
>>>> on parisc and uml. This introduces a small performance regression when
>>>> using a libc that is aware of the vdso (glibc-2.29 or higher).
>>>
>>> Can this performance hit quantified in any way?
>>
>> It's trivial to test calling glibc clock_gettime() in a loop
>> on a specific piece of hardware, the difference should largely
>> depend on how long the timer hardware access takes compared
>> to the syscall overhead.
>>
>> On machines that have neither TICK nor STICK clocksource, the
>> simpler version should even be minimally faster, on those that
>> have one of the two, there is an added cost for entering the
>> syscall on every clock_gettime() as we do on architectures without
>> vdso.
> 
> OK, thanks. Since Andreas has access to a SPARC T4 as of recently, he should
> be able to test this. Please allow some time for him to review and test the
> changes, so we can be sure this doesn't cause any serious regressions.

I tested this patch (running Linux in an LDOM under Solaris) and
measuring the cost of clock_gettime(), running millions of calls. The
calls takes around 13-15 times as long (from around 82-94 nanoseconds
per call to around 1220 nanoseconds per call) with this patch compared
to without, so not an insignificant performance regression in this
environment.

Cheers,
Andreas

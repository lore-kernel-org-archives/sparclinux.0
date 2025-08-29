Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E62356B9;
	Fri, 29 Aug 2025 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461769; cv=none; b=H5Z94opduCSLpMdxdaEv3VxJeYaIKmqfnnWLN4MxaiQTyDBQVVWhKxHjWVK+9+b4+WtVmwURUjdYMU/3G7nzc4qK/XRoTNtp8oFXAARJ6PFuwN7/3jbzNhQsZXG20xy3ikkA6aBv/Y7O5MJ3of6uE6S3g1m7t+EmZ33S1RLCyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461769; c=relaxed/simple;
	bh=WZLA+EyUvojIZeZiJhcTQ9QFotnHjZBHLHdqR8dLfsg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=E/8/Ovhi5MSuurxobtEx5Wc1NaRYgyHPT0s0G+2TCTxOOLTkgot9+iPw3LpMhNtGMQWhB5+sSJOy7ib+IaQdfAfelEVGeToIQRG7k2wpbsINVaZJspl2qg6Y0uraF0Su68NS5IDw24PPJiwgEuvvr/OiltIrMRWZ4dc94m85J+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Fo1EmuCf reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Fo1EmuCf"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cCv2m1Mjzz1Fb3j;
	Fri, 29 Aug 2025 12:02:40 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cCv2l4MQ8z1Fb3p;
	Fri, 29 Aug 2025 12:02:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756461760;
	bh=kqPjzVYCOx/1Pm0lD8BQmtq+qr4gvj0qmeZkb4mE3Es=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Fo1EmuCfOGEfFFlPuuFyESdCvYMKz3ZXUS3DKwccCEfwLiAWDh++ip21Uy7CFDt1K
	 5+jx/8wT3qZbAgb2ByOj8N/U0rJVZ/ca2vHXi9+vvBeH0cRzTc9Xsd+88/4GMxILAj
	 eB8ZLUmXtOIllE7dJ8f8/BNNbTaYbNLcS0m5W6zHDfIlJoiftvVMfHnPM7ic6g2Ccf
	 1vzsEjUK+fUc7yPMjsAdEd6C5HvxNTSuAGkdR9upOpG/NKmNJbMFSCgjF8F+ClpZ2f
	 LV9f+4k1rYuhiy8gcVvpJQT4xlj0O+hxNAEU5vuAvXtI7zLFtTIid1a03Bj5SaU+CT
	 vT5GZw7D6mlIg==
Message-ID: <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
Date: Fri, 29 Aug 2025 12:02:39 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
From: Andreas Larsson <andreas@gaisler.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, Arnd Bergmann
 <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>,
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>,
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
Content-Language: en-US
In-Reply-To: <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-28 17:38, Andreas Larsson wrote:
> and with all of them applied I got: 
> 
> ----------------%<----------------
> [    1.849344] Run /init as init process
> [    1.851309] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [    1.851339] CPU: 4 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1+ #3 VOLUNTARY
> [    1.851363] Call Trace:
> [    1.851374] [<0000000000436524>] dump_stack+0x8/0x18
> [    1.851400] [<00000000004291f4>] vpanic+0xdc/0x320
> [    1.851420] [<000000000042945c>] panic+0x24/0x30
> [    1.851437] [<00000000004844a4>] do_exit+0xac4/0xae0
> [    1.851458] [<0000000000484684>] do_group_exit+0x24/0xa0
> [    1.851476] [<0000000000494c60>] get_signal+0x900/0x940
> [    1.851495] [<000000000043ecb8>] do_notify_resume+0xf8/0x600
> [    1.851514] [<0000000000404b48>] __handle_signal+0xc/0x30
> [    1.852291] Press Stop-A (L1-A) from sun keyboard or send break
> [    1.852291] twice on console to return to the boot prom
> [    1.852310] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> ----------------%<----------------
> 
> but given that I don't have the kernel anymore I'm starting to
> question myself if that run was really with the same base
> commit. I'll do a rebuild and see.

I found out that my previous kernel installation for the kernel with the first 8
patches was a broken mess. Sorry about the confusion. With that sorted out and a
rebuilt kernel with all patches, the failure above is the one I get for both 8
and 13 patches, and it is repeatable.

Cheers,
Andreas


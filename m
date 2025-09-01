Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE43323E;
	Mon,  1 Sep 2025 14:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736944; cv=none; b=rSrXUxtKkjVzwbF1Pp8zDGRe/D+WmxpN5wUiBK0WmgVbxCncRAycCSz/cT8IZlN7lZLUpVDhq0HQwEOPf06txTCVxfRVOwit6/jDbYb5VDbfXZ7rwQq+Uaj6ZYI3/rJ511kMWPhKV3+9/EO2oXI9ANsn1AZWD++2qo5yWMT8Ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736944; c=relaxed/simple;
	bh=Vr01r5jShe7WtXxZ4Mi/EO92tb7sdPPrmfO5tRlFpYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rv8LbEMhgM8bH+LqJbvI33okVJpCiawxrCGDqatE6fldFIzMftb8H1N0AkS83SaUaUuQ5IORJZMSdS+5XxRk7udMb/LYGF0tvYF7VeRzWaYHskj8ty/6jtGPBCOM8TWz1j3aDqmXtr238CKOST1o8H95rIIvvdkBS00JsTSBlJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=iEcGj1s5 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="iEcGj1s5"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cFrpY0W3Fz1FZPg;
	Mon,  1 Sep 2025 16:28:53 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cFrpX45vSz1DDGX;
	Mon,  1 Sep 2025 16:28:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756736932;
	bh=vlF9UlIvy8pbJYsfz3BdB6jdgH7aYB2RLg1qK8id57w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iEcGj1s5+QCUstRtxZQFajGR1R28c/sp1aDzcDi+17lfcoKLDht8XYWWOJoKUySVc
	 JKiNBbph3ddMDgfldn5Phdu9bZTq02vuXN2sjyVHUL1WiLPbHB/uyeO36Ynfr3WHdd
	 HBn9Abm62N23ch/09Q/rQ/YQvqnNDWCYfxQToL2LtLznlwOXAMrlY4echA5fC2pQED
	 PYigxNIeaq7k7I54nh39VTfVoW6SFGfMp2y1lHFp6Fkw65+7crN6UfssjoMutAFD/d
	 lr1jCqzJ71y+fqaNk+KgMwJ/KRMvrCfU22BSd5bDT48o1YLoG1QvNHNCCFH6hTzuWf
	 tFVfEapYXAqvQ==
Message-ID: <18d9e41c-f05f-4b3e-8217-4b8deb7afabd@gaisler.com>
Date: Mon, 1 Sep 2025 16:28:52 +0200
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
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
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
 <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>
 <20250829160020-5aeb38c3-2cb1-45b0-81fd-35e113417b65@linutronix.de>
 <f1204327-9d67-4ca2-9f55-6777453173f6@gaisler.com>
 <20250829185830-be502aa8-0f00-46b7-90fe-2d3cf3f1e7af@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250829185830-be502aa8-0f00-46b7-90fe-2d3cf3f1e7af@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-08-29 19:07, Thomas Weißschuh wrote:
> What does this do?
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e2c928de7d2c..6ae7afae948c 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1299,6 +1299,11 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>         struct k_sigaction *action;
>         int sig = info->si_signo;
>  
> +       if (unlikely(is_global_init(t)) && sig == SIGSEGV)
> +               panic("killing init, sig=%d errno=%d code=%d addr=%d vdso=%px",
> +                     info->si_signo, info->si_errno, info->si_code, info->si_addr,
> +                     t->mm->context.vdso);
> +
>         spin_lock_irqsave(&t->sighand->siglock, flags);
>         action = &t->sighand->action[sig-1];
>         ignored = action->sa.sa_handler == SIG_IGN;

This (with addr=%px) results in:

[    2.073506] Run /init as init process
[    2.076547] Kernel panic - not syncing: killing init, sig=11 errno=0 code=1 addr=0000000000000000 vdso=fff8000100384000
[    2.076594] CPU: 7 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1-00010-gf63e40394cec #11 VOLUNTARY 
[    2.076620] Call Trace:
[    2.076632] [<0000000000436524>] dump_stack+0x8/0x18
[    2.076660] [<00000000004291f4>] vpanic+0xdc/0x320
[    2.076682] [<000000000042945c>] panic+0x24/0x30
[    2.076700] [<0000000000493240>] force_sig_info_to_task+0x200/0x220
[    2.076726] [<0000000000493720>] force_sig_fault+0x40/0x60
[    2.076747] [<0000000000439e28>] sun4v_data_access_exception+0xa8/0x140
[    2.076770] [<00000000004066d4>] sun4v_dacc+0x28/0x34
[    2.077940] Press Stop-A (L1-A) from sun keyboard or send break
[    2.077940] twice on console to return to the boot prom
[    2.077981] ---[ end Kernel panic - not syncing: killing init, sig=11 errno=0 code=1 addr=0000000000000000 vdso=fff8000100384000 ]---

Cheers,
Andreas


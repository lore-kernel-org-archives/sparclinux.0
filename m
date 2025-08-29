Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D60432C30C;
	Fri, 29 Aug 2025 16:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756485366; cv=none; b=aK7agYq+U8PiXDZFY4sCWuj+pvpltqMd+tq+s9vT6TfZA1GYKGeAFfNkquLUPk/bNDhsLimbefn/+r00yGHeKtWikpLAvsNGmPwseEb6oZRGcL538/yNZgWFD535hgQEkzFSzfwEu6Jt0CoqfDQ2uWxRg0PfF+wK1INauRTPU6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756485366; c=relaxed/simple;
	bh=sQl5kcilRzkkjss4zlKynqguKe0QJlH+/tDb4kFyIbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUxi4xvhDTTqPR2/4ikgOk4qiKThSJR6S5z9e0dgJlsMp+7FpH+auvx7BqjoB8H4dM+66Gx4LnfAN/Ezh0jaUsaO2tarMxHfrB6q2myHvQgKBJftA5bzpiHFbhrpuUV7+uR013eCIkzuEMk+tIRQdl110jJRssx3qVy2lMsxWtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=LNzEYbG1 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="LNzEYbG1"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cD3mS5Csrz1DDXK;
	Fri, 29 Aug 2025 18:35:52 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cD3mS1tfmz1DDXM;
	Fri, 29 Aug 2025 18:35:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756485352;
	bh=eAm1P5mXnJduAjGMpVi/V3volcMlpadCWNnKwiqtODk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=LNzEYbG19BJf1b9RDlweV8sXNb2pckZF0aIdMg9UkWksUF/YbswXJCCZfXjFpFSjv
	 cSlwe/9MwKs/pI6XpquxCFK8wupUyUM0b7iS06fhHVi6RutS2jp4TV7BsQQfxJNi8O
	 P+jAxTbVlzykUE3o3jSwGgOAr8dHqjjEVK0sMjAlNSnjYJRCGKgowXqZREExpYApPs
	 Vr0HxHzS1CSAAUozgyxrPEItKZw+ykXkLJWTqLSecE3GFIpiq1nU/mB6pjKDXzHYWX
	 xuMk9Ss24ukt1dI4H6Se1X1hgo7JEnG0s+gR43cSaDSmdN+P2Xw0lRKpORw4kdbEh7
	 hXm+OtRdg8Ong==
Message-ID: <f1204327-9d67-4ca2-9f55-6777453173f6@gaisler.com>
Date: Fri, 29 Aug 2025 18:35:51 +0200
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
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250829160020-5aeb38c3-2cb1-45b0-81fd-35e113417b65@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-08-29 16:05, Thomas Weißschuh wrote:
> How are you currently building these kernels? Are you using the packaging
> from Debian and doing full rebuilds every time?

No, I cross build it separately with incremental builds for builtin stuff.
The modules are rebuilding every time however, I guess because I want to
have the git SHA in the version to not risk messing up which modules goes
with what kernel.

Then I scp over the image and modules and install in the Debian system.

> You can also build Debian binary packages directly from a git checkout with
> 'make bindeb-pkg'. This gives you nice incremental rebuilds.
> 
> Another hunk to test, to see from where the SIGSEGV comes from.
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index e2c928de7d2c..0b2777e88f44 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1299,6 +1299,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>         struct k_sigaction *action;
>         int sig = info->si_signo;
>  
> +       if (unlikely(is_global_init(t)) && sig == SIGSEGV)
> +               panic("killing init");
> +
>         spin_lock_irqsave(&t->sighand->siglock, flags);
>         action = &t->sighand->action[sig-1];
>         ignored = action->sa.sa_handler == SIG_IGN;

This results in:

[    1.661344] Run /init as init process
[    1.663057] Kernel panic - not syncing: killing init
[    1.663077] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1-00009-gc619bda6cd8d #10 VOLUNTARY 
[    1.663102] Call Trace:
[    1.663113] [<0000000000436524>] dump_stack+0x8/0x18
[    1.663138] [<00000000004291f4>] vpanic+0xdc/0x320
[    1.663160] [<000000000042945c>] panic+0x24/0x30
[    1.663176] [<0000000000493228>] force_sig_info_to_task+0x1e8/0x200
[    1.663198] [<0000000000493700>] force_sig_fault+0x40/0x60
[    1.663217] [<0000000000439e28>] sun4v_data_access_exception+0xa8/0x140
[    1.663236] [<00000000004066d4>] sun4v_dacc+0x28/0x34
[    1.663991] Press Stop-A (L1-A) from sun keyboard or send break
[    1.663991] twice on console to return to the boot prom
[    1.664010] ---[ end Kernel panic - not syncing: killing init ]---

> diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
> index 38a664d69782..efc3fef8f9bc 100644
> --- a/arch/sparc/vdso/vma.c
> +++ b/arch/sparc/vdso/vma.c
> @@ -25,7 +25,7 @@
>  #include <vdso/datapage.h>
>  #include <asm/vdso/vsyscall.h>
>  
> -unsigned int __read_mostly vdso_enabled = 1;
> +unsigned int __read_mostly vdso_enabled = 0;
>  
>  #ifdef CONFIG_SPARC64
>  static struct vm_special_mapping vdso_mapping64 = {

The analogue to this, booting with kernel parameter vdso=0,
makes the system boot fine.


> diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> index 02ea19f67164..ae87888fef8a 100644
> --- a/lib/vdso/gettimeofday.c
> +++ b/lib/vdso/gettimeofday.c
> @@ -318,6 +318,8 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
>         const struct vdso_clock *vc = vd->clock_data;
>         u32 msk;
>  
> +       return false;
> +
>         if (!vdso_clockid_valid(clock))
>                 return false;

This (independently) makes the system boot fine.


> diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
> index f3caa29a331c..a4669f7feada 100644
> --- a/arch/sparc/vdso/vdso.lds.S
> +++ b/arch/sparc/vdso/vdso.lds.S
> @@ -16,10 +16,7 @@
>  VERSION {
>         LINUX_2.6 {
>         global:
> -               clock_gettime;
> -               __vdso_clock_gettime;
> -               gettimeofday;
> -               __vdso_gettimeofday;
> +               __nothing;
>         local: *;
>         };
>  }

I have not tried this one yet.

Cheers,
Andreas


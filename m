Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF213314A7;
	Fri, 29 Aug 2025 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756487279; cv=none; b=RWHppdOi/z9Ilsk+PTPCIC8TPlmBcQGOeK2tLL9aChFMLvjMIfLsYLik5jKEZy67hu+11oHdY5e+8JO3o2sJHHhQx213rxRAapgRRQNQtmn0kWUACck7xxu0m901xTUScvtoi43PPZbLyfN+HDt/mesEy+V07bnZ3l5P4ZFhN3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756487279; c=relaxed/simple;
	bh=BL57tdy1ODOJY/Hy0g6+qUDqhu9+6PEkKwTN61xSxQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0e0k0332pSdSC8u8zMZeBRuCcsGa8vYJRAiLQIvn5ss8Buh1vWKXOHcZ6eFZw9ok/jeYPmo72ssZN/G4lIrnsHBYOU02ALTz9t0tuYkhB4cYLKwuCtelpk9EHO+IcZ7KvXrqRMa6lHe1eCvvhyMsRM/j37LRz64kVbVghEA1a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FrgiBCas; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MiQGjEQF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FrgiBCas";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MiQGjEQF"
Date: Fri, 29 Aug 2025 19:07:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756487275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbwyXCi3wc8fwtwUktq2EcPtsj974o9K4k2+RiLoNFo=;
	b=FrgiBCasN8Mlwjt0vPy0/awXZ9BLrjUZDufSezGvNgGoSu1OftpUn7J6a+CLhEVI/li0Dj
	Uq7ey7E9fAaXFY2YAdxmAfynL0MsVerkXjYoAjhE2Oy3qziLfB5peHwzIRLfDYroXDmWsF
	8jJpNIeMMFATU9snbLGvkG+NoikVpdnmyu13CnqWF3k5/IqIjQfIge1t+OZ2bFyUP/vt1M
	YZLEWaF3HpSXGru9kYx2geg7LN5cn5LZKWPSVj/0yFyaO2l+xx3gd0FCQdtfE+XpmGuFiV
	NPKAWOaXh25wBmDXq8T+bJQOBMK2TODlcpnjz7qTQ7QPKg2LtISY8y44R0w76w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756487275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VbwyXCi3wc8fwtwUktq2EcPtsj974o9K4k2+RiLoNFo=;
	b=MiQGjEQFqPkOQYyWnR9GAFiZDvjgConIH0h9SHntJopHwoo4CwDoH9dNNAEmWTvG++zjlu
	tmBZZCQ4POZjJIAg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Andreas Larsson <andreas@gaisler.com>
Cc: Andy Lutomirski <luto@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
	Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, Nick Alcock <nick.alcock@oracle.com>, 
	John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 08/13] sparc64: vdso: Switch to the generic vDSO
 library
Message-ID: <20250829185830-be502aa8-0f00-46b7-90fe-2d3cf3f1e7af@linutronix.de>
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
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1204327-9d67-4ca2-9f55-6777453173f6@gaisler.com>

On Fri, Aug 29, 2025 at 06:35:51PM +0200, Andreas Larsson wrote:
> On 2025-08-29 16:05, Thomas Weißschuh wrote:
> > How are you currently building these kernels? Are you using the packaging
> > from Debian and doing full rebuilds every time?
> 
> No, I cross build it separately with incremental builds for builtin stuff.
> The modules are rebuilding every time however, I guess because I want to
> have the git SHA in the version to not risk messing up which modules goes
> with what kernel.
> 
> Then I scp over the image and modules and install in the Debian system.

Ack.

> > You can also build Debian binary packages directly from a git checkout with
> > 'make bindeb-pkg'. This gives you nice incremental rebuilds.
> > 
> > Another hunk to test, to see from where the SIGSEGV comes from.
> > 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index e2c928de7d2c..0b2777e88f44 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1299,6 +1299,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
> >         struct k_sigaction *action;
> >         int sig = info->si_signo;
> >  
> > +       if (unlikely(is_global_init(t)) && sig == SIGSEGV)
> > +               panic("killing init");
> > +
> >         spin_lock_irqsave(&t->sighand->siglock, flags);
> >         action = &t->sighand->action[sig-1];
> >         ignored = action->sa.sa_handler == SIG_IGN;
> 
> This results in:
> 
> [    1.661344] Run /init as init process
> [    1.663057] Kernel panic - not syncing: killing init
> [    1.663077] CPU: 0 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1-00009-gc619bda6cd8d #10 VOLUNTARY 
> [    1.663102] Call Trace:
> [    1.663113] [<0000000000436524>] dump_stack+0x8/0x18
> [    1.663138] [<00000000004291f4>] vpanic+0xdc/0x320
> [    1.663160] [<000000000042945c>] panic+0x24/0x30
> [    1.663176] [<0000000000493228>] force_sig_info_to_task+0x1e8/0x200
> [    1.663198] [<0000000000493700>] force_sig_fault+0x40/0x60
> [    1.663217] [<0000000000439e28>] sun4v_data_access_exception+0xa8/0x140
> [    1.663236] [<00000000004066d4>] sun4v_dacc+0x28/0x34
> [    1.663991] Press Stop-A (L1-A) from sun keyboard or send break
> [    1.663991] twice on console to return to the boot prom
> [    1.664010] ---[ end Kernel panic - not syncing: killing init ]---

What does this do?

diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..6ae7afae948c 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1299,6 +1299,11 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
        struct k_sigaction *action;
        int sig = info->si_signo;
 
+       if (unlikely(is_global_init(t)) && sig == SIGSEGV)
+               panic("killing init, sig=%d errno=%d code=%d addr=%d vdso=%px",
+                     info->si_signo, info->si_errno, info->si_code, info->si_addr,
+                     t->mm->context.vdso);
+
        spin_lock_irqsave(&t->sighand->siglock, flags);
        action = &t->sighand->action[sig-1];
        ignored = action->sa.sa_handler == SIG_IGN;

(...)

> > diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
> > index 02ea19f67164..ae87888fef8a 100644
> > --- a/lib/vdso/gettimeofday.c
> > +++ b/lib/vdso/gettimeofday.c
> > @@ -318,6 +318,8 @@ __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t clock,
> >         const struct vdso_clock *vc = vd->clock_data;
> >         u32 msk;
> >  
> > +       return false;
> > +
> >         if (!vdso_clockid_valid(clock))
> >                 return false;
> 
> This (independently) makes the system boot fine.
> 
> 
> > diff --git a/arch/sparc/vdso/vdso.lds.S b/arch/sparc/vdso/vdso.lds.S
> > index f3caa29a331c..a4669f7feada 100644
> > --- a/arch/sparc/vdso/vdso.lds.S
> > +++ b/arch/sparc/vdso/vdso.lds.S
> > @@ -16,10 +16,7 @@
> >  VERSION {
> >         LINUX_2.6 {
> >         global:
> > -               clock_gettime;
> > -               __vdso_clock_gettime;
> > -               gettimeofday;
> > -               __vdso_gettimeofday;
> > +               __nothing;
> >         local: *;
> >         };
> >  }
> 
> I have not tried this one yet.

If the above works, then this one is not necessary.


Thomas

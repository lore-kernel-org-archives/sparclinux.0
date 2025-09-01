Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14CC335BB7;
	Mon,  1 Sep 2025 14:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738799; cv=none; b=seUFy06KlfPU9M+7hgkIgoxv90T664jGaaecO8dcRr3ABx+OugGWeVoHzDKstinzLST22VKoHkMpE305U+TMrnPu7Z5GpgTZ89Nq2KFT6Eyo1YryWV5mmwXqmSbydXZwDGD8++kf+mKXujTyfn1q6HLqTcDs1ipYfOPQtWBJ9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738799; c=relaxed/simple;
	bh=Srmgk0gw2+ryiP1RbMOgD7H4FArhN6lnVB/qDY6fTMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L09/FuTeecOoVww6RASzJV4TzXPAK9EdwcgHYPI6mabTWVeYZbQn6XSGbIU9beE6GRJwEY6rOgMlxRmHK+902FifrtKoanln+arYgDJ9DjZvcufLrJI8906IQJ6MUtOkZobdxKGVGY8K7pUrl2m3I3IkVhyzcyDUB0FaqHpvYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+ESQXZo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RMnykGK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+ESQXZo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RMnykGK3"
Date: Mon, 1 Sep 2025 16:59:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756738795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PB8zuML1kiuAkBAHseJ49M0Krsa/c4iv5wrswU+E5c8=;
	b=t+ESQXZozxJaupiaqOxSINQt2HSCGw6UfjgRQVgeAw/kBrfqz88WoroCL/eda+d8orM6SQ
	wMJCI7zQxDtvSB4mhi3W9lIQyI53jJVfv4v+L80h/AqTs4Dw8Dk/qMzI1N61s+MyfiS468
	ywFTNFMzIpP/2ta/gIKwkfP0O7tICQC5f7WiIsf+nUWBKVXGw1BjgoFPlu+iEIgcn7zUIC
	N0miNoJUX5XIcjIWdLkZbrxdmkek3cy4Asi8S0+rd1O519DKZ79vgBsuUVMRE5YtW+w0Bp
	z8kl/WUxUcK8MsR42PNHED2cncIx+K/4yzTMs4Rw7GlJ+P/tkHE84DARvX39RA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756738795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PB8zuML1kiuAkBAHseJ49M0Krsa/c4iv5wrswU+E5c8=;
	b=RMnykGK3PAwaMRv7doIdlWV2iQdNcho7lEl07xSeopX5rMxmmKYV9DkU5ije1Iktuyigf6
	w2XeAUmqPEZwMcAA==
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
Message-ID: <20250901164203-efc4e1ca-d83c-4776-bc20-13e1088ac548@linutronix.de>
References: <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
 <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>
 <20250829160020-5aeb38c3-2cb1-45b0-81fd-35e113417b65@linutronix.de>
 <f1204327-9d67-4ca2-9f55-6777453173f6@gaisler.com>
 <20250829185830-be502aa8-0f00-46b7-90fe-2d3cf3f1e7af@linutronix.de>
 <18d9e41c-f05f-4b3e-8217-4b8deb7afabd@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <18d9e41c-f05f-4b3e-8217-4b8deb7afabd@gaisler.com>

Hi Andreas,

thanks!

On Mon, Sep 01, 2025 at 04:28:52PM +0200, Andreas Larsson wrote:
> On 2025-08-29 19:07, Thomas Weißschuh wrote:
> > What does this do?
> > 
> > diff --git a/kernel/signal.c b/kernel/signal.c
> > index e2c928de7d2c..6ae7afae948c 100644
> > --- a/kernel/signal.c
> > +++ b/kernel/signal.c
> > @@ -1299,6 +1299,11 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
> >         struct k_sigaction *action;
> >         int sig = info->si_signo;
> >  
> > +       if (unlikely(is_global_init(t)) && sig == SIGSEGV)
> > +               panic("killing init, sig=%d errno=%d code=%d addr=%d vdso=%px",
> > +                     info->si_signo, info->si_errno, info->si_code, info->si_addr,
> > +                     t->mm->context.vdso);
> > +
> >         spin_lock_irqsave(&t->sighand->siglock, flags);
> >         action = &t->sighand->action[sig-1];
> >         ignored = action->sa.sa_handler == SIG_IGN;
> 
> This (with addr=%px) results in:
> 
> [    2.073506] Run /init as init process
> [    2.076547] Kernel panic - not syncing: killing init, sig=11 errno=0 code=1 addr=0000000000000000 vdso=fff8000100384000
> [    2.076594] CPU: 7 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1-00010-gf63e40394cec #11 VOLUNTARY 
> [    2.076620] Call Trace:
> [    2.076632] [<0000000000436524>] dump_stack+0x8/0x18
> [    2.076660] [<00000000004291f4>] vpanic+0xdc/0x320
> [    2.076682] [<000000000042945c>] panic+0x24/0x30
> [    2.076700] [<0000000000493240>] force_sig_info_to_task+0x200/0x220
> [    2.076726] [<0000000000493720>] force_sig_fault+0x40/0x60
> [    2.076747] [<0000000000439e28>] sun4v_data_access_exception+0xa8/0x140
> [    2.076770] [<00000000004066d4>] sun4v_dacc+0x28/0x34
> [    2.077940] Press Stop-A (L1-A) from sun keyboard or send break
> [    2.077940] twice on console to return to the boot prom
> [    2.077981] ---[ end Kernel panic - not syncing: killing init, sig=11 errno=0 code=1 addr=0000000000000000 vdso=fff8000100384000 ]---

So a NULL-pointer deref. Please also try the following, to get the trapping code.

--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1299,6 +1299,14 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
        struct k_sigaction *action;
        int sig = info->si_signo;
 
+       if (unlikely(is_global_init(t)) && sig == SIGSEGV) {
+               struct pt_regs *regs = task_pt_regs(t);
+
+               panic("killing init, sig=%d errno=%d code=%d addr=%px vdso=%px pc=0x%lx vdsopc=0x%lx",
+                     info->si_signo, info->si_errno, info->si_code, info->si_addr,
+                     t->mm->context.vdso, regs->tpc, regs->tpc - (unsigned long)t->mm->context.vdso);
+       }
+
        spin_lock_irqsave(&t->sighand->siglock, flags);
        action = &t->sighand->action[sig-1];
        ignored = action->sa.sa_handler == SIG_IGN;


Please give me the disassembly for the address printed as "vdsopc" from
arch/sparc/vdso/vdso64.so.dbg starting from its function entrypoint.


Thomas

Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14382701DC;
	Fri, 29 Aug 2025 14:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756476316; cv=none; b=ABp8iti326V0ciYR4ycoko/oXdzQfbYCSf6P/XVcBbin4gSWBaUmDVh1TTFq/o0upomZriBAFVgGd6vn4liB0YBkt1+thLegnroAevLPoCURpUr815wCi/9VO+mWOFS7PIdwzlS1O+ZBCsld6AXYh0d1if2HNZ/0VKqa4UFNpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756476316; c=relaxed/simple;
	bh=rzFd4j+Y98vTbTk4PaMe+JnMZbspF/b/jARo28rP0vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRz9XZY0swSb46T5Upu5IE3SAvUYqtExvED0HY3iWxvj6Jx36SQcNdp1bH+oAi5jw+urrZ219BVTnvcTKaG0byhX0C7dvgXSFBKMYwt1lpuhivdCScQJ8/vW5JCh5Dt0HXDxSYC2sIHMdjug9hQ/kOjqIVmvqTVi+NJCfn1scNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GYL4Wfvc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SaLBxMeO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GYL4Wfvc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SaLBxMeO"
Date: Fri, 29 Aug 2025 16:05:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756476309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9G3qg9RepmeEtzhCrGzDelrryA4jtFe/dra2lm7EVo=;
	b=GYL4WfvcXOXUFp0ee1MwRQS73pjUQlDzmnkdw72t8RrLYsu4yVMtSOeixN74thvGLw9GyV
	dmWlsWI4HVnKXxOH1Sz6EswWm6mbmSw5i70sugF9FmI8W2WXJg6JKVMyLRN3pc9tMl0ijX
	x3rLeZBcNNZsmCDnzqne94FPc+z3jBQ9hjMB7w+VbSmazYZvxTJHg/0vVBFmIE7/mxWuA+
	s0RaO7BXvQyUzbdK+e3QHlWLBMQRYoCeb/iCt+AeBLkfZoKCSUyNzmr67u2/shfqjzCNMb
	x1VXO13MjWNoM5TULaj4f8c7GuaWXhewyK+Qy/uAPToJHFWC5mcKIfsz8MPvtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756476309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z9G3qg9RepmeEtzhCrGzDelrryA4jtFe/dra2lm7EVo=;
	b=SaLBxMeOaH6p2YANcPGu97CwCGBccpyOpHIZBB1CB06EGUMChvMTh8REjAQZJtsDIodQf1
	UZPMbJSntFwCYEAQ==
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
Message-ID: <20250829160020-5aeb38c3-2cb1-45b0-81fd-35e113417b65@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-8-b5ff80672347@linutronix.de>
 <0b223e3d-25af-4897-b513-699dfeedfa04@gaisler.com>
 <20250826074526-a1463084-366a-44d1-874b-b898f4747451@linutronix.de>
 <271c108b-0fe4-4e7a-9bc7-325e75cf60ab@gaisler.com>
 <8f31efde-0212-49b9-a0ea-64d5532c0071@gaisler.com>
 <20250829122023-948f7969-b6b0-4ae2-9c12-71cc39abcf9e@linutronix.de>
 <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b699dde-2dde-4900-abd6-d902b4cff853@gaisler.com>

On Fri, Aug 29, 2025 at 03:41:22PM +0200, Andreas Larsson wrote:
> On 2025-08-29 12:37, Thomas Weißschuh wrote:
> > On Fri, Aug 29, 2025 at 12:02:39PM +0200, Andreas Larsson wrote:
> >> On 2025-08-28 17:38, Andreas Larsson wrote:
> >>> and with all of them applied I got: 
> >>>
> >>> ----------------%<----------------
> >>> [    1.849344] Run /init as init process
> >>> [    1.851309] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> >>> [    1.851339] CPU: 4 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1+ #3 VOLUNTARY
> >>> [    1.851363] Call Trace:
> >>> [    1.851374] [<0000000000436524>] dump_stack+0x8/0x18
> >>> [    1.851400] [<00000000004291f4>] vpanic+0xdc/0x320
> >>> [    1.851420] [<000000000042945c>] panic+0x24/0x30
> >>> [    1.851437] [<00000000004844a4>] do_exit+0xac4/0xae0
> >>> [    1.851458] [<0000000000484684>] do_group_exit+0x24/0xa0
> >>> [    1.851476] [<0000000000494c60>] get_signal+0x900/0x940
> >>> [    1.851495] [<000000000043ecb8>] do_notify_resume+0xf8/0x600
> >>> [    1.851514] [<0000000000404b48>] __handle_signal+0xc/0x30
> >>> [    1.852291] Press Stop-A (L1-A) from sun keyboard or send break
> >>> [    1.852291] twice on console to return to the boot prom
> >>> [    1.852310] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> >>> ----------------%<----------------
> >>>
> >>> but given that I don't have the kernel anymore I'm starting to
> >>> question myself if that run was really with the same base
> >>> commit. I'll do a rebuild and see.
> >>
> >> I found out that my previous kernel installation for the kernel with the first 8
> >> patches was a broken mess. Sorry about the confusion. With that sorted out and a
> >> rebuilt kernel with all patches, the failure above is the one I get for both 8
> >> and 13 patches, and it is repeatable.
> > 
> > This splat means that init got killed by SIGSEGV, so that makes some sense in
> > the context of the code being touched. Then let's focus on patch 8 for now.
> > 
> > In the meantime I installed a full Debian, but the bug is still not
> > reproducible in QEMU.
> > 
> > * Did you use the SMP or UP kernel config from Debian?
> 
> I based my config on the SMP config that was in use on the system.
> Produces an tremendous amount of modules unfortunately, so I'll have
> to cut down in the config. Right now the turnaround time for testing
> a new kernel with this setup for this system is quite bad.

How are you currently building these kernels? Are you using the packaging
from Debian and doing full rebuilds every time?
You can also build Debian binary packages directly from a git checkout with
'make bindeb-pkg'. This gives you nice incremental rebuilds.

Another hunk to test, to see from where the SIGSEGV comes from.

diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..0b2777e88f44 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1299,6 +1299,9 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
        struct k_sigaction *action;
        int sig = info->si_signo;
 
+       if (unlikely(is_global_init(t)) && sig == SIGSEGV)
+               panic("killing init");
+
        spin_lock_irqsave(&t->sighand->siglock, flags);
        action = &t->sighand->action[sig-1];
        ignored = action->sa.sa_handler == SIG_IGN;


Sorry for the response spam...
Thomas

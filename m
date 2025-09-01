Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D15522F77E;
	Mon,  1 Sep 2025 19:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756753530; cv=none; b=dPfSRMrzGjSUznVfeXkO3YV+D+x7Qj9NMCggyiBUo47IubhfBrFxEETzvZ7vb5lDos/988C/mk8NfXqajbdleP5enpPfIEUAXKom7DaoN+OBR/NFmBVJBPyTMbs9UHXvOxDTEBkmxz0LWn++j8CPKiQJXNHPXd4HNebemLiiGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756753530; c=relaxed/simple;
	bh=c7jv6Y5lLzrpX0lcAB3TGgDYZutg9jNfF1Z1oH9PP6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cR0ASk/wnXnT+hqpKq2UghjCzq8b/pwCs5H/GWZlVEGKK+zKEdRFAhFxIJ2rJhiYrEFLNVljVHz/DFK+cYwb/kTKR7GJwTP96ePyGtGvaAlaVzkO14i+OkjWbu2Mhbg2JlTnlvy7fHoazdldOgBXDPEJzasOmvFqadsvzZ8FbOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=CdsM5LXl reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="CdsM5LXl"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cFyxc0htNz1FXb8;
	Mon,  1 Sep 2025 21:05:24 +0200 (CEST)
Received: from [10.10.15.10] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cFyxb4LSdz1FQVx;
	Mon,  1 Sep 2025 21:05:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1756753524;
	bh=FxaT//OcrvdqR1vkzq5c0SEQvxciF10LAeUiOe1NZAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CdsM5LXlNv388CM8CK8akGS07mTLXaaP6AKonuFVgQt287DIwZCgHW04M9RZUqReQ
	 bP/LwxQbYGwtmHUbZlqjf/egOcFdo1Q7UnPX5J+kildW6GEzZe35dgFvDyxuZF9kRW
	 K5PLH/k/bNKC+xJkTuTSowPl7gaSIYc9NEBlAG2LOGxCDwTnjdQ6DQGi4RVu/Yjx0n
	 HJ3gunk5nNTGVHBxpItRjWqsIKanJ0EyFZT0wnv3RaRmRBkeamptoqDydeK7zaWJ1F
	 E6JEMGx7lDdihzLQWTZwt76JXS6Amu2ZeCYAVPYiLe2HyVPMBryfY869BIpPaLA6iO
	 6nFFlfPhBU9AA==
Message-ID: <3be01877-cfcb-43e2-811d-e8751338dc9c@gaisler.com>
Date: Mon, 1 Sep 2025 21:05:23 +0200
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
 <20250901164203-efc4e1ca-d83c-4776-bc20-13e1088ac548@linutronix.de>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250901164203-efc4e1ca-d83c-4776-bc20-13e1088ac548@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2025-09-01 16:59, Thomas Weißschuh wrote:
> So a NULL-pointer deref. Please also try the following, to get the trapping code.
> 
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -1299,6 +1299,14 @@ force_sig_info_to_task(struct kernel_siginfo *info, struct task_struct *t,
>         struct k_sigaction *action;
>         int sig = info->si_signo;
>  
> +       if (unlikely(is_global_init(t)) && sig == SIGSEGV) {
> +               struct pt_regs *regs = task_pt_regs(t);
> +
> +               panic("killing init, sig=%d errno=%d code=%d addr=%px vdso=%px pc=0x%lx vdsopc=0x%lx",
> +                     info->si_signo, info->si_errno, info->si_code, info->si_addr,
> +                     t->mm->context.vdso, regs->tpc, regs->tpc - (unsigned long)t->mm->context.vdso);
> +       }
> +
>         spin_lock_irqsave(&t->sighand->siglock, flags);
>         action = &t->sighand->action[sig-1];
>         ignored = action->sa.sa_handler == SIG_IGN;
> 
> 
> Please give me the disassembly for the address printed as "vdsopc" from
> arch/sparc/vdso/vdso64.so.dbg starting from its function entrypoint.

I get

[    1.680341] Run /init as init process
[    1.682256] Kernel panic - not syncing: killing init, sig=11 errno=0 code=1 addr=0000000000000000 vdso=fff800010081e000 pc=0xfff800010081e684 vdsopc=0x684
[    1.682289] CPU: 2 UID: 0 PID: 1 Comm: init Not tainted 6.17.0-rc1-00011-g1f71a73bede3 #12 VOLUNTARY
[    1.682313] Call Trace:
[    1.682324] [<0000000000436524>] dump_stack+0x8/0x18
[    1.682351] [<00000000004291f4>] vpanic+0xdc/0x320
[    1.682373] [<000000000042945c>] panic+0x24/0x30
[    1.682389] [<0000000000493258>] force_sig_info_to_task+0x218/0x240
[    1.682412] [<0000000000493740>] force_sig_fault+0x40/0x60
[    1.682430] [<0000000000439e28>] sun4v_data_access_exception+0xa8/0x140
[    1.682449] [<00000000004066d4>] sun4v_dacc+0x28/0x34
[    1.683232] Press Stop-A (L1-A) from sun keyboard or send break
[    1.683232] twice on console to return to the boot prom
[    1.683252] ---[ end Kernel panic - not syncing: killing init, sig=11 errno=0 code=1 addr=0000000000000000 vdso=fff800010081e000 pc=0xfff800010081e684 vdsopc=0x684 ]---

and we have

#if defined(CONFIG_SPARC64)
int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
{
 640:   9d e3 bf 50     save  %sp, -176, %sp
        __asm__ __volatile__(
 644:   40 00 00 03     call  650 <__vdso_clock_gettime+0x10>
 648:   01 00 00 00     nop 
 64c:   ff ff 79 b4     unknown
 650:   9e 03 e0 08     add  %o7, 8, %o7
 654:   c6 43 c0 00     ldsw  [ %o7 ], %g3
 658:   86 00 c0 0f     add  %g3, %o7, %g3
        if (!vdso_clockid_valid(clock))
 65c:   80 a6 20 17     cmp  %i0, 0x17
 660:   18 40 00 3b     bgu,pn   %icc, 74c <__vdso_clock_gettime+0x10c>
 664:   84 10 00 03     mov  %g3, %g2
        msk = 1U << clock;
 668:   82 10 20 01     mov  1, %g1
 66c:   83 28 40 18     sll  %g1, %i0, %g1
        if (likely(msk & VDSO_HRES))
 670:   80 88 68 83     btst  0x883, %g1
 674:   02 40 00 30     be,pn   %icc, 734 <__vdso_clock_gettime+0xf4>
 678:   80 88 60 60     btst  0x60, %g1
        if (!__arch_vdso_hres_capable())
 67c:   87 2e 30 04     sllx  %i0, 4, %g3
 680:   86 00 80 03     add  %g2, %g3, %g3
                while (unlikely((seq = READ_ONCE(vc->seq)) & 1)) {
 684:   fa 00 80 00     ld  [ %g2 ], %i5                          <-- this one
 688:   80 8f 60 01     btst  1, %i5
 68c:   12 60 00 39     bne,pn   %xcc, 770 <__vdso_clock_gettime+0x130>
 690:   01 00 00 00     nop 
 ...

where the READ_ONCE that does the trapping load is the READ_ONCE(vc->seq)
in do_hres() in lib/vdso/gettimeofday.c. So we seem to  have a NULL vc.

With patches 1-8 applied on v6.17-rc1, addr2line gives us:

0x640: arch/sparc/vdso/vclock_gettime.c:34
0x644: arch/sparc/include/asm/vdso/gettimeofday.h:150
0x648: arch/sparc/include/asm/vdso/gettimeofday.h:150
0x64c: arch/sparc/include/asm/vdso/gettimeofday.h:150
0x650: arch/sparc/include/asm/vdso/gettimeofday.h:150
0x654: arch/sparc/include/asm/vdso/gettimeofday.h:150
0x658: arch/sparc/include/asm/vdso/gettimeofday.h:150
0x65c: lib/vdso/gettimeofday.c:321 (discriminator 1)
0x660: lib/vdso/gettimeofday.c:321 (discriminator 1)
0x664: lib/vdso/gettimeofday.c:321 (discriminator 1)
0x668: lib/vdso/gettimeofday.c:328
0x66c: lib/vdso/gettimeofday.c:328
0x670: lib/vdso/gettimeofday.c:329 (discriminator 1)
0x674: lib/vdso/gettimeofday.c:329 (discriminator 1)
0x678: lib/vdso/gettimeofday.c:329 (discriminator 1)
0x67c: lib/vdso/gettimeofday.c:175
0x680: lib/vdso/gettimeofday.c:175
0x684: lib/vdso/gettimeofday.c:190 (discriminator 2)


Cheers,
Andreas

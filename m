Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7399360EF0
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104563; cv=pass; b=FNsYf5hazaaVCCVcMWX/GzENNnTJbEer5KzMuUrH72BZ6X9Nw35vwGmZfwyKRheF7JI0xcyHHf6460yKjFvuHp4NKnscBJzxLMv+D7d4ipRm6Ahs5bHxjeWJEjIx1iil7VwhcYZ7L7f8bKCtsE7uCLqhpaUg+3sWdvPWxruRLAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104563; c=relaxed/simple;
	bh=2iADdXB0u89j4TAc4evJkaJgQVI0i6XZPvplCiNFcAg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RcplfAFZuXxAB9CtFu4hxQqQiTZuowBtvGjtsgIC7ombuuZzh88xKu3pCPz4iaPdVqwGP2jqZmOB/+irxb1yAaPEIHU0q5W0LEm0N3YMWOOWZTjwqug6jYiWgYCdTweyOZ3/ORnxtZp6uE99Y16UwbPK5zDjV0jF0gDjTwSlmNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=seo6/dCG; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="seo6/dCG"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a60591ae54so1058734a12.3
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 02:02:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791104559; cv=none;
        d=google.com; s=arc-20260327;
        b=ULBKWucGGFm5Wmw8vImyifUyLYxrDcqG1vbOcfcTplVPtspEOlaqvAQsd6nXirEHMv
         jYy65fWWgHZD+7XmjlnYVkrReVIBki5izB5AR3ixIZFXiWzkXyA0TN+yqEYeQZ78O8f5
         z10UAT4MXO9k7tODCKoR4IjcRHq4iLIjs3SKulwis9RHmjcHSt48qj2ukHv9+1G70Kko
         eGSO2fbkQ/Ija1T4iftJE//spSvG/DiVcuHJEwlNHNniIPAs/cgM5cnJTi5GnyBOLesv
         p5Ct+rZwBOvpBaxr8n3Rq3Sq/L94IE2amt6KuB83PhvCxqGHsZqc7jxdQtxSPFllHqIP
         ltGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4kVu/yq/WaOXMdFOaNW9qNBMm3nKlSEjdOviAUDMdnU=;
        fh=LklTktD+ELispFclBFEsIyJLvB5o5egavNE/7wMSKgY=;
        b=Da9LXYSAvEKt6tuV7WM51syy2yeM6wYq7Fas+Ntqy5X7zHFZpT7/PP2KeItXgrTIvG
         Atc/tt4AMqm6JCzxrVDMNDpt0mDloR6ug2cKCWQwfgLs8mXwsfoi7oJKo2jC2eNWdkQV
         c24hoHIeQ+y1zuzr92r3de1e2vQVh4V5wPnnr2KYGm0KR8E17lKvBThwAR3E2bh54fHy
         4paK7NU1fcluwBJjpcpC5yqTu6tsE/ewTZbyb01UXWI8ZtAzT0f41i7HMSVriwojd864
         HSPgSvllzhWlQ6PJeNqGMxOw8h0hY8JSr+zyZpC0BE/DuDGk6W5SAR/TQX+KqenRRZAG
         sVvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791104559; x=1791709359; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4kVu/yq/WaOXMdFOaNW9qNBMm3nKlSEjdOviAUDMdnU=;
        b=seo6/dCGJBHmzoZ+l/drKAr6l6gojJLim9pdbQmdKSEVBwKLmRFnBdhgvURHmmodnj
         CQM/9pnTYiT1l+ms58nNi75DaDLkkrP/StNhPUDzk6fvaJ0i+dIoBq0dRCSaCJorDBYX
         QUA1K1GHQvEmPmk5/DjAWwAuQ8+4r8BRkP51JOiaTRTUvicb4kDWFeyeTrjzQvswP8KI
         IkUJNTvR/OrCNgmzqdoButM0a7/+wtLceTPNOjfCAF6EihGct2XQWGWfQpgc3fk7Flr9
         Ooml+AYV1MchHWh5n1nrE9HqKf/GR/dtPqihD8VhRmFXNBjLxdHyDaMDfKfXGNRUickF
         39vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791104559; x=1791709359;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4kVu/yq/WaOXMdFOaNW9qNBMm3nKlSEjdOviAUDMdnU=;
        b=bPLNIm+nndW+n+7TbHrtSDE6j3RF8bCl+HPAqIFFFdpMtqZwjdJBmFTDqKllbwdVnO
         PBLoyOtX80bFWBKpGPtQdC1m5mRZ/CLpOEjTf7ejq6da1BngSnDf1tj41tX9sOXyHK7O
         yIHdFeK4pZnmQ6DIaV2/zuRi1SX7DLRpTYbspMTRguXscLIwsZWuOPoLYM6liOD/NQCx
         9LM9Z6Pv/qX92OXx2jhTzuRu9Avos6J8fuM9VBekGilhxptu0SJsClF7k0NFH5hehp8l
         1b0288tNCbLIWFvacw0aKpaDY8iDUQS8vlTkJMh5Js3xBbdTq2gW3UoBCg4dxu7AXkyE
         nxUg==
X-Forwarded-Encrypted: i=1; AKwUvBwRP6Nhx9k/SAeGTccDbr2XyMGXnXsmgGmKWGPrq/Pf900ZojKGlqLwOm0WOeKFvDiG8V9esUTDD8Bz@vger.kernel.org
X-Gm-Message-State: AFq9FYKQuhZcDEblqurFtr5dzvRHE7siGcYH8xc2BMhNUvYqHPLKWIrY
	eYK2u9x2sBcZhqwv/zoBHTT6GRThYQIV85Na5asl/QdiakQM2Ihqqg4A6HvK+6oP25HpUYIkOCz
	4IY+53MIOKpMlJf6RvGks2uuhwEso3as=
X-Gm-Gg: AYBFou2MwHiXUFPnKNgQqJRe1GJjMqrLYPX5e37Kfix/KU4edubczhbs/pcZPcNbnQK
	FkCjZEmmlE8zxAEQSXKiy14S0EhHV8Zt8XaNoOn3JZ+yw6rPtJoBfac8VnRzd8snT+Aw/pjUWaZ
	c8twagH9DMzCw3fncWagAM67Sq+uAwrlyE/vpJS0T4iofyVeMjXqkMFbx0O293WWgb5swno7jgR
	fX5q7B84Tmn4e2PK4/gwGwOBSxcPhEchY4KFJeF8uwLO9BHXi3nCyaLEXinrYK8FSwBM49KlTH4
	5D5kkQDAYzavKt1q+GpW0WF14B+gQImS6DLZShThHRB6w2okYqPEQw6OHkQJcmStWGV2OVLgCjK
	4gDB+y/DvGWJtpv10XUbgyfTXMOll3K4ODcMl1YxyEQ==
X-Received: by 2002:a05:6402:27d0:b0:6ac:b49e:42a with SMTP id
 4fb4d7f45d1cf-6af9e335cd4mr6612425a12.28.1791104558767; Sun, 04 Oct 2026
 02:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005821.8369-1-kaloz@kernel.org> <20260927005821.8369-3-kaloz@kernel.org>
In-Reply-To: <20260927005821.8369-3-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 4 Oct 2026 11:02:27 +0200
X-Gm-Features: AclHuK-LuHKkhlhvEtgwByXee8TuF66Nw1OhkzhK6l7LcKAy6Spos4bz3m9Gxjw
Message-ID: <CA+=Fv5SLKZn6Hs3tcxn_wO8k4RW3C0040fOVMVfe8L+oMhpZSg@mail.gmail.com>
Subject: Re: [PATCH 2/3] sparc32: emulate casa on V8 CPUs
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> sun4m implements no compare-and-swap instruction, only ldstub and swap,
> so the V9 casa opcode is undefined there and raises illegal_instruction.
> Complete the immediate-ASI form from do_illegal_instruction() for both
> ASIs a compiler emits -- 0x80, the V9 primary address space, and 0x0A
> from gcc -mcpu=3Dleon3 -- so a C library can use one casa for its 32-bit
> atomics on any V8 part. The opcode is unimplemented, so the ASI carries
> no distinction the emulated CAS has to honour. LEON parts built without
> casa take the same trap and are the LEON parts this serves.
>
> The CAS is futex_atomic_cmpxchg_inatomic(), so it is atomic against the
> futex operations and against itself on SMP. Everything else, including
> the register-ASI form and casxa, raises SIGILL.
>
> Confirmed on a dual-SuperSPARC SPARCstation 20.
>
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/kernel/Makefile     |   1 +
>  arch/sparc/kernel/cas_emu_32.c | 117 +++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/entry.h      |   1 +
>  arch/sparc/kernel/traps_32.c   |   7 ++
>  arch/sparc/kernel/unimp_32.h   |  71 ++++++++++++++++++++
>  5 files changed, 197 insertions(+)
>  create mode 100644 arch/sparc/kernel/cas_emu_32.c
>  create mode 100644 arch/sparc/kernel/unimp_32.h
>
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index 497b5714fa8f..fbea79a4ab58 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -40,6 +40,7 @@ obj-y                   +=3D sys_sparc_$(BITS).o
>  obj-$(CONFIG_SPARC32)   +=3D systbls_32.o
>  obj-y                   +=3D time_$(BITS).o
>  obj-$(CONFIG_SPARC32)   +=3D windows.o
> +obj-$(CONFIG_SPARC32)   +=3D cas_emu_32.o
>  obj-y                   +=3D cpu.o
>  obj-$(CONFIG_SPARC32)   +=3D devices.o
>  obj-y                   +=3D ptrace_$(BITS).o
> diff --git a/arch/sparc/kernel/cas_emu_32.c b/arch/sparc/kernel/cas_emu_3=
2.c
> new file mode 100644
> index 000000000000..257f528d9a2c
> --- /dev/null
> +++ b/arch/sparc/kernel/cas_emu_32.c
> @@ -0,0 +1,117 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Emulation of the V9 casa compare-and-swap for V8 CPUs.
> + *
> + * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
> + *
> + * sun4m implements no compare-and-swap at all, only ldstub and swap, an=
d
> + * casa is optional on LEON. Where it is missing, casa is an undefined o=
pcode
> + * and raises illegal_instruction (tt 0x02).
> + *
> + * Both immediate ASIs a compiler emits are accepted: 0x80, the V9 prima=
ry
> + * address space, and 0x0A, which gcc -mcpu=3Dleon3 uses. The opcode is
> + * unimplemented wherever this runs, so the ASI carries no distinction t=
he
> + * emulated CAS has to honour.
> + *
> + * The register-ASI form is not emulated: it reads %asi, which V8 does n=
ot
> + * have. casxa is a 64-bit CAS and is meaningless on a 32-bit CPU.
> + *
> + * The CAS takes the futex ops' lock, so it is atomic against them and
> + * against itself, but not against a plain store to the same word.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/sched/signal.h>
> +#include <linux/mm.h>
> +#include <linux/uaccess.h>
> +#include <linux/ptrace.h>
> +#include <asm/futex.h>
> +#include <asm/ptrace.h>
> +
> +#include "entry.h"
> +#include "unimp_32.h"
> +
> +#define CASA_OP                3       /* insn[31:30] */
> +#define CASA_OP3       0x3c    /* insn[24:19] */
> +
> +#define ASI_P          0x80
> +#define ASI_LEON       0x0a
> +
> +/* A fault returns -EFAULT, and the caller pages the word in. */
> +static int cas_try(u32 __user *uaddr, u32 cmp, u32 newval, u32 *oldval)
> +{
> +       int ret;
> +
> +       pagefault_disable();
> +       ret =3D futex_atomic_cmpxchg_inatomic(oldval, uaddr, cmp, newval)=
;
> +       pagefault_enable();
> +       return ret;
> +}
> +
> +/*
> + * Returns 1 if the trap was consumed, either by emulating the CAS and
> + * advancing the PC or by delivering a fault signal for a bad address, a=
nd 0
> + * if this is not a casa we emulate, in which case the caller raises SIG=
ILL.
> + */
> +int try_emulate_casa(struct pt_regs *regs, unsigned int insn)
> +{
> +       unsigned int rd, rs1, rs2, asi;
> +       unsigned long addr;
> +       u32 cmp, newval, old;
> +       int fault =3D 0, ret;
> +
> +       if ((insn >> 30) !=3D CASA_OP)
> +               return 0;
> +       if (((insn >> 19) & 0x3f) !=3D CASA_OP3)
> +               return 0;
> +       if (insn & (1 << 13))                   /* i =3D=3D 1: register A=
SI */
> +               return 0;
> +       asi =3D (insn >> 5) & 0xff;
> +       if (asi !=3D ASI_P && asi !=3D ASI_LEON)
> +               return 0;
> +
> +       rd =3D (insn >> 25) & 0x1f;
> +       rs1 =3D (insn >> 14) & 0x1f;
> +       rs2 =3D insn & 0x1f;
> +
> +       unimp_flush_windows(rs1, rs2, rd);
> +
> +       addr =3D unimp_get_reg(rs1, regs, &fault);
> +       cmp =3D unimp_get_reg(rs2, regs, &fault);
> +       newval =3D unimp_get_reg(rd, regs, &fault);
> +       if (fault)
> +               goto sigsegv;
> +
> +       if (addr & 3) {                         /* CAS is naturally align=
ed */
> +               send_sig_fault(SIGBUS, BUS_ADRALN, (void __user *)addr, c=
urrent);
> +               return 1;
> +       }
> +       if (!access_ok((void __user *)addr, sizeof(u32)))
> +               goto sigsegv;
> +
> +       while ((ret =3D cas_try((u32 __user *)addr, cmp, newval, &old)) =
=3D=3D -EFAULT) {
> +               /*
> +                * Page the word in writably and retry, as
> +                * fault_in_user_writeable() does.
> +                */
> +               struct mm_struct *mm =3D current->mm;
> +               int fx;
> +
> +               mmap_read_lock(mm);
> +               fx =3D fixup_user_fault(mm, addr, FAULT_FLAG_WRITE, NULL)=
;
> +               mmap_read_unlock(mm);
> +               if (fx)
> +                       goto sigsegv;
> +       }
> +
> +       if (unimp_put_reg(rd, old, regs))
> +               goto sigsegv;
> +
> +       regs->pc =3D regs->npc;
> +       regs->npc +=3D 4;
> +       return 1;
> +
> +sigsegv:
> +       send_sig_fault(SIGSEGV, SEGV_MAPERR, (void __user *)addr, current=
);
> +       return 1;
> +}
> diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
> index c746c0fd5d6b..2eb2b0be90df 100644
> --- a/arch/sparc/kernel/entry.h
> +++ b/arch/sparc/kernel/entry.h
> @@ -14,6 +14,7 @@ void handler_irq(int irq, struct pt_regs *regs);
>  void do_hw_interrupt(struct pt_regs *regs, unsigned long type);
>  void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
>                              unsigned long npc, unsigned long psr);
> +int try_emulate_casa(struct pt_regs *regs, unsigned int insn);
>
>  void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
>                           unsigned long npc, unsigned long psr);
> diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
> index e1d50820c376..69851b19766a 100644
> --- a/arch/sparc/kernel/traps_32.c
> +++ b/arch/sparc/kernel/traps_32.c
> @@ -109,6 +109,8 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned l=
ong type)
>  void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsi=
gned long npc,
>                             unsigned long psr)
>  {
> +       unsigned int insn;
> +
>         if (psr & PSR_PS) {
>                 const struct exception_table_entry *entry;
>
> @@ -126,6 +128,11 @@ void do_illegal_instruction(struct pt_regs *regs, un=
signed long pc, unsigned lon
>                regs->pc, *(unsigned long *)regs->pc);
>  #endif
>
> +       if (!get_user(insn, (unsigned int __user *)pc)) {
> +               if (try_emulate_casa(regs, insn))
> +                       return;
> +       }
> +
>         send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, current);
>  }
>
> diff --git a/arch/sparc/kernel/unimp_32.h b/arch/sparc/kernel/unimp_32.h
> new file mode 100644
> index 000000000000..9ab1705b9d04
> --- /dev/null
> +++ b/arch/sparc/kernel/unimp_32.h
> @@ -0,0 +1,71 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
> + */
> +#ifndef _SPARC_UNIMP_32_H
> +#define _SPARC_UNIMP_32_H
> +
> +#include <linux/uaccess.h>
> +#include <asm/ptrace.h>
> +
> +/*
> + * Operand access for instructions completed out of do_illegal_instructi=
on().
> + *
> + * Like maybe_flush_windows() in unaligned_32.c this has to be inlined: =
the
> + * save/restore chain must run in the trapping window, not one level dee=
per
> + * behind a call, or the outermost user window is left un-flushed and
> + * try_to_clear_window_buffer() kills the task on its next fork.
> + */
> +static __always_inline void unimp_flush_windows(unsigned int rs1,
> +                                               unsigned int rs2,
> +                                               unsigned int rd)
> +{
> +       if (rs1 >=3D 16 || rs2 >=3D 16 || rd >=3D 16)
> +               __asm__ __volatile__("save %sp, -0x40, %sp\n\t"
> +                                    "save %sp, -0x40, %sp\n\t"
> +                                    "save %sp, -0x40, %sp\n\t"
> +                                    "save %sp, -0x40, %sp\n\t"
> +                                    "save %sp, -0x40, %sp\n\t"
> +                                    "save %sp, -0x40, %sp\n\t"
> +                                    "save %sp, -0x40, %sp\n\t"
> +                                    "restore; restore; restore; restore;=
\n\t"
> +                                    "restore; restore; restore;\n\t");
> +}
> +
> +/*
> + * Globals and outs come from pt_regs, locals and ins from the flushed w=
indow
> + * on the user stack. %g0 reads as zero.
> + */
> +static inline unsigned long unimp_get_reg(unsigned int reg,
> +                                         struct pt_regs *regs, int *faul=
t)
> +{
> +       struct reg_window32 __user *win;
> +       unsigned long val;
> +
> +       if (reg < 16)
> +               return reg ? regs->u_regs[reg] : 0;
> +
> +       win =3D (struct reg_window32 __user *)regs->u_regs[UREG_FP];
> +       if (get_user(val, &win->locals[reg - 16])) {
> +               *fault =3D 1;
> +               return 0;
> +       }
> +       return val;
> +}
> +
> +/* %g0 discards the result. */
> +static inline int unimp_put_reg(unsigned int reg, unsigned long val,
> +                               struct pt_regs *regs)
> +{
> +       struct reg_window32 __user *win;
> +
> +       if (reg < 16) {
> +               if (reg)
> +                       regs->u_regs[reg] =3D val;
> +               return 0;
> +       }
> +       win =3D (struct reg_window32 __user *)regs->u_regs[UREG_FP];
> +       return put_user(val, &win->locals[reg - 16]);
> +}
> +
> +#endif /* _SPARC_UNIMP_32_H */
> --
> 2.47.3
>


Tested on a real SPARCstation 20, on both a HyperSPARC and a
SuperSPARC-II module, neither has hardware casa. A hand-encoded casa
instruction completes correctly instead of SIGILL on both.

I also verified the key property this series depends on: userspace
casa-based locking and real FUTEX_LOCK_PI/UNLOCK_PI callers correctly
serialize on the same lock word under contention (40000/40000 ops,
zero lost, on both CPUs).

Tested-by: Magnus Lindholm <linmag7@gmail.com>

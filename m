Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23423B27C9
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 09:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791104722; cv=pass; b=MBRga6DgHhiO514BJCYkacBSyPOUQ+xfby5UViJyktmdDOKWWor2uwWKEwAN8SpF3SeOb3Asb9rxRGmUxYSqCVNKPRWTnozpsR8QlofZ5cNkScd41Laj2lGzK+sxFP81yPuZVRLrSZ4ZnnVon7hzFOIRFYn2VTXuuUji8SMidmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791104722; c=relaxed/simple;
	bh=Md3eVMFMNjS4x/y9MdWU2A1HQjTNlRJ8suqFtL2iTGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TNZVDoa5EpEeoSjiis/m74DHLhVBYUXgFU+pjwGorsQjG7DaovaCWbzUPtetnBR83k5iEWbGwqdWKD8EjBqFmTHvdp6V/6IBW8PBSP4H5LmC7yntH6bZ5reFq6W1L/a+9aBJZSxsMcZpU//J0WBbgdVBN/KyxYsh3pmYbQ7mSxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0VQYSoZ; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0VQYSoZ"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6af9befd04cso1180882a12.2
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 02:05:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791104719; cv=none;
        d=google.com; s=arc-20260327;
        b=c1C998mUfolzfE6kzYA1SCosC60Vi5yaaNFDS70vBLlmAi0Uk7FGCe/TTJ6o+EPzyT
         2Co3A9TI1jg9yDxCXL//02VlDDldt4tT69T3lGznTGAn72bQN+AUS7jUf30M66p8SO0/
         pXpRyMDGwO94ceeNlvRSZX/devR4MnX7UdK5Rp8v6mCJ9luVaXRVK9WixL47a8vUzPdj
         5XAGFUv5xveSR7156q38bSLJLjIYOsvuC6VPfF9vSluaBeahlyg7S+FQxYHAbBC77ePX
         q7nnAhO+F965p/O/R20gmr8ObMlRJRAjlc/lKwtyGCw5b3Q47rSiXpoBqvjbcNesYZVC
         ualg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WHZw58du1+z3AjNtEPV+ML/gwcbQQio5oIr/dAa76uU=;
        fh=YizxEt+raAQZdZ5AkbcQUXwyuxTwAGaBzddkTIRjCag=;
        b=kT8V5cYYAaB5dfB7paYgdua4F0SobjWWT0I6GS1UCGJtJ75g0N1S3nXXr6QQaJYGmX
         MH8WYMDtA5iG6ZDmqWPSNOstkFokdrh55OltuUWBUR6L366pjR2RUYJpbRgqnG8zO6EY
         TYowKT1wVf5JAXeP2VLtTFWn0+BLIv0sPGp8cb5xIicBJJDqHjTfl0UAH1WrF0vV3BG7
         fAlHV68/Xo0eQ37mmJBhkPfLuWR7E7M3AlpU8ZqEmuJyJQzcEWZh0r0/JaR5uvDQHnwL
         SSJcX91ubtd00z4oHiNzVFEC/Moq1DeqD1G2wM4KibhIGnd2gKM3gSejbTUVnA1gj+eA
         A5Fg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791104719; x=1791709519; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WHZw58du1+z3AjNtEPV+ML/gwcbQQio5oIr/dAa76uU=;
        b=J0VQYSoZ3rWc/FAzQU3TllIzYQeBPaWCoR6VfyWr2Js6mpCQoBlD2YFOoRx8h5aoPx
         nrKJQ4JGh1vuSMCtoUB4MlrSwlD22j5AvjStM57Ghu6JHAPyYm1RI88SVH3m0l+PvtHi
         SJ8ZFujyKkqbVaAkr3DEFC5ebxiS/5J+oolDN3XGi24P83qUqCaFk6AIoAXqH7BOslAV
         lrMa4W9kWZ9NEVsWNruW7yTCGnWgW24QIBxqvJGwaiqd82WB4uRbYLN0H5y++6KHXcKn
         JXcwawGoBSvwvktYCfAOFsGLlo3c7NWK/HsDGeQIiNy0fW1wJe7azd/pFPj5tIdJg4Yy
         MsKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791104719; x=1791709519;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WHZw58du1+z3AjNtEPV+ML/gwcbQQio5oIr/dAa76uU=;
        b=sKTl3KSr2WrDRN9XpFIpeUu1eGFZ9VHiDC1bJexHQnQSuIFwGucozp++nzIoU3WbHU
         QnjUlbX+wjz+10DeSEEJ+oO3g9ktyQyF3hsvwKgYBJOfujOPSsEm5e+i7QJd4m7k8zOr
         r1mvcfi5wDdiZHKmQpy3DdBx/paubgHJd+LQT8vntnmhQ8/Gnlv4monCEG/pLNMEZcXU
         82oRYrfKjZVz5NhgTmBXpwKjLjEXnQouJ5DCGByX9oQmhj3zQUDJ1K7vovqnc/HY1tqy
         MfXgUpd0fLG0I7VPCW+Quu17DWgfNuV6bse7619vBSWzjxGjTDbXbgL28xT6chtGGBj0
         K4nQ==
X-Forwarded-Encrypted: i=1; AKwUvBwGrx01hc2EFHxQvAvePQeFOFZ5FN3fiRMBAdlCia2m7lsS9+Q4VRb7DJIO9kuqIMxkjjc717dN7tfa@vger.kernel.org
X-Gm-Message-State: AFq9FYI5PHtHhammBQlgHiyrsMY0n/PTPLlic0R0p71aYi5IKSkGSvz1
	8tPF+P9iAObjGjH/bDN66X2RyU+Q17AXDcckgPNy/Efbmgn4BixgghozI0ENrZqs2O9zr1zk33I
	g7SMNJcLD3HwbdNYhBgNVH0CmuqemURk=
X-Gm-Gg: AYBFou1wiobZDULDHPTVHH6SsA3QLYxmcrnSxHgU/qA90LTaoUbbpFJtPAHnGJoJlSv
	5I9WFn7qjyTqsCkVCRwJXxjdzjk/7h1S+EX3mxFle0pYlQWIcPQO/wJtqn5f6/ng5Qko/q1dIjz
	vaBRS2rcsPrAtit5eOcNkfK4fSb1zaysCbfPi19e1T8bw3iejRweyhFtj/lyPTqhQEm85rjmCWH
	pMZ4r2afLa4RCOrLGO4y4Z9gEn1CUC1kdBXWUSoBpAW84A9OyzohWC2vwK/AaqM0EmbnrHKi3tV
	x0FBvW/IRAcI26sAI3oxzKFjXrmpLiW7MxEvBmnrwBBxT4lekFZGsPGvUtb9Tt0PAKJE2ulqGWC
	TpQ3Zlu+D4WiAuZOmNq8f5jkO3e/L4NUSe9gsxaE/Dw==
X-Received: by 2002:a05:6402:4020:b0:6aa:9fd4:35fb with SMTP id
 4fb4d7f45d1cf-6afad8cd8f0mr4371450a12.8.1791104718721; Sun, 04 Oct 2026
 02:05:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005821.8369-1-kaloz@kernel.org> <20260927005821.8369-4-kaloz@kernel.org>
In-Reply-To: <20260927005821.8369-4-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 4 Oct 2026 11:05:07 +0200
X-Gm-Features: AclHuK-DCkXdzly_4kVOkpuer8jTshhCLwSKLrwW6TM9YcPaLvNihMwHwTNI6u8
Message-ID: <CA+=Fv5RBuL-DP-P1k-+c_CahtEB4h=2dkg2Y9D=X6vd_AMsF0w@mail.gmail.com>
Subject: Re: [PATCH 3/3] sparc32: emulate integer divide taken as illegal_instruction
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> SuperSPARC and SuperSPARC-II implement a 52-bit by 32-bit integer divide
> and raise illegal_instruction for udiv and sdiv when the 64-bit dividend
> {Y, rs1} has significant bits above bit 51, as the SuperSPARC II
> Addendum documents, so whether a divide traps depends on its operands.
> gcc emits udiv under -mcpu=3Dv8, including in libgcc's __udivdi3, so
> 64-bit division in user code on these CPUs dies with SIGILL.
>
> Complete udiv and sdiv, and their -cc forms, from
> do_illegal_instruction(), sharing the windowed-operand helpers with the
> casa emulation. A CPU that executes the instruction never reaches the
> handler, nor does a kernel-mode illegal instruction. A fault reading a
> windowed operand raises SIGSEGV, as the casa emulation does. On overflow
> the quotient saturates to 0xffffffff for udiv and to 0x7fffffff or
> 0x80000000 for sdiv, and the -cc forms set V, as the architecture
> specifies.
>
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/kernel/Makefile     |   1 +
>  arch/sparc/kernel/div_emu_32.c | 127 +++++++++++++++++++++++++++++++++
>  arch/sparc/kernel/entry.h      |   1 +
>  arch/sparc/kernel/traps_32.c   |   3 +
>  4 files changed, 132 insertions(+)
>  create mode 100644 arch/sparc/kernel/div_emu_32.c
>
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index fbea79a4ab58..43e15b46b8dd 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_SPARC32)   +=3D systbls_32.o
>  obj-y                   +=3D time_$(BITS).o
>  obj-$(CONFIG_SPARC32)   +=3D windows.o
>  obj-$(CONFIG_SPARC32)   +=3D cas_emu_32.o
> +obj-$(CONFIG_SPARC32)   +=3D div_emu_32.o
>  obj-y                   +=3D cpu.o
>  obj-$(CONFIG_SPARC32)   +=3D devices.o
>  obj-y                   +=3D ptrace_$(BITS).o
> diff --git a/arch/sparc/kernel/div_emu_32.c b/arch/sparc/kernel/div_emu_3=
2.c
> new file mode 100644
> index 000000000000..208b4071a525
> --- /dev/null
> +++ b/arch/sparc/kernel/div_emu_32.c
> @@ -0,0 +1,127 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Imre Kaloz <kaloz@kernel.org>
> + *
> + * SuperSPARC and SuperSPARC-II implement a 52-bit by 32-bit integer div=
ide
> + * and raise illegal_instruction for udiv and sdiv when the dividend {Y,=
 rs1}
> + * has significant bits above bit 51. Complete those divides here.
> + *
> + * Format 3 (op =3D 2), op3 0x0e udiv, 0x0f sdiv, plus 0x10 for the form=
s that
> + * set %icc. {Y, rs1} / rs2 saturates on overflow and leaves Y alone.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/sched/signal.h>
> +#include <linux/uaccess.h>
> +#include <asm/ptrace.h>
> +#include <asm/psr.h>
> +
> +#include "entry.h"
> +#include "unimp_32.h"
> +
> +int try_emulate_div(struct pt_regs *regs, unsigned int insn)
> +{
> +       unsigned int op3, rd, rs1, rs2;
> +       unsigned long r1, r2, result =3D 0;
> +       int fault =3D 0, is_signed, cc, ovf =3D 0;
> +
> +       if ((insn >> 30) !=3D 2)
> +               return 0;
> +       op3 =3D (insn >> 19) & 0x3f;
> +       switch (op3) {
> +       case 0x0e: case 0x0f: case 0x1e: case 0x1f:
> +               break;
> +       default:
> +               return 0;
> +       }
> +       is_signed =3D op3 & 0x01;
> +       cc =3D op3 & 0x10;
> +
> +       rd =3D (insn >> 25) & 0x1f;
> +       rs1 =3D (insn >> 14) & 0x1f;
> +       rs2 =3D (insn & (1 << 13)) ? 0 : (insn & 0x1f);
> +
> +       unimp_flush_windows(rs1, rs2, rd);
> +
> +       r1 =3D unimp_get_reg(rs1, regs, &fault);
> +       if (insn & (1 << 13)) {                 /* i =3D=3D 1: sign-exten=
ded simm13 */
> +               long simm =3D insn & 0x1fff;
> +
> +               if (simm & 0x1000)
> +                       simm |=3D ~0x1fffL;
> +               r2 =3D (unsigned long)simm;
> +       } else {
> +               r2 =3D unimp_get_reg(rs2, regs, &fault);
> +       }
> +       if (fault) {
> +               /* A windowed operand could not be read from the user sta=
ck. */
> +               send_sig_fault(SIGSEGV, SEGV_MAPERR,
> +                              (void __user *)regs->u_regs[UREG_FP], curr=
ent);
> +               return 1;
> +       }
> +
> +       if ((unsigned int)r2 =3D=3D 0) {
> +               send_sig_fault(SIGFPE, FPE_INTDIV,
> +                              (void __user *)regs->pc, current);
> +               return 1;
> +       }
> +       if (is_signed) {
> +               long long num =3D ((long long)(int)regs->y << 32) |
> +                               (unsigned int)r1;
> +
> +               /*
> +                * INT64_MIN / -1 is undefined in C; the quotient is +2^6=
3,
> +                * a positive overflow.
> +                */
> +               if (num =3D=3D LLONG_MIN && (int)r2 =3D=3D -1) {
> +                       result =3D 0x7fffffff;
> +                       ovf =3D 1;
> +               } else {
> +                       long long q =3D num / (int)r2;
> +
> +                       if (q > 2147483647LL) {
> +                               result =3D 0x7fffffff;
> +                               ovf =3D 1;
> +                       } else if (q < -2147483647LL - 1) {
> +                               result =3D 0x80000000;
> +                               ovf =3D 1;
> +                       } else {
> +                               result =3D (unsigned long)(unsigned int)q=
;
> +                       }
> +               }
> +       } else {
> +               unsigned long long num =3D
> +                       ((unsigned long long)(unsigned int)regs->y << 32)=
 |
> +                       (unsigned int)r1;
> +               unsigned long long q =3D num / (unsigned int)r2;
> +
> +               if (q > 0xffffffffULL) {
> +                       result =3D 0xffffffff;
> +                       ovf =3D 1;
> +               } else {
> +                       result =3D (unsigned long)(unsigned int)q;
> +               }
> +       }
> +
> +       if (unimp_put_reg(rd, result, regs)) {
> +               send_sig_fault(SIGSEGV, SEGV_MAPERR,
> +                              (void __user *)regs->u_regs[UREG_FP], curr=
ent);
> +               return 1;
> +       }
> +
> +       if (cc) {
> +               unsigned long psr =3D regs->psr & ~PSR_ICC;
> +
> +               if (result & 0x80000000)
> +                       psr |=3D PSR_N;
> +               if (result =3D=3D 0)
> +                       psr |=3D PSR_Z;
> +               if (ovf)
> +                       psr |=3D PSR_V;
> +               regs->psr =3D psr;
> +       }
> +
> +       regs->pc =3D regs->npc;
> +       regs->npc +=3D 4;
> +       return 1;
> +}
> diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
> index 2eb2b0be90df..4911cfd07d60 100644
> --- a/arch/sparc/kernel/entry.h
> +++ b/arch/sparc/kernel/entry.h
> @@ -15,6 +15,7 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned lon=
g type);
>  void do_illegal_instruction(struct pt_regs *regs, unsigned long pc,
>                              unsigned long npc, unsigned long psr);
>  int try_emulate_casa(struct pt_regs *regs, unsigned int insn);
> +int try_emulate_div(struct pt_regs *regs, unsigned int insn);
>
>  void do_priv_instruction(struct pt_regs *regs, unsigned long pc,
>                           unsigned long npc, unsigned long psr);
> diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
> index 69851b19766a..f9050dee0f1c 100644
> --- a/arch/sparc/kernel/traps_32.c
> +++ b/arch/sparc/kernel/traps_32.c
> @@ -131,6 +131,9 @@ void do_illegal_instruction(struct pt_regs *regs, uns=
igned long pc, unsigned lon
>         if (!get_user(insn, (unsigned int __user *)pc)) {
>                 if (try_emulate_casa(regs, insn))
>                         return;
> +               /* SuperSPARC traps divides wider than 52 bits. */
> +               if (try_emulate_div(regs, insn))
> +                       return;
>         }
>
>         send_sig_fault(SIGILL, ILL_ILLOPC, (void __user *)pc, current);
> --
> 2.47.3
>

I guess I already responded to this before, but I've now had some
more time to do proper testing of this full series, I've tested
this on a real dual SuperSPARC-II SPARCstation 20, which genuinely
traps on this condition. Checked UDIV/SDIV across the overflow-
saturation boundary in both directions, including INT64_MIN / -1
(the one case easy to get backwards), a zero divisor combined with
an erratum-triggering dividend (correctly raises SIGFPE), and
UDIVCC's condition codes for both a zero and a nonzero quotient.
10/10 correct, matching the V8 semantics my own already-upstream
divide-emulation patch targets.

Tested-by: Magnus Lindholm <linmag7@gmail.com>

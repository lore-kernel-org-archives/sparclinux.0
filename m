Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438942E4257
	for <sparclinux@vger.kernel.org>; Sun,  4 Oct 2026 08:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103884; cv=pass; b=gFM4xXpoutUkXTedQ/TufA5MAN8vi1VXQiPcuCu+KaBkZCxTNUukU8fwpHMHDAXxOeZDNPWh5cpowvTOt806qU3aVQQOHx8JoAeSLglTMaNw/ozMHDIG5K/EoYWd8z4MiTk9UzkA7JtrCn0cKJB6KR91zvGdKm99rSUZckgybRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103884; c=relaxed/simple;
	bh=a3dq4F5hZcch0kXBpQkEeinaRCHGax4kQvnENoiYn/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MHlbPN8I1oZXlOCmsFoiIkoXDOrEk3v3YbFyZesmvZTd8v4qTqZyZocN3gkwY/hOQkr7/l/jeUa4//LyPP0845FoF1uYT3/cC46kdjWYZ18taH8ZGxrw3rdIIzGhlQIwWJfZJ4QhlsDHVD4MtWq+UJA3kV90FaW9rgeYGglTs4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f9TyHVYP; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f9TyHVYP"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2e62319cfaso71460366b.2
        for <sparclinux@vger.kernel.org>; Sun, 04 Oct 2026 01:51:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791103879; cv=none;
        d=google.com; s=arc-20260327;
        b=V1/6uasQP+6WuOjZd0I43jhDVewtHjSJtnBnXQTGBpkWthqoOdGb0HPojhrczzCh67
         6vU/f5vSK+jdG4dmTOP1+a48mptsQR3ZO2pGhPKJVPN8Cy9zB25tfDdkrVjj2l6QQXl3
         uO5DShAkyl9H/gmR36i4GYdi75+4tpoY6aMXEGW/aCXiW6DOXUmxrddNQXCaANTxweWk
         mW1ZIDOBOkkxhXsymUmjzLcUH5IT2/uikf1MZAp9xne4EDLPeYaPUb7wvAKe8qqYzu8O
         8EQTinVQu8Z9OvxKC4OKkF246fe65HZdB7/LYclBNDqfaXHf/tJmcuLfINM0r6LqrZ4C
         ZFdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IE3W/S+XItDaS0v98Y+ZUAiffd5bjG5l0VA34Ly11+M=;
        fh=nLtMBa0z4XnxKewoJRZfVDClU1DrFzxI93K4T5eJAFU=;
        b=ZHiLE0ITVnbmq9EKUqJc/X7X/1LtkVqTuSn9JAiAUiKKt1W+jtAEbSC+uvLnqdXLDi
         vO2bUvaLGuDXwpbyithuYqQC6K/XEGN4Y0I/1B64HzlWQKf/oo6TEEvy+14QdNSfuifT
         7lRl4DGI15W27JXeqEY3bXrcqnrykKHxvrvxBDQvD5OsDP5oyhqSgsMs4kxN9wFuoDOr
         3aj15zwgodEpmPpIHUQSa4sQnjqRpWrw5PP4OAMqNdm49RytXLJvfl1O8POfV+orvuhJ
         mgU1mGZguwxv8kAnyNZx0AQOsvHCDWlV3f3KFSX/SDQV7Z3FVo8A0tN9b8lMMk4HrgmH
         KsPw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791103879; x=1791708679; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IE3W/S+XItDaS0v98Y+ZUAiffd5bjG5l0VA34Ly11+M=;
        b=f9TyHVYPwZPuID0bEQBBMQ+acvHfO2TAS3TyEvQeMmySB5xFHrnAFHrq1qex0zhQfR
         oQ4kM5p/Q1NvLrVhP9VIwh4UGSEaf4sY8TDyUNGghz21meuD/iSPD2LBj8SAVqpbEyTl
         1UvWMPmPu2I0fsrsr6CJ2HgSlOHinlRBwkj2wLzzYanSb0PaLOU1bwkjBe1P+QwloG7Y
         rKFg8K6n9P6I6+pRobOBw9ui7pJM3JBlC1xW2fzcKyH8opkzlnuquOi5GeF5CzzazCe9
         u29X+yO/LxvNFy/EEjP/+eipG0/O25RnA5jf75n+PRoQNZ6xwLsoa/zSMMje5ExQK9dK
         UG7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791103879; x=1791708679;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IE3W/S+XItDaS0v98Y+ZUAiffd5bjG5l0VA34Ly11+M=;
        b=J8xIflnXi6RftQUZUMunrxwif1iSFqCE9D6RQ6tZFLJ8j26G3WlaHUcbyHCAxIb+88
         5rXcutWUCHAqDINIi3bRgNf++VCSNBR6T7if7KrzL9ldGwY7yJvfI32JxP6jEUsQizCu
         GFtBAzqP1lEuuWA3kJPsd95lIyHz5lIg+gxtp7P0Indwu8vTulDmcNzLLXjcBAVdoZOm
         Rgr3hcTfSvbEi0h5u5kdqLYpzFJlxQj2iH0uUbj8TD5vjzPKgF4wxHzlywNpc7f/NzXd
         eyUrf3skm87aVN++6fsyNcIsBNxLuRGzfuyqWCZi/9iBFpAjVAYS+bSTwPEaup2Td6Tz
         HXBg==
X-Forwarded-Encrypted: i=1; AKwUvBz4xhVi6TxraK4jtlNVCtmwnxwWZcQ+qa7FrE2ZDl5889olkh9z1rHQGAtC7kZQ00oDf6iVMKGhMt1I@vger.kernel.org
X-Gm-Message-State: AFq9FYKPe1OwnNW8BI3c12EZiwALA/AaX+DmYswEbiDzUs2h9FzLk+U8
	VNylp5KZFYiRo2wFa5idG1i9M4BeKojBWgtOnOWlmKd1VbAwAXMqVnh+Uv9smbFe3SgOqat/qsy
	OAdJWXeruJc7bU+MTxsDVMHE8j2hxIkCMoccK
X-Gm-Gg: AYBFou0pj5RMZDdetDVFVgsG8mYx2KlS723SpCQQ6MPY5XxFWC1kEAVTxZ0y52PH9/6
	TNcgVB3ZaZ1HAKx4mX8FbARI4CiPxX0YF0pF7paEcQk6t2niTEM5TA6YGTS+CVsF5PPNsyd3jnv
	CMhc14o0ZH/ame46urgQGOPO2pILPUJc7ypzy43bfyNp8en6lHwYE40BgQ133q3QbybcXL9/CsC
	lD6CA4GsJmC6NRnk57/Nyy9hxpnV/83vHkxUdpK5DqVRN+Jp0jjnsrHnjebEgWeCHlmgk7LcYcp
	HoHMo3xXMWS7Etqo6KEsKIn0I0XlSAF7AOVvhmCVE1fgb8gGOic/b1rBmjMjsualiZ5lVryzmwe
	karbn1IgeEzsLPoK6UjM1khWOJ+SulVh4a3uNU391KQ==
X-Received: by 2002:a05:6402:4595:b0:6ab:e30:c9ac with SMTP id
 4fb4d7f45d1cf-6afad732328mr3533378a12.6.1791103879028; Sun, 04 Oct 2026
 01:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005821.8369-1-kaloz@kernel.org> <20260927005821.8369-2-kaloz@kernel.org>
In-Reply-To: <20260927005821.8369-2-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sun, 4 Oct 2026 10:51:07 +0200
X-Gm-Features: AclHuK9KY8WlCdIqvjnP4WQZk1D_MtjB20nxukAu_h3NNW66dw1F-VEMknyuhjU
Message-ID: <CA+=Fv5SMMMa=tBKkanp0xp9ZU6FtxqJiqgOShotmRs9QNXjuzQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] sparc32: support futexes on SMP
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> asm-generic/futex.h provides the futex atomic ops for UP only, so FUTEX
> has depended on !(SPARC32 && SMP).
>
> Implement them in atomic32.c for both. LEON parts that implement casa
> run it on the user word, as user code updates the word with casa there
> and takes no kernel lock. Other CPUs have no compare-and-swap; the ops
> serialize on __atomic_hash, which lets a kernel emulation of user casa
> share the lock.
>
> casa is optional on LEON, so it is probed once at boot. On a part
> without it the kernel-mode illegal_instruction is fixed up from the
> exception table.
>
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>
> ---
>  arch/sparc/include/asm/futex_32.h |   6 +-
>  arch/sparc/kernel/traps_32.c      |  13 +++-
>  arch/sparc/lib/atomic32.c         | 122 ++++++++++++++++++++++++++++++
>  init/Kconfig                      |   1 -
>  4 files changed, 139 insertions(+), 3 deletions(-)
>
> diff --git a/arch/sparc/include/asm/futex_32.h b/arch/sparc/include/asm/f=
utex_32.h
> index 6a332a9f099c..2271aad566f8 100644
> --- a/arch/sparc/include/asm/futex_32.h
> +++ b/arch/sparc/include/asm/futex_32.h
> @@ -1,6 +1,10 @@
>  #ifndef _ASM_FUTEX_H
>  #define _ASM_FUTEX_H
>
> -#include <asm-generic/futex.h>
> +#include <linux/types.h>
> +
> +int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user=
 *uaddr);
> +int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> +                                 u32 oldval, u32 newval);
>
>  #endif
> diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
> index bb149f6cc34b..e1d50820c376 100644
> --- a/arch/sparc/kernel/traps_32.c
> +++ b/arch/sparc/kernel/traps_32.c
> @@ -11,6 +11,7 @@
>   */
>
>  #include <linux/cpu.h>
> +#include <linux/extable.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sched/debug.h>
>  #include <linux/mm_types.h>
> @@ -108,8 +109,18 @@ void do_hw_interrupt(struct pt_regs *regs, unsigned =
long type)
>  void do_illegal_instruction(struct pt_regs *regs, unsigned long pc, unsi=
gned long npc,
>                             unsigned long psr)
>  {
> -       if(psr & PSR_PS)
> +       if (psr & PSR_PS) {
> +               const struct exception_table_entry *entry;
> +
> +               /* The casa probe on a CPU without casa. */
> +               entry =3D search_exception_tables(pc);
> +               if (entry) {
> +                       regs->pc =3D entry->fixup;
> +                       regs->npc =3D regs->pc + 4;
> +                       return;
> +               }
>                 die_if_kernel("Kernel illegal instruction", regs);
> +       }
>  #ifdef TRAP_DEBUG
>         printk("Ill instr. at pc=3D%08lx instruction is %08lx\n",
>                regs->pc, *(unsigned long *)regs->pc);
> diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
> index 8ae880ebf07a..be712c2917d5 100644
> --- a/arch/sparc/lib/atomic32.c
> +++ b/arch/sparc/lib/atomic32.c
> @@ -9,8 +9,13 @@
>   */
>
>  #include <linux/atomic.h>
> +#include <linux/futex.h>
> +#include <linux/init.h>
>  #include <linux/spinlock.h>
>  #include <linux/module.h>
> +#include <linux/uaccess.h>
> +#include <asm/cpu_type.h>
> +#include <asm/futex.h>
>
>  #ifdef CONFIG_SMP
>  #define ATOMIC_HASH_SIZE       4
> @@ -195,3 +200,120 @@ unsigned long __xchg_u32(volatile u32 *ptr, u32 new=
)
>         return (unsigned long)prev;
>  }
>  EXPORT_SYMBOL(__xchg_u32);
> +
> +/* Only some LEON parts implement casa. */
> +static bool sparc32_casa __ro_after_init;
> +
> +static int __casa_user(u32 *uval, u32 __user *uaddr, u32 oldval, u32 new=
val)
> +{
> +       /*
> +        * casa [%o0] 0xb, %o1, %o2, as a word any assembler accepts. ASI
> +        * 0x0b is the supervisor address space; the emulated casa in
> +        * cas_emu_32.c instead accepts the user ASIs 0x0a and 0x80.
> +        */
> +       register u32 __user *uaddr_r asm("o0") =3D uaddr;
> +       register u32 oldval_r asm("o1") =3D oldval;
> +       register u32 newval_r asm("o2") =3D newval;
> +       int ret =3D 0;
> +
> +       __asm__ __volatile__(
> +       "1:     .word   0xd5e20169\n"
> +       "2:\n"
> +       "       .section .fixup,#alloc,#execinstr\n"
> +       "       .align  4\n"
> +       "3:     sethi   %%hi(2b), %0\n"
> +       "       jmpl    %0 + %%lo(2b), %%g0\n"
> +       "        mov    %4, %0\n"
> +       "       .previous\n"
> +       "       .section __ex_table,#alloc\n"
> +       "       .align  4\n"
> +       "       .word   1b, 3b\n"
> +       "       .previous\n"
> +       : "+r" (ret), "+r" (newval_r)
> +       : "r" (uaddr_r), "r" (oldval_r), "i" (-EFAULT)
> +       : "memory");
> +
> +       *uval =3D newval_r;
> +       return ret;
> +}
> +
> +/* Without casa the illegal_instruction trap takes the fixup above. */
> +static int __init sparc32_casa_probe(void)
> +{
> +       u32 word =3D 0, val;
> +
> +       if (sparc_cpu_model =3D=3D sparc_leon)
> +               sparc32_casa =3D !__casa_user(&val, (u32 __force __user *=
)&word,
> +                                           0, 1);
> +       return 0;
> +}
> +early_initcall(sparc32_casa_probe);
> +
> +/*
> + * Without casa, user CAS is emulated under the same lock. ATOMIC_HASH()
> + * uses page offset bits only, so every mapping of a word takes one lock=
.
> + */
> +int futex_atomic_cmpxchg_inatomic(u32 *uval, u32 __user *uaddr,
> +                                 u32 oldval, u32 newval)
> +{
> +       unsigned long flags;
> +       u32 val;
> +       int ret;
> +
> +       if (!access_ok(uaddr, sizeof(u32)))
> +               return -EFAULT;
> +       if (sparc32_casa)
> +               return __casa_user(uval, uaddr, oldval, newval);
> +
> +       /* Every caller already runs with page faults disabled. */
> +       spin_lock_irqsave(ATOMIC_HASH(uaddr), flags);
> +       ret =3D __get_user(val, uaddr);
> +       if (!ret && val =3D=3D oldval)
> +               ret =3D __put_user(newval, uaddr);
> +       spin_unlock_irqrestore(ATOMIC_HASH(uaddr), flags);
> +
> +       if (!ret)
> +               *uval =3D val;
> +       return ret;
> +}
> +
> +int arch_futex_atomic_op_inuser(int op, u32 oparg, int *oval, u32 __user=
 *uaddr)
> +{
> +       u32 oldval, newval, val;
> +       int ret;
> +
> +       if (get_user(oldval, uaddr))
> +               return -EFAULT;
> +
> +       for (;;) {
> +               switch (op) {
> +               case FUTEX_OP_SET:
> +                       newval =3D oparg;
> +                       break;
> +               case FUTEX_OP_ADD:
> +                       newval =3D oldval + oparg;
> +                       break;
> +               case FUTEX_OP_OR:
> +                       newval =3D oldval | oparg;
> +                       break;
> +               case FUTEX_OP_ANDN:
> +                       newval =3D oldval & ~oparg;
> +                       break;
> +               case FUTEX_OP_XOR:
> +                       newval =3D oldval ^ oparg;
> +                       break;
> +               default:
> +                       return -ENOSYS;
> +               }
> +
> +               ret =3D futex_atomic_cmpxchg_inatomic(&val, uaddr, oldval=
, newval);
> +               if (ret)
> +                       return ret;
> +               if (val =3D=3D oldval)
> +                       break;
> +               oldval =3D val;
> +       }
> +
> +       *oval =3D oldval;
> +       return 0;
> +}
> diff --git a/init/Kconfig b/init/Kconfig
> index 8583d9f06c52..9eb8086af7db 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -1875,7 +1875,6 @@ config BASE_SMALL
>
>  config FUTEX
>         bool "Enable futex support" if EXPERT
> -       depends on !(SPARC32 && SMP)
>         default y
>         imply RT_MUTEXES
>         help
> --
> 2.47.3
>

Tested on a real SPARCstation 20 (SMP), on both a HyperSPARC and a
SuperSPARC-II module. Raw FUTEX_WAIT/WAKE and FUTEX_LOCK_PI/UNLOCK_PI
all work on both (no more ENOSYS), and an 8-thread pthread_mutex
contention test (1.6M locked increments) finished with zero lost
updates on both CPUs.

Tested-by: Magnus Lindholm <linmag7@gmail.com>

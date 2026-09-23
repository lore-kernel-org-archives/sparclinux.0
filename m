Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888C3498904
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 20:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790195646; cv=pass; b=VU8yKXCNGpCMKvbi20ItTFyV6vxiOPUa6R8EBq3MlgQLhLEo3BSpTrN0Onc5ydFYgbWexrzhDqHGZbOJNeAWhcpHcA+oxpgYfqHXE0aUpkSoNuU8zCiKY1nWiP3AkDem+tvAGg9fFTZY3U3qT0oIcX8k9z6WGA9VFZTPS3m0Pzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790195646; c=relaxed/simple;
	bh=x2KsbWxNcXzDGrxUjPtXA6JMUYxlGrwEtnlKXN9TOj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEjoByb7c3rRhP20Agv1XHf801wRbInQjVNpZa6mDC/GVnZ1XqwWP7u1vatt6QjjXaDis5D0EfmMerXpOoNi1W6VAhr5GxvJbXW1iYjp0Y3T5NdHY5bZavBXADLQlW1l0MpwD2HQjH7nLC1AsKpI25krdo1XBFm7AtfgWGCAshU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MSzf5flg; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MSzf5flg"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2d8facae850so23385ad.0
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 13:34:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790195642; cv=none;
        d=google.com; s=arc-20260327;
        b=D79U6Q2EKGVe/CmELtf6ibqC8GBmF/i5BXdmye/sa/0cn8gr062d65Jh7mkOQBeQe0
         IH+exOG0aGWqmhlJDDmbccCeiJ3Q0/6XZgKri4XeWSt/mZ84vHcNfx9Qn5BOVBO+QZd2
         5keIAr5WM5jZhp8JywWZRkEIlPTk4sj/4ThAOq0hd5zlxuhJWyzic3SFB0skCX9aI5gr
         XVTu45y+PbUyvhabztE2PP4FzQ35KLM/FkcmBZAGpME4Gx0gH0VU/dDuuaMGQWB6DLXw
         0GazMIuo97SkC0kZEDUJ7BeakDSiM3+znVLxwjM+4PRJui491PZbwctD3RU1UakDq99r
         l0pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iRjbWXUWKdI5T5j70ZPijMzoSc0FwXFiL+Py7PH7F4=;
        fh=bsH0hRMLpa4Cj4Sc05RztbsX8UNBxqUwsLHWRq6WEiI=;
        b=NhVTIZP/CYt/j5T6gFlxTFA0pRFNKrp+QLlwJe5pE+iHaZHxB1WUPf2JoLF4g7c55p
         d3woP9HelpyIx7x7dTHb95iReBGWAGfOwKAvTHCFF1Zjn4Ks4oxOuoM00c4lxnTKpmxe
         UN0tcYUaly9tC5gFx0LyjdSi1qhs7XWD6pxIbYShrhfNz6WOZBb5kN/16mBEai7IsBQn
         aXGpGerIKIrcOi7Fa0thTVJdccr0Vkbn6ae0Sp2jslGKvZKXQJbjwGp/C1bf3q9wNtMW
         xkk/HJdc81tF09l5hvogzmb//z+ZQYDjxJ+Y/mp90qod1D6VMSFEmhkI+S2GZ7Snkf3r
         jgSw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790195642; x=1790800442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iRjbWXUWKdI5T5j70ZPijMzoSc0FwXFiL+Py7PH7F4=;
        b=MSzf5flgQ4zcxUOOnu+OwR/YRC6E51dPDWsedFPaYZOIZ6+ZD+BPxm6ghQskoHsS7V
         +WhBoa5GMSF4LYMPBI+KytXB7ORnu/bv9DCM0i7TLxEaQTFdXh/L54pQrVinMtTw4uxc
         tBjS39jspT6+vRG6ts7g6gmp/S4Ea0E0Ea2FX7FA0Au/XA/2BwxI8n1REMZISPWem501
         HLuujeOAKEXlfahxMq4O4x38CfM9tLv8roRG5eYaOutFLwxG9lIIVtwbr1drN8WAn3OP
         tItAl9W34ejYNVFOa2Ui3oCbbF12XR9xOWY0IlidTGHKlpsdQ9qbVq21MFPCfX/+/UXc
         7zkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790195642; x=1790800442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iRjbWXUWKdI5T5j70ZPijMzoSc0FwXFiL+Py7PH7F4=;
        b=P5gamRqlAK0f73lZ03ftAU7Z9r2O8EVkymT/ifB7Oj6H1lSMNvwZaRyFeyeLuHbFN6
         6QDGWNoEYimabEcFsUUan9t0cUNt1iCRGqcDFEqRzV5Z4QJWDT1MkioIv7HDApZGkCA3
         ziA84oMneumcWQBxIPFdRzA+ILZRewVtV0YoKc+27oYgA01/NM3sqVSzoAvNpBA27JN+
         owYRsmNOGUU1hOY2g0I9qK/SSiQWPc79fhtoOoJFqZjIGYp5/aZvHCxGKNWl2y/E0jVT
         nViXcNK0VfNgg63NzPUQcoorDCOx5yyZhKfTntYRxeJFwTJUj5B8E32uGBHTKi1TKydO
         xztA==
X-Forwarded-Encrypted: i=1; AKwUvBzzc63Lenyryy834eM+Ey8fOGNV45e/46seWYt3hKMmevwCNGTqZ981ZwCaDrlgejCeD+Dda+qYr1nI@vger.kernel.org
X-Gm-Message-State: AFuF++nyqummlYuF78linROb/fXPYp0XgQwFQzFW1BSF2JXtvrQsajd3
	asGAU6gfDSULSkh8MBuR86EHK5UTbUFsUfkewL1ZgimNJfTy2bFo4GVgPvoZ1PssBhr2DYFMrEe
	5bcxCP0nitzF/v62GotH0jQjdL1/T8YlTFM29D7wz
X-Gm-Gg: AYBFou39T031T4vKGIzX53uwB4fdL/yqiNbm3uYufzTyVMIcTMJyzlEDVwUK8YJdr9N
	xdD/GQzES7Rfi/2AhDd31wEOoE83WAxhVT2vkMWktjcj2UJbGBLIPZFRTp92zKykmvv51eX6ncE
	CAdHDzf1O2CblV3dDWi1psXkOkacgHVwvwaHv40X5aDa0Z86PQy4gd3KOsFnDOvuFTRkPxUDgrQ
	52bCt6Oxe+vRractvGYbcwAhrOabdA/zkvYjKSYBKbnsS3+QIZL8iB11PxIz2V+fyy6SXXHf2mJ
	7xBOoLAhLUYwEjVMzgazajGB3WvOOqR6DVIRA6PNCtPtz/vxjBVAdYrsQ/n6FK7f1XlMquBVvAc
	7h6qLReXotEXfCr8f9vBU
X-Received: by 2002:a17:902:f543:b0:2d5:db38:800f with SMTP id
 d9443c01a7336-2df7b3e1e8emr1773735ad.14.1790195640940; Wed, 23 Sep 2026
 13:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923193432.2489729-1-stian@itx.no>
In-Reply-To: <20260923193432.2489729-1-stian@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Wed, 23 Sep 2026 13:33:48 -0700
X-Gm-Features: AcwNN1UT7NrgvcNDp1sJnOfbIhVSfmmWr9VKa8r6V-od56OMd3RrgE8WhcMyDkE
Message-ID: <CAP-5=fX2M6ndLGh5GKjiP2eK=tCp_LpE1iVjDH+Nkz5jJVpxqw@mail.gmail.com>
Subject: Re: [PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit task
To: Stian Halseth <stian@itx.no>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 12:34=E2=80=AFPM Stian Halseth <stian@itx.no> wrote=
:
>
> memory_read() hands libdw 8 bytes whatever the sampled task's ABI. For a
> 32-bit task libdw keeps the low 32 bits (__libdwfl_frame_reg_set()), so
> on a big-endian machine each word read from the stack or a DSO is the
> one at addr + 4, and unwinding stops at the first frame restored from
> the stack. On sparc the 8-byte load from a stack address that is only
> 4-byte aligned even traps, and perf dies with SIGBUS. Read 4 bytes for a
> PERF_SAMPLE_REGS_ABI_32 sample.
>
> A recording of the other byte order has each sample swapped in 8-byte
> units when it is read (perf_event__all64_swap()), which leaves the
> 4-byte words of a 32-bit stack dump reversed and paired up wrongly.
> Undo the swap of the unit holding the word and swap the word itself, as
> __evsel__parse_sample() does for PERF_SAMPLE_CPU.
>
> Suggested-by: Ian Rogers <irogers@google.com>
> Signed-off-by: Stian Halseth <stian@itx.no>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
> Ian raised the cross-endian case in review of the sparc64 perf_regs
> series:
> https://lore.kernel.org/all/CAP-5=3DfUuRm3dWra4a-6eNF3F=3DtafcHvvDipqmDEX=
N5+ti-sW0A@mail.gmail.com/
>
> Tested with 32-bit sparc programs (static, dynamic and multithreaded) on
> top of that series, with a local change so perf recognises sparc32plus
> binaries: natively on sparc64 perf died with SIGBUS before and unwinds
> complete chains after; cross-endian on x86 no call chain was complete
> before and all are after. 64-bit unwinding is unchanged in both.
>
> Words read from a DSO rather than the stack dump are still not swapped
> for a recording of the other byte order, whatever the word size, as
> before this change.
>
>  tools/perf/util/unwind-libdw.c | 46 ++++++++++++++++++++++++++++------
>  1 file changed, 39 insertions(+), 7 deletions(-)
>
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 4ccfcc7c2dfc..d49901b1571e 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -4,6 +4,7 @@
>  #include <elfutils/libdw.h>
>  #include <elfutils/libdwfl.h>
>  #include <inttypes.h>
> +#include <byteswap.h>
>  #include <errno.h>
>  #include "debug.h"
>  #include "dso.h"
> @@ -17,6 +18,8 @@
>  #include <linux/types.h>
>  #include <linux/zalloc.h>
>  #include "event.h"
> +#include "evsel.h"
> +#include "memswap.h"
>  #include "perf_regs.h"
>  #include "callchain.h"
>  #include "util/env.h"
> @@ -203,9 +206,10 @@ static bool get_thread(Dwfl *dwfl __maybe_unused, pi=
d_t tid, void *arg,
>  }
>
>  static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
> -                         Dwarf_Word *data)
> +                         Dwarf_Word *data, size_t len)
>  {
>         struct addr_location al;
> +       union u64_swap u;
>         ssize_t size;
>         struct dso *dso;
>
> @@ -218,15 +222,38 @@ static int access_dso_mem(struct unwind_info *ui, D=
warf_Addr addr,
>         if (!dso)
>                 goto out_fail;
>
> -       size =3D dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 =
*) data, sizeof(*data));
> +       size =3D dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 =
*)&u, len);
>
>         addr_location__exit(&al);
> -       return !(size =3D=3D sizeof(*data));
> +       if (size !=3D (ssize_t)len)
> +               return 1;
> +       *data =3D len =3D=3D sizeof(u32) ? u.val32[0] : u.val64;
> +       return 0;
>  out_fail:
>         addr_location__exit(&al);
>         return -1;
>  }
>
> +/*
> + * libdw expects a 32-bit task's words zero-extended.  A recording of th=
e
> + * other byte order was swapped in 8-byte units when it was read (see
> + * perf_event__all64_swap()), so a 4-byte word is picked out of its unit=
 with
> + * that swap undone, as for PERF_SAMPLE_CPU in __evsel__parse_sample().
> + */
> +static Dwarf_Word stack_word(struct stack_dump *stack, int offset, size_=
t len,
> +                            bool swapped)
> +{
> +       union u64_swap u;
> +
> +       if (len =3D=3D sizeof(u64))
> +               return *(Dwarf_Word *)&stack->data[offset];
> +       if (!swapped)
> +               return *(u32 *)&stack->data[offset];
> +
> +       u.val64 =3D bswap_64(*(u64 *)&stack->data[offset & ~7]);
> +       return bswap_32(u.val32[(offset & 4) / 4]);
> +}
> +
>  static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwar=
f_Word *result,
>                         void *arg)
>  {
> @@ -234,11 +261,16 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, =
Dwarf_Addr addr, Dwarf_Word *
>         struct unwind_info *ui =3D dwfl_ui_ti->ui;
>         struct stack_dump *stack =3D &ui->sample->user_stack;
>         u64 start, end;
> +       bool swapped;
> +       size_t len;
>         int offset;
>         int ret;
>
>         if (!ui->sample->user_regs)
>                 return false;
> +       len =3D ui->sample->user_regs->abi =3D=3D PERF_SAMPLE_REGS_ABI_32=
 ?
> +             sizeof(u32) : sizeof(u64);
> +       swapped =3D ui->sample->evsel && ui->sample->evsel->needs_swap;
>
>         ret =3D perf_reg_value(&start, ui->sample->user_regs,
>                              perf_arch_reg_sp(ui->e_machine));
> @@ -248,11 +280,11 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, =
Dwarf_Addr addr, Dwarf_Word *
>         end =3D start + stack->size;
>
>         /* Check overflow. */
> -       if (addr + sizeof(Dwarf_Word) < addr)
> +       if (addr + len < addr)
>                 return false;
>
> -       if (addr < start || addr + sizeof(Dwarf_Word) > end) {
> -               ret =3D access_dso_mem(ui, addr, result);
> +       if (addr < start || addr + len > end) {
> +               ret =3D access_dso_mem(ui, addr, result, len);
>                 if (ret) {
>                         pr_debug("unwind: access_mem 0x%" PRIx64 " not in=
side range"
>                                  " 0x%" PRIx64 "-0x%" PRIx64 "\n",
> @@ -263,7 +295,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dw=
arf_Addr addr, Dwarf_Word *
>         }
>
>         offset  =3D addr - start;
> -       *result =3D *(Dwarf_Word *)&stack->data[offset];
> +       *result =3D stack_word(stack, offset, len, swapped);
>         pr_debug("unwind: access_mem addr 0x%" PRIx64 ", val %lx, offset =
%d\n",
>                  addr, (unsigned long)*result, offset);
>         return true;
>
> base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
> --
> 2.55.0
>

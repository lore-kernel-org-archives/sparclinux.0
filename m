Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8EF415F25
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790109125; cv=pass; b=juN/Qnlt1aXT1BXoCBhGU5v1P11ADW0DvxtnccXDspp7jnuTYzsp7AANgHU9jhMl7IR5Sygnd9k0RrlOgmYMNxEBOtpYXjzH7OaGVc3IrV+IVLRZuMsWzhv6Hw9uRdf3nzePPHzFapmZvo1sw3xLEGT2mVUdXJ4mBIjzBDreFPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790109125; c=relaxed/simple;
	bh=Cqup7AetL9K62WBqnLjsTFdg6y7ugt8kjt4WDduAD5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQIPCfHqngKckL7HFpH0r2Swq81BxzqKhQEL6Emw6tARpBpBUKuatWHfgdZ5sQs9jbYvX3uGqQvkIpBrwnmifEx84LMHBEOaWLrMu1hvIU6/4tOS54+tgPYanYSPpSCrXi1Nwk4xx723o+3Li2Z4+9EA3LOVyS1xh0Rxzc0icZ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W24wP/W8; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W24wP/W8"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53113d72966so15801cf.1
        for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 13:31:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790109116; cv=none;
        d=google.com; s=arc-20260327;
        b=l9CRGwk4UnJlMRsJW1mRu+O0VABvK5qBp4ZhBxokgcfhwtKQTVhJq4tDQalH++VslA
         fQw0GbaXoMxjJV7Z6AZ8eMUeReTPJYvUZja0xrWuL6sbhriUILfQDevSfzHXA2FJeZey
         OK4xL2f0tLWEO3C7aXJpBSSeplY08CPidYgIBZ5puKctHeygojhKLOAJtXsQxdgXn/Vy
         dalZBksPGEQZrNQ/6OkGDjLq9zQTyoDXl05ME49k1xO4DewO1sQBEEYdxUc0GA5Xpo4n
         zue/6T/ECOKpHWwjiNWu64yI4+sgWn062nD0H1/GEQB1tbyPt8GOlg1zVBUCZc3TFmQF
         T3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yt2fVj+D+BZLEuC3IP5IvX5L/bag4MLjrGfCScvwXs8=;
        fh=GF28OTpT+XHNEp6HEp9+qtH8jDlfu7bV6D7mELMMbj0=;
        b=K6lm8DnXJDbCaQrokdxtyz42QjDOEp/VkHVANCRYsAkpwVZSlSzddgtrGUxn2n8IXS
         dD3AXSwB0X5iSHtKVNgPEHLvmgYQ3JlPmZRwqu9GJQWD6GAWxSYwnVzDFETmsTK3JtrP
         KqnpX0qbo3Oo5s2QUcrZWvf+I/tdloe7yN5yzKBQaic/M5xLvlFnNAKqwe/8SZIs1xLq
         i/EhwWz4kat8+RsqTPh03sSid6Kn3i4l2G8+4CJQFVUTvMdSCahUVM/xHd8zahnrCZKx
         CvfH/vdMfPdEZTZpY4ytujTNppW0xfDp6yqIXNyaNvd1eC5CviCqx6bgcC6JG1xTpFws
         1eLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790109116; x=1790713916; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Yt2fVj+D+BZLEuC3IP5IvX5L/bag4MLjrGfCScvwXs8=;
        b=W24wP/W8GCu02xBV7PwFN5dY3O9AT8caymdIUHX82fnCQkCNZOlTkUhZDkGqYhSCFG
         aVvYe14VEAOzeKZLJcWReV5ekaK7gQqYKKbBWJNhstLW4rFxWdNlryFfPE1O9jBg48Lr
         j9XSrUeFxPPb7QiH0/fpFpJ9jNM/3NO5iNNQMUGjvM8WurVejKPCIPbkrHaGRSQ/BOii
         yMKYxX+RacPGOKbzkIYS57TsCscg4cgw0cJGh37VTSoWGXIBGALUWUWxqWNIiieK0uc/
         9GQHNfDLJ6uOBW8Ob7lWoswzbpXo4bm1dEnxjdFJIFUGjK5D7SUrVyO9wATIRhCgiTgF
         tdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790109116; x=1790713916;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Yt2fVj+D+BZLEuC3IP5IvX5L/bag4MLjrGfCScvwXs8=;
        b=swoWrhZL1tLGeOXv+0zK81l6Xac5ak/cX7HrZhR34xNhrF99RRLpJkZnemZsCUTTjd
         0mx1rhKbkGhjkMsw+MAxcNfEmv8EBJ7KJmO8dkX5/AjHWUyCWVt+7sCMP6MGK2THw4Gl
         He7sGFL808g83e81VipaMiKujos6tAHJDEc3SBq7G0rM+ZH+rF/qdE1w6zR6CQntEIB5
         KhVQ9CSAv3888RU8UXdkWOmixL+zpErrbpeASPd73iSawkG1wLRPUl9R1u/nzNI12j95
         r3IGLYKRCGSnSYj+wK4BUAHpfcFEqw9QRLLbQfQpOT0GeRxBNjAjqGhdEDtsAsYOAre3
         JWdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxG+8A7QrADcwsiEIQjo8C1E9GURB1GCeVS+43j7I7jeAaVnZD/iAbQMdSnOz+wopifXm5+JBLmZ/vf@vger.kernel.org
X-Gm-Message-State: AFuF++l67BaqIDtThozvlrsZc60vPtdXO046CX/1c/00/dVBadLJwKwU
	c6mtEudl/mqPgZbVgnqwnHHZ2vNWuCiZQLjpvTl6/AbDzCkXnhqQgJ49jSADFNFLQNQ3Xe7LMt9
	a4g6i1qOWB6LpFG7xtewVLXou6m4QnBqBvhzxQs/q
X-Gm-Gg: AYBFou26ba6LzolFUXoxIB8PX30R1lhACKSTPcZa7QdqrnwRS7YMXma0XBctPm7g6RR
	RgeOJJcpYYVvxmvVZ7lPTvvDF/hAdBiNwG/NHugvkhYhM1u487i0kC9nI/1FD+b6RRgjxRl2XeB
	+nxzAh7ro7U2s1yd/QPhYvbWqi4MfWwas7MSTp8ywUP7esKEq4pGZ8lDqRi0s0kP9Xk65eKxdvp
	vwUE/sLRQHMmK228Br8Du7tT9dO5w62wMS1FL0yavXd4jPXF8LyMKhmb4WzduUBxLGLM3++t2BN
	jWv8GgSsktMMXMX4EwD9pniJLjuAH0GTCdxqmVywwEl8J/7on26BDoV2iiAVCMNwTXzxw4AnTdg
	Gp5GcMrw=
X-Received: by 2002:ac8:5dc7:0:b0:530:2f98:cebb with SMTP id
 d75a77b69052e-532edf82e0dmr343251cf.11.1790109115281; Tue, 22 Sep 2026
 13:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922201507.1719668-1-stian@itx.no> <20260922201507.1719668-4-stian@itx.no>
In-Reply-To: <20260922201507.1719668-4-stian@itx.no>
From: Ian Rogers <irogers@google.com>
Date: Tue, 22 Sep 2026 13:31:42 -0700
X-Gm-Features: AcwNN1W47jisLkjyDbBHkQcLxD_JSYXLb7urv68bHAW4cx9V-8I3vqjOhGxN5Sk
Message-ID: <CAP-5=fWNhJGHnRoz7FrwZO2mOZa4NCi5C3ZsFGrirAE0prj69w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/3] perf tools: Support sparc user register
 samples and dwarf unwinding
To: Stian Halseth <stian@itx.no>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Magnus Lindholm <linmag7@gmail.com>, 
	linux-perf-users@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 1:15=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
> Add the sparc perf_regs tables and the EM_SPARC/EM_SPARCV9 dispatch for
> register names, masks, ip/sp and the perf-to-DWARF register mapping,
> plus the uapi header copy.
>
> For libdw unwinding, seed DWARF registers 16-31 (%l0-%l7, %i0-%i7) from
> the register save area at the top of the stack dump: the kernel flushes
> the sampled window there, and the CFI after `save` needs %i6 and %i7 to
> find the first caller. The dump base on sparc is the biased %sp, so
> read words from the dump with memcpy rather than an aligned
> dereference.
>
> Signed-off-by: Stian Halseth <stian@itx.no>
> ---
>  tools/arch/sparc/include/uapi/asm/perf_regs.h | 33 +++++++++
>  tools/perf/arch/sparc/include/perf_regs.h     | 18 +++++
>  tools/perf/check-headers.sh                   |  1 +
>  tools/perf/util/dwarf-regs-arch/Build         |  1 +
>  .../util/dwarf-regs-arch/dwarf-regs-sparc.c   | 12 ++++
>  tools/perf/util/dwarf-regs.c                  |  4 ++
>  tools/perf/util/include/dwarf-regs.h          |  1 +
>  tools/perf/util/perf-regs-arch/Build          |  1 +
>  .../util/perf-regs-arch/perf_regs_sparc.c     | 69 +++++++++++++++++++
>  tools/perf/util/perf_regs.c                   | 18 +++++
>  tools/perf/util/perf_regs.h                   |  5 ++
>  tools/perf/util/unwind-libdw.c                | 41 ++++++++++-
>  12 files changed, 203 insertions(+), 1 deletion(-)
>  create mode 100644 tools/arch/sparc/include/uapi/asm/perf_regs.h
>  create mode 100644 tools/perf/arch/sparc/include/perf_regs.h
>  create mode 100644 tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
>  create mode 100644 tools/perf/util/perf-regs-arch/perf_regs_sparc.c
>
> diff --git a/tools/arch/sparc/include/uapi/asm/perf_regs.h b/tools/arch/s=
parc/include/uapi/asm/perf_regs.h
> new file mode 100644
> index 000000000000..17f14335d6c0
> --- /dev/null
> +++ b/tools/arch/sparc/include/uapi/asm/perf_regs.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_SPARC_PERF_REGS_H
> +#define _UAPI_ASM_SPARC_PERF_REGS_H
> +
> +/*
> + * Mirrors struct pt_regs.  O6 is %sp as held in the register, i.e. bias=
ed
> + * by 2047 for a 64-bit task.
> + */
> +enum perf_event_sparc_regs {
> +       PERF_REG_SPARC_G0,
> +       PERF_REG_SPARC_G1,
> +       PERF_REG_SPARC_G2,
> +       PERF_REG_SPARC_G3,
> +       PERF_REG_SPARC_G4,
> +       PERF_REG_SPARC_G5,
> +       PERF_REG_SPARC_G6,
> +       PERF_REG_SPARC_G7,
> +       PERF_REG_SPARC_O0,
> +       PERF_REG_SPARC_O1,
> +       PERF_REG_SPARC_O2,
> +       PERF_REG_SPARC_O3,
> +       PERF_REG_SPARC_O4,
> +       PERF_REG_SPARC_O5,
> +       PERF_REG_SPARC_O6,
> +       PERF_REG_SPARC_O7,
> +       PERF_REG_SPARC_TSTATE,
> +       PERF_REG_SPARC_PC,
> +       PERF_REG_SPARC_NPC,
> +       PERF_REG_SPARC_Y,
> +       PERF_REG_SPARC_MAX
> +};
> +
> +#endif /* _UAPI_ASM_SPARC_PERF_REGS_H */
> diff --git a/tools/perf/arch/sparc/include/perf_regs.h b/tools/perf/arch/=
sparc/include/perf_regs.h
> new file mode 100644
> index 000000000000..493fbff9ea16
> --- /dev/null
> +++ b/tools/perf/arch/sparc/include/perf_regs.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef ARCH_PERF_REGS_H
> +#define ARCH_PERF_REGS_H
> +
> +#include <stdlib.h>
> +#include <linux/types.h>
> +#include "../../../../arch/sparc/include/uapi/asm/perf_regs.h"
> +
> +#define PERF_REGS_MASK ((1ULL << PERF_REG_SPARC_MAX) - 1)
> +#define PERF_REGS_MAX  PERF_REG_SPARC_MAX
> +
> +#ifdef __arch64__
> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_64
> +#else
> +#define PERF_SAMPLE_REGS_ABI   PERF_SAMPLE_REGS_ABI_32
> +#endif
> +
> +#endif /* ARCH_PERF_REGS_H */
> diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
> index 531c0e0e84df..f144590f5082 100755
> --- a/tools/perf/check-headers.sh
> +++ b/tools/perf/check-headers.sh
> @@ -42,6 +42,7 @@ declare -a FILES=3D(
>    "arch/mips/include/uapi/asm/perf_regs.h"
>    "arch/powerpc/include/uapi/asm/perf_regs.h"
>    "arch/s390/include/uapi/asm/perf_regs.h"
> +  "arch/sparc/include/uapi/asm/perf_regs.h"
>    "arch/x86/include/uapi/asm/perf_regs.h"
>    "arch/x86/include/uapi/asm/kvm.h"
>    "arch/x86/include/uapi/asm/svm.h"
> diff --git a/tools/perf/util/dwarf-regs-arch/Build b/tools/perf/util/dwar=
f-regs-arch/Build
> index ceb68ae86fd8..bda944029046 100644
> --- a/tools/perf/util/dwarf-regs-arch/Build
> +++ b/tools/perf/util/dwarf-regs-arch/Build
> @@ -6,4 +6,5 @@ perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-mips.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-powerpc.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-riscv.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-s390.o
> +perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-sparc.o
>  perf-util-$(CONFIG_LIBDW) +=3D dwarf-regs-x86.o
> diff --git a/tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c b/tools/p=
erf/util/dwarf-regs-arch/dwarf-regs-sparc.c
> new file mode 100644
> index 000000000000..dd0c80e29764
> --- /dev/null
> +++ b/tools/perf/util/dwarf-regs-arch/dwarf-regs-sparc.c
> @@ -0,0 +1,12 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <errno.h>
> +#include <dwarf-regs.h>
> +#include "../../../arch/sparc/include/uapi/asm/perf_regs.h"
> +
> +int __get_dwarf_regnum_for_perf_regnum_sparc(int perf_regnum)
> +{
> +       if (perf_regnum < PERF_REG_SPARC_G0 || perf_regnum > PERF_REG_SPA=
RC_O7)
> +               return -ENOENT;
> +
> +       return perf_regnum;
> +}
> diff --git a/tools/perf/util/dwarf-regs.c b/tools/perf/util/dwarf-regs.c
> index 797f455eba0d..df9200c31aaa 100644
> --- a/tools/perf/util/dwarf-regs.c
> +++ b/tools/perf/util/dwarf-regs.c
> @@ -217,6 +217,10 @@ int get_dwarf_regnum_for_perf_regnum(int perf_regnum=
, unsigned int machine,
>         case EM_S390:
>                 reg =3D __get_dwarf_regnum_for_perf_regnum_s390(perf_regn=
um);
>                 break;
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               reg =3D __get_dwarf_regnum_for_perf_regnum_sparc(perf_reg=
num);
> +               break;
>         case EM_LOONGARCH:
>                 reg =3D __get_dwarf_regnum_for_perf_regnum_loongarch(perf=
_regnum);
>                 break;
> diff --git a/tools/perf/util/include/dwarf-regs.h b/tools/perf/util/inclu=
de/dwarf-regs.h
> index 46a764cf322f..4a02f30c5604 100644
> --- a/tools/perf/util/include/dwarf-regs.h
> +++ b/tools/perf/util/include/dwarf-regs.h
> @@ -113,6 +113,7 @@ int __get_dwarf_regnum_for_perf_regnum_loongarch(int =
perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_powerpc(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_riscv(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_s390(int perf_regnum);
> +int __get_dwarf_regnum_for_perf_regnum_sparc(int perf_regnum);
>  int __get_dwarf_regnum_for_perf_regnum_mips(int perf_regnum);
>
>  /*
> diff --git a/tools/perf/util/perf-regs-arch/Build b/tools/perf/util/perf-=
regs-arch/Build
> index be95402aa540..47220a2f2dae 100644
> --- a/tools/perf/util/perf-regs-arch/Build
> +++ b/tools/perf/util/perf-regs-arch/Build
> @@ -6,4 +6,5 @@ perf-util-y +=3D perf_regs_mips.o
>  perf-util-y +=3D perf_regs_powerpc.o
>  perf-util-y +=3D perf_regs_riscv.o
>  perf-util-y +=3D perf_regs_s390.o
> +perf-util-y +=3D perf_regs_sparc.o
>  perf-util-y +=3D perf_regs_x86.o
> diff --git a/tools/perf/util/perf-regs-arch/perf_regs_sparc.c b/tools/per=
f/util/perf-regs-arch/perf_regs_sparc.c
> new file mode 100644
> index 000000000000..36d84ddd3a48
> --- /dev/null
> +++ b/tools/perf/util/perf-regs-arch/perf_regs_sparc.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include "../perf_regs.h"
> +#include "../../arch/sparc/include/perf_regs.h"
> +
> +uint64_t __perf_reg_mask_sparc(bool intr __maybe_unused)
> +{
> +       return PERF_REGS_MASK;
> +}
> +
> +const char *__perf_reg_name_sparc(int id)
> +{
> +       switch (id) {
> +       case PERF_REG_SPARC_G0:
> +               return "g0";
> +       case PERF_REG_SPARC_G1:
> +               return "g1";
> +       case PERF_REG_SPARC_G2:
> +               return "g2";
> +       case PERF_REG_SPARC_G3:
> +               return "g3";
> +       case PERF_REG_SPARC_G4:
> +               return "g4";
> +       case PERF_REG_SPARC_G5:
> +               return "g5";
> +       case PERF_REG_SPARC_G6:
> +               return "g6";
> +       case PERF_REG_SPARC_G7:
> +               return "g7";
> +       case PERF_REG_SPARC_O0:
> +               return "o0";
> +       case PERF_REG_SPARC_O1:
> +               return "o1";
> +       case PERF_REG_SPARC_O2:
> +               return "o2";
> +       case PERF_REG_SPARC_O3:
> +               return "o3";
> +       case PERF_REG_SPARC_O4:
> +               return "o4";
> +       case PERF_REG_SPARC_O5:
> +               return "o5";
> +       case PERF_REG_SPARC_O6:
> +               return "sp";
> +       case PERF_REG_SPARC_O7:
> +               return "o7";
> +       case PERF_REG_SPARC_TSTATE:
> +               return "tstate";
> +       case PERF_REG_SPARC_PC:
> +               return "pc";
> +       case PERF_REG_SPARC_NPC:
> +               return "npc";
> +       case PERF_REG_SPARC_Y:
> +               return "y";
> +       default:
> +               return NULL;
> +       }
> +
> +       return NULL;
> +}
> +
> +uint64_t __perf_reg_ip_sparc(void)
> +{
> +       return PERF_REG_SPARC_PC;
> +}
> +
> +uint64_t __perf_reg_sp_sparc(void)
> +{
> +       return PERF_REG_SPARC_O6;
> +}
> diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
> index 558c143abbab..5880b54fd7dc 100644
> --- a/tools/perf/util/perf_regs.c
> +++ b/tools/perf/util/perf_regs.c
> @@ -68,6 +68,10 @@ uint64_t perf_intr_reg_mask(uint16_t e_machine)
>         case EM_S390:
>                 mask =3D __perf_reg_mask_s390(/*intr=3D*/true);
>                 break;
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               mask =3D __perf_reg_mask_sparc(/*intr=3D*/true);
> +               break;
>         case EM_386:
>         case EM_X86_64:
>                 mask =3D __perf_reg_mask_x86(/*intr=3D*/true);
> @@ -111,6 +115,10 @@ uint64_t perf_user_reg_mask(uint16_t e_machine)
>         case EM_S390:
>                 mask =3D __perf_reg_mask_s390(/*intr=3D*/false);
>                 break;
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               mask =3D __perf_reg_mask_sparc(/*intr=3D*/false);
> +               break;
>         case EM_386:
>         case EM_X86_64:
>                 mask =3D __perf_reg_mask_x86(/*intr=3D*/false);
> @@ -154,6 +162,10 @@ const char *perf_reg_name(int id, uint16_t e_machine=
, uint32_t e_flags)
>         case EM_S390:
>                 reg_name =3D __perf_reg_name_s390(id);
>                 break;
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               reg_name =3D __perf_reg_name_sparc(id);
> +               break;
>         case EM_386:
>         case EM_X86_64:
>                 reg_name =3D __perf_reg_name_x86(id);
> @@ -215,6 +227,9 @@ uint64_t perf_arch_reg_ip(uint16_t e_machine)
>                 return __perf_reg_ip_riscv();
>         case EM_S390:
>                 return __perf_reg_ip_s390();
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               return __perf_reg_ip_sparc();
>         case EM_386:
>         case EM_X86_64:
>                 return __perf_reg_ip_x86();
> @@ -244,6 +259,9 @@ uint64_t perf_arch_reg_sp(uint16_t e_machine)
>                 return __perf_reg_sp_riscv();
>         case EM_S390:
>                 return __perf_reg_sp_s390();
> +       case EM_SPARC:
> +       case EM_SPARCV9:
> +               return __perf_reg_sp_sparc();
>         case EM_386:
>         case EM_X86_64:
>                 return __perf_reg_sp_x86();
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index 79be2b791509..3f453d910aa4 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -65,6 +65,11 @@ uint64_t __perf_reg_ip_s390(void);
>  uint64_t __perf_reg_sp_s390(void);
>  int __perf_sdt_arg_parse_op_s390(char *old_op, char **new_op);
>
> +uint64_t __perf_reg_mask_sparc(bool intr);
> +const char *__perf_reg_name_sparc(int id);
> +uint64_t __perf_reg_ip_sparc(void);
> +uint64_t __perf_reg_sp_sparc(void);
> +
>  int __perf_sdt_arg_parse_op_x86(char *old_op, char **new_op);
>  uint64_t __perf_reg_mask_x86(bool intr);
>  const char *__perf_reg_name_x86(int id);
> diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libd=
w.c
> index 63a5c2253174..62484bcd5cd3 100644
> --- a/tools/perf/util/unwind-libdw.c
> +++ b/tools/perf/util/unwind-libdw.c
> @@ -4,7 +4,9 @@
>  #include <elfutils/libdw.h>
>  #include <elfutils/libdwfl.h>
>  #include <inttypes.h>
> +#include <elf.h>
>  #include <errno.h>
> +#include <string.h>
>  #include "debug.h"
>  #include "dso.h"
>  #include <dwarf-regs.h>
> @@ -261,12 +263,44 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, =
Dwarf_Addr addr, Dwarf_Word *
>         }
>
>         offset  =3D addr - start;
> -       *result =3D *(Dwarf_Word *)&stack->data[offset];
> +       memcpy(result, &stack->data[offset], sizeof(*result));
>         pr_debug("unwind: access_mem addr 0x%" PRIx64 ", val %lx, offset =
%d\n",
>                  addr, (unsigned long)*result, offset);
>         return true;
>  }
>
> +/*
> + * The sampled window's %l and %i registers (DWARF 16-31) are not in the
> + * sample; the kernel flushed them to the register save area at the top =
of
> + * the dumped stack.
> + */
> +static void libdw_set_sparc_window_registers(struct unwind_info *ui,
> +                                            struct regs_dump *user_regs,
> +                                            Dwarf_Word *dwarf_regs)
> +{
> +       struct stack_dump *stack =3D &ui->sample->user_stack;
> +       bool abi64 =3D user_regs->abi =3D=3D PERF_SAMPLE_REGS_ABI_64;
> +       size_t wsize =3D abi64 ? sizeof(u64) : sizeof(u32);
> +       u64 sp, offset =3D abi64 ? 2047 : 0;
> +
> +       if (perf_reg_value(&sp, user_regs, perf_arch_reg_sp(ui->e_machine=
)))
> +               return;
> +       if (offset + 16 * wsize > stack->size)
> +               return;
> +
> +       for (int i =3D 0; i < 16; i++) {
> +               const char *p =3D &stack->data[offset + i * wsize];
> +               u32 w32;
> +
> +               if (abi64) {
> +                       memcpy(&dwarf_regs[16 + i], p, sizeof(u64));
> +               } else {
> +                       memcpy(&w32, p, sizeof(w32));
> +                       dwarf_regs[16 + i] =3D w32;
> +               }
> +       }
> +}
> +
>  static bool libdw_set_initial_registers(Dwfl_Thread *thread, void *arg)
>  {
>         struct dwfl_ui_thread_info *dwfl_ui_ti =3D arg;
> @@ -276,6 +310,7 @@ static bool libdw_set_initial_registers(Dwfl_Thread *=
thread, void *arg)
>         int max_dwarf_reg =3D 0;
>         bool ret;
>         uint16_t e_machine =3D ui->e_machine;
> +       bool is_sparc =3D e_machine =3D=3D EM_SPARC || e_machine =3D=3D E=
M_SPARCV9;
>         int e_flags =3D ui->e_flags;
>         uint64_t ip_perf_reg =3D perf_arch_reg_ip(e_machine);
>         Dwarf_Word val =3D 0;
> @@ -295,6 +330,8 @@ static bool libdw_set_initial_registers(Dwfl_Thread *=
thread, void *arg)
>                                 max_dwarf_reg =3D dwarf_reg;
>                 }
>         }
> +       if (is_sparc && max_dwarf_reg < 31)
> +               max_dwarf_reg =3D 31;

Thanks! I think these are great patches! At this point in the code are
you setting max_dwarf_reg so that there's space for the window
registers? I think adding a comment here for clarity would be
worthwhile as it matches up with libdw_set_sparc_window_registers.

Thanks,
Ian

>
>         dwarf_regs =3D calloc(max_dwarf_reg + 1, sizeof(*dwarf_regs));
>         if (!dwarf_regs)
> @@ -313,6 +350,8 @@ static bool libdw_set_initial_registers(Dwfl_Thread *=
thread, void *arg)
>                         }
>                 }
>         }
> +       if (is_sparc)
> +               libdw_set_sparc_window_registers(ui, user_regs, dwarf_reg=
s);
>         if (perf_reg_value(&val, user_regs, ip_perf_reg) =3D=3D 0)
>                 dwfl_thread_state_register_pc(thread, val);
>
> --
> 2.55.0
>

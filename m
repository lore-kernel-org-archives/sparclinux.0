Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61773244687
	for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790096656; cv=pass; b=E0BF6uNTewOIDlL1IYGiukMrb0srvVJ+9+OUg9bAp5IAtHLpj086RuLG9MicsO4S+yvRCh+d6qk5zcBp9LrYL+QijzCBx3BrfsPzEP3at1zFg6J0A1cS3thGjvNiqLVxYzI0MIfQpZh9DgDw/evS/cwlCvPdC/3e/3anDxiisZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790096656; c=relaxed/simple;
	bh=N+17ejK9dvQysXp+TSqhs1pxARNJ/m/mz+8XCJSK0qw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ugyra8yy/GISXCVf9YRgsfToXF0dKqXT/UXW9XR8BqbUNiHaZvSy8Qt/+Jy8Hon1Vf4xNCzb85Re+9/erRFPNWgXnIEeReZ2CWO3FozT3e65TIOQ1ejl7NDXV3ooCdjarvM7KuL4zqXPeLTwkxO98kQLHo87o6HjbYsadOp/+pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=itFrTt1v; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="itFrTt1v"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f55eff0so3916066b.0
        for <sparclinux@vger.kernel.org>; Tue, 22 Sep 2026 10:04:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790096654; cv=none;
        d=google.com; s=arc-20260327;
        b=ZkHMptDe8Y2tAR30UI4YTVkZv+7MVVr0OpKHL0QirjqgqWNsB6THgPrkNTZG+4ohzp
         EBavoy5hOmPcckaGz31afhHhrmbGaQe7ipW9yNPuj8cE/zNrNFv1XXAjHvqf5WA4Ezw1
         mS5ah76ZXZkPVHSr+fddh7jYOqgRr2joe+l+znxnJgXcpVmOLZafnjtEg/57vcIHCa/c
         tsVr3BStCdEGRCclDA3ojM3AfTLObCOop5MeXvznRJIKns7KoxXutWTsCEyRGMxYcyHi
         QUAMwP7cYVzzJniGyTlH76NhankUbntjrbppglh50QnzjA6PDtnXR/pb2G0rwso9HR9s
         tvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oGbbuTvPUpYX589X/WoOVAkQ+2julwkRlp6p5cd8Vfk=;
        fh=WJ8OAnEDl1E6VEGixfsIG7jzxg/EL+LQTjdZUK3gvoY=;
        b=VaHl2qV2yvEwt7tL0Te8AuNNBHj5Et5z6yHYiVfCv8zUDKKNThZ6kjK1ZHeJJI/wUu
         ZwCP5YaDhEmskwZkFjqnlR969iMNYOG/oB0o73zE/MEjQeEVhVdxlv6XSe+Lk/208VTN
         mV4GYL4EjZO26n5WyWYYuHiQI/+2/GTSX9e/03BplYuMIhaIc/9XH6/Ay7JmhsejrIkn
         0dulhtnBRet3KnMDiOJuKSyJmR8/Pp8Qc3DHgTk5pUrug/0QPHuU1VZK9qbznef64imI
         Al/eDW37RW9751HMZLeH/KIZ/DXy9az4ZHAn8OJ33ZiE7YdjEHzIpMCOA0/qv1nx3f7b
         qfPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790096653; x=1790701453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oGbbuTvPUpYX589X/WoOVAkQ+2julwkRlp6p5cd8Vfk=;
        b=itFrTt1vXWt+vheonVNZCzEOUjz8duQuzUNAaxXMCDzlh0/vZt6aZ5YO23MtL2DQve
         lVCg0OCnosMkLGcg92xdfkLqTNy+DeSpYcrQSGYzyFjUW3z3VuGVYpTIk2/R1R4TOXQ5
         eUhOENBf53tL4hTVtt50SsMc8zJATKqdABnbI+q++AjEeZ2qTpls7cWN+mc4n63Ys63o
         86X/iSFqq0jLPQRvCwDdCrISfhpVZoCI80WkBE0Pl7RqedJn1L3yX4AmbTrdhRr4iFtg
         HM1sbqmFzIJc7Zrxthy2gWr7e3ATRzV5IN6lERk/0bvQqx8/kRuFbE9jVrS1Df3Q8RXn
         AXQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790096653; x=1790701453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oGbbuTvPUpYX589X/WoOVAkQ+2julwkRlp6p5cd8Vfk=;
        b=aySPuSIviuHLN2lzW8bONmzcjUtThBWcSRLnsdCzGD1/Jt9691N1edXh7ZAK2JdBYD
         4sEU3QwE3R3gHfGZ6S4nzm6Tt4KnzB7bRCvENrFzxeN0BvpCnsEeFjJELVrukA2tnmCF
         ekSnYVSIRuRdqevCgukrxZ0AMuqLlar7PjABqZvLtXx04v9sx/aQ1iishhqCDi+3Bx+p
         q82T9vgAJz1x1czyd2E7ZVLIWB2jqMY2IXeFGmEF5pKcmq6cP99wcc8xVmk4XEhsPMCh
         WHxcl7WvmktVwM2OfY7/B1dDQWu8OApRFPbxUwtHb3WzYDjW0kKEMJ4NEWXGh+X2QVtZ
         V2wA==
X-Forwarded-Encrypted: i=1; AKwUvByqWp/1GOT9vPj7Oiz5pytFwrCwPEMlfL1e0J28L9s66TbZI7Ehr263INmwC+MANU07KC4UlAcxuJGr@vger.kernel.org
X-Gm-Message-State: AFuF++lRqnCPFQCPuy7DICaPkpiUpZWdoDlG3fPvU28+crnIos/RrUj4
	IBq5qEyIUfLUr70IbhLQduGJvdNObi2BhddOXXnXtzQGu+iNv+Bv2HKplPj3HsC8WJTlWhnx/VB
	pkRIpuXkGi0kHFYndRDlPzBNx6BD9C0g=
X-Gm-Gg: AYBFou15fKooGvHJPaH7j0trCNObc6dMDvJj86oQpakrRWbIGR+AVnv4W2kp1d5AqCK
	3TWoyjLD80blg+d6CANjGqA+239CLtyI7ypp1tX2DUzTv2c4cM9E4++wzNnje9xmxQ9RNRRZEef
	yu94/+lExtB1fESoiytDK4gIyMkCty57wj+rmpyLoQJwClosTkK98Peqospak7GCak4BeFWgDTE
	ARn5kEVfFEiRDoTEeCuHHoOS6uokMThpSw4dVbS1TOWCfyucJ7z1SUAZEYao7CJ6ilNIy/zzAv3
	7ov8vsN/IbZmPNB81OdHwPbC6+7qnPUMIJc5VZ6vhLy4qpzM2DADnJ54TyrytZ+AlOAiawmWp4y
	AOa25wFIlRYLFa3p/7FVypY0szd1Y4j62LVQEIv4s
X-Received: by 2002:a17:906:794f:b0:c24:87e3:b8b8 with SMTP id
 a640c23a62f3a-c2a1569a558mr1259266366b.17.1790096653404; Tue, 22 Sep 2026
 10:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922135653.1622301-1-stian@itx.no>
In-Reply-To: <20260922135653.1622301-1-stian@itx.no>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Tue, 22 Sep 2026 19:04:01 +0200
X-Gm-Features: AclHuK_CUEgpakuA9mXaxlN0HtfMc5v_kwsh8oph45ybTZCltYVIkWHGrzXcUdc
Message-ID: <CA+=Fv5RnsBXnxb2JHfZ2kXkYB7fz3KLS3+oHtx==z9W93WRANA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] perf: user stack dump on sparc64 needs an arch hook
To: Stian Halseth <stian@itx.no>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stian,

On Tue, Sep 22, 2026 at 4:38=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
> I am adding HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP to sparc64, so
> that perf record --call-graph dwarf and elfutils' eu-stackprof work
> there. The sparc side (patch 2) is straightforward and follows parisc.
> One thing does not fit in arch code, and I would like to get the shape
> of that agreed before sending the rest.
>
> The user stack dump copies the stack as it is in memory and assumes the
> call chain is there. On sparc it may not be: the sampled register
> window's %l/%i registers, which hold the frame pointer and return
> address the unwinder starts from (the CFI after `save` defines the CFA
> in terms of %i6), stay in the register file until a window spills. The
> kernel already deals with this wherever it exposes user stack memory:
> perf_callchain_user() on sparc calls flushw_user() before walking the
> chain, and ptrace does the same. The stack dump has no arch entry
> point where that could happen.
>
> I looked for a sparc-only way and did not find a correct one:
>
> - flushing in the sparc PMU interrupt handler misses software events
>   (cpu-clock, tracepoints), which reach perf_event_overflow() without
>   passing through it;
> - perf_user_stack_pointer() is private to kernel/events/internal.h, so
>   the arch cannot override it;
> - perf_reg_abi() is called at the right time but is a query, and a
>   flush as a side effect of it would be wrong.
>
> So patch 1 adds a no-op hook in the style of perf_arch_misc_flags():
> perf_arch_prepare_ustack(), called from perf_prepare_sample() when
> PERF_SAMPLE_STACK_USER is requested and user regs exist. Patch 2 is the
> sparc64 implementation and its user. Happy to take a different name or
> placement.
>
> Tested on an UltraSPARC T4-1 on 7.3-rc4 with a perf tool taught the
> sparc registers (that patch, and the matching elfutils backend, follow
> once the hook is settled): register values check out against known
> contents, and --call-graph dwarf unwinds correctly for both cycles and
> cpu-clock. perf stat/record/record -g are unchanged.
>
> Link: https://github.com/sparclinux/issues/issues/99
>
> Stian Halseth (2):
>   perf/core: Let an arch prepare the user stack before it is dumped
>   sparc64: Support PERF_SAMPLE_REGS_USER and PERF_SAMPLE_STACK_USER
>
>  arch/sparc/Kconfig                      |  2 +
>  arch/sparc/include/asm/perf_event.h     |  3 ++
>  arch/sparc/include/uapi/asm/perf_regs.h | 33 +++++++++++++
>  arch/sparc/kernel/Makefile              |  2 +-
>  arch/sparc/kernel/perf_regs.c           | 65 +++++++++++++++++++++++++
>  include/linux/perf_event.h              |  7 +++
>  kernel/events/core.c                    |  2 +
>  7 files changed, 113 insertions(+), 1 deletion(-)
>  create mode 100644 arch/sparc/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/sparc/kernel/perf_regs.c
>
> --
> 2.55.0
>


Very nice series, thanks for working on this!

I built and booted the series on a sparc64 box and haven't
noticed any regressions so far.

I also smoke-tested the new interfaces from 64-bit userspace with a
small standalone C program using perf_event_open() and software
cpu-clock events. The register-only, stack-only, and combined
register/stack tests all passed. The test does not use tools/perf or
request PERF_SAMPLE_CALLCHAIN. I haven't tested end-to-end DWARF
unwinding yet.

I see that you plan to post the userspace changes once the hook is
settled. Could you include the tools/perf support in the next revision,
or post it as a follow-up or linked companion series? Having that
available, along with a link to the matching elfutils changes, would
make testing easier and let us exercise the intended DWARF unwinding
use case directly.

Also, could you update the sparc entries from TODO to ok in:

  Documentation/features/perf/perf-regs/arch-support.txt
  Documentation/features/perf/perf-stackdump/arch-support.txt

Those updates would fit naturally in patch 2 alongside the
HAVE_PERF_REGS and HAVE_PERF_USER_STACK_DUMP selections.

Thanks,
Magnus

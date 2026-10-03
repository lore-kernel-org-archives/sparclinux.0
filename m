Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4933921FA
	for <sparclinux@vger.kernel.org>; Sat,  3 Oct 2026 17:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791048298; cv=pass; b=ueptRscpD2lm0VrHYSFwMn3AaPrImZHYWGLuTFW8Szur+3KDLQoyUWbOEDEN7pUEiwbY4nQGQd4qeV6o1fLicC+O4Zhy+LuJrjq0TyVx3RsSWzod+GB9JgPtYwmFwEsn4nwPvU/XYeRUltEUooFTvAb1t2iu9YnczzCq9ECuhMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791048298; c=relaxed/simple;
	bh=NvcB03/UfBEDw+SJvs39CUjmPCM1Z+7rSnuluHlZg6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Chd666urvTr8RcTPKhGRyid1cPFJL/4+JqdzB6JQC5Nlf/Gd/5shrU1/0eBLzWFrl9sTbnBF/ZgQLzz4MD93ZGbyUF8MERYptTRpE7YjyHklmLri5tGaPPMXU3L/DFL1cFxA0kAAYs1KIiYVNoyw1GUmLNGsbPZ1FAJLic8VIqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d34TOg9k; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d34TOg9k"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a6063d7dc4so606175a12.3
        for <sparclinux@vger.kernel.org>; Sat, 03 Oct 2026 10:24:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791048294; cv=none;
        d=google.com; s=arc-20260327;
        b=GkuDuild4TBME4W9b+skg3Ks4sbxZyGA/pLDQF5FdNVDVJaNv6F/bQUC/l2KRFve7H
         oVQlAwNGWki6sQPIPUw6TCwuVSxEbQ17R6p3+YJ3hJN4bJoely0EJdKk+PIE9S5AprlY
         JZ1unk1NOgW6Pep0osf6CBWbyjCWhhx8RI7Kvr5rjHPzj3v/5mUDPNZAYc+uP++ZiC27
         aDp00YfgTGmKrkBvIZspjelfzdXSnc42B4komZ4nwbVta5soK6G3Qm9du2pKp0e6GmUc
         V0uyKJ0M4nIZG2KvPTChbzROm0FglK+8lStS8lkUakqtmDOhHl4+p1U4BT1OXFmtXMfA
         yBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uFdyfTKH1tj7mz2/irRhCn3QWgr+wWFYsFTpKuz0Xyg=;
        fh=a5Z+ldDhYGDC+8Xv30Ya3epZOfw57HueYHxpsmHrOYs=;
        b=oBo3UjIZu5uLdsyU9GN4widA8i6uYcJFyeGxDgS+3Fu1nFeGiDeyoCXRjc/s8VztCz
         G8ZL4TgfZbxZ7kj/QnUqcfEp6azX1mb7YKYNgO7xarTrQrusUEezUwkSTJ1dFlX4Qbwf
         s6kQZAL2Zi+Kg5Wm/YDY4HjelYox0ppVR5X4N1HCKyfLX/fTS/eGZAzR6MfZ67ed4Oxw
         JFEKhrAr3d/ut//qG9GHCbc+4HwdvMItGxt9A4CAfxktn5ssuypio7wfyhWgYbOrwQer
         mQwtTL/Y5XxTimKMJJ01lWwbDneurL3a7ryZl/aoVb7ozxcMHiDBnHiUgK58Ab9TSQ0j
         ZSwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791048294; x=1791653094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uFdyfTKH1tj7mz2/irRhCn3QWgr+wWFYsFTpKuz0Xyg=;
        b=d34TOg9kZA1do7hdgPAyJb8VHT2upOut0Cexdi+lpk0rd16cp0gKybIxrMude9tZer
         CdjF7p79TQ0oS+rL9V9gTeoHHMDnBd+ETJg21I4gLCHPGlMy8SdS++lpQOTjgfCWXtmd
         n4ai0qYsK0UoIkVsDGu2hB9VYgBaVIwY+epULcV32rs0MXYDK2dHdWEZCvlumOBKppji
         WGz1G5g4d/BHrAOEFLbtXeTBShFHd+6EIicu53A5s6pE0AO3b6KgI1s948QSBfjv+kTH
         eCEif0/QkcogAqg7vLxtMMtaYIvfRbKupahdGua3NMcALLS1HiPTU9+ddmmcxXYS/U4+
         yHTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791048294; x=1791653094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uFdyfTKH1tj7mz2/irRhCn3QWgr+wWFYsFTpKuz0Xyg=;
        b=kEdMDgfvFoqEA8f77miSVJ9MiqrsWdmULeNw1/9k3oRaMKVY5x9cpBb6dsPzImfzat
         zkn2VGUxu3c4Ku6MhX3vNpa3cLaMk07/BGPA2WdExHOn/nFFUByElzR7rCsSwjE18j9s
         5LvG1Vna4evejNXwkgP8G1zxggzNnI5ZXnDTXZal6vNjEC1bCWo03FnSU7HonT2NLdeT
         M/kxfBQwF1evrQSOZshsWj1AurJXaftx27gFqLnLDaFie3YXic6G2NGjaL1N/fkt8Usl
         XcP4pZEOeCk75iKaNfxtQn3wWekne3RnU4jL3Njih20hye6M3pil8yefuZYEJNhFIkOv
         xN3w==
X-Forwarded-Encrypted: i=1; AKwUvByTrlXBq2iJEzqkkpOuBrOU3Upc3cJv4EFb7WKR/tl9XOEWutg5PI8ACm/pkFXnDicPsEb+XLuOWvBr@vger.kernel.org
X-Gm-Message-State: AFq9FYJQYnv8uYVtybsx+B3RiTXFwtJ8zGoQ4sWy7HPm408Zz3KL1eBm
	ujwDHRFHATFjy/NsZ5CHYsLvVC3fT0iFuhF5aqqyBXMLVS3x06TxSKVV33fvtdRthZOdBpyuCzI
	JI4Rxs1yHohANameTPc4q81pM+T4fp9Q=
X-Gm-Gg: AYBFou1349mvvxQgC9ZEIgEgg58IcMtXEAyKI9rTIVfmwHjMIXtmZb3U4sntq584bWI
	q2JwEfXq4EU+Dc7H8IYgNkudmwNMLIrSgwtF9onfAzzgP6LWHF6Zw4TZnk9mQUU+rC9Cre9wRQY
	iVs2omXYUd9xExUs8wjCTghxySEsyKkqJljfFlrsXYRMtPq2FLe1ijtOfYUnKI7TE8/e7Jz24yc
	t2Y0YN8xSDIPR+yw9QiQEqVK/gD7d5PT7rq177aDICA7iLD+zq9JMrCcdGoddo0DVrpcwAnEicW
	2t3pOnEA+tQPSdLqxhFdC7/d8PbWBlUiDbK68AfWkk0lQhbvcjLNDntLxZomaEXIc5bHKmNpZlZ
	+5a4tevwBzMcyQlX/vpjmTV1SHMMAGcB/PVXbd2m4Jw==
X-Received: by 2002:a05:6402:2349:b0:6aa:ec10:81a6 with SMTP id
 4fb4d7f45d1cf-6af9e2c1a52mr4941597a12.10.1791048294103; Sat, 03 Oct 2026
 10:24:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261003125627.3419702-1-stian@itx.no>
In-Reply-To: <20261003125627.3419702-1-stian@itx.no>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Sat, 3 Oct 2026 19:24:42 +0200
X-Gm-Features: AclHuK_j5RV7QxEWELBdlhZMe-OrkmmSRgKa6Vmvk3LBGY7X-uSoN4QK2WO-tKg
Message-ID: <CA+=Fv5SCMgMpd1tVwhdfwC7QZ-TNRnou3UAdgVjOX425EwF5Ew@mail.gmail.com>
Subject: Re: [PATCH 0/3] sparc64: stale TLB/TSB entries can livelock a thread
To: Stian Halseth <stian@itx.no>
Cc: Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stian,

On Sat, Oct 3, 2026 at 2:56=E2=80=AFPM Stian Halseth <stian@itx.no> wrote:
>
> On a SPARC T7-1 (M7, 256 strands) running up to 256 compiler processes
> in parallel, a thread now and then stops dead: runnable, fixed PC,
> system time climbing, no kernel messages.  One was caught retrying the
> same store for 25 minutes.
>
> Two causes:
>
>  - flush_tlb_fix_spurious_fault() is a no-op on sparc64 (it falls back
>    to flush_tlb_page(), which is empty here), so a write that faults on
>    a stale read-only TLB entry faults again forever.  Same for the PMD
>    hook.
>
>  - tsb_grow() publishes the new TSB before the other CPUs have switched
>    to it, and all flushes go to the new one.  Stale entries survive in
>    the old TSB and are reloaded into the TLB: read-only ones feed the
>    loop above, writable ones for unmapped pages point at freed memory.
>
> A probe in the fault path on the T7-1 showed 128 of 868 spurious faults
> during one toolchain build and test run on a CPU still using an old TSB
> that held the read-only entry, 31 of them repeating on the same thread
> and page.  A SPARC T4-1 (64 strands) shows the same: 143 of 2780.  With
> the series the T7-1 run shows 757 spurious faults, none on an old TSB
> and no repeats, and the build's system time is back from 29 min to 7.
>
> Patch 1 avoids a double flush once the hook does real work, patch 2
> defines the PTE and PMD hooks, patch 3 keeps the old TSB flushable
> until smp_tsb_sync() has returned.
>
> Tested on a T7-1 (sun4v): five consecutive full Go test suite runs
> (make.bash + dist test), once with THP off and once with THP enabled,
> no stalls; a T4-1 runs it as its daily kernel.
> On sun4u (V240, UltraSPARC IIIi) it boots and survives TSB-grow,
> copy-on-write, hugetlb and fork stress with no stale reads.
> Build-tested with CONFIG_SMP=3Dn and without THP/hugetlb.
>
> Tracking issue with the probe patch and the logs:
> https://github.com/sparclinux/issues/issues/108
>
> Stian Halseth (3):
>   sparc64: provide ptep_set_access_flags()
>   sparc64: flush the TLB on a spurious write fault
>   sparc64: keep flushing the old TSB while tsb_grow() switches CPUs
>
>  arch/sparc/include/asm/mmu_64.h      |   5 ++
>  arch/sparc/include/asm/pgtable_64.h  |   3 +
>  arch/sparc/include/asm/tlbflush_64.h |  10 ++++
>  arch/sparc/mm/tlb.c                  |  35 ++++++++++++++
>  arch/sparc/mm/tsb.c                  |  80 +++++++++++++++++++++++++++++=
+-
>  5 files changed, 127 insertions(+), 6 deletions(-)
>

Tested on an M3000 (SPARC64 VII+, eight CPUs) and an Ultra45
(UltraSPARC IIIi, UP). Both booted and passed memory-growth,
COW and remap/protection tests without observed regressions.
The Ultra45 also passed HugeTLB mapping tests.

Counters on the M3000 confirmed execution of the spurious-fault
hook and both old-TSB flush paths. I did not reproduce the original
livelock before patching, and THP was not tested.

The M3000 tests included a separate integration adjustment for
my unmerged Fujitsu support: physical-address conversion in the
four new old-TSB flush paths. Your three patches were unchanged.

So for this series:

Tested-by: Magnus Lindholm <linmag7@gmail.com>

Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3275C77B7E
	for <sparclinux@archiver.kernel.org>; Thu, 25 May 2023 20:08:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbjEYUIZ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 25 May 2023 16:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbjEYUIY (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 25 May 2023 16:08:24 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944C1BB
        for <sparclinux@vger.kernel.org>; Thu, 25 May 2023 13:08:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-338516ea11aso6219395ab.3
        for <sparclinux@vger.kernel.org>; Thu, 25 May 2023 13:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685045299; x=1687637299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwEH9RLMdsbq8mv/836L9d1ukre5dvMmw+kdM+lXLDo=;
        b=Hg6FE4Jhy2Y80PVT3js1Fq3U7ezH34iyRqbVapOC4f93GPFlkePhSN46GevvCB2K8i
         GpJ4zCJO83wc3WsCKPoB2E0dcrw6z6oF85zWBswjT7ucPcWjL2kNOCIAvlv/it/DSU8C
         RX3N2T5uefFwG5jo4/ZsFKt+czPAzun6imnNY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685045299; x=1687637299;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwEH9RLMdsbq8mv/836L9d1ukre5dvMmw+kdM+lXLDo=;
        b=MeVG1oycz0dbmTciExyZOpJbpIWbSggpxG8aF/Cg/hcsYRoB8Ep/bBZSXBY3Ok4djQ
         LObxh2AjIla1Vbe2tIeC55swKVfudwKo7pq8U/cwe5z0afSXSOrPk7mZ4U77mT0ZvfH5
         mYr0yzdQevVfW83DYmgSnJMo8FSDIL2ibu1jLxnmVa0RsYsmuBRH1j+nMY3wEXX0r+y6
         Q/K1qO9/Kg+Zk46V8UcThZwUKdew5fxUd2uouJIFxjvPe3TKAhdFNehw3spqLeglKOq4
         y5tGby3fSiX1kJqcOZtjI/bJo8MU+INROaCBKz97zKgrGbhJYxP8DMd1oerm7vA6VaZT
         k02g==
X-Gm-Message-State: AC+VfDw5rzrY1RhesVNa4/qXULp/nzP5mG2ILv8y9X7sqDSjyYgTYV90
        bVwX435oNphnIuGgGNg14G03smighcEowofkO/Q=
X-Google-Smtp-Source: ACHHUZ4deSJkotOsMrtLv96JklKmFBusGWFoO9TcT4FFX8cU+n78joqs7ALUT3mMR+22vcYs7tF+5w==
X-Received: by 2002:a92:ccc9:0:b0:335:7a0a:3cdd with SMTP id u9-20020a92ccc9000000b003357a0a3cddmr13273070ilq.4.1685045298819;
        Thu, 25 May 2023 13:08:18 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com. [209.85.166.179])
        by smtp.gmail.com with ESMTPSA id t7-20020a92c0c7000000b00331ab6616easm522111ilf.67.2023.05.25.13.08.17
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 13:08:17 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-33828a86ee2so35595ab.0
        for <sparclinux@vger.kernel.org>; Thu, 25 May 2023 13:08:17 -0700 (PDT)
X-Received: by 2002:a05:6e02:1be4:b0:335:12d6:2c7d with SMTP id
 y4-20020a056e021be400b0033512d62c7dmr18774ilv.0.1685045296939; Thu, 25 May
 2023 13:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.14.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid> <ZG-MTPSZakRDl2CP@alley>
In-Reply-To: <ZG-MTPSZakRDl2CP@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 13:08:04 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XNgevGRrD8cAsq03RwDX=n0i6d=4VDxWDKo-g3DQ07dA@mail.gmail.com>
Message-ID: <CAD=FV=XNgevGRrD8cAsq03RwDX=n0i6d=4VDxWDKo-g3DQ07dA@mail.gmail.com>
Subject: Re: [PATCH v5 14/18] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Colin Cross <ccross@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Thu, May 25, 2023 at 9:27=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-05-19 10:18:38, Douglas Anderson wrote:
> > Implement a hardlockup detector that doesn't doesn't need any extra
> > arch-specific support code to detect lockups. Instead of using
> > something arch-specific we will use the buddy system, where each CPU
> > watches out for another one. Specifically, each CPU will use its
> > softlockup hrtimer to check that the next CPU is processing hrtimer
> > interrupts by verifying that a counter is increasing.
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -85,7 +85,7 @@ __setup("nmi_watchdog=3D", hardlockup_panic_setup);
> >
> >  #endif /* CONFIG_HARDLOCKUP_DETECTOR */
> >
> > -#if defined(CONFIG_HARDLOCKUP_DETECTOR_PERF)
> > +#if defined(CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER)
> >
> >  static DEFINE_PER_CPU(atomic_t, hrtimer_interrupts);
> >  static DEFINE_PER_CPU(int, hrtimer_interrupts_saved);
> > @@ -106,6 +106,14 @@ notrace void arch_touch_nmi_watchdog(void)
> >  }
> >  EXPORT_SYMBOL(arch_touch_nmi_watchdog);
> >
> > +void watchdog_hardlockup_touch_cpu(unsigned int cpu)
> > +{
> > +     per_cpu(watchdog_hardlockup_touched, cpu) =3D true;
> > +
> > +     /* Match with smp_rmb() in watchdog_hardlockup_check() */
> > +     smp_wmb();
>
> It is great that you described where the related barrier is.
>
> Another important information is what exactly is synchronized.
> And I am actually not sure what we are synchronizing here.
>
> My understanding is that a write barrier should synchronize
> related writes, for example:
>
>         X =3D ...;
>         /* Make sure that X is modified before Y */
>         smp_wmb();
>         Y =3D ...;
>
> And the related read barrier should synchronize the related reads,
> for example:
>
>         if (test(Y)) {
>                 /*
>                  * Make sure that we use the updated X when
>                  * we saw the updated Y.
>                  */
>                  smp_rmb();
>                  do_something(X);
>          }
>
> IMHO, we do not need any barrier here because we have only
> one variable "watchdog_hardlockup_touched" here.
> watchdog_hardlockup_check() will either see the updated value
> or not. But it does not synchronize it against any other
> variables or values.

Fair. These barriers were present in the original buddy lockup
detector that we've been carrying in ChromeOS but that doesn't
necessarily mean that they were there for a good reason.

Reasoning about weakly ordered memory always makes my brain hurt and I
never feel confident at the end that I got the right answer and, of
course, this is coupled by the fact that if I have a logic error in my
reasoning that it might cause a rare / subtle bug. :( When possible I
try to write code that uses full blown locks to make it easier to
reason about (even if less efficient), but that's not necessarily
possible here. While we obviously don't just want to sprinkle barriers
all over the code, IMO it's not a terrible sin to put a barrier in a
case where it makes it easier to reason about the order of things.

In any case, I guess in this case I would worry about some sort of
ordering race when enabling / disabling the buddy lockup detector. At
the end of the buddy's watchdog_hardlockup_enable() /
watchdog_hardlockup_disable() we adjust the "watchdog_cpus" which
changes buddy assignments. Without a barrier, I _think_ it would be
possible for a new CPU to notice the change in buddies without
noticing the touch. Does that match your understanding? Now when
reasoning about CPUs going online/offline we need to consider this
extra case and we have to decide if there's any chance it could lead
to a false lockup detection. With the memory barriers here, it's a
little easier to think about.

Did the above convince you about keeping the barriers? If so, do you
have any suggested comment that would make it clearer?


> > +}
> > +
> >  static bool is_hardlockup(unsigned int cpu)
> >  {
> >       int hrint =3D atomic_read(&per_cpu(hrtimer_interrupts, cpu));
> > @@ -443,11 +454,15 @@ static enum hrtimer_restart watchdog_timer_fn(str=
uct hrtimer *hrtimer)
> >       struct pt_regs *regs =3D get_irq_regs();
> >       int duration;
> >       int softlockup_all_cpu_backtrace =3D sysctl_softlockup_all_cpu_ba=
cktrace;
> > +     unsigned long hrtimer_interrupts;
> >
> >       if (!watchdog_enabled)
> >               return HRTIMER_NORESTART;
> >
> > -     watchdog_hardlockup_kick();
> > +     hrtimer_interrupts =3D watchdog_hardlockup_kick();
> > +
> > +     /* test for hardlockups */
>
> I would omit the comment. It is not valid when perf detector is used.
> And checking the buddy is clear from the function name.
>
> > +     watchdog_buddy_check_hardlockup(hrtimer_interrupts);
>
> I would personally move this into watchdog_hardlockup_kick().
> watchdog_timer_fn() is already complex enough. And checking
> the buddy when kicking a CPU makes sense.

Sure, I'll add that to my list of things to follow-up with.


> Also I would not pass "hrtimer_interrupts". I guess that it is
> just an optimization. It is an extra churn in the code. IMHO,
> is is not wort it. This code does not need to be super optimized.

The main reason I did it is that "hrtimer_interrupts" is static to
watchdog.c now. If I don't pass it in then I have to make it
non-static and add it to the header. That also means anyone looking at
the variable and figuring out how it is read/written needs to go
search for other people that reference it. I feel like it's cleaner to
just pass it in. If you feel strongly that I should change this then
let me know, but otherwise I'll plan to leave this how I have it.


> >       /* kick the softlockup detector */
> >       if (completion_done(this_cpu_ptr(&softlockup_completion))) {
> > diff --git a/kernel/watchdog_buddy.c b/kernel/watchdog_buddy.c
> > new file mode 100644
> > index 000000000000..fee45af2e5bd
> > --- /dev/null
> > +++ b/kernel/watchdog_buddy.c
> > @@ -0,0 +1,93 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/cpumask.h>
> > +#include <linux/kernel.h>
> > +#include <linux/nmi.h>
> > +#include <linux/percpu-defs.h>
> > +
> > +static cpumask_t __read_mostly watchdog_cpus;
> > +
> > +static unsigned int watchdog_next_cpu(unsigned int cpu)
> > +{
> > +     cpumask_t cpus =3D watchdog_cpus;
>
> A copy should be done by cpumask_copy().
>
> But the question is why a copy would be needed. When called from
> watchdog_buddy_check_hardlockup(), this function is not sychronized
> against the CPU hotplug. And even the copying would be racy.
>
> IMHO, the copy does not help much and we do not need it.
>
> The only important this is that this function would return
> a valid CPU. And I think that it is guarantted because
> CPU0 could not be disabled.

Yup, I'll get rid of the copy.


> > +     unsigned int next_cpu;
> > +
> > +     next_cpu =3D cpumask_next(cpu, &cpus);
> > +     if (next_cpu >=3D nr_cpu_ids)
> > +             next_cpu =3D cpumask_first(&cpus);
> > +
> > +     if (next_cpu =3D=3D cpu)
> > +             return nr_cpu_ids;
> >> +    return next_cpu;
> > +}
> > +
> > +int __init watchdog_hardlockup_probe(void)
> > +{
> > +     return 0;
> > +}
> > +
> > +void watchdog_hardlockup_enable(unsigned int cpu)
> > +{
> > +     unsigned int next_cpu;
> > +
> > +     /*
> > +      * The new CPU will be marked online before the hrtimer interrupt
> > +      * gets a chance to run on it. If another CPU tests for a
> > +      * hardlockup on the new CPU before it has run its the hrtimer
> > +      * interrupt, it will get a false positive. Touch the watchdog on
> > +      * the new CPU to delay the check for at least 3 sampling periods
> > +      * to guarantee one hrtimer has run on the new CPU.
> > +      */
> > +     watchdog_hardlockup_touch_cpu(cpu);
> > +
> > +     /*
> > +      * We are going to check the next CPU. Our watchdog_hrtimer
> > +      * need not be zero if the CPU has already been online earlier.
> > +      * Touch the watchdog on the next CPU to avoid false positive
> > +      * if we try to check it in less then 3 interrupts.
> > +      */
> > +     next_cpu =3D watchdog_next_cpu(cpu);
> > +     if (next_cpu < nr_cpu_ids)
> > +             watchdog_hardlockup_touch_cpu(next_cpu);
>
> Thinking loudly:
>
> This feels racy when many CPUs are enabled/disabled in parallel.
> I am not 100% sure it it can happen though.
>
> My understanding is that it can't happen because the CPU hotplug
> is serialized by cpu_add_remove_lock.
>
> So, this seems to work after all.
>
> > +
> > +     cpumask_set_cpu(cpu, &watchdog_cpus);
> > +}
> > +
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1035,10 +1035,55 @@ config BOOTPARAM_SOFTLOCKUP_PANIC
> >
> >         Say N if unsure.
> >
> > -config HARDLOCKUP_DETECTOR_PERF
> > +# Both the "perf" and "buddy" hardlockup detectors count hrtimer
> > +# interrupts. This config enables functions managing this common code.
> > +config HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> >       bool
> >       select SOFTLOCKUP_DETECTOR
> >
> > +config HARDLOCKUP_DETECTOR_PERF
> > +     bool
> > +     depends on HAVE_HARDLOCKUP_DETECTOR_PERF
> > +     select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> > +
> > +config HARDLOCKUP_DETECTOR_BUDDY
> > +     bool
> > +     depends on SMP
> > +     select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> > +
> > +# For hardlockup detectors you can have one directly provided by the a=
rch
> > +# or use a "non-arch" one. If you're using a "non-arch" one that is
> > +# further divided the perf hardlockup detector (which, confusingly, ne=
eds
> > +# arch-provided perf support) and the buddy hardlockup detector (which=
 just
> > +# needs SMP). In either case, using the "non-arch" code conflicts with
> > +# the NMI watchdog code (which is sometimes used directly and sometime=
s used
> > +# by the arch-provided hardlockup detector).
> > +config HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
> > +     bool
> > +     depends on (HAVE_HARDLOCKUP_DETECTOR_PERF || SMP) && !HAVE_NMI_WA=
TCHDOG
> > +     default y
> > +
> > +config HARDLOCKUP_DETECTOR_PREFER_BUDDY
> > +     bool "Prefer the buddy CPU hardlockup detector"
> > +     depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH && HAVE_HARDLOCKUP_D=
ETECTOR_PERF && SMP
>
> Huh, I have big troubles to scratch my head around this check:
>
>        HAVE_HARDLOCKUP_DETECTOR_NON_ARCH depends on HAVE_HARDLOCKUP_DETEC=
TOR_PERF and SMP
>
>        and this depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH and again
>                on HAVE_HARDLOCKUP_DETECTOR_PERF and SMP.

The goal is to have "HARDLOCKUP_DETECTOR_PREFER_BUDDY" to show up as
an option if there is an option _other_ than the buddy. If there's not
more than one hardlockup detector to pick from then there's no reason
to ask the person configuring the kernel which one they'd prefer. At
the moment, if you have an "arch" lockup detector then you're stuck
with it, so you only get a choice if a "perf" detector is available
and you've got SMP.

Ah, so I guess this could be simplified to:

depends on HAVE_HARDLOCKUP_DETECTOR_PERF && SMP

OK, I'll add that to the list.


> > +     help
> > +       Say Y here to prefer the buddy hardlockup detector over the per=
f one.
> > +
> > +       With the buddy detector, each CPU uses its softlockup hrtimer
> > +       to check that the next CPU is processing hrtimer interrupts by
> > +       verifying that a counter is increasing.
> > +
> > +       This hardlockup detector is useful on systems that don't have
> > +       an arch-specific hardlockup detector or if resources needed
> > +       for the hardlockup detector are better used for other things.
> > +
> > +# This will select the appropriate non-arch hardlockdup detector
> > +config HARDLOCKUP_DETECTOR_NON_ARCH
> > +     bool
> > +     depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH
> > +     select HARDLOCKUP_DETECTOR_BUDDY if !HAVE_HARDLOCKUP_DETECTOR_PER=
F || HARDLOCKUP_DETECTOR_PREFER_BUDDY
> > +     select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF =
&& !HARDLOCKUP_DETECTOR_PREFER_BUDDY
> > +
> >  #
> >  # Enables a timestamp based low pass filter to compensate for perf bas=
ed
> >  # hard lockup detection which runs too fast due to turbo modes.
> > @@ -1053,9 +1098,10 @@ config HARDLOCKUP_CHECK_TIMESTAMP
> >  config HARDLOCKUP_DETECTOR
> >       bool "Detect Hard Lockups"
> >       depends on DEBUG_KERNEL && !S390
>
> Is there any reason why S390 could not or do not want to use the buddy
> hardlockup detector.

This isn't a new dependency, but it's a good question. Looking at the
git history, I see commit dea20a3fbdd0 ("[PATCH] Disable
DETECT_SOFTLOCKUP for s390"). ...and it looks like the softlockup
detector still says it's broken on s390. That would mean that the
buddy detector is broken too.


> > -     depends on HAVE_HARDLOCKUP_DETECTOR_PERF || HAVE_HARDLOCKUP_DETEC=
TOR_ARCH
> > +     depends on HAVE_HARDLOCKUP_DETECTOR_NON_ARCH || HAVE_HARDLOCKUP_D=
ETECTOR_ARCH
> >       select LOCKUP_DETECTOR
> > -     select HARDLOCKUP_DETECTOR_PERF if HAVE_HARDLOCKUP_DETECTOR_PERF
> > +     select HARDLOCKUP_DETECTOR_NON_ARCH if HAVE_HARDLOCKUP_DETECTOR_N=
ON_ARCH
>
> Anyway, the configuration of the hard lockup detectors is insane and
> this patchset makes it even worse, especially the new
> HARDLOCKUP_DETECTOR_NON_ARCH stuff.
>
> It seems that sparc, powerpc and s390 are somehow special. Do you
> still have in mind how they are distinguished using the Kconfig
> variables?
>
> For example, I am pretty confused by the meaning of HAVE_NMI_WATCHDOG.
>
> And sparc has its own variant of
> watchdog_hardlockup_enable()/disable(). It means that it is
> arch-specific. Does it work with the 13th patch which made
> watchdog_hardlockup_enable()/disable() to be watchdog-hardlockup-type
> specific? Is is somehow related to HAVE_NMI_WATCHDOG?
> Does this replace the entire watchdog only only the enable part?
>
> I think that we need to make this more straightforward. But I first
> need to understand the existing maze of config variables.

I agree that it's confusing. I'm obviously biased, but IMO it's less
confusing after my patchset than before. ;-) The state of the world
before my patchset set a pretty low bar.

As far as I understand it, at an architecture-level you can choose any
_ONE_ of the following:

a) Implement bits needed for the the "perf" hardlockup detector. x86
has done this, some configs of powerpc do this, and arm64 now after my
patch series. This is HAVE_HARDLOCKUP_DETECTOR_PERF.

b) Implement your own totally separate hardlockup detector that
doesn't use any of the common "perf" code but still looks the same to
userspace (same sysctls, etc). Only powerpc does this (in some
configs). As per conversations in previous versions of my patch
series, apparently powerpc's version is quite fancy and maybe someday
people can move some of these features to the common code. This is
HAVE_HARDLOCKUP_DETECTOR_ARCH.

c) Don't implement the full features of a hardlockup detector but
still have the basics. In the very least, I think it doesn't support
the sysctls "hardlockup_panic" and "hardlockup_all_cpu_backtrace". It
doesn't support the kernel command line parameter "nmi_watchdog=3D". I
don't know for sure if there are any other differences. Only sparc64
does this. This is HAVE_NMI_WATCHDOG. Confusingly,
HAVE_HARDLOCKUP_DETECTOR_ARCH selects HAVE_NMI_WATCHDOG.

d) Don't implement _any_ hardlockup detector of any sort. After my
patchset you can still end up with "buddy" if you have SMP.


One thing that would probably help would be to bring sparc64 to a full
"arch" hardlockup implementation and then get rid of the special case.
That seems a bit outside my scope, though if someone wanted to post
patches for that I'd be willing to give them a review.

I guess other than that, the best we could try to do is to rename some
configs and/or add some subconfigs to describe certain features? Maybe
HAVE_NMI_WATCHDOG =3D> HAVE_HARDLOCKUP_DETECTOR_ARCH_BASIC_FEATURES
would help? I'd love to come up with a better name for
HAVE_HARDLOCKUP_DETECTOR_NON_ARCH but I couldn't come up with one.
Maybe the unwieldy  "HAVE_HARDLOCKUP_DETECTOR_THAT_COUNTS_HRTIMER"?

If you have concrete suggestions for what would be cleaner, let me
know and I can queue up a patch. ...or I'm happy to review a patch.

-Doug

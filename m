Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA49EB64DC
	for <sparclinux@archiver.kernel.org>; Wed, 21 Jun 2023 23:50:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjFUXub (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 21 Jun 2023 19:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjFUXua (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 21 Jun 2023 19:50:30 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647D171C
        for <sparclinux@vger.kernel.org>; Wed, 21 Jun 2023 16:50:29 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-988e6fc41ccso428562266b.3
        for <sparclinux@vger.kernel.org>; Wed, 21 Jun 2023 16:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687391427; x=1689983427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NhYNZ0vxtpjuX5s0wcMa09N91qzj3byTq4ke4NqIBlc=;
        b=JcGUN7qBgO45ROZWwfF4YxtinCtw4P0shhwl5xpUyD4q/a3pzcpR5Tn++eUoPr0uJU
         S/AnCod7ToEwVr1HvCjEjTC8CKcSZhADFbFRnTRE3w15YorxPqnewtleda6x8XMAndFQ
         Bio0kCmfDu+0CMbYBmbKbtPJrbnx5JBI5AbVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687391427; x=1689983427;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhYNZ0vxtpjuX5s0wcMa09N91qzj3byTq4ke4NqIBlc=;
        b=kDneFOPHbxAyZ9svFTnOTIOG1oXCPFZBUDvfXsDkw23jcnoeHJD40DdshmWgQ1xMBa
         UPICyXRdQoLmLbbjj+vjpFcNAdnss0xtJpc9e7cHdNLsYfzbpeZmdUIVvnwnJ6TGy4Ba
         PilzO5P8a3eDDQElWSuatwyCFF0im4w30IS3vgnVw8z7x7Do4BdjI0WPt38lxdGYT2Dg
         PwAAERXfToXbF06SK46h6hwz0Z/iAE7iAXfGQuF5VoDVKTU/uLImvf8Vt7psu53dgkhz
         TEJOJ9CspTV71i909ZDpZ38Pp4QsMfbAFHoYyv/+y7mUnUcY5uSpdHXHf5pJ53jLlDtg
         7Flg==
X-Gm-Message-State: AC+VfDw0A5YE1FlDQW7FZeYrq6lppUPSR7sVcHXorjt1v82XQQV9NJB2
        2FulcZ6ieiFYdt7q34cKKvCmWwgTMMnDc4pX45YutLjr
X-Google-Smtp-Source: ACHHUZ4edaQO2BEiczcZnse+0u6I5ZzwrX8MrrHgCqh49UYdgoYQE6fP4H1R9s23f6LH6y6B7tVOJQ==
X-Received: by 2002:a17:906:58c5:b0:988:817c:ed59 with SMTP id e5-20020a17090658c500b00988817ced59mr8358485ejs.32.1687391426789;
        Wed, 21 Jun 2023 16:50:26 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id s6-20020a170906a18600b009875a6d28b0sm3818921ejy.51.2023.06.21.16.50.24
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 16:50:25 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-51bcf75c4acso3051a12.0
        for <sparclinux@vger.kernel.org>; Wed, 21 Jun 2023 16:50:24 -0700 (PDT)
X-Received: by 2002:a50:c35e:0:b0:519:7d2:e256 with SMTP id
 q30-20020a50c35e000000b0051907d2e256mr4978edb.0.1687391424164; Wed, 21 Jun
 2023 16:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-7-pmladek@suse.com>
 <871qi5otdh.fsf@mail.lhotse>
In-Reply-To: <871qi5otdh.fsf@mail.lhotse>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 21 Jun 2023 16:50:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XgC0JkjMZjx0z-gt0iXp-UJr87nutB9xWKhB6qMzWWNg@mail.gmail.com>
Message-ID: <CAD=FV=XgC0JkjMZjx0z-gt0iXp-UJr87nutB9xWKhB6qMzWWNg@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Wed, Jun 21, 2023 at 6:08=E2=80=AFAM Michael Ellerman <mpe@ellerman.id.a=
u> wrote:
>
> Petr Mladek <pmladek@suse.com> writes:
> > The HAVE_ prefix means that the code could be enabled. Add another
> > variable for HAVE_HARDLOCKUP_DETECTOR_ARCH without this prefix.
> > It will be set when it should be built. It will make it compatible
> > with the other hardlockup detectors.
> >
> > The change allows to clean up dependencies of PPC_WATCHDOG
> > and HAVE_HARDLOCKUP_DETECTOR_PERF definitions for powerpc.
> >
> > As a result HAVE_HARDLOCKUP_DETECTOR_PERF has the same dependencies
> > on arm, x86, powerpc architectures.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> >  arch/powerpc/Kconfig | 5 ++---
> >  include/linux/nmi.h  | 2 +-
> >  lib/Kconfig.debug    | 9 +++++++++
> >  3 files changed, 12 insertions(+), 4 deletions(-)
>
> Something in this patch is breaking the powerpc g5_defconfig, I don't
> immediately see what though.
>
> ../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98handle_backtrac=
e_ipi=E2=80=99:
> ../arch/powerpc/kernel/stacktrace.c:171:9: error: implicit declaration of=
 function =E2=80=98nmi_cpu_backtrace=E2=80=99 [-Werror=3Dimplicit-function-=
declaration]
>   171 |         nmi_cpu_backtrace(regs);
>       |         ^~~~~~~~~~~~~~~~~
> ../arch/powerpc/kernel/stacktrace.c: In function =E2=80=98arch_trigger_cp=
umask_backtrace=E2=80=99:
> ../arch/powerpc/kernel/stacktrace.c:226:9: error: implicit declaration of=
 function =E2=80=98nmi_trigger_cpumask_backtrace=E2=80=99; did you mean =E2=
=80=98arch_trigger_cpumask_backtrace=E2=80=99? [-Werror=3Dimplicit-function=
-declaration]
>   226 |         nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_b=
acktrace_ipi);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |         arch_trigger_cpumask_backtrace
> cc1: all warnings being treated as errors

Yeah, I can reproduce that.

The problem is that before ${SUBJECT} patch "include/linux/nmi.h"
would include <asm/nmi.h>. Now it won't.

There are a ton of different ways to fix this, but I think the one
that makes sense is to be consistent with other architectures and move
the "arch_trigger_cpumask_backtrace" definitions to asm/irq.h.

https://lore.kernel.org/r/20230621164809.1.Ice67126857506712559078e7de26d32=
d26e64631@changeid

-Doug

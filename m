Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5B3C77B7D
	for <sparclinux@archiver.kernel.org>; Mon,  8 May 2023 01:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjEHBE6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 7 May 2023 21:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjEHBE6 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 7 May 2023 21:04:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03CF1160E;
        Sun,  7 May 2023 18:04:55 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-24df4ef05d4so3555147a91.2;
        Sun, 07 May 2023 18:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683507895; x=1686099895;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+PPFKXX425r8vzKPVM6Zic55f59QA5mguBoW8dBKWo=;
        b=g6nKyzCdl7wTzFzj0LPDCvxv55Fy7TfpGWgO3pV6ij+uOoq81YB2jNTSX5iaFONC1a
         2mmifmqG7gTqnR60RJOMRKTGxfC1MPZOBDnxBxC8EfLhTHJL8AhE1/n2yUOJyPMLC9o/
         uuml0GrB72oOnQcqwCMNQfB2MRnFdMZQT3rB+TP3y0CeS4NjZ5eUYbvjHqlpvDWij0mY
         +Rsmlbec0zcoH6AhBTwgJ1Kv0dXBCznV96/reb0frVyB8K6Y485zWs34lthhXNKMQ7fk
         dmwcTIP128fzDg1lcXBtIwm0yEzMGvicYdNfyIwQCmGboUqYj0oPhBVNRspiaZjXGsoc
         yQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683507895; x=1686099895;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L+PPFKXX425r8vzKPVM6Zic55f59QA5mguBoW8dBKWo=;
        b=Rwn1gDs9Ux87sCcOre1k4ysdM8AdA2GoHVqsnPXWw09eav5Dwyb2uZKyEORPbFqDYp
         8yF0AqyX1Xp2lLH+DAn3xWndfrFcVwOU5RjWqUYBcAimXuvdZjeCR8kHkArDKX/FVkqU
         T6fwK1lWctr0DTzQR/TdwOQma9seevf+JmcMEAjoqfMnbVjcwRAAohYltkWDE/BXXaQ6
         QmPeFC2xY+yDb6Jn+FXSwEdweXYYZcQtlbPh/i+MoPS8k/HGuGO2/L6r1WbIXd62HGGE
         gpGY7tMjkYjMeye2ILJ+3ZD8Pepj2lkrz28HAXwI0SB5nGXG4/zINM4vARjEMBoXXw9J
         lPng==
X-Gm-Message-State: AC+VfDzfmDhcP+Zqcbj4FaZx3yIIAE+JqqUcaUuWvY1MoV0F1OGm2iRC
        S5/jeZskQyuiELDLrg+iVbg=
X-Google-Smtp-Source: ACHHUZ59icTjTc2OdzI15EfiZxFSZ69uNN4QwbtfViigDNmld+b2odQxDB6B0BmyEFVXN9x050Oztw==
X-Received: by 2002:a17:90b:3142:b0:246:f8d7:3083 with SMTP id ip2-20020a17090b314200b00246f8d73083mr8577679pjb.16.1683507895288;
        Sun, 07 May 2023 18:04:55 -0700 (PDT)
Received: from localhost (58-6-235-78.tpgi.com.au. [58.6.235.78])
        by smtp.gmail.com with ESMTPSA id ie14-20020a17090b400e00b0024e1172c1d3sm11713201pjb.32.2023.05.07.18.04.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 May 2023 18:04:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 08 May 2023 11:04:40 +1000
Message-Id: <CSGHQJAJHWVS.1UAJOF8P5UXSK@wheely>
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Doug Anderson" <dianders@chromium.org>
Cc:     "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Sumit Garg" <sumit.garg@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>, <ricardo.neri@intel.com>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        "Masayoshi Mizuma" <msys.mizuma@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <ito-yuichi@fujitsu.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <christophe.leroy@csgroup.eu>,
        <davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <mpe@ellerman.id.au>, "Will Deacon" <will@kernel.org>,
        <ravi.v.shankar@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Colin Cross" <ccross@android.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
 <CSDZSKA38AEF.FY7J3JXBJX4I@wheely>
 <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
In-Reply-To: <CAD=FV=XDfbx3UaP7DV63tASE5Md7siS-EnORD_3T-4yYaEQ7ww@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat May 6, 2023 at 2:35 AM AEST, Doug Anderson wrote:
> Hi,
>
> On Thu, May 4, 2023 at 7:36=E2=80=AFPM Nicholas Piggin <npiggin@gmail.com=
> wrote:
> >
> > On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > > From: Colin Cross <ccross@android.com>
> > >
> > > Implement a hardlockup detector that doesn't doesn't need any extra
> > > arch-specific support code to detect lockups. Instead of using
> > > something arch-specific we will use the buddy system, where each CPU
> > > watches out for another one. Specifically, each CPU will use its
> > > softlockup hrtimer to check that the next CPU is processing hrtimer
> > > interrupts by verifying that a counter is increasing.
> >
> > Powerpc's watchdog has an SMP checker, did you see it?
>
> No, I wasn't aware of it. Interesting, it seems to basically enable
> both types of hardlockup detectors together. If that really catches
> more lockups, it seems like we could do the same thing for the buddy
> system.

It doesn't catch more lockups. On powerpc we don't have a reliable
periodic NMI hence the SMP checker. But it is preferable that a CPU
detects its own lockup because NMI IPIs can result in crashes if
they are taken in certain critical sections.

> If people want, I don't think it would be very hard to make
> the buddy system _not_ exclusive of the perf system. Instead of having
> the buddy system implement the "weak" functions I could just call the
> buddy functions in the right places directly and leave the "weak"
> functions for a more traditional hardlockup detector to implement.
> Opinions?
>
> Maybe after all this lands, the powerpc watchdog could move to use the
> common code? As evidenced by this patch series, there's not really a
> reason for the SMP detection to be platform specific.

The powerpc SMP checker could certainly move to common code if
others wanted to use it.

> > It's all to
> > all rather than buddy which makes it more complicated but arguably
> > bit better functionality.
>
> Can you come up with an example crash where the "all to all" would
> work better than the simple buddy system provided by this patch?

CPU2                     CPU3
spin_lock_irqsave(A)     spin_lock_irqsave(B)
spin_lock_irqsave(B)     spin_lock_irqsave(A)

CPU1 will detect the lockup on CPU2, but CPU3's lockup won't be
detected so we don't get the trace that can diagnose the bug.

Another thing I actually found it useful for is you can easily
see if a core (i.e., all threads in the core) or a chip has
died. Maybe more useful when doing presilicon and bring up work
or firmware hacking, but still useful.

Thanks,
Nick

> It
> seems like they would be equivalent, but I could be missing something.
> Specifically they both need at least one non-locked-up CPU to detect a
> problem. If one or more CPUs is locked up then we'll always detect it.
> I suppose maybe you could provide a better error message at lockup
> time saying that several CPUs were locked up and that could be
> helpful. For now, I'd keep the current buddy system the way it is and
> if you want to provide a patch improving things to be "all-to-all" in
> the future that would be interesting to review.


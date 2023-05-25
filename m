Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47347C7EE29
	for <sparclinux@archiver.kernel.org>; Thu, 25 May 2023 23:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjEYXd1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 25 May 2023 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240106AbjEYXd0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 25 May 2023 19:33:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF43119
        for <sparclinux@vger.kernel.org>; Thu, 25 May 2023 16:33:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-776fee32f12so22249039f.3
        for <sparclinux@vger.kernel.org>; Thu, 25 May 2023 16:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685057602; x=1687649602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3YzCxsRkWRgjvxa97wKSZh7dXjwpqx38ke3QcUo28Gw=;
        b=lbN+JPrMHCqUzqMI9MtbQ2wyIXugiMXiFWfr7XiTUE3P7Q5PQLDTq6bLqnUuurb7Ek
         7s4pLVMafmoEL2i/0wdm/Gd6degeg7BPiOLHMq+T+nv4OMzanvzZkDnhEZhRDbGQBBl/
         JgbiaLuq+P0VXQ/a9v4IUpYVzVgigROLT7uDo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057602; x=1687649602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3YzCxsRkWRgjvxa97wKSZh7dXjwpqx38ke3QcUo28Gw=;
        b=XXCTWUQkSOMVdvcw54euJMnmADjJ/2mLBxGsORszy3Ie7lzmx2zUzz8ioTAxRj/r6X
         vfxINiQlw8iAWEN1xAfXNxXyUIciEGFZaoy+wN2tMkoAbAJ+9r0s4j0j+JAftov60Zbk
         /hr27lirsy3kwQDVIMKe9lPVn6bmImzIYfr8QhfH0GcjQoZ+KepkuTv4KC2SbodJrx4p
         +Fx7n7ypX8BboGQEDHnc0KUGkNT7Aexr3fvnEGZTfVt6unKqsEskWgbUOJR+C/YlJn/z
         QsOjXCbHf1csQJ1bopL2jxprsQWt5z6xYXu8xvHmecxTW3ETGlYG2DWKTsrCfwbpEz01
         XVOQ==
X-Gm-Message-State: AC+VfDwspCY4lCiSsMNyfbIeo3elqmY9TRj8FGyvdW0v8M4OiegrwRjU
        uSxJyK+wtCzwjAbyVE+4aJ9sS8LKKcrH4nuKk+8=
X-Google-Smtp-Source: ACHHUZ4Jym0hdXHxabUHlE8NLtajefOzBMJeBPLxC4bBJNkAUzeVn1ab2tWImbqSzGcHJ7xCPFbY1A==
X-Received: by 2002:a5e:840e:0:b0:766:48cf:6ca9 with SMTP id h14-20020a5e840e000000b0076648cf6ca9mr879088ioj.12.1685057601931;
        Thu, 25 May 2023 16:33:21 -0700 (PDT)
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com. [209.85.166.170])
        by smtp.gmail.com with ESMTPSA id i35-20020a056638382300b00418647d4279sm747079jav.69.2023.05.25.16.33.20
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 16:33:21 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-33a8f766b64so31055ab.1
        for <sparclinux@vger.kernel.org>; Thu, 25 May 2023 16:33:20 -0700 (PDT)
X-Received: by 2002:a05:6e02:1c84:b0:331:a582:1c63 with SMTP id
 w4-20020a056e021c8400b00331a5821c63mr3274ill.3.1685057600304; Thu, 25 May
 2023 16:33:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.12.I91f7277bab4bf8c0cb238732ed92e7ce7bbd71a6@changeid> <ZG4TW--j-DdSsUO6@alley>
In-Reply-To: <ZG4TW--j-DdSsUO6@alley>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 25 May 2023 16:33:08 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vu4BSec-kDxf8oS+DDcb+3W6RS-Z-Ouu-+sRnk2zhSrQ@mail.gmail.com>
Message-ID: <CAD=FV=Vu4BSec-kDxf8oS+DDcb+3W6RS-Z-Ouu-+sRnk2zhSrQ@mail.gmail.com>
Subject: Re: [PATCH v5 12/18] watchdog/hardlockup: Rename some "NMI watchdog" constants/function
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
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Wed, May 24, 2023 at 6:38=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Fri 2023-05-19 10:18:36, Douglas Anderson wrote:
> > Do a search and replace of:
> > - NMI_WATCHDOG_ENABLED =3D> WATCHDOG_HARDLOCKUP_ENABLED
> > - SOFT_WATCHDOG_ENABLED =3D> WATCHDOG_SOFTOCKUP_ENABLED
> > - watchdog_nmi_ =3D> watchdog_hardlockup_
> > - nmi_watchdog_available =3D> watchdog_hardlockup_available
> > - nmi_watchdog_user_enabled =3D> watchdog_hardlockup_user_enabled
> > - soft_watchdog_user_enabled =3D> watchdog_softlockup_user_enabled
> > - NMI_WATCHDOG_DEFAULT =3D> WATCHDOG_HARDLOCKUP_DEFAULT
> >
> > Then update a few comments near where names were changed.
> >
> > This is specifically to make it less confusing when we want to
> > introduce the buddy hardlockup detector, which isn't using NMIs. As
> > part of this, we sanitized a few names for consistency.
> >
> > --- a/kernel/watchdog.c
> > +++ b/kernel/watchdog.c
> > @@ -30,17 +30,17 @@
> >  static DEFINE_MUTEX(watchdog_mutex);
> >
> >  #if defined(CONFIG_HARDLOCKUP_DETECTOR) || defined(CONFIG_HAVE_NMI_WAT=
CHDOG)
> > -# define NMI_WATCHDOG_DEFAULT        1
> > +# define WATCHDOG_HARDLOCKUP_DEFAULT 1
> >  #else
> > -# define NMI_WATCHDOG_DEFAULT        0
> > +# define WATCHDOG_HARDLOCKUP_DEFAULT 0
> >  #endif
> >
> >  unsigned long __read_mostly watchdog_enabled;
> >  int __read_mostly watchdog_user_enabled =3D 1;
> > -int __read_mostly nmi_watchdog_user_enabled =3D NMI_WATCHDOG_DEFAULT;
> > -int __read_mostly soft_watchdog_user_enabled =3D 1;
> > +int __read_mostly watchdog_hardlockup_user_enabled =3D WATCHDOG_HARDLO=
CKUP_DEFAULT;
> > +int __read_mostly watchdog_softlockup_user_enabled =3D 1;
>
> I still see nmi_watchdog_user_enabled and soft_watchdog_user_enabled
> in include/linux/nmi.h. They are declared there and also mentioned
> in a comment.
>
> It seems that they do not actually need to be declared there.
> I guess that it was need for the /proc stuff. But it was
> moved into kernel/watchdog.c by the commit commit dd0693fdf054f2ed37
> ("watchdog: move watchdog sysctl interface to watchdog.c").
>
> >  int __read_mostly watchdog_thresh =3D 10;
> > -static int __read_mostly nmi_watchdog_available;
> > +static int __read_mostly watchdog_hardlockup_available;
> >
> >  struct cpumask watchdog_cpumask __read_mostly;
> >  unsigned long *watchdog_cpumask_bits =3D cpumask_bits(&watchdog_cpumas=
k);
>
> Otherwise, I like the changes.
>
> With the following:
>
> diff --git a/include/linux/nmi.h b/include/linux/nmi.h
> index 83076bf70ce8..d14fe345eae9 100644
> --- a/include/linux/nmi.h
> +++ b/include/linux/nmi.h
> @@ -17,8 +17,6 @@ void lockup_detector_soft_poweroff(void);
>  void lockup_detector_cleanup(void);
>
>  extern int watchdog_user_enabled;
> -extern int nmi_watchdog_user_enabled;
> -extern int soft_watchdog_user_enabled;
>  extern int watchdog_thresh;
>  extern unsigned long watchdog_enabled;
>
> @@ -68,8 +66,8 @@ static inline void reset_hung_task_detector(void) { }
>   * 'watchdog_enabled' variable. Each lockup detector has its dedicated b=
it -
>   * bit 0 for the hard lockup detector and bit 1 for the soft lockup dete=
ctor.
>   *
> - * 'watchdog_user_enabled', 'nmi_watchdog_user_enabled' and
> - * 'soft_watchdog_user_enabled' are variables that are only used as an
> + * 'watchdog_user_enabled', 'watchdog_hardlockup_user_enabled' and
> + * 'watchdog_softlockup_user_enabled' are variables that are only used a=
s an
>   * 'interface' between the parameters in /proc/sys/kernel and the intern=
al
>   * state bits in 'watchdog_enabled'. The 'watchdog_thresh' variable is
>   * handled differently because its value is not boolean, and the lockup
>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
>
> Even better might be to remove the unused declaration in a separate
> patch. I think that more declarations are not needed after moving
> the /proc stuff into kernel/watchdog.c.
>
> But it might also be fixed later.

Breadcrumbs: I squashed your suggestion together with Tom's patch and
posted the result:

https://lore.kernel.org/r/20230525162822.1.I0fb41d138d158c9230573eaa37dc56a=
fa2fb14ee@changeid

-Doug

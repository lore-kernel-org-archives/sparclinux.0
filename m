Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35C9CC433E0
	for <sparclinux@archiver.kernel.org>; Fri, 19 Mar 2021 11:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0422660233
	for <sparclinux@archiver.kernel.org>; Fri, 19 Mar 2021 11:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbhCSL4l (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 07:56:41 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:43769 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhCSL4Z (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 Mar 2021 07:56:25 -0400
Received: from mail-oo1-f44.google.com ([209.85.161.44]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8EdM-1ljAT20eQ4-014DNm; Fri, 19 Mar 2021 12:56:24 +0100
Received: by mail-oo1-f44.google.com with SMTP id r17-20020a4acb110000b02901b657f28cdcso2232918ooq.6;
        Fri, 19 Mar 2021 04:56:23 -0700 (PDT)
X-Gm-Message-State: AOAM531IpywpDCZL5mXIIbiEezdjbyKVHIEn3OBa72DLLxfeeuzdh9yQ
        sH49UHXfs6/AoI0eljJGA2GWeq8sQKgfbi5h6os=
X-Google-Smtp-Source: ABdhPJzd3Z0SvgafgJB3BryuSug06GbHK03nk7pE34toWuK8Akr6j87tVIkrQus7VV/22uXbjsvi3puMlYtcnFpCr/o=
X-Received: by 2002:a4a:8ed2:: with SMTP id c18mr1102738ool.66.1616154982844;
 Fri, 19 Mar 2021 04:56:22 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
 <CAK8P3a3Za8N2-Hs02nG0CcGJ+RcTrR0UqDOesd8E6PmhYRR2_A@mail.gmail.com> <ebf12838-4525-a525-93bd-2229927e50ca@physik.fu-berlin.de>
In-Reply-To: <ebf12838-4525-a525-93bd-2229927e50ca@physik.fu-berlin.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Mar 2021 12:56:06 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2WCYxG4-4x49Uc-+pXPciY5EsDqmNcEfufcXZp6Q3+MQ@mail.gmail.com>
Message-ID: <CAK8P3a2WCYxG4-4x49Uc-+pXPciY5EsDqmNcEfufcXZp6Q3+MQ@mail.gmail.com>
Subject: Re: sparc: clang: error: unknown argument: '-mno-fpu'
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:68NgCvHbLOSRr/cCYSltJEj1he71kT+3gn8cgjnf3IB+dOWhi6s
 ET2DVayqURap6Y8o/jg1cgZH/qtwnxMyZVBQt+7OYJurJdV0sWVKsHUjMRINCJK//kYADU1
 Pay8UWb4MwegdRqMSJJfOZrpkqN/zTS7Uu0NTLKiWJGafUt1zZhSnDCs/nMWoFJYhpDlioT
 XrQ/a8dWrsNVTvCFPwwtQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2ZmDadyOC5U=:2By7NodaNkfmmuEG/EBWQC
 vp3fcNks0aU5kTjT1lDtqBZQOwvRjpC3crSiBEDDgDZqeQrJbPRy5vOQaxqkW8zCsZPeZ7Y8Z
 d2bpUWlMWAPz+3M20Jmkf2oEQNGICPcCU7V5Wt7kOeaFSnvCbRCYWSmDsqmmtwcWaBKFb9ynw
 PFyi6IXS5JAIJcvwS26zkMxdtzcGOGOaqBwFZk7wX0XYghqPQ3XUSfBQ2f/dxjTvuZ2kP9Vy9
 t4lbAkH5MRyg5GwjMUrbjWVi6mqtqACdZ0r0Zht7vc6BAVtkGlGwrVOq2HkaL1/+liUeS8hnb
 bxueyAN6MFIu9pHKG7VU/7pnamI4qzhreQ8AavB0qfdRjqrahqrEBgInJyYiGD8FYWQ2i0wqs
 kSDVRP33wRRuGUapHXw2E8YNqa/yf2UiR3p3EOqOTFLjdwkzaLImuLZ/dQX2F9+ZZPucg8Gog
 sLyetEu5C20tsLfME8Izj6ZMd9m32h2Dg9MQeRbh+U+l2qmpFyPpQ+2TXBlOfuEownMIL2cZ1
 92Lobgu6C+M0ZNpx0Iidx76J3QpbahzxmgUqATAVIxl
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Mar 19, 2021 at 12:38 PM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On 3/19/21 12:31 PM, Arnd Bergmann wrote:
> > On Fri, Mar 19, 2021 at 8:36 AM Naresh Kamboju
> > <naresh.kamboju@linaro.org> wrote:
> >>
> >> Linux mainline master build breaks for sparc defconfig.
> >> There are multiple errors / warnings with clang-12 and clang-11 and 10.
> >>  - sparc (defconfig) with clang-12, clang-11 and clang-10
> >>  - sparc (tinyconfig) with clang-12, clang-11 and clang-10
> >>  - sparc (allnoconfig) with clang-12, clang-11 and clang-10
> >>
> >> make --silent --keep-going --jobs=8
> >> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sparc
> >> CROSS_COMPILE=sparc64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> >> clang'
> >
> > I don't think anyone has successfully built a sparc kernel with clang,
> > and I don't
> > think it's worth trying either, given how little upstream work the
> > sparc port sees overall.
>
> We'll get there. There are some other SPARC-related clang bugs that need
> to be squashed first. We have made quite some improvements and it's actually
> maintained by the community. Of course, we don't have a commercial backer
> but that shouldn't be necessary for open source to work.

I meant there is no point for Naresh to do it as part of his build
testing with tuxmake.
If someone else gets it working, they can tell Naresh to try again, but until
then, I'd limit clang regression testing to x86, arm, powerpc, s390, mips, riscv
and arc.

         Arnd

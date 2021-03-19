Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8B6C433DB
	for <sparclinux@archiver.kernel.org>; Fri, 19 Mar 2021 11:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BBD664F6C
	for <sparclinux@archiver.kernel.org>; Fri, 19 Mar 2021 11:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCSLcd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 19 Mar 2021 07:32:33 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:44903 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbhCSLcR (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 19 Mar 2021 07:32:17 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]) by
 mrelayeu.kundenserver.de (mreue012 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MDeAZ-1lVm4824PP-00Aktk; Fri, 19 Mar 2021 12:32:15 +0100
Received: by mail-ot1-f49.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so8165521ota.9;
        Fri, 19 Mar 2021 04:32:15 -0700 (PDT)
X-Gm-Message-State: AOAM531hTFkD5UpRviTvEZk8k7MmN3VSaBaW9hOeQk5q9T94qch2med0
        Mqh220ctbEI7eCF4r5fQ5g6EeToTtg0lG1A2Jp8=
X-Google-Smtp-Source: ABdhPJzziWzMyp+APwKyslsVmjhbEQ65dTouyXRSCjhbmf6+E7bGpjYyyQ3fQxl3+lX3nRcnhX45UaA7d6TnbRaeIDw=
X-Received: by 2002:a9d:6341:: with SMTP id y1mr791241otk.210.1616153534185;
 Fri, 19 Mar 2021 04:32:14 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
In-Reply-To: <CA+G9fYseDSQ2Vgg5Cb=8HHdpm56aeVQH0Vdx7JK1SktGpRRkgw@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 19 Mar 2021 12:31:57 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3Za8N2-Hs02nG0CcGJ+RcTrR0UqDOesd8E6PmhYRR2_A@mail.gmail.com>
Message-ID: <CAK8P3a3Za8N2-Hs02nG0CcGJ+RcTrR0UqDOesd8E6PmhYRR2_A@mail.gmail.com>
Subject: Re: sparc: clang: error: unknown argument: '-mno-fpu'
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:jCIJn2ixaKElO0GPpK73IT2fpTy+h2VqeNQZuDk658szPLWkXMI
 sT2eLM8OxiTmkSlFHF/05oqBROkwNBnNgy8jPnh6aiqPke2l/OJzMyKC95wkV001QbWkIxY
 lMsa9WmVQ2bx5hi7g5aYxtxQwuDzSV/yLIeek93Nb7Muv47GroVeVlP6UtDqGQ6Fx3Q/gEC
 XIHhyZii41Mf6UKblFtcw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:khtR9LemqXE=:s2dPl6qGySlnuLYj1pSabY
 mIEdQf1o4wi3V7JuD7dP+eft8R/YKDxnd5QEvGmInqPu9eQqO18IfEetDNDCdiAzXGc9KLOYU
 8QIykZRTcpMvaKlkgVURellBdjqL1UinH8yERJWYt6LymJ4BtvRMGI+AuMJElRAcWG6d4Eci2
 wFwbyKa0gymyLTQoA3l7xTCDuFGJipgBelEIt9+ETHsrOYqoMAbGZpmbxC1mjZpDI8hzX5Mop
 euxbazIKJRNW9ado6O9lzTw3pU2CNTvJ/M+cP3Nga1aLV1l8CfmJBTqOl+8bcj26sPlgQFU5f
 dr9YiL3NLtKpKiks331EqEErt5KxPHL+hnyRxt3R5hcVkp092umTF2rJd8xS1niT6O36pSIjz
 EhsuFu4QDSDBVZhm75Kzj/tSIb5MT/6pmbHxGnmCAzxn4mLqGKkeM02O0OqxZ
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Mar 19, 2021 at 8:36 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> Linux mainline master build breaks for sparc defconfig.
> There are multiple errors / warnings with clang-12 and clang-11 and 10.
>  - sparc (defconfig) with clang-12, clang-11 and clang-10
>  - sparc (tinyconfig) with clang-12, clang-11 and clang-10
>  - sparc (allnoconfig) with clang-12, clang-11 and clang-10
>
> make --silent --keep-going --jobs=8
> O=/home/tuxbuild/.cache/tuxmake/builds/1/tmp ARCH=sparc
> CROSS_COMPILE=sparc64-linux-gnu- 'HOSTCC=sccache clang' 'CC=sccache
> clang'

I don't think anyone has successfully built a sparc kernel with clang,
and I don't
think it's worth trying either, given how little upstream work the
sparc port sees
overall.

        Arnd

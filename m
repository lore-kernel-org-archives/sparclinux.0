Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D5BEB64DC
	for <sparclinux@archiver.kernel.org>; Sat,  1 Jul 2023 15:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjGAPBy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 1 Jul 2023 11:01:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjGAPBx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 1 Jul 2023 11:01:53 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE5D35B3
        for <sparclinux@vger.kernel.org>; Sat,  1 Jul 2023 08:01:51 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b6c5ede714so35512061fa.1
        for <sparclinux@vger.kernel.org>; Sat, 01 Jul 2023 08:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688223709; x=1690815709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0wvLshWsSLBZ/5yypeB0xY2a5lfsRQLT8GONX/h7vZc=;
        b=XPPG+skOZC9Gfu5l38nfIqefIdZngA91ganjbznQpINHiRDPge49rAPkZ0lucQWwfl
         HE7DVD0tojBe3/vfNs9VyJd0M3q0XMn+I3BqZhuynVyyj8OOtEi/QySuTLOTjoMVp52V
         JV6nR74tvwjD2kcV4GEEVDFbZtJ2556e1Z19s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688223709; x=1690815709;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0wvLshWsSLBZ/5yypeB0xY2a5lfsRQLT8GONX/h7vZc=;
        b=VOBfdW63Tf85pkM4+TTHwwn8KtoskX9xOiAbd1OixHqL3ZwToQ7kAJV6GvvMZ3MB0j
         H302+XRdptVXbBK58+rdehnLADqXhLHi82klkTVgDCqG1/Fh+I6sCr53AdFJVoMDpWbM
         CcTkqhXoVYg/A+fw2LJ0boA9yf71Rky9e9x9tnJefqezTfKlLlVke5aNWRa8z+th+AWB
         OvUpsl0L3X6mAJr2y3cxOGBivuJHbzH5LPb6TpBSX4X94H/YVy/YAIszcjK+89BTl0HO
         vbqSYaplrc8B+uFZ19tsbSVHSGLFHD3JfavqGzfSdQTAXSymFLp8BvTRTgY6REN8muKB
         CHyA==
X-Gm-Message-State: AC+VfDyTC6dc0o9MaRDs3nl06jHxo5U3Lkc9kwOQY7arCNakRvkNYbHe
        d4SPn/PCiLNhQLrUnW2z9KQXJm+BEzLDG/dTDEXjTphO
X-Google-Smtp-Source: ACHHUZ5RX45AVj/us3GvsryoeUS/LBbYEZ1GmR1maULTNWgW/0nFGcVSAMfULkCHsbRQqfiOZZc0/w==
X-Received: by 2002:a05:651c:168a:b0:2b6:b9ee:a7b8 with SMTP id bd10-20020a05651c168a00b002b6b9eea7b8mr3626916ljb.4.1688223709511;
        Sat, 01 Jul 2023 08:01:49 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id h16-20020a2eb0f0000000b002b6dba16f28sm556003ljl.127.2023.07.01.08.01.48
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 08:01:49 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b63e5f94f1so36726771fa.1
        for <sparclinux@vger.kernel.org>; Sat, 01 Jul 2023 08:01:48 -0700 (PDT)
X-Received: by 2002:aa7:d047:0:b0:51b:f862:7b6a with SMTP id
 n7-20020aa7d047000000b0051bf8627b6amr9564270edo.14.1688223687666; Sat, 01 Jul
 2023 08:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net> <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
 <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
In-Reply-To: <CAMo8BfJ+FcR8ZfNk8GNL5pRsJO13O=on8ewRHSJkuQ85_WPk0A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 1 Jul 2023 08:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgy=8CEGoGJnHkuz4p0pR+Q-5RvsM4VNyYeWabshYr5yQ@mail.gmail.com>
Message-ID: <CAHk-=wgy=8CEGoGJnHkuz4p0pR+Q-5RvsM4VNyYeWabshYr5yQ@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Chris Zankel <chris@zankel.net>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
        linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, 1 Jul 2023 at 03:32, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Thanks for the build fix. Unfortunately despite being obviously correct
> it doesn't release the mm lock in case VMA is not found, so it results
> in a runtime hang. I've posted a fix for that.

Heh. I woke up this morning to that feeling of "Duh!" about this, and
find you already had fixed it. Patch applied.

            Linus

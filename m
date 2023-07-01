Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86B4BEB64DC
	for <sparclinux@archiver.kernel.org>; Sat,  1 Jul 2023 04:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGAEYQ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 1 Jul 2023 00:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjGAEX2 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 1 Jul 2023 00:23:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD1C194
        for <sparclinux@vger.kernel.org>; Fri, 30 Jun 2023 21:23:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b69ff54321so42212141fa.2
        for <sparclinux@vger.kernel.org>; Fri, 30 Jun 2023 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688185404; x=1690777404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ViFCqfiw9NC8hbaUDlyrBH6eii1s13MnpTkthHHGEXE=;
        b=iLQSUKMrejl6RA4EdckKtAAlQTtW3RQHk/Sn8sKvV3xMSSd/PdyBC3Nql9/cMb1DGQ
         rjN37N9HnQRndWMYOjts60rAZNM/4oO5SzDGOzDEB3thhQodOSlREplORnQcpCtu57qz
         pn8BA8TN7FIfTZDlD75VCK74vIJ8aHdwuhqWo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688185404; x=1690777404;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViFCqfiw9NC8hbaUDlyrBH6eii1s13MnpTkthHHGEXE=;
        b=UsI8efBkDFM6Re2C2PCA3L818eSckKpIcstuipW1xSC3fJQaJvq/w8JjAHncRX6F+s
         MHQ0KsZR4MivIfq8EKKsatO0q8hNwTTt5P9LHKMERXC9DfDAa/UhyJ3Fn6oRO0Q5T5UE
         cOko0nveuZ5eRerD0jGVDYs802bkXxgN5YhSOgxNRVfQFz27ck5LXQFHPxsDmzWk71oa
         ws4/eHcwQDwJSdoYL5Wa9Q5rXLozg2QyEciuHNKSs9Zggxoo7ub0JmdgaJNNdxHRaphR
         jdtuhYWsM6ujUFoPrrofe1MB2oeJFWIHfEwq2EjB2eGrKxv55Ks18WU1wFK0uB/TNHeK
         aoRw==
X-Gm-Message-State: ABy/qLYGOHtWzebAQ0HDTDF8vsgf71Y22tLZbg5sAWOWPUGS6GBLsqPV
        coxScmq3Hwai5CUmDUETCtXLSa5x0hhx50MR0PWLLhoC
X-Google-Smtp-Source: APBJJlFne7+oSyyCKSxMuWqCSsV041tpdb+0M9U2S9p67Fa7OpD1TvXIBH32gshgGrbynCyIxsp58g==
X-Received: by 2002:a2e:9201:0:b0:2b6:c7cc:4b71 with SMTP id k1-20020a2e9201000000b002b6c7cc4b71mr2963416ljg.8.1688185404336;
        Fri, 30 Jun 2023 21:23:24 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id c13-20020aa7c98d000000b0051dd4daf13fsm2698463edt.30.2023.06.30.21.23.23
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 21:23:24 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-51d93425853so2701175a12.1
        for <sparclinux@vger.kernel.org>; Fri, 30 Jun 2023 21:23:23 -0700 (PDT)
X-Received: by 2002:a2e:888e:0:b0:2b5:9f54:e290 with SMTP id
 k14-20020a2e888e000000b002b59f54e290mr3104948lji.0.1688185382985; Fri, 30 Jun
 2023 21:23:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
 <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net> <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
 <CAHk-=wiN5H-2dh2zCo_jXE7_ekrxSHvQcMw4xfUKjuQs2=BN4w@mail.gmail.com>
 <fb63ea7b-c44b-fb1b-2014-3d23794fa896@roeck-us.net> <CAHk-=whh_aUHYF6LCV36K9NYHR4ofEZ0gwcg0RY5hj=B7AT4YQ@mail.gmail.com>
 <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
In-Reply-To: <e4dd115b-1a41-4859-bbeb-b3a6a75bf664@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 30 Jun 2023 21:22:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
Message-ID: <CAHk-=wgBAhFqD6aoD2rL0qws8S1erdbrvmQXuYi=ZFEUVNuVfg@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>,
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

On Fri, 30 Jun 2023 at 19:50, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Yes, the patch below fixes the problem.
>
> Building xtensa:de212:kc705-nommu:nommu_kc705_defconfig ... running ......... passed

Thanks. Committed as

  d85a143b69ab ("xtensa: fix NOMMU build with lock_mm_and_find_vma()
conversion")

and pushed out.

                    Linus

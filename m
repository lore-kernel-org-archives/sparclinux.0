Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28BFEB64DA
	for <sparclinux@archiver.kernel.org>; Fri, 30 Jun 2023 06:34:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjF3GeG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 02:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbjF3GeF (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Jun 2023 02:34:05 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC530C4
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:34:04 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51dec0b6fecso676643a12.1
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688106843; x=1690698843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TpIIQ08qfNEuob2XBLG/PQlcqkOfTkfohi2v2vX8ccE=;
        b=M2TBpBxIoHxKCHngKt32vUluBC4EJdqoYOVETJ7o+8oH09CY6BShREL8qj56C6356X
         5q3XGeGw9IJacNLJzP0IKB2VtPNs0Bg8sJThD1TefnyJEjI0iWLHlryGHkNUmFHM1S+w
         BtATWIITfAqQhH/6AQDQTS9JcuwoFVpAEkFnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688106843; x=1690698843;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TpIIQ08qfNEuob2XBLG/PQlcqkOfTkfohi2v2vX8ccE=;
        b=F6A+8LYUcz+p0M1oVzjPKvqiZscfXzOFy6lrBxb/42Wxnc6hO+lc3DwI5RgNO+uGrZ
         ngJNO7pjrue+wCPK5GvVP34+gjRq4lWFDGuz5wwwqfr7BQNKXsUUnxp78n/r9zKE2G5V
         yfD9hq/TbNQz3FGGmgXT2pFICp+aK9B3Stiwmefg1ddiiUgIoa1WcDR3IfbqQmDAy0qB
         FBMwARmhk11gX/hagBTwiWaZ3ZmCG1MbAHt1KBzKNnEgGsMciBrU2/CoYzSpPS3NT4lc
         A+Sj8l4wFqRAeWH/tqJiLlPaBsvH0ROZo6ihxm+qJKWy8jeDiVnXXQ7769wnDXCfUeKV
         5bMQ==
X-Gm-Message-State: ABy/qLbBMq0I41wmUEnnOwsOhd7awEhMot3cK9FNTEpg/CfPn6n8Rzdh
        DpGrgAzaLP1xAH4cxhDyQcftZdEmTUoCL/KtCHlSe9LF
X-Google-Smtp-Source: APBJJlGR37IiJKVVFEhPd972TxxPTBXwg+rC1SIy4jRYY1Zp5DauxtgxAbtUbhvhx1hTlu+pEzLPzg==
X-Received: by 2002:a50:ec8e:0:b0:51d:ad30:5ed7 with SMTP id e14-20020a50ec8e000000b0051dad305ed7mr884786edr.35.1688106843150;
        Thu, 29 Jun 2023 23:34:03 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id p18-20020aa7d312000000b0051a2d2f82fdsm6586393edq.6.2023.06.29.23.34.02
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:34:03 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-51d91e9b533so1611116a12.3
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:34:02 -0700 (PDT)
X-Received: by 2002:aa7:d551:0:b0:51d:af77:d201 with SMTP id
 u17-20020aa7d551000000b0051daf77d201mr909491edr.18.1688106842535; Thu, 29 Jun
 2023 23:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com> <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net>
In-Reply-To: <fbe57907-b03f-ac8c-f3f4-4d6959bbc59c@roeck-us.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:33:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
Message-ID: <CAHk-=wgE9iTd_g20RU+FYa0NPhGSdiUDPW+moEqdHR4du1jmVA@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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

On Thu, 29 Jun 2023 at 23:29, Guenter Roeck <linux@roeck-us.net> wrote:
>
> Did you see that one (in mainline) ?
>
> Building csky:defconfig ... failed

Nope. Thanks. Obvious fix: 'address' is called 'addr' here.

I knew we had all these tiny little mazes that looked the same but
were just _subtly_ different, but I still ended up doing too much
cut-and-paste.

And I only ended up cross-compiling the fairly small set that I had
existing cross-build environments for. Which was less than half our
~24 different architectures.

Oh well.  We'll get them all. Eventually. Let me go fix up that csky case.

              Linus

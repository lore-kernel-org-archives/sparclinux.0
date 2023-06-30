Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B0EB64DA
	for <sparclinux@archiver.kernel.org>; Fri, 30 Jun 2023 06:16:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjF3GQo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 02:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbjF3GQn (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Jun 2023 02:16:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273D92686
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:16:41 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b6a0d91e80so24279771fa.3
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1688105799; x=1690697799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Uhmn3RW3fCZZK1xj84ra9lbrAgT4ezYFSHn/zPTSsl0=;
        b=DQaZ81L7Do33pBNUFaX9m6QU6KjSkQ3rYs7NZjeDSQ3P44DtZfIuipS1Oi/H3rejnk
         laNHIpw21rQA8FnPyvH2SdTQyWVJ8C+M23ElNcmQt3fnHplhwc6hTQ8gi8iY7k5FrYn+
         +M7OFBrmGGFfFjqFYXy+1czp1wSE+XPwh5x58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688105799; x=1690697799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uhmn3RW3fCZZK1xj84ra9lbrAgT4ezYFSHn/zPTSsl0=;
        b=KkxfmCDX1R14JH3kF4cMRX9VgkY5u+AxxLAFYEL161ZTgquf3btIlaT6nZqhy5QlRr
         GkRVxg+TJdaWpgVfsd9uhcdlE/OtWuI58Bda35diW+8Dg5/uaLuNOndQUgyWk+vw0DxA
         2uso/fqI+v+ZUNJQKDk52kSCnFTBpnm8zIDX1LkXe4c7k+FjpX6yim2RQm1iI+B71avM
         K5bUvpS3wJ8rI9f25S12MtM4ozSBokHUfMCnwWg3dsoPd26XlSrm9w11/BrgNREQhz6m
         fuoYjeBKhtmDRFYVAfgLqMcHdj3e+vFvqJsO10a4WO9TKdNYm3hiyDVdeipaKLFDf/KJ
         TSgw==
X-Gm-Message-State: ABy/qLZF7sXTTqxf+yx+L/+tQlqxRCw79tZh3XsuTlps0poT4H6oBaCf
        +tEN0adqwBzyooL10lYm0X3r4lzW3YzQnrBGVkkivQls
X-Google-Smtp-Source: APBJJlEnwVxlvM3E4vx8rGsdn9qhA1iBxm7vBTuu+BPGU6uW1W1I7ONeoZZ4PaNXj6eikpcJD0EWVg==
X-Received: by 2002:a2e:8744:0:b0:2b6:be8a:27a6 with SMTP id q4-20020a2e8744000000b002b6be8a27a6mr1285294ljj.45.1688105799455;
        Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id u19-20020a2e91d3000000b002b657f10b78sm2934932ljg.58.2023.06.29.23.16.39
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b69dcf45faso24537611fa.0
        for <sparclinux@vger.kernel.org>; Thu, 29 Jun 2023 23:16:39 -0700 (PDT)
X-Received: by 2002:a2e:870f:0:b0:2b6:99a3:c254 with SMTP id
 m15-20020a2e870f000000b002b699a3c254mr1390190lji.26.1688105798765; Thu, 29
 Jun 2023 23:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230629184151.888604958@linuxfoundation.org> <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
In-Reply-To: <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 29 Jun 2023 23:16:21 -0700
X-Gmail-Original-Message-ID: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Message-ID: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
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

On Thu, 29 Jun 2023 at 22:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> arch/parisc/mm/fault.c: In function 'do_page_fault':
> arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in this function)
>   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))

Bah. "prev" should be "prev_vma" here.

I've pushed out the fix. Greg, apologies. It's

   ea3f8272876f parisc: fix expand_stack() conversion

and Naresh already pointed to the similarly silly sparc32 fix.

             Linus

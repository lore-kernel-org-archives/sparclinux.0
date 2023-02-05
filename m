Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B27C636CD
	for <sparclinux@archiver.kernel.org>; Sun,  5 Feb 2023 18:52:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBESwW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 5 Feb 2023 13:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBESwT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 5 Feb 2023 13:52:19 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0771CACE
        for <sparclinux@vger.kernel.org>; Sun,  5 Feb 2023 10:52:17 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m8so9682698edd.10
        for <sparclinux@vger.kernel.org>; Sun, 05 Feb 2023 10:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FHO7GI+A1DWHNoRePsnR8I5+C4R4p3/7zIJvX3p+LUg=;
        b=HW9XJWDNzeOCSuB6xjuHzGjlFrFpNWXt04d038AYbQHAwGjnEJnVJFaDX127TnFYpL
         ydEGn0SwgrZ26RVkS0s0lgFAxMQXSWztEh7hBcLvV0G2Q3rBSAhctrbX0nTU4l9fQ760
         cFueFrfradqcL9O/I0nJrdeB83AKu6+dYCVG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FHO7GI+A1DWHNoRePsnR8I5+C4R4p3/7zIJvX3p+LUg=;
        b=NB5msWBzp5oqxXLRDl3i0yfgOrwwUg19r9fXHl0F2hOgtL7ubeFD8dtbCokAStAkMc
         Dy0hoTB+7fhMsLrwYhYkZBbzxMDNALBwWim28rDcGvm3PeLG9BiS2RZG4Cvik8meSLRG
         zvZATjebpa/N6MkSlkV3scv5ggbHMs4z89YDWGIltWgJes6UXdBNXdrT0/8y/3Rju8My
         9nYnN2g2CCFsSTiO4rxRpib5pZydYdnyqJnLS5u5RvEcnavzTr2QiKKcpFppFvjneeAX
         dCuIbvIWsnyQ+lBJ4YeBgKm/2DBLUTjOnOvelrxOf7rO5jk6jXojETKnldjdtapgEET+
         Zl8g==
X-Gm-Message-State: AO0yUKVDdTFp0D3LefjkhmBkPqQimaXyJRqmfYi8K1y7GvgyxfE3JUSu
        r6IITAo8NU4fXNZ8eimMoKUROU4YeZwB3GWzxxY=
X-Google-Smtp-Source: AK7set/orjljcp5rlR6FxAwrZ0IVAAXAqjqnFUsufKofvO+BdDe2TOcvF3zYfBPAwTTrd8bcY99rRw==
X-Received: by 2002:a05:6402:1643:b0:492:8c77:7dad with SMTP id s3-20020a056402164300b004928c777dadmr16831088edx.8.1675623135807;
        Sun, 05 Feb 2023 10:52:15 -0800 (PST)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id w12-20020a056402268c00b0049e65e4ff20sm4098697edd.14.2023.02.05.10.52.14
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 10:52:15 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id ml19so28704482ejb.0
        for <sparclinux@vger.kernel.org>; Sun, 05 Feb 2023 10:52:14 -0800 (PST)
X-Received: by 2002:a17:906:892:b0:87a:7098:ca09 with SMTP id
 n18-20020a170906089200b0087a7098ca09mr4354270eje.78.1675623134603; Sun, 05
 Feb 2023 10:52:14 -0800 (PST)
MIME-Version: 1.0
References: <Y9lz6yk113LmC9SI@ZenIV> <Y9l0aBPUEpf1bci9@ZenIV> <92a4aa45-0a7c-a389-798a-2f3e3cfa516f@linux-m68k.org>
In-Reply-To: <92a4aa45-0a7c-a389-798a-2f3e3cfa516f@linux-m68k.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 5 Feb 2023 10:51:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wirpn8qX5hCyeS0a4GCQH5p-2ACXgzJTj7zjZ5rGux_Bw@mail.gmail.com>
Message-ID: <CAHk-=wirpn8qX5hCyeS0a4GCQH5p-2ACXgzJTj7zjZ5rGux_Bw@mail.gmail.com>
Subject: Re: [PATCH 04/10] m68k: fix livelock in uaccess
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, Feb 4, 2023 at 10:16 PM Finn Thain <fthain@linux-m68k.org> wrote:
>
> That could be a bug I was chasing back in 2021 but never found. The mmap
> stressors in stress-ng were triggering a crash on a Mac Quadras, though
> only rarely. Sometimes it would run all day without a failure.
>
> Last year when I started using GCC 12 to build the kernel, I saw the same
> workload fail again but the failure mode had become a silent hang/livelock
> instead of the oopses I got with GCC 6.
>
> When I press the NMI button after the livelock I always see
> do_page_fault() in the backtrace. So I've been testing your patch. I've
> been running the same stress-ng reproducer for about 12 hours now with no
> failures which looks promising.
>
> In case that stress-ng testing is of use:
> Tested-by: Finn Thain <fthain@linux-m68k.org>

Could you test the thing that Mark Rutland pointed to? He had an
actual test-case for this for the arm64 fixes some years ago.

See

   https://lore.kernel.org/all/Y9pD+TMP+%2FSyfeJm@FVFF77S0Q05N/

for his email with links to his old test-case?

                Linus

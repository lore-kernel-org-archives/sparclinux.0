Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F8DFC433EF
	for <sparclinux@archiver.kernel.org>; Wed, 23 Feb 2022 20:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238032AbiBWUNl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:13:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237733AbiBWUNk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 23 Feb 2022 15:13:40 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121EE4C419
        for <sparclinux@vger.kernel.org>; Wed, 23 Feb 2022 12:13:12 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a23so54628189eju.3
        for <sparclinux@vger.kernel.org>; Wed, 23 Feb 2022 12:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+S6BFzj6o5ckty5iXSThNrfkPsdFE94/fVb8NP4+aFs=;
        b=F/2f/aEUKxSuzDdCknAbug+t8clrlE0v7gj9NkhphhHftuFg6XGIjvpJXVx+ZHKhn9
         jOIdz4l7lK+/F1JhXkxR/PARyehOhzu1/S93ijWQKe7fGKOKTiRs9R81aIq3OYNVOgnf
         G4UcKLBEtMgH8cssPIzV42vV3R64/Z0YRVhdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+S6BFzj6o5ckty5iXSThNrfkPsdFE94/fVb8NP4+aFs=;
        b=B67Qi499uaKz+EtIz2DL767bemIwx/FDMC+oc85R3wlKwUY6yJVbPzqyUS+XBXIUQV
         eVuf0BnBPC49QwJ8qgHIPA1tMG7MH9lNb9UmiTshKz1KE1/j8UO0tPaHBbIXFxskGceo
         1ghVO9G8wM0amllbKePztt03TImcdGn6rYe/Q4Itppk1rV/Ay9Nwvrx7IplmrjicwD7J
         eNRxGdpJ+ievtrETzadG99fzn0tt5U8DS9TLCzuWFZOnaM7kWLrmnXkTrSVfKHSd8e5Z
         466OKcwHLEjqKRe8eGot7Qvi8sMsLdAiiZy/X2UPtGovtbUv5YAKjJLKm04mtvhc/RJo
         sA9w==
X-Gm-Message-State: AOAM531ClyPTR5SJl6ngbnP4Aa9h6lVHYSpOEJ2oegh8slScgbABnl7n
        PnQpLS48oKNFvi1dplsnoVpfE0gXL7bJXkZLe+A=
X-Google-Smtp-Source: ABdhPJzRcJMU3VHsSLnNYHeE1Nsth3Qtr3fVDnJRR3u6I0SAKSjKHfnmdBSDu9ipkkPoMYCJf7lPUg==
X-Received: by 2002:a17:906:d8ae:b0:6cf:3fa:4d80 with SMTP id qc14-20020a170906d8ae00b006cf03fa4d80mr1038871ejb.544.1645647190213;
        Wed, 23 Feb 2022 12:13:10 -0800 (PST)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id s12sm239301ejn.121.2022.02.23.12.13.10
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:13:10 -0800 (PST)
Received: by mail-wr1-f49.google.com with SMTP id p9so41449517wra.12
        for <sparclinux@vger.kernel.org>; Wed, 23 Feb 2022 12:13:10 -0800 (PST)
X-Received: by 2002:a05:6512:130b:b0:443:c2eb:399d with SMTP id
 x11-20020a056512130b00b00443c2eb399dmr822016lfu.27.1645646720244; Wed, 23 Feb
 2022 12:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-10-arnd@kernel.org>
 <20220221132456.GA7139@alpha.franken.de>
In-Reply-To: <20220221132456.GA7139@alpha.franken.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Feb 2022 12:05:04 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdHz6OU3M9T5zE9Fc9SNdDs52iOE+eVn-wuUT6UDpBLg@mail.gmail.com>
Message-ID: <CAHk-=wjdHz6OU3M9T5zE9Fc9SNdDs52iOE+eVn-wuUT6UDpBLg@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] mips: use simpler access_ok()
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Arnd Bergmann <arnd@kernel.org>, Christoph Hellwig <hch@lst.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Rich Felker <dalias@libc.org>,
        David Miller <davem@davemloft.net>,
        Richard Weinberger <richard@nod.at>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>, linux-csky@vger.kernel.org,
        linux-hexagon <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Openrisc <openrisc@lists.librecores.org>,
        linux-parisc <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Feb 21, 2022 at 5:25 AM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> With this patch
[ .. snip snip ..]
> I at least get my simple test cases fixed, but I'm not sure this is
> correct.

I think you really want to do that anyway, just to get things like
wild kernel pointers right (ie think get_kernel_nofault() and friends
for ftrace etc).

They shouldn't happen in any normal situation, but those kinds of
unverified pointers is why we _have_ get_kernel_nofault() in the first
place.

On x86-64, the roughly equivalent situation is that addresses that
aren't in canonical format do not take a #PF (page fault), they take a
#GP (general protection) fault.

So I think you want to do that fixup_exception() for any possible addresses.

> Is there a reason to not also #define TASK_SIZE_MAX   __UA_LIMIT like
> for the 32bit case ?

I would suggest against using a non-constant TASK_SIZE_MAX. Being
constant is literally one reason why it exists, when TASK_SIZE itself
has often been about other things (ie "32-bit process").

Having to load variables for things like get_user() is annoying, if
you could do it with a simple constant instead (where that "simple"
part is to avoid having to load big values from a constant pool -
often constants like "high bit set" can be loaded and compared against
more efficiently).

               Linus

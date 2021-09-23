Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 546D6C433F5
	for <sparclinux@archiver.kernel.org>; Thu, 23 Sep 2021 16:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BD1E60E9C
	for <sparclinux@archiver.kernel.org>; Thu, 23 Sep 2021 16:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbhIWQDs (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 23 Sep 2021 12:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242387AbhIWQDp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 23 Sep 2021 12:03:45 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EE1C06175F
        for <sparclinux@vger.kernel.org>; Thu, 23 Sep 2021 09:02:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id a26so202091ljp.2
        for <sparclinux@vger.kernel.org>; Thu, 23 Sep 2021 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DLOxhnwH/JaVIhRbDcxcZPpiYGHLJbtd0CRIGAWnOsw=;
        b=QMXOiJ6n28J2emY/y7cY9+DD4h8Pn0KRvNWmJxYGi/2iw91Mhhsv5k4E/yi6SvFmH+
         cwsdxpHCcIaSp+pnaMQx9j8vfDg38b4ujoTb2lzS4jvwjrgaoWuJfcNbrdzMUshkRDfy
         wyxZpTZP4dsY0GDCSs5bbcT3wFiFu+kSB/Akk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DLOxhnwH/JaVIhRbDcxcZPpiYGHLJbtd0CRIGAWnOsw=;
        b=X1uP9wdpOEQYtz6GDJVXTPkvJN+G2JWH67SutQwIWTLG/XXLA/yANxVrjw6Ufj/IkM
         yj36PrNcbkPYw0Te+82jThzrJmlt3x3/YGCyJ4ABuOF9fw6ooqGxZ5WvH+VAOkLq4h8E
         zdIubl/wIJ9bqe+pkDof8Z3AGNmTIPsYnqtbTSxRlw7ZRU1LXQjriTzOTltsB7c1HRtd
         YyFaf6AvOOcxrHDAFq+3kVqacwC5R7ACUuYxJ7WuW+G1FrzmW/7Osu2YxZCB7X7WYDE4
         oVWvQ+80PnrJQndEnDf5v9slpzn3iGY1MMyhhY1XqdiQ6eEPKprAROG/oAcvbqndQOoS
         gwPw==
X-Gm-Message-State: AOAM532waoJR0Wqg1d5uQcThwrTenHzPG0mIzAdwRaf32F3UaMH+/IQ+
        nll00mSPN3P/pg8sMdjgWIz0e03PeQkQJSEx
X-Google-Smtp-Source: ABdhPJxDhK4B2ZhfdPgn4N+J/CUGyxjA+aLysq6lSGNXf7ze9sqpX1Geq3zfXaMqSpIJbHcyx0u7Qw==
X-Received: by 2002:a2e:9901:: with SMTP id v1mr5698133lji.384.1632412930357;
        Thu, 23 Sep 2021 09:02:10 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id v4sm493110lfp.99.2021.09.23.09.02.02
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:02:05 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id m5so199824ljp.4
        for <sparclinux@vger.kernel.org>; Thu, 23 Sep 2021 09:02:02 -0700 (PDT)
X-Received: by 2002:a2e:3309:: with SMTP id d9mr5950451ljc.249.1632412922441;
 Thu, 23 Sep 2021 09:02:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210923074335.12583-1-rppt@kernel.org>
In-Reply-To: <20210923074335.12583-1-rppt@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 23 Sep 2021 09:01:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Message-ID: <CAHk-=wiJB8H5pZz-AKaSJ7ViRtdxQGJT7eOByp8DJx2OwZSYwA@mail.gmail.com>
Subject: Re: [PATCH 0/3] memblock: cleanup memblock_free interface
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        KVM list <kvm@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-usb@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        xen-devel@lists.xenproject.org, Mike Rapoport <rppt@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Sep 23, 2021 at 12:43 AM Mike Rapoport <rppt@kernel.org> wrote:
>
> The core change is in the third patch that makes memblock_free() a
> counterpart of memblock_alloc() and adds memblock_phys_alloc() to be a

^^^^^^^^^^^^^^^^^^^
> counterpart of memblock_phys_alloc().

That should be 'memblock_phys_free()'

HOWEVER.

The real reason I'm replying is that this patch is horribly buggy, and
will cause subtle problems that are nasty to debug.

You need to be a LOT more careful.

From a trivial check - exactly because I looked at doing it with a
script, and decided it's not so easy - I found cases like this:

-               memblock_free(__pa(paca_ptrs) + new_ptrs_size,
+               memblock_free(paca_ptrs + new_ptrs_size,

which is COMPLETELY wrong.

Why? Because now that addition is done as _pointer_ addition, not as
an integer addition, and the end result is something completely
different.

pcac_ptrs is of type 'struct paca_struct **', so when you add
new_ptrs_size to it, it will add it in terms of that many pointers,
not that many bytes.

You need to use some smarter scripting, or some way to validate it.

And no, making the scripting just replace '__pa(x)' with '(void *)(x)'
- which _would_ be mindless and get the same result - is not
acceptable either, because it avoids one of the big improvements from
using the right interface, namely having compiler type checking (and
saner code that people understand).

So NAK. No broken automated scripting patches.

               Linus

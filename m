Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A7DCC04A95
	for <sparclinux@archiver.kernel.org>; Tue, 25 Oct 2022 14:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbiJYOoJ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 25 Oct 2022 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiJYOnw (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 25 Oct 2022 10:43:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BEE196340
        for <sparclinux@vger.kernel.org>; Tue, 25 Oct 2022 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666709029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pxb6hLNBaPYX709qS8Dsh8K7Uk4NY/7ppFr76EjMPTQ=;
        b=NcETdbnMS7Xr7l46uNhf+fBh2LBHHdjZBpAh8izCVBoYON6o4OoQVsEI3G1wAl9fkKq1hT
        PVDOOk3+qfP6XgfOSVKiVT5GwlZKQBQD3ZCOAq63fHp7SJ56W72iFfdnV7ZZjKGL0bFkMs
        2a7722/btr53MFl9z6ixbBD+BIETSKw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-jbgyBPsrN46jhVDU8IcfmQ-1; Tue, 25 Oct 2022 10:43:48 -0400
X-MC-Unique: jbgyBPsrN46jhVDU8IcfmQ-1
Received: by mail-qt1-f198.google.com with SMTP id k12-20020ac8474c000000b0039cdd680ccaso9090303qtp.1
        for <sparclinux@vger.kernel.org>; Tue, 25 Oct 2022 07:43:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pxb6hLNBaPYX709qS8Dsh8K7Uk4NY/7ppFr76EjMPTQ=;
        b=cSUpKNNE+0ArYyjeVIs5dl6odApUpU/c+wx3J8Ap3mk/8PhjADifUqsjoN2EbTBIAy
         r1Md6xqqGLvOxM47/c/ceDVy0woULe4ibIFzXWxPIyjpe77WnNoF0OT3t/WWf8inYqoL
         x7zd9OvQK1zKq6Z05bwndT65gNDorV8BdEKDZN/sPtuJMRiYx1n9I5c3B5ZIqk5qWZ7c
         rgFVAC7beXq1pBLMFBpsLSTIIkHGClRcfYU63YYRo5xGXoBDZNvDV9KTBx1/fo7M6hiC
         rjiHsuyqluVKgTD2fYBOAOFf8wrv1tRYDqGZAekhM07qZfsRpXKt9OEXxXpJDnqrUswK
         LN9A==
X-Gm-Message-State: ACrzQf0lM3FqP9+e84ud6SjRDbz25g/ipLBzAriuzNn/xMXpGJoRN1qh
        AMY1QKhce6dKqj12SDklKPzSrV4Awn3kBw6A2TjB0wOsjS3DEKhybKxmQ8g1UG7Ua9LRUSUkXHo
        2T0pEo/m8OjTFIV2roi5VzA==
X-Received: by 2002:ac8:5fc5:0:b0:39c:bb48:e42f with SMTP id k5-20020ac85fc5000000b0039cbb48e42fmr31816274qta.586.1666709028243;
        Tue, 25 Oct 2022 07:43:48 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7GfOvBIe3eVSO7BOHXT4+eelhHEZ0ULsG5cnoD9Qz3T3NoGoqp3jXdbO0dGqNFN3eQPDey7A==
X-Received: by 2002:ac8:5fc5:0:b0:39c:bb48:e42f with SMTP id k5-20020ac85fc5000000b0039cbb48e42fmr31816250qta.586.1666709027994;
        Tue, 25 Oct 2022 07:43:47 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id h10-20020a05620a400a00b006f8665f483fsm396408qko.85.2022.10.25.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:43:47 -0700 (PDT)
Date:   Tue, 25 Oct 2022 10:43:45 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>
Cc:     David Miller <davem@davemloft.net>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Alistair Popple <apopple@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andi Kleen <andi.kleen@intel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Huang Ying <ying.huang@intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, sparclinux@vger.kernel.org
Subject: Re: dpkg fails on sparc64 (was: [PATCH v4 4/7] mm/thp: Carry over
 dirty bit when thp splits on pmd)
Message-ID: <Y1f2IR+h4i2+/swj@x1n>
References: <20220811161331.37055-1-peterx@redhat.com>
 <20220811161331.37055-5-peterx@redhat.com>
 <20221021160603.GA23307@u164.east.ru>
 <Y1Wbi4yyVvDtg4zN@x1n>
 <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADxRZqy+cMHN4FjtDr7-LOyVf0y+G8MPiBoGiTEsSj48jBfVnw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Oct 25, 2022 at 01:22:45PM +0300, Anatoly Pugachev wrote:
> On Sun, Oct 23, 2022 at 10:53 PM Peter Xu <peterx@redhat.com> wrote:
> > On Fri, Oct 21, 2022 at 07:06:03PM +0300, Anatoly Pugachev wrote:
> > >
> > >     Link: https://lkml.kernel.org/r/20220811161331.37055-5-peterx@redhat.com
> > >
> > > So, v6.0-rc3-176-g0d206b5d2e0d) does not segfault dpkg,
> > > v6.0-rc3-177-g0ccf7f168e17 segfaults it on package install.
> > >
> > > dpkg test was (apt) install/remove some packages, segfaults only on install
> > > (not remove).
> > >
> > > Reverted 0ccf7f168e17bb7eb5a322397ba5a841f4fbaccb from top of v6.1-rc1 and
> > > tried to compile kernel, but got error
> > >
> > > mm/huge_memory.c: In function ‘__split_huge_pmd_locked’:
> > > mm/huge_memory.c:2129:17: error: ‘dirty’ undeclared (first use in this function)
> > >  2129 |                 dirty = is_migration_entry_dirty(entry);
> > >       |                 ^~~~~
> > > mm/huge_memory.c:2129:17: note: each undeclared identifier is reported only once for each function it appears in
> > > make[2]: *** [scripts/Makefile.build:250: mm/huge_memory.o] Error 1
> > >
> > > So can't test v6.1-rc1 with patch reverted...
> >
> > Sorry to know this, and thanks for the report and debugging.  The revert
> > won't work because dirty variable is used in later patch for the swap path
> > too.  I've attached a partial (and minimum) revert, feel free to try.
> 
> Peter,
> 
> tested again with 6.1.0-rc2 already, non patched kernel segfaulting
> dpkg, using your patch makes dpkg
> (or kernel) to behave properly.
> Thanks!

Thanks for the quick feedback.

> 
> > I had a feeling that it's somehow related to the special impl of sparc64
> > pte_mkdirty() where a kernel patching mechanism is used to share code
> > between sun4[uv].  I'd assume your machine is sun4v?  As that's the one
> > that needs the patching, iiuc.
> 
> kernel boot log reports
> ARCH: SUN4V

Then it's expected but unfortunate too, as QEMU doesn't seem to have
support on sun4v so I cannot even try that out with a VM.

https://wiki.qemu.org/Documentation/Platforms/SPARC

I'd also expect there's nothing useful in either dmesg or relevant logs
because it's segv, but please share if you find anything that may be
helpful.

Maybe we need to have the minimum revert for v6.1 before we have more
clues.

Thanks,

-- 
Peter Xu


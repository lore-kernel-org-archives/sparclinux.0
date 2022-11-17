Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C87C433FE
	for <sparclinux@archiver.kernel.org>; Thu, 17 Nov 2022 02:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiKQCaK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 21:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiKQCaJ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Nov 2022 21:30:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82692AC6B
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 18:30:08 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p141so408953iod.6
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 18:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MKjMIVgBYuixUb7aB0jNqDpf5b0ztY7pCeOHcrf1GyA=;
        b=yOElW9RE8d35nyhq6uqy5BLT0fmiRJym4fWK8qJLQCPSvlthD/DRbfHH3Jr/LcHE4o
         WokFjUnyrOfFdgoFlY+kQnFRtHkCktBCtYHSnaM+V577CDv0/MtM509lzD4OfA7Qj/mh
         61hDpOWrmqepRBbby+Ce3bzwViBxKq80uEb3BOmLjtOUtiPaNhB0S2IcoAE+cPHdCDBK
         +z5MfsO0a2O85qNVmk5VEVWbdx5Tss8gqlvHt6IaRQUYx91q2ijnJ6BfaPwBSWTaGIBV
         L2IW7QbHvcx6sh7TxIceZZVqQKECuy1DYw6wHvZeFkqBAGKkFAt+tJdGiEVQhMhNV8H1
         a1Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MKjMIVgBYuixUb7aB0jNqDpf5b0ztY7pCeOHcrf1GyA=;
        b=nTIbPYxEaoZABd8cTzKuKcg8etAAm7h7Ph3GvY9PLYBsNpMQzsVFVTdDnlLPVJ3XBA
         TcH7LSAGhXbZN/7XTlaDDzaZb2mfUy/csQqhH+/7Tzo66EczS+uRLjNmFuYHiRAy8FTp
         JSEHrBbrAESjlI5eDVrX3u8Z0d5rat3+JINlOPsveYU96CYl6BAOuPMrMJo7OPqFeFQS
         hFmn8lEMbNfdvb+ZqK66rc1Li17EIuVyaZNAABNf1qYWjxQbGP/YG0FdnsnlZrUCPe1a
         ByHkba8alZQqx6+/k0cwoT5/jI+s0JbDVOaicOKI0b6R4PPiBTZZxhuxbdwXwwGCX8qg
         XwSQ==
X-Gm-Message-State: ANoB5pmdXLdaBgBYHPKTQjVE5TcptyRYONPBQhsei5EfpjwWtcL38QBW
        DZcpsxjQflaXjGvvTz+/FKssLl5qT8/VIOb/zHdY94f4ki6CFNevh5A=
X-Google-Smtp-Source: AA0mqf73fC8beOPRO7rLuNjcmjOH2r4YzNahzPf8xG2BXK+wHE+OQz6MN7Inu7jfaRE6jhn7IP/pmAyvkIJ9bAP/8D4=
X-Received: by 2002:a5d:9283:0:b0:6ba:13c6:b74 with SMTP id
 s3-20020a5d9283000000b006ba13c60b74mr465930iom.86.1668652208124; Wed, 16 Nov
 2022 18:30:08 -0800 (PST)
MIME-Version: 1.0
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com> <Y3UPAKqVp6WAmRHV@x1n>
In-Reply-To: <Y3UPAKqVp6WAmRHV@x1n>
From:   hev <r@hev.cc>
Date:   Thu, 17 Nov 2022 10:29:57 +0800
Message-ID: <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on pmd"
To:     Peter Xu <peterx@redhat.com>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Peter,

On Thu, Nov 17, 2022 at 12:25 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> > On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> > >
> > > Hello Peter,
>
> Hi, Hev,
>
> Thanks for letting me know.
>
> > >
> > > I see a random crash issue  on the LoongArch system, that is caused by
> > > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > > pmd").
> > >
> > > Now, the thing is already resolved. The root cause is arch's mkdirty
> > > is set hardware writable bit in unconditional. That breaks
> > > write-protect and then breaks COW.
>
> Could you help explain how that happened?
>
> I'm taking example of loongarch here:
>
> static inline pte_t pte_mkdirty(pte_t pte)
> {
>         pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
>         return pte;
> }
>
> #define _PAGE_MODIFIED          (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
> #define _PAGE_MODIFIED_SHIFT    9

_PAGE_MODIFIED is a software dirty bit

> #define _PAGE_DIRTY             (_ULCAST_(1) << _PAGE_DIRTY_SHIFT)
> #define _PAGE_DIRTY_SHIFT       1

_PAGE_DIRTY is a hardware writable bit (bad naming), meaning that mmu
allows write memory without any exception raised.

>
> I don't see when write bit is set, which is bit 8 instead:
>
> #define _PAGE_WRITE             (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
> #define _PAGE_WRITE_SHIFT       8

_PAGE_WRITE is a software writable bit (not hardware).

As David said, In __split_huge_pmd_locked, the VMA does not include VM_WRITE,

entry = maybe_mkwrite(entry, vma);

so the pte does not include software writable bit (_PAGE_WRITE).

and the dirty is true,

if (dirty)
    entry = pte_mkdirty(entry);

so the incorrect arch's pte_mkdirty set hardware writable
bit(_PAGE_DIRTY) in unconditional for read-only pages.

Regards,
Ray

>
> According to loongarch spec:
>
> https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#section-multi-level-page-table-structure-supported-by-page-walking
>
> Bits 1 & 8 match the spec D & W definitions.  Bit 9 seems not defined but I
> didn't quickly spot how that's related to the write bit.
>
> > >
> > > Here is a simple and fast testcase (It may be helpful for sparc64):
> > > https://gist.github.com/heiher/72919fae6b53f04cac606a9631100506
> > > (assertion: c sum == 0)
> >
> > Just tried on my sparc64 VM -  fixed vs old (non-patched) kernels...
> >
> > fixed kernel (6.1.0-rc5) running ./a.out:
> > mator@ttip:~$ ./a.out
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > ...
> >
> > old (non-patched) kernel (6.1.0-rc4) :
> > mator@ttip:~$ ./a.out
> > c sum: 35150012350464
> > p sum: 35184372088832
> > c sum: 35150012350464
> > p sum: 35184372088832
> > ...
>
> Thanks for the quick run, Anatoly.  Obviously I went the wrong way before
> on the code patching.  It seems we have more chance fixing this.
>
> --
> Peter Xu
>

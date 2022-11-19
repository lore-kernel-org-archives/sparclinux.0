Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7881CC4332F
	for <sparclinux@archiver.kernel.org>; Sat, 19 Nov 2022 14:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbiKSOGh (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 19 Nov 2022 09:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbiKSOGh (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 19 Nov 2022 09:06:37 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34596B9F3
        for <sparclinux@vger.kernel.org>; Sat, 19 Nov 2022 06:06:35 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id o13so3804972ilq.6
        for <sparclinux@vger.kernel.org>; Sat, 19 Nov 2022 06:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HySLA6s6PCTDYfxJoms8KAj8+52rJt19Ujaob1kBIRs=;
        b=f3XhTlyJ4Lqf8RKe7v195+NYw5qxAHZXQX70hGAEglD0G4ibAPgUpVQ1t2MWLc3ONa
         i1RoAYVJRaIF352vk/1j/W3UbY1o38ALaPuVy1HTaLJ1X2yVSWOmDy+4GvrnMHXPCdp/
         mpDO9qkNxE7XGvKSo0ilz1XFkQLdAgWjd1TAUG2xZ7oip1J087nBU5pqVEZG8MDzHBF0
         QgJDWWCY0smj4xqk9VPA2UQ8njnuJRt4EewZ1Q/O6jA2gYt6cjH3/yXbMlBsqWRy31yR
         XQQf7cbaNUn13gCjovSNJvLaUKHLk/C0y45Mq8I3vjo2Tc2CQy0DOJBjSLg/tXIWyBO5
         rvBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HySLA6s6PCTDYfxJoms8KAj8+52rJt19Ujaob1kBIRs=;
        b=oUlwD6iJjbzJ2Ei835JN+7D8GK3uW6596JW4x7/XoMaiH1NBjXf2dxEyAkHDesFTBG
         zT+qLnOU/IV1CuEWjBy0tHajZvnj8Qvr60aenEVZPwTjy3KT8A00s6+dH1daLpbcyJR2
         Z12aLV38xBQMnanjGPhlS5vS+QF6MOFwX/3683GE0Kv54RskbiwHUC/v1ZVwiv7uNN3K
         2I5A/CE7/Ppim74T67T4tnfNTdwHa96QS9yBULh7+NBovf7BVTkSVOwrSfn8m8rUINiC
         Fn7abIMfJOVVtec+WFxfvVoqC1a+vS5YWxmxRLNl0u90GMXlweJG2UCw0J+cfuEevndo
         DJwg==
X-Gm-Message-State: ANoB5plmu+c6w+2fu5jzbB0WtNFZKsHnzShjjG6l5dzWJAwgcLCy25Go
        LUOtN3paDEKXDRMX5Wwp5LjpGQaaFjOy2QsitlSAxQ==
X-Google-Smtp-Source: AA0mqf6Q47ASy2lOn7xhwiwVK+Kr1p4PdbXvwnDQKTXaAndihBA03dFdxprODH/qtdjgY8Nw7TTfE++Z5E3w7PNwWgQ=
X-Received: by 2002:a92:d1d2:0:b0:302:535a:6eca with SMTP id
 u18-20020a92d1d2000000b00302535a6ecamr4974303ilg.256.1668866795323; Sat, 19
 Nov 2022 06:06:35 -0800 (PST)
MIME-Version: 1.0
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3UPAKqVp6WAmRHV@x1n> <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
 <Y3Z9Zf0jARMOkFBq@x1n>
In-Reply-To: <Y3Z9Zf0jARMOkFBq@x1n>
From:   hev <r@hev.cc>
Date:   Sat, 19 Nov 2022 22:06:23 +0800
Message-ID: <CAHirt9i8iLCP3_ppEL5kO2XLVAg0sno0GdzdKyzk7DSMTJF0tA@mail.gmail.com>
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

Hi, Peter,

On Fri, Nov 18, 2022 at 2:29 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Nov 17, 2022 at 10:29:57AM +0800, hev wrote:
> > Hi Peter,
>
> Hi, Hev,
>
> >
> > On Thu, Nov 17, 2022 at 12:25 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> > > > On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> > > > >
> > > > > Hello Peter,
> > >
> > > Hi, Hev,
> > >
> > > Thanks for letting me know.
> > >
> > > > >
> > > > > I see a random crash issue  on the LoongArch system, that is caused by
> > > > > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > > > > pmd").
> > > > >
> > > > > Now, the thing is already resolved. The root cause is arch's mkdirty
> > > > > is set hardware writable bit in unconditional. That breaks
> > > > > write-protect and then breaks COW.
> > >
> > > Could you help explain how that happened?
> > >
> > > I'm taking example of loongarch here:
> > >
> > > static inline pte_t pte_mkdirty(pte_t pte)
> > > {
> > >         pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
> > >         return pte;
> > > }
> > >
> > > #define _PAGE_MODIFIED          (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
> > > #define _PAGE_MODIFIED_SHIFT    9
> >
> > _PAGE_MODIFIED is a software dirty bit
> >
> > > #define _PAGE_DIRTY             (_ULCAST_(1) << _PAGE_DIRTY_SHIFT)
> > > #define _PAGE_DIRTY_SHIFT       1
> >
> > _PAGE_DIRTY is a hardware writable bit (bad naming), meaning that mmu
> > allows write memory without any exception raised.
>
> (I just missed this email before I reply to the other one, I should have
>  read this one first..)
>
> I see. This surprises me a bit, as I can't quickly tell how it'll always
> work with the generic mm code.
>
> Say, is there a quick answer on why _PAGE_DIRTY is set here rather than
> pte_mkwrite()?  Because AFAIU that's where the mm wants to grant write
> permission to a page table entry as the API, no?
>
> >
> > >
> > > I don't see when write bit is set, which is bit 8 instead:
> > >
> > > #define _PAGE_WRITE             (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
> > > #define _PAGE_WRITE_SHIFT       8
> >
> > _PAGE_WRITE is a software writable bit (not hardware).
> >
> > As David said, In __split_huge_pmd_locked, the VMA does not include VM_WRITE,
> >
> > entry = maybe_mkwrite(entry, vma);
> >
> > so the pte does not include software writable bit (_PAGE_WRITE).
>
> Are you sure?  In your test case you mapped with RW, IIUC it means even
> after the fork() VM_WRITE is set on both sides?

Sorry, I was wrong.

In this case, both VMAs are writable, the pte's writable bit is
cleared by pte_wrprotect. So if pte_mkdirty sets hardware writable bit
unconditionally, then there will be no way to catch writes to
implement COW.

I will try to explain how it works about pte write, dirty and
write-protect on LoongArch in the LoongArch mailing-list.

Regards,
Ray

>
> But I agree the write bit is not set, not because !VM_WRITE, but because we
> take care of that explicitly to make sure pte has the same write bit as pmd:
>
>                 (pmd used to be wr-protected due to fork())
>                 write = pmd_write(old_pmd);
>                 ...
>
>                 (then when split pte shouldn't have write bit too)
>                 if (!write)
>                         entry = pte_wrprotect(entry);
>
> >
> > and the dirty is true,
> >
> > if (dirty)
> >     entry = pte_mkdirty(entry);
> >
> > so the incorrect arch's pte_mkdirty set hardware writable
> > bit(_PAGE_DIRTY) in unconditional for read-only pages.
>
> True, that does also apply to sparc64 pte_mkdirty() with _PAGE_W_4[UV].  I
> should have noticed earlier that its comment told me that's a write bit
> already..
>
> #define _PAGE_W_4U        _AC(0x0000000000000002,UL) /* Writable             */
>
> Thanks,
>
> --
> Peter Xu
>

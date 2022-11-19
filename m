Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6658BC43217
	for <sparclinux@archiver.kernel.org>; Sat, 19 Nov 2022 14:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbiKSOUe (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 19 Nov 2022 09:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiKSOUd (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 19 Nov 2022 09:20:33 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAF48CFC0
        for <sparclinux@vger.kernel.org>; Sat, 19 Nov 2022 06:20:31 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id i5so3801698ilc.12
        for <sparclinux@vger.kernel.org>; Sat, 19 Nov 2022 06:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yiIrO3QJ9FqGI1W8MgeqZveRlXgYO7d04pOinsw5OS4=;
        b=0WGBdTMsp56KBqqY+suna+fbNqVkNRBcNRo/3cUJS8yQnuf7sqWHfjSAEx7vxXyXHr
         s1BY1rGymPPt4Sxhh2qqE0ACnxv5jxNdd14B/nqCLbt+RcP7oiBYO+0lxRHK4+PpN1l9
         iP/cQePD4nqmRsDY23HsilrXpJ4+ImjyF7VI9xdPPrPkIRDHWE4dDdRGNVtNV3Hs3kfg
         PjrXTPjsgAEGqDQI57OjmxhM+g8I0mGUGoBKSr6kqoY8Yj2zKMfL5j3xPdovATQEhLWn
         vcQICwWuqPacArQzonyKxdgbCNFeQ5I0I8VryS/m5+yrHALQx7kdtee2UJj5JRgcX2Yf
         503w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yiIrO3QJ9FqGI1W8MgeqZveRlXgYO7d04pOinsw5OS4=;
        b=fA3eL3CgU52xxIhirST1WXuy5DExkPzL3iCPqAkO7el+SMqyCqSHZXQLdy+WLX+m62
         vMt3ens5ImQbbYJxAc1Kc7ShypmBIvUsh/jszB17DGEjgnboXBhQTCMq6KCvH6FTRPR+
         lVHKQ2NFjjDuQ/wYltXGbyZYumMx676i47RPpYjkkoJ4aTRMYSTwYRG6xlKcl66ED+oA
         B5qrh/8hxC/ZkF7VaLnNNnGHYGf7/yxz6YZSJW3bW7+CllhjkUKBie1VGquhNh1dGlTV
         q/8plW4g4CExrJmI1iQCidUxFQAbax+NNVmBy/UjV/LSjN13MYgTVXgGsOHglZPZx5wx
         a52Q==
X-Gm-Message-State: ANoB5plkOZA78W+9SWTo8KYrFiYDkCeOcU8Nqn1WQWYu6ZFpSr7MkxOM
        3nBgeJFe2JvUA1+qPOsyFvk96R51050uxVKl/14VqQ==
X-Google-Smtp-Source: AA0mqf7sY1uF76oTP19CbgpTLmeIV7GhdUPEPCH/OAhw2wNsU60oPlA2YjRv3hFu3eMl08xwgD843RHy4uGgDqYQ8T4=
X-Received: by 2002:a92:c691:0:b0:302:75c9:5d55 with SMTP id
 o17-20020a92c691000000b0030275c95d55mr5171218ilg.34.1668867630758; Sat, 19
 Nov 2022 06:20:30 -0800 (PST)
MIME-Version: 1.0
References: <20221117042532.4064448-1-chenhuacai@loongson.cn>
 <Y3ZPRx/VUoVvujNa@x1n> <Y3aDQKwGDLXtWRJu@x1n>
In-Reply-To: <Y3aDQKwGDLXtWRJu@x1n>
From:   hev <r@hev.cc>
Date:   Sat, 19 Nov 2022 22:20:20 +0800
Message-ID: <CAHirt9itKO_K_HPboXh5AyJtt16Zf0cD73PtHvM=na39u_ztxA@mail.gmail.com>
Subject: Re: [PATCH 04/47] LoongArch: Set _PAGE_DIRTY only if _PAGE_WRITE is
 set in {pmd,pte}_mkdirty()
To:     Peter Xu <peterx@redhat.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi, Peter,

On Fri, Nov 18, 2022 at 2:53 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Thu, Nov 17, 2022 at 10:12:07AM -0500, Peter Xu wrote:
> > Hi, Huacai,
> >
> > On Thu, Nov 17, 2022 at 12:25:32PM +0800, Huacai Chen wrote:
> > > Now {pmd,pte}_mkdirty() set _PAGE_DIRTY bit unconditionally, this causes
> > > random segmentation fault after commit 0ccf7f168e17bb7e ("mm/thp: carry
> > > over dirty bit when thp splits on pmd").
> > >
> > > The reason is: when fork(), parent process use pmd_wrprotect() to clear
> > > huge page's _PAGE_WRITE and _PAGE_DIRTY (for COW);
> >
> > Is it safe to drop dirty bit when wr-protect?  It means the mm can reclaim
> > the page directly assuming the page contains rubbish.
> >
> > Consider after fork() and memory pressure kicks the kswapd, I don't see
> > anything stops the kswapd from recycling the pages and lose the data in
> > both processes.
>
> Feel free to ignore this question..  I think I got an answer from Hev (and
> I then got a follow up question):
>
> https://lore.kernel.org/all/Y3Z9Zf0jARMOkFBq@x1n/
>
> >
> > > then pte_mkdirty() set
> > > _PAGE_DIRTY as well as _PAGE_MODIFIED while splitting dirty huge pages;
> > > once _PAGE_DIRTY is set, there will be no tlb modify exception so the COW
> > > machanism fails; and at last memory corruption occurred between parent
> > > and child processes.
> > >
> > > So, we should set _PAGE_DIRTY only when _PAGE_WRITE is set in {pmd,pte}_
> > > mkdirty().
> > >
> > > Cc: stable@vger.kernel.org
> > > Cc: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> > > ---
> > > Note: CC sparc maillist because they have similar issues.
> >
> > I also had a look on sparc64, it seems to not do the same as loongarch
> > here (not removing dirty in wr-protect):
> >
> > static inline pmd_t pmd_wrprotect(pmd_t pmd)
> > {
> >       pte_t pte = __pte(pmd_val(pmd));
> >
> >       pte = pte_wrprotect(pte);
> >
> >       return __pmd(pte_val(pte));
> > }
> >
> > static inline pte_t pte_wrprotect(pte_t pte)
> > {
> >       unsigned long val = pte_val(pte), tmp;
> >
> >       __asm__ __volatile__(
> >       "\n661: andn            %0, %3, %0\n"
> >       "       nop\n"
> >       "\n662: nop\n"
> >       "       nop\n"
> >       "       .section        .sun4v_2insn_patch, \"ax\"\n"
> >       "       .word           661b\n"
> >       "       sethi           %%uhi(%4), %1\n"
> >       "       sllx            %1, 32, %1\n"
> >       "       .word           662b\n"
> >       "       or              %1, %%lo(%4), %1\n"
> >       "       andn            %0, %1, %0\n"
> >       "       .previous\n"
> >       : "=r" (val), "=r" (tmp)
> >       : "0" (val), "i" (_PAGE_WRITE_4U | _PAGE_W_4U),
> >         "i" (_PAGE_WRITE_4V | _PAGE_W_4V));
> >
> >       return __pte(val);
> > }
>
> (Same here; I just overlooked what does _PAGE_W_4U meant..)
>
> >
> > >
> > >  arch/loongarch/include/asm/pgtable.h | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/loongarch/include/asm/pgtable.h b/arch/loongarch/include/asm/pgtable.h
> > > index 946704bee599..debbe116f105 100644
> > > --- a/arch/loongarch/include/asm/pgtable.h
> > > +++ b/arch/loongarch/include/asm/pgtable.h
> > > @@ -349,7 +349,9 @@ static inline pte_t pte_mkclean(pte_t pte)
> > >
> > >  static inline pte_t pte_mkdirty(pte_t pte)
> > >  {
> > > -   pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
> > > +   pte_val(pte) |= _PAGE_MODIFIED;
> > > +   if (pte_val(pte) & _PAGE_WRITE)
> > > +           pte_val(pte) |= _PAGE_DIRTY;
> >
> > I'm not sure whether mm has rule to always set write bit then set dirty
> > bit, need to be careful here because the outcome may differ when use:
> >
> >   pte_mkdirty(pte_mkwrite(pte))
> >   (expected)
> >
> > VS:
> >
> >   pte_mkwrite(pte_mkdirty(pte))
> >   (dirty not set)
> >
> > I had a feeling I miss some arch-specific details here on why loongarch
> > needs such implementation, but I can't quickly tell.
>
> After a closer look I think it's fine for loongarch as pte_mkwrite will
> also set the dirty bit unconditionally, so at least the two ways will still
> generate the same pte (DIRTY+MODIFIED+WRITE).
>
> But this whole thing is still confusing to me.  It'll still be great if
> anyone can help explain why the _DIRTY cannot be set only in pte_mkwrite()
> if that's the solo place in charge of "whether the pte is writable".
>
> The other follow up question is: how do we mark "this pte contains valid
> data" (the common definition of "dirty bit"), while "this pte is not
> writable" on loongarch?
>
> It can happen when we're installing a page with non-zero data meanwhile
> wr-protected.  That's actually a valid case for userfaultfd wr-protect mode
> where user specified UFFDIO_COPY ioctl with flag UFFDIO_COPY_MODE_WP, where
> we'll install a non-zero page from user buffer but don't grant write bit.
>
> From code-wise, I think it can be done currently with this on loongarch:
>
>   pte_wrprotect(pte_mkwrite(pte_mkdirty(pte)))
>
> Where pte_wrprotect(pte_mkwrite(pte)) is not a no-op but applying MODIFIED.

We would like to note that on LoongArch (for misunderstanding naming):
* _PAGE_DIRTY meaning hardware writable.
* _PAGE_WRITE meaning software writable.
* _PAGE_MODIFIED meaning software dirty, this page contains updated valid data.

PTE APIs:
* pte_mkwrite: Allow to write, only needs set _PAGE_WRITE.
* pte_mkdirty: Mark as dirty, only needs set _PAGE_MODIFIED.
* pte_dirty: Test is dirty, only test _PAGE_MODIFIED.
* pte_wrprotect: Clear both writable, force to raise exception to
handle_mm_fault.

If a pte is only set _PAGE_WRITE without _PAGE_DIRTY by pte_mkwrite,
then a write memory access will cause mmu exception, and the
(_PAGE_DIRTY|_PAGE_MODIFIED) will be set in this exception handler. I
think the _PAGE_DIRTY is also possible to set in pte_mkwrite for
speedup, then _PAGE_MODIFIED must be set at the same time. To avoid
the page data being modified but not detected by pte_dirty. (Current
code may needs to fix

pte_mkdirty mark pte as dirty is the main function, It can also make
pte writeable by hardware(_PAGE_DIRTY) for speedup (too) if and only
if the pte is writable(_PAGE_WRITE). (mkdirty sets _PAGE_DIRTY
unconditionally is the root cause of the huge page COW issue.

For write-protection, pte_wrprotect will clear both writable(software
and hardware) in pte to force a MMU exception to handle_mm_fault.

So yeah, the pte marked as dirty(_PAGE_MODIFIED) and without any
writable in the following code:

  pte_wrprotect(pte_mkwrite(pte_mkdirty(pte)))

Regards,
Ray

>
> While on many other archs it'll be as simple as:
>
>   pte_mkdirty(pte)
>
> But that's really error-prone and not obvious.
>
> Copying Hev too.
>
> Thanks,
>
> --
> Peter Xu
>

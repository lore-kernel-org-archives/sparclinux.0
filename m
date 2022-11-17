Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1060C43219
	for <sparclinux@archiver.kernel.org>; Thu, 17 Nov 2022 18:30:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240657AbiKQSaJ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 17 Nov 2022 13:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240558AbiKQS34 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 17 Nov 2022 13:29:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA24F79908
        for <sparclinux@vger.kernel.org>; Thu, 17 Nov 2022 10:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668709737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SCwrHAH8w/75e7RIvwniXR2/IhWfvKJ1bBk1DvOk8y4=;
        b=Ke3aS4W5dWK7uLdAILX2L+GjvkE+vDfH1tg1ux1IYYr9U/HyAK2qiVhRoJRig7pt4vgVga
        oagwNfpWYhGqBxI3wN4FUcnekvKaXri8L00NZIaRUoMRPl9LNPx7tcwZj0l0eC/9QnBLTb
        HnvmCJOKcmrCY7vaxWnlf0rXJYD8uyY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-1M5eF9AJPjSHXxaoImLOSw-1; Thu, 17 Nov 2022 13:28:55 -0500
X-MC-Unique: 1M5eF9AJPjSHXxaoImLOSw-1
Received: by mail-qt1-f200.google.com with SMTP id gc12-20020a05622a59cc00b003a5444280e1so2455322qtb.13
        for <sparclinux@vger.kernel.org>; Thu, 17 Nov 2022 10:28:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SCwrHAH8w/75e7RIvwniXR2/IhWfvKJ1bBk1DvOk8y4=;
        b=zQsj4THf3C3T/74ix45eaE/SKEru5JW17WJd/wgKWFLv0R6Usm8Rpw3WaMTH8T20p/
         I+VAzgNCOG5wXB3hdFB0CDfDIrVeHEkdfuZHxoCBrCumgYk3Ym8I1jzTqzkJ8DgFBerU
         t9Ka6Os/egLYfNQwr64dK9EjwfNr79iZ1Dj2lFv3aIXcMNTEmN9OD7feCbpz+aOWR+p/
         XZAkyezxORPS9QFoabxOLcbyJQk7XxX8cVKmElzc8kZ1DEwT5KO81DdOG/YagYdBypgL
         8pelc9EY0vGyPEDbKZo+bepqfhB3XB/KQjJH5acPI7UeMP185lmw28MwKfj6zrMgfbuO
         6JGg==
X-Gm-Message-State: ANoB5pkzSdomq+iyJ+ciIoYhveHuoYUogUwSBXIlcK3ua9W6SST1FF8z
        pnxQW7n2S1VAkBHRjo4T26HWhb13E5GdpQT1NFAJsE/Ym8wgWtYdw/Zjux1ZJDvgaI85yVMUDuC
        64e4MYXr5/gZuZOm7ol1mnQ==
X-Received: by 2002:a37:aad6:0:b0:6fa:e0bb:cb6d with SMTP id t205-20020a37aad6000000b006fae0bbcb6dmr2861718qke.707.1668709735336;
        Thu, 17 Nov 2022 10:28:55 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6x5K8X5t9p31ZONbie6/kQJJQKF067lEy8gKV5E7CZydHtJU7W40Elm22ZNmEjr6VTLNzuwA==
X-Received: by 2002:a37:aad6:0:b0:6fa:e0bb:cb6d with SMTP id t205-20020a37aad6000000b006fae0bbcb6dmr2861702qke.707.1668709735067;
        Thu, 17 Nov 2022 10:28:55 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id o10-20020ac841ca000000b00399fe4aac3esm733817qtm.50.2022.11.17.10.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 10:28:54 -0800 (PST)
Date:   Thu, 17 Nov 2022 13:28:53 -0500
From:   Peter Xu <peterx@redhat.com>
To:     hev <r@hev.cc>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Message-ID: <Y3Z9Zf0jARMOkFBq@x1n>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3UPAKqVp6WAmRHV@x1n>
 <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Nov 17, 2022 at 10:29:57AM +0800, hev wrote:
> Hi Peter,

Hi, Hev,

> 
> On Thu, Nov 17, 2022 at 12:25 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> > > On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> > > >
> > > > Hello Peter,
> >
> > Hi, Hev,
> >
> > Thanks for letting me know.
> >
> > > >
> > > > I see a random crash issue  on the LoongArch system, that is caused by
> > > > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > > > pmd").
> > > >
> > > > Now, the thing is already resolved. The root cause is arch's mkdirty
> > > > is set hardware writable bit in unconditional. That breaks
> > > > write-protect and then breaks COW.
> >
> > Could you help explain how that happened?
> >
> > I'm taking example of loongarch here:
> >
> > static inline pte_t pte_mkdirty(pte_t pte)
> > {
> >         pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
> >         return pte;
> > }
> >
> > #define _PAGE_MODIFIED          (_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
> > #define _PAGE_MODIFIED_SHIFT    9
> 
> _PAGE_MODIFIED is a software dirty bit
> 
> > #define _PAGE_DIRTY             (_ULCAST_(1) << _PAGE_DIRTY_SHIFT)
> > #define _PAGE_DIRTY_SHIFT       1
> 
> _PAGE_DIRTY is a hardware writable bit (bad naming), meaning that mmu
> allows write memory without any exception raised.

(I just missed this email before I reply to the other one, I should have
 read this one first..)

I see. This surprises me a bit, as I can't quickly tell how it'll always
work with the generic mm code.

Say, is there a quick answer on why _PAGE_DIRTY is set here rather than
pte_mkwrite()?  Because AFAIU that's where the mm wants to grant write
permission to a page table entry as the API, no?

> 
> >
> > I don't see when write bit is set, which is bit 8 instead:
> >
> > #define _PAGE_WRITE             (_ULCAST_(1) << _PAGE_WRITE_SHIFT)
> > #define _PAGE_WRITE_SHIFT       8
> 
> _PAGE_WRITE is a software writable bit (not hardware).
> 
> As David said, In __split_huge_pmd_locked, the VMA does not include VM_WRITE,
> 
> entry = maybe_mkwrite(entry, vma);
> 
> so the pte does not include software writable bit (_PAGE_WRITE).

Are you sure?  In your test case you mapped with RW, IIUC it means even
after the fork() VM_WRITE is set on both sides?

But I agree the write bit is not set, not because !VM_WRITE, but because we
take care of that explicitly to make sure pte has the same write bit as pmd:

                (pmd used to be wr-protected due to fork())
		write = pmd_write(old_pmd);
                ...

                (then when split pte shouldn't have write bit too)
                if (!write)
                        entry = pte_wrprotect(entry);

> 
> and the dirty is true,
> 
> if (dirty)
>     entry = pte_mkdirty(entry);
> 
> so the incorrect arch's pte_mkdirty set hardware writable
> bit(_PAGE_DIRTY) in unconditional for read-only pages.

True, that does also apply to sparc64 pte_mkdirty() with _PAGE_W_4[UV].  I
should have noticed earlier that its comment told me that's a write bit
already..

#define _PAGE_W_4U	  _AC(0x0000000000000002,UL) /* Writable             */

Thanks,

-- 
Peter Xu


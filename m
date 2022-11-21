Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A222AC4332F
	for <sparclinux@archiver.kernel.org>; Mon, 21 Nov 2022 18:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiKUS47 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 21 Nov 2022 13:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbiKUS4x (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 21 Nov 2022 13:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2FA59FD5
        for <sparclinux@vger.kernel.org>; Mon, 21 Nov 2022 10:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669056956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vNb5TWM1Ex5oTrwhjEXEfbipjw7z3HX9TgJtMa+3kWw=;
        b=cycuQ2rUu64sU+y5Kvf5gO90/9IlefdiYm4UvnAP5AtCbbRGL9rTWQFTuUStDb0ohvaSPm
        jBX//mFbllWaEXFAF06bnI//OBjmBsAyOTSg0+ak4GVxb0hpwtMnbZeTr5BqV9uhBqxoW3
        S6e1l4ZtvQbmNHLigSDhaw01nqtfV4o=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-wqsDUtH7OomBD5NoK8HtLg-1; Mon, 21 Nov 2022 13:55:55 -0500
X-MC-Unique: wqsDUtH7OomBD5NoK8HtLg-1
Received: by mail-qk1-f200.google.com with SMTP id i17-20020a05620a249100b006fa2e10a2ecso16592009qkn.16
        for <sparclinux@vger.kernel.org>; Mon, 21 Nov 2022 10:55:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vNb5TWM1Ex5oTrwhjEXEfbipjw7z3HX9TgJtMa+3kWw=;
        b=F45bekgEN1wnC6yfSai1ASj3ANsxlEUbg8YZkjCblcC9z1pi0A2flVSqyWSxRnKWvd
         vIfWWTAIAEr7egkHrV0DdBvKhcQCXr95ytuer2KfgFY3b8zDCJhhK7AL5uoeoV4VHZKk
         5ZrqMrfEcY1IMGzDdbvLYd9oZ8xkCG2/hcHbZQEtjcvRFBJp0jwX8wvTfM/HRQtIvOvd
         K6FG2oVfBRosSg6B3msxuAdtKm8084REwq+b9/AbnXplSBZTQDnXE7Wxng00JsOIorcL
         MKrQpGv4tgoVAqplUVmyOWCYGjYpKEVYdJOM2KXj8yMzeIVnGwQAyZWBKBtBR55TW8xv
         qQAg==
X-Gm-Message-State: ANoB5pneuk6/OqG5d/XLPp0XIAqPmzKou8p/GpE1OzzNp/3KrERlalzU
        izH69oW0nkRwxruz9epXHK6z7ZAuRJnaE+P+1jLaQcgVVqYX+Wl5D/StqS9/ufyQhsbMaWJHLgM
        J9SP4dsmr6B7wnJ0WRJlCQA==
X-Received: by 2002:ac8:41d0:0:b0:39c:b702:8ec with SMTP id o16-20020ac841d0000000b0039cb70208ecmr18280495qtm.253.1669056953754;
        Mon, 21 Nov 2022 10:55:53 -0800 (PST)
X-Google-Smtp-Source: AA0mqf671XvtqVEYSSt0VvwoYRnvBNU5DmAwJSm3eexlvvQqhsxWuf1JDsdhesL0eeu6wzPGE1oNuw==
X-Received: by 2002:ac8:41d0:0:b0:39c:b702:8ec with SMTP id o16-20020ac841d0000000b0039cb70208ecmr18280478qtm.253.1669056953454;
        Mon, 21 Nov 2022 10:55:53 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id t18-20020a05620a451200b006fafc111b12sm8931024qkp.83.2022.11.21.10.55.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 10:55:52 -0800 (PST)
Date:   Mon, 21 Nov 2022 13:55:51 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>, hev <r@hev.cc>
Cc:     hev <r@hev.cc>, Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Message-ID: <Y3vJt+im60gTCNJi@x1n>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="e9TD/csLxyFJ3Twt"
Content-Disposition: inline
In-Reply-To: <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


--e9TD/csLxyFJ3Twt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi, Anatoly (or/and Hev),

On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> >
> > Hello Peter,
> >
> > I see a random crash issue  on the LoongArch system, that is caused by
> > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > pmd").
> >
> > Now, the thing is already resolved. The root cause is arch's mkdirty
> > is set hardware writable bit in unconditional. That breaks
> > write-protect and then breaks COW.
> >
> > Here is a simple and fast testcase (It may be helpful for sparc64):
> > https://gist.github.com/heiher/72919fae6b53f04cac606a9631100506
> > (assertion: c sum == 0)
> 
> Just tried on my sparc64 VM -  fixed vs old (non-patched) kernels...
> 
> fixed kernel (6.1.0-rc5) running ./a.out:
> mator@ttip:~$ ./a.out
> c sum: 0
> p sum: 35184372088832
> c sum: 0
> p sum: 35184372088832
> c sum: 0
> p sum: 35184372088832
> c sum: 0
> p sum: 35184372088832
> c sum: 0
> p sum: 35184372088832
> ...
> 
> old (non-patched) kernel (6.1.0-rc4) :
> mator@ttip:~$ ./a.out
> c sum: 35150012350464
> p sum: 35184372088832
> c sum: 35150012350464
> p sum: 35184372088832
> ...

I've got another patch attached that might be nicer to fix this same
problem for both archs but without dropping the dirty bit, could you help
check whether it works?

Hopefully the new patch could replace the other one (624a2c94f5b7 Partly
revert "mm/thp: carry over dirty bit when thp splits on pmd") in Andrew's
tree before it lands next rc1, and this new one should be applicable
directly to e.g. v6.0 tag (or need to have 624a2c94f5b7 reverted if on any
of Andrew's trees).

-- 
Peter Xu

--e9TD/csLxyFJ3Twt
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-mm-thp-Wr-protect-pte-after-mkdirty.patch"

From e349b24573870ef50d0c1b3bf124e14f5dfe1fa5 Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Mon, 21 Nov 2022 13:36:59 -0500
Subject: [PATCH] mm/thp: Wr-protect pte after mkdirty
Content-type: text/plain

Anatoly Pugachev reported sparc64 breakage on the patch:

https://lore.kernel.org/r/20221021160603.GA23307@u164.east.ru

Hev <r@hev.cc> also reported similar issue on loongarch:

(the original mail was private, but Anatoly copied the list here)
https://lore.kernel.org/r/CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com

Also Hev pointed out that the issue is having HW write bit set within the
pte_mkdirty() so the split pte can be written after split even if e.g. they
were shared by more than one processes, causing data corrupt.

Hev also tried to explain why loongarch set HW write bit in mkdirty:

https://lore.kernel.org/r/CAHirt9itKO_K_HPboXh5AyJtt16Zf0cD73PtHvM=na39u_ztxA@mail.gmail.com

One way to fix it is as what Huacai proposed here for loongarch:

https://lore.kernel.org/r/20221117042532.4064448-1-chenhuacai@loongson.cnn

Or more agressively, not sure whether (IMHO) we can remove the
"optimization" to grant HW write bit in pte_mkdirty() in both archs,
leaving set the write bit only in pte_mkwrite().

For now the simpler solution that'll work for all is we wr-protect after
pte_mkdirty(), so the HW write bit can be persistent after thp split.

Cc: Hev <r@hev.cc>
Cc: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/huge_memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index e5f5a1a00596..ae90b65f6121 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2191,13 +2191,18 @@ static void __split_huge_pmd_locked(struct vm_area_struct *vma, pmd_t *pmd,
 			entry = maybe_mkwrite(entry, vma);
 			if (anon_exclusive)
 				SetPageAnonExclusive(page + i);
-			if (!write)
-				entry = pte_wrprotect(entry);
 			if (!young)
 				entry = pte_mkold(entry);
 			/* NOTE: this may set soft-dirty too on some archs */
 			if (dirty)
 				entry = pte_mkdirty(entry);
+			/*
+			 * NOTE: this needs to happen after pte_mkdirty,
+			 * because some archs (sparc64, loongarch) could
+			 * set hw write bit when mkdirty.
+			 */
+			if (!write)
+				entry = pte_wrprotect(entry);
 			if (soft_dirty)
 				entry = pte_mksoft_dirty(entry);
 			if (uffd_wp)
-- 
2.37.3


--e9TD/csLxyFJ3Twt--


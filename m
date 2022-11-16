Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04888C433FE
	for <sparclinux@archiver.kernel.org>; Wed, 16 Nov 2022 16:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238691AbiKPQeB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 11:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiKPQdk (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Nov 2022 11:33:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7023C6584E
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 08:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668615940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tZZG5773YY8mLmTXTvUfSvM9dtomJZB7uijJ4GU3KOw=;
        b=hLr/SJgM9vfGyvl8rtU8efbS6zSG1WF6Dly8Aa1SVJ51UwDkOIEbmA81GD+D03Sw7ott0q
        yHwFGmm6KTBlaS0UXdDO1/fB/0ZA41z869gjr6wXUWQTNPt+hDsVCTtzzxch3fTFwCGaTO
        7CP5tinJdXxM6AirWh5ltE0amN7RmNo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-628-Qq7MVi5WMOqDz_L1yMfShg-1; Wed, 16 Nov 2022 11:25:39 -0500
X-MC-Unique: Qq7MVi5WMOqDz_L1yMfShg-1
Received: by mail-qk1-f198.google.com with SMTP id bk30-20020a05620a1a1e00b006fb2378c857so16993125qkb.18
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 08:25:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZZG5773YY8mLmTXTvUfSvM9dtomJZB7uijJ4GU3KOw=;
        b=oIxfBe4u+EzudJrp+VVX4JPWKBToAfpkA4fMVGwywKSu4RZD0pWKezCapgI0vhHXmM
         000RBh1gBBlBu5P7BmZuoPjMwdZdxd3duLaW3VWbTZIIRebT0iugwOUkW2a1yc35cRj0
         yZ3w9AYmeRGYY+ELkRYayY8MTKzAhTvs3iABc8T+H5DBWB917T5XSnxqPUJlI0DinREs
         Iw26A6PpJsbyNThgvxXS4SWZjiNcUEhyAQr6Nb5R/Zl20gEs7mO5xeCOSHZFVOkMz0Em
         uGWAXcsf+8lsE1g8IsOu+ssrfhsjypN+MUHic9vLIt0ANg0GqGQPPz+MhBx/XByxAq7N
         ZwJg==
X-Gm-Message-State: ANoB5pk9qzCsQDb55r91spGl8S6Btn0ftRwOQu77St3zrO/RfBDYvZbL
        fVaTEm+ttd5f1cg1aaqsB6rMVJ62DQdkOsX4wSd7GTeuPKSrmI0pxifXNADcVrN+7AG4seocH0s
        K+DkECCCsx4ehyBCU17ahaA==
X-Received: by 2002:ac8:7a81:0:b0:3a5:6131:6438 with SMTP id x1-20020ac87a81000000b003a561316438mr21956458qtr.164.1668615937927;
        Wed, 16 Nov 2022 08:25:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7695HWXTep81cSyE1V03duopul61bFYUW3N8qUeviRu+gTCSrQMXJmzY9BDWU29BQ+ziD58Q==
X-Received: by 2002:ac8:7a81:0:b0:3a5:6131:6438 with SMTP id x1-20020ac87a81000000b003a561316438mr21956446qtr.164.1668615937677;
        Wed, 16 Nov 2022 08:25:37 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id s8-20020a05620a254800b006ee8874f5fasm10163228qko.53.2022.11.16.08.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 08:25:37 -0800 (PST)
Date:   Wed, 16 Nov 2022 11:25:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Anatoly Pugachev <matorola@gmail.com>, hev <r@hev.cc>
Cc:     hev <r@hev.cc>, Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Message-ID: <Y3UPAKqVp6WAmRHV@x1n>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> >
> > Hello Peter,

Hi, Hev,

Thanks for letting me know.

> >
> > I see a random crash issue  on the LoongArch system, that is caused by
> > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > pmd").
> >
> > Now, the thing is already resolved. The root cause is arch's mkdirty
> > is set hardware writable bit in unconditional. That breaks
> > write-protect and then breaks COW.

Could you help explain how that happened?

I'm taking example of loongarch here:

static inline pte_t pte_mkdirty(pte_t pte)
{
	pte_val(pte) |= (_PAGE_DIRTY | _PAGE_MODIFIED);
	return pte;
}

#define _PAGE_MODIFIED		(_ULCAST_(1) << _PAGE_MODIFIED_SHIFT)
#define	_PAGE_MODIFIED_SHIFT	9
#define _PAGE_DIRTY		(_ULCAST_(1) << _PAGE_DIRTY_SHIFT)
#define	_PAGE_DIRTY_SHIFT	1

I don't see when write bit is set, which is bit 8 instead:

#define _PAGE_WRITE		(_ULCAST_(1) << _PAGE_WRITE_SHIFT)
#define	_PAGE_WRITE_SHIFT	8

According to loongarch spec:

https://loongson.github.io/LoongArch-Documentation/LoongArch-Vol1-EN.html#section-multi-level-page-table-structure-supported-by-page-walking

Bits 1 & 8 match the spec D & W definitions.  Bit 9 seems not defined but I
didn't quickly spot how that's related to the write bit.

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

Thanks for the quick run, Anatoly.  Obviously I went the wrong way before
on the code patching.  It seems we have more chance fixing this.

-- 
Peter Xu


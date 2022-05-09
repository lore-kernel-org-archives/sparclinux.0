Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A421BC433F5
	for <sparclinux@archiver.kernel.org>; Mon,  9 May 2022 04:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbiEIEQS (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 9 May 2022 00:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbiEIEKm (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 9 May 2022 00:10:42 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467529D4D9
        for <sparclinux@vger.kernel.org>; Sun,  8 May 2022 21:06:49 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d22so12686484plr.9
        for <sparclinux@vger.kernel.org>; Sun, 08 May 2022 21:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=i8fTOca+12ZBwL8GFn68r89tRt5Zov30Zcvy0gFIx3s=;
        b=7oatG6weF86vW9pYog/WbnQv4ca5m77rm6XTxoXr1wXD+MeQ64n02aa13Lj0IMGWDh
         0jcAZ1/E8rhHmjwEiLH/wurqHwo7x7/oZPYnCacuSWGecYOh1cK7FR/f3ATgGUHe2XoH
         alZRF5CLU74LfUYGYSIuPW6xCoE9yhYrt5aPGmZHPMFjbnAa5HGvTb+BGlG1lzOEp7hA
         36hA/3+gDs89H4Ko4WXpK9eOIJ7FvaCtE+d5TzIwgk5OffyCSOeBgBkeqs8WGQvukk6n
         Rziui08UqLz3/L11wKnIDNIsOSawBpoleO3JIuQk/5rZjNynFDwVMrI47wZqmUxCKfmZ
         bBpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8fTOca+12ZBwL8GFn68r89tRt5Zov30Zcvy0gFIx3s=;
        b=Dyf67IBdHr03ImnE69HFiqyrDuIX5OuF4llDMVKyvsaGf/u3DqWr9pBNKCCitmhitR
         z8vZDLxl903smvmsgLiZsM/epcWvQp0eAztQZEBmDk9rrAl95hK4JLj8btvqtOB1xJv9
         BT6MtbHxtcfOeDPeiyvieobKxieUEaIy6xXteoylEK+4FjnYrP6BfkkpUAbI/vAdl1wS
         LOzj3+U0m77fos0eaat7gynkGMv4UuUemYrVj3u0d1htrSvM99YOrAOrHsgMN0Cw69NX
         Q8Ra40rhxYnX0kwaPaGaj0J+wZ1bG7E4qNqQOtP45gjJ+Z6hs496H07YPBYrc3f9DeX4
         izZw==
X-Gm-Message-State: AOAM532RXTW1mIGRwFoPwYAKt0n7Lb30kAxe3/8xRB17nIdPSYiYUi/3
        /PzXNbuGNdXu6aPOml9GPQEwrBDm0RqIfQ==
X-Google-Smtp-Source: ABdhPJzXNNNMoKGLlNS0rEzt5xQj0NLF+6rNIW0g3Nng1UFaP6z9LjY7xwl48st6GzktvUM1QgACdw==
X-Received: by 2002:a17:902:758a:b0:15e:ef4f:fed5 with SMTP id j10-20020a170902758a00b0015eef4ffed5mr12919922pll.1.1652069208384;
        Sun, 08 May 2022 21:06:48 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902ab8400b0015e8d4eb1f8sm5831321plr.66.2022.05.08.21.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 21:06:47 -0700 (PDT)
Date:   Mon, 9 May 2022 12:06:43 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        catalin.marinas@arm.com, will@kernel.org,
        tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
        deller@gmx.de, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, ysato@users.sourceforge.jp, dalias@libc.org,
        davem@davemloft.net, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: change huge_ptep_clear_flush() to return the
 original pte
Message-ID: <YniTU+iT/pV5j/41@FVFYT0MHHV2J.usts.net>
References: <cover.1652002221.git.baolin.wang@linux.alibaba.com>
 <012a484019e7ad77c39deab0af52a6755d8438c8.1652002221.git.baolin.wang@linux.alibaba.com>
 <Ynek+b3k6PVN3x7J@FVFYT0MHHV2J.usts.net>
 <bf627d1a-42f8-77f3-6ac2-67edde2feb8a@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf627d1a-42f8-77f3-6ac2-67edde2feb8a@linux.alibaba.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, May 08, 2022 at 09:09:55PM +0800, Baolin Wang wrote:
> 
> 
> On 5/8/2022 7:09 PM, Muchun Song wrote:
> > On Sun, May 08, 2022 at 05:36:39PM +0800, Baolin Wang wrote:
> > > It is incorrect to use ptep_clear_flush() to nuke a hugetlb page
> > > table when unmapping or migrating a hugetlb page, and will change
> > > to use huge_ptep_clear_flush() instead in the following patches.
> > > 
> > > So this is a preparation patch, which changes the huge_ptep_clear_flush()
> > > to return the original pte to help to nuke a hugetlb page table.
> > > 
> > > Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > > Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> > 
> > Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> 
> Thanks for reviewing.
> 
> > 
> > But one nit below:
> > 
> > [...]
> > > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > > index 8605d7e..61a21af 100644
> > > --- a/mm/hugetlb.c
> > > +++ b/mm/hugetlb.c
> > > @@ -5342,7 +5342,7 @@ static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
> > >   		ClearHPageRestoreReserve(new_page);
> > >   		/* Break COW or unshare */
> > > -		huge_ptep_clear_flush(vma, haddr, ptep);
> > > +		(void)huge_ptep_clear_flush(vma, haddr, ptep);
> > 
> > Why add a "(void)" here? Is there any warning if no "(void)"?
> > IIUC, I think we can remove this, right?
> 
> I did not meet any warning without the casting, but this is per Mike's
> comment[1] to make the code consistent with other functions casting to void
> type explicitly in hugetlb.c file.
>

Got it. I see hugetlb.c per this rule, while others do not.
 
> [1]
> https://lore.kernel.org/all/495c4ebe-a5b4-afb6-4cb0-956c1b18d0cc@oracle.com/
> 

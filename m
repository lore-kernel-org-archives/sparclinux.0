Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C9C4332F
	for <sparclinux@archiver.kernel.org>; Fri, 25 Nov 2022 18:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiKYSng (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 13:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiKYSnf (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 25 Nov 2022 13:43:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21AD41B79F
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 10:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669401760;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oualrKRDDf0lFn/7Xv9q0zEvBMrRXi9BI43GVn40pF4=;
        b=jMIdQ72+tX/SwVURh5lDmOWcLimL7Udd13b9ouofolFcPCZyQxUJjIwCRt7/s5A9yi5ROM
        HXgihOc138xHo8RWdParxOh6+FCrxk5eJ7xNQwGVEqisNgDwcTqJ4aTAUky+8djX50c2Cn
        PyErjmnGSb7bfVFgCL2h9ZcAyYY24CQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-vQAOYpCbN-WmTv4rD-P8NA-1; Fri, 25 Nov 2022 13:42:39 -0500
X-MC-Unique: vQAOYpCbN-WmTv4rD-P8NA-1
Received: by mail-qv1-f72.google.com with SMTP id ob12-20020a0562142f8c00b004c6c72bf1d0so4285133qvb.9
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 10:42:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oualrKRDDf0lFn/7Xv9q0zEvBMrRXi9BI43GVn40pF4=;
        b=uI8DT7mXL7YXHQv8KsJElmhw6R3Uxn3rlrwfSjI6hmqHwDXHKKGaJ20JSSEF/BargV
         F4YrLxL9zSuW44CjZJz6gCOBlWacgFhIfCylUm1aou2FhbQcTU8PWcZ1wZSFVS8z+QQO
         RJBANeWokrQ/YW3WXK4AbLMKDrtHZVLHMtKmc42CX+nVNXItiES/GGsCzJgPSIugnoRs
         cRJyemJWRRVS9m/HeIYJpmmu9ODhKLWjMTkIU3VD/q/ukV+xO6rxu3m/OtFb0XuA9wI0
         3i4DgWHpQ2s67Yq7HMay0cegfiXTB/RTtirE67JmbLqZ3pR/i/29Ju8LA3nvdDvwDDIq
         3Rxw==
X-Gm-Message-State: ANoB5pmFW1V4gqmY2P4HBCQObzI5jcp1UWvarJQfWA+r8h/G+qRm+fum
        c8Tck1uzMCgG6Hg9XOUVLu5yD7plP+MmZE+iXy1Ocz3WrpppW4q6wWK13PT2xKApdmUdpK7uKw+
        Pb2Xu9HRT1YX1d0XZaL6guQ==
X-Received: by 2002:a0c:c3ca:0:b0:4bb:93b8:ef1c with SMTP id p10-20020a0cc3ca000000b004bb93b8ef1cmr26142587qvi.103.1669401758110;
        Fri, 25 Nov 2022 10:42:38 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7i65clZj7lCw/dYMc+dXk3OnMDFGdYdSo5GonSQ2rsAw6malshv/ckO5F4O0oDweedDgFMIw==
X-Received: by 2002:a0c:c3ca:0:b0:4bb:93b8:ef1c with SMTP id p10-20020a0cc3ca000000b004bb93b8ef1cmr26142561qvi.103.1669401757856;
        Fri, 25 Nov 2022 10:42:37 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-46-70-31-27-79.dsl.bell.ca. [70.31.27.79])
        by smtp.gmail.com with ESMTPSA id br7-20020a05620a460700b006faa2c0100bsm3205819qkb.110.2022.11.25.10.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 10:42:37 -0800 (PST)
Date:   Fri, 25 Nov 2022 13:42:36 -0500
From:   Peter Xu <peterx@redhat.com>
To:     hev <r@hev.cc>
Cc:     Anatoly Pugachev <matorola@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on
 pmd"
Message-ID: <Y4EMnNiLdC7G+oKu@x1n>
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3vJt+im60gTCNJi@x1n>
 <CAHirt9jjjcj9FdhiJZJLhA-7iNRrWgsMYDYPpyOc0a_k7NhGqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHirt9jjjcj9FdhiJZJLhA-7iNRrWgsMYDYPpyOc0a_k7NhGqA@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Nov 25, 2022 at 07:38:36PM +0800, hev wrote:
> On Tue, Nov 22, 2022 at 2:55 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, Anatoly (or/and Hev),
> >
> > On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> > > On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> > > >
> > > > Hello Peter,
> > > >
> > > > I see a random crash issue  on the LoongArch system, that is caused by
> > > > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > > > pmd").
> > > >
> > > > Now, the thing is already resolved. The root cause is arch's mkdirty
> > > > is set hardware writable bit in unconditional. That breaks
> > > > write-protect and then breaks COW.
> > > >
> > > > Here is a simple and fast testcase (It may be helpful for sparc64):
> > > > https://gist.github.com/heiher/72919fae6b53f04cac606a9631100506
> > > > (assertion: c sum == 0)
> > >
> > > Just tried on my sparc64 VM -  fixed vs old (non-patched) kernels...
> > >
> > > fixed kernel (6.1.0-rc5) running ./a.out:
> > > mator@ttip:~$ ./a.out
> > > c sum: 0
> > > p sum: 35184372088832
> > > c sum: 0
> > > p sum: 35184372088832
> > > c sum: 0
> > > p sum: 35184372088832
> > > c sum: 0
> > > p sum: 35184372088832
> > > c sum: 0
> > > p sum: 35184372088832
> > > ...
> > >
> > > old (non-patched) kernel (6.1.0-rc4) :
> > > mator@ttip:~$ ./a.out
> > > c sum: 35150012350464
> > > p sum: 35184372088832
> > > c sum: 35150012350464
> > > p sum: 35184372088832
> > > ...
> >
> > I've got another patch attached that might be nicer to fix this same
> > problem for both archs but without dropping the dirty bit, could you help
> > check whether it works?
> 
> The tesecase PASSED with this patch and without:
>  * "Partly revert "mm/thp: carry over dirty bit when thp splits on pmd"
>  * "LoongArch: Set _PAGE_DIRTY only if _PAGE_WRITE is set in
> {pmd,pte}_mkdirty()"

My fault to not have noticed that the partly revert patch already landed
6.1-rc5, so it'll need to be another patch upon it.

I'll post a formal patch.  Thanks Hev.

-- 
Peter Xu


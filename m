Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8321CC4332F
	for <sparclinux@archiver.kernel.org>; Fri, 25 Nov 2022 11:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKYLgB (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 06:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbiKYLfx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 25 Nov 2022 06:35:53 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B311D309
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:35:52 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id f6so1857197ilu.13
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nFMkbAnvlKjqrt8rkBg30WNrIjYyI1CmHgOwIxQSg6g=;
        b=0VTK9We71iBfovVH6eRX30Pn4eygx5CPdkjqyEPBu4EIQK9YCqNJ5YOIceGhd8ru81
         sb/YXHDasclcT4WhgIR1vhBdt1LE2jkSjWjqKs1hHTKkuBQHurzBdozfbwhoDrGb1Ncn
         E6U2wGTjVGoi+dR5JN20AXAl1d1CKlx82fBduDOVrqOWnblTALtacet8t9Sar2Mjb1O4
         iFvowZAH+ro5yv5QUn2MHV+GPD9zYvSHfa/f1FF2synXMd86LErdE7xXbo8X7yqcWlRj
         M1Zpe8FM77nRsuxB9nyLnReCRS6sdVaCKyzS7qwPAcKKM3Rza++lyQMKVoWI2g5k89/k
         hzqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nFMkbAnvlKjqrt8rkBg30WNrIjYyI1CmHgOwIxQSg6g=;
        b=kGOsbkSN2sYd2Wmz1eCNsSj8Avd8t5kuZ3/+vJ6eJ5fIjzsXuJUtCGix6ygL+fGn2O
         AKaSJ1buRz/Ro7bmNFm5IHG5GVFMIbQJcKNbWd9bJUoKn795EaEmL2Sxot0xKtZrP27J
         xfGpuII6ZYIJX1DKXbFqei0dv4nsUl/vylIwd8en1lfdzcx6xpfMJ3DsN/4MttVHwtTR
         Z7q9y/aogLAQjjH+y6oecvtcdMuafx4/w8Tz3GhSJMoXLa++8iYWU9vOtDnAyd7ThkJs
         CiBT2z+lwkZu/0rzJas10plx9mF+7Vdy4NZRXdTy2U56UsAcKVD2VmFxQ1Xv8ROO+wtK
         RDYg==
X-Gm-Message-State: ANoB5pmNSrXDCYTSYCysnYy8oFmUwfimhFDwg00AUeVN3n+OeC5hwmht
        cQjfiAfewS7Tm8XBUOUqSv6gpsEIsjbslYKtzIzZuA==
X-Google-Smtp-Source: AA0mqf7MiR7YDkYZw39jYXOj065S7pDWNsadCAla+OXK2YrmHd8Gm8aWdYOS2cH/KtSQKk5tYRAIHsyoEt+Vg+8vXNY=
X-Received: by 2002:a92:dc84:0:b0:302:c7c0:25d6 with SMTP id
 c4-20020a92dc84000000b00302c7c025d6mr7700587iln.122.1669376151448; Fri, 25
 Nov 2022 03:35:51 -0800 (PST)
MIME-Version: 1.0
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3UPAKqVp6WAmRHV@x1n> <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
 <Y3Z9Zf0jARMOkFBq@x1n> <CAHirt9i8iLCP3_ppEL5kO2XLVAg0sno0GdzdKyzk7DSMTJF0tA@mail.gmail.com>
 <79cf9e73-440c-5ff0-856f-3df6c13061ef@redhat.com> <CAHirt9gKYojqqj3ty1+kLwxOc9DbjPj_WzLvOvx0SnWaWFGc4g@mail.gmail.com>
 <06b0a108-0496-ad28-a88c-a4d2fd554ca8@redhat.com>
In-Reply-To: <06b0a108-0496-ad28-a88c-a4d2fd554ca8@redhat.com>
From:   hev <r@hev.cc>
Date:   Fri, 25 Nov 2022 19:35:40 +0800
Message-ID: <CAHirt9hzmif4dyc5deGm=Ev+Ww12HoZOscY_6DnOGmG7AXZXMg@mail.gmail.com>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on pmd"
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>,
        Anatoly Pugachev <matorola@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Nov 25, 2022 at 7:17 PM David Hildenbrand <david@redhat.com> wrote:
>
> On 25.11.22 12:15, hev wrote:
> > Hi, David,
> >
> >>
> >> Just to ask again,
> >>
> >> is code like
> >>          maybe_mkwrite(pte_mkdirty(entry), vma);
> >>
> >> Like we have in copy_present_page(), wp_page_reuse(), wp_page_copy() ...
> >> broken on LoongArch of the VMA lacks VM_WRITE?
> >
> > Sorry for the late reply. In this test case, The VMA doesn't lack VM_WRITE.
> >
>
> Let me ask again: is this a problem in all of the functions I mentioned
> above were we *could* lack VM_WRITE?
>
> Because that needs fixing independently of this issue here.

Oops. sorry I don't know.

Peter?

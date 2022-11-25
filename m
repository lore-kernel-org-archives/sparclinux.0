Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 666FEC4332F
	for <sparclinux@archiver.kernel.org>; Fri, 25 Nov 2022 11:16:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKYLQK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 06:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbiKYLQJ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 25 Nov 2022 06:16:09 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3350D4EC0D
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:16:06 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id j27so1862335ila.1
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CNKUis7jq+hOURjGYnvRmUO6iQL643RnZMTMINr5/Ro=;
        b=IdY+cJ3ec7U5KmruL8QQBJNynqHFr5O+1e+QVsZn/COqVB7/z79zK8nQUBbQSRB6MN
         gegAE/TkUv8kSA7G/0JxalZY8aUfXaspwpMN1HbMc5kePnfez4ePOsd2VFwv4XFzkHJR
         f0Jbi7rUyNM2mtQYJDpjX4fjpfkJebmJxhUA0Q7lHe1YDpAz8tTQgS6dtL+0+xXI4Vn9
         2tya1zAv6+TnOVrW2Pz6IOXxR9CCUYVwgrd0jY6FhzLgRhi9+TW6g9qyPqihJtBJfb6M
         9AswiR/RlKa5kPSJry7RR/Z+OrqwPubNKhUg/lY5FqlxhP58NFPzYgpB9OXxT+hNAxD6
         tI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CNKUis7jq+hOURjGYnvRmUO6iQL643RnZMTMINr5/Ro=;
        b=4H1f3S1IiOb99dMlwMAPxQcXP32QT5v4SXsN/piZzrwdi8H/K6wj6AY5UP4a+GWqsn
         oud2/5hqsj+GcUqJNzfpssMGmN4NGKl3zsX3vBxJmbuNrljrlx3S6BomBva2O52I4KC8
         dC9gsP3xM5J5gzGgrzGjHOwhAAzomlTyJrhM+hciVXjXTMQy45sSM+6LNmzqNdFEf3Kg
         L9aFEXqaHHxF/PjVomBUyHMiTvktbNg0SeKLjuq3r8ijntoX5O6Gheac/AP/8G4ok0CS
         f4eGoV+JQOpM6w3Za0Cj4cI7W4k+1bnxF+bNmAg0Vv3ifb6miMKxOLy8jcDbEU1Dp1Bw
         27WQ==
X-Gm-Message-State: ANoB5pl20sWpE7qBkmyI7YmE2jr9HyQFsehbzhT7cGf49PJTBFExZYl5
        STbmmkRBoXcs2SLWwlZNr9M8XCLLQFS9Nef1dP8koxSz7XwuqC6HjhU=
X-Google-Smtp-Source: AA0mqf7B9whAUyiqgxa2s1b5aXoaN1v69MCHV5r99K/9o2owJsmj2c5wXpH1Y2tAsPrGrDp/ZSGyfdSGHsppW76bz1M=
X-Received: by 2002:a92:dd90:0:b0:302:3dbd:c1bd with SMTP id
 g16-20020a92dd90000000b003023dbdc1bdmr16894002iln.149.1669374965621; Fri, 25
 Nov 2022 03:16:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
 <Y3UPAKqVp6WAmRHV@x1n> <CAHirt9i03CFCK-4XNZb8dUxHrQqKx8c0_3=S2Y3oNvUex3xCBw@mail.gmail.com>
 <Y3Z9Zf0jARMOkFBq@x1n> <CAHirt9i8iLCP3_ppEL5kO2XLVAg0sno0GdzdKyzk7DSMTJF0tA@mail.gmail.com>
 <79cf9e73-440c-5ff0-856f-3df6c13061ef@redhat.com>
In-Reply-To: <79cf9e73-440c-5ff0-856f-3df6c13061ef@redhat.com>
From:   hev <r@hev.cc>
Date:   Fri, 25 Nov 2022 19:15:54 +0800
Message-ID: <CAHirt9gKYojqqj3ty1+kLwxOc9DbjPj_WzLvOvx0SnWaWFGc4g@mail.gmail.com>
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

Hi, David,

>
> Just to ask again,
>
> is code like
>         maybe_mkwrite(pte_mkdirty(entry), vma);
>
> Like we have in copy_present_page(), wp_page_reuse(), wp_page_copy() ...
> broken on LoongArch of the VMA lacks VM_WRITE?

Sorry for the late reply. In this test case, The VMA doesn't lack VM_WRITE.

Regards,
Ray

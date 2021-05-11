Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F19C43462
	for <sparclinux@archiver.kernel.org>; Tue, 11 May 2021 17:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD746112F
	for <sparclinux@archiver.kernel.org>; Tue, 11 May 2021 17:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbhEKRxK (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 11 May 2021 13:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEKRxI (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 11 May 2021 13:53:08 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB47C061574
        for <sparclinux@vger.kernel.org>; Tue, 11 May 2021 10:52:01 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id g14so23928490edy.6
        for <sparclinux@vger.kernel.org>; Tue, 11 May 2021 10:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vvtm8n5cG3jzsceNHvZusZOhtfG69GGyP0C0zXimiGg=;
        b=H0AsqdZCMhypi9/Qd7/1eUPAVczkGpwzNdPrEzyRmHk3+xGYRUzHdDlO2l4ucRTL8I
         6IkWY+o747IONKRbHjInbulgo0QHOF+Aog+9sCymBmOTGkGLMG+u9jruv/UZbKRmL6Hs
         djJGJfy02eav+9cJ/e8taZvmfCdpWKwopL9l1L00vGTndNfe8I1Ba0qFSrrwJA5o7Fa2
         kypHmxkIMZ4AZTUMiSVLWlzzQG450CuwCzyuG27tqQfsnYHhRA1T87hFThJfEPtkcb4Y
         ue4D2yBkATCGXbxXcVfdq4bXxs/UCpwDO9F00VAa9ugcnvVl8Xt3EZbMRGFEais4Tdh5
         EGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vvtm8n5cG3jzsceNHvZusZOhtfG69GGyP0C0zXimiGg=;
        b=rcG1FoWV1nBhWW1gn9KOTgT49SQDvHYGYwR91Q2bk4iogNhn15WrrS+op++3P5KeYe
         2Iyf2HlQ8mceb0EcbsD047on0ZfxkL/O7k8Z4lI9BSIkeoHh5p9aRY65ZrI3OUBIqZeD
         xS9wfAeS3W8XCeaBSzvbuNplTFH9FdjDoXzJbE02Td0GhrMNkFi2D+DWA+6nB2o/m3M1
         i4HIfT4XTL1iqOfB+1wZes7s6uBKFbTpl7tyGsZokOOgmbRGycrLUZK48theeamcs2/B
         jU247fpHg+3zqjURqO/A9GNsVlxnrcGoTxNQ4KbJsAYv63k54ajk8JlIdLl/9lknzRUD
         1PGQ==
X-Gm-Message-State: AOAM531qu5Zo5zmzXAVngYDYILqCOw/I0C8cH7d5G1bgeoB+M9qtXfp5
        J8xISBHdnEevoMm7QwKFgpGdTvd0W1tKSfNGXXA6
X-Google-Smtp-Source: ABdhPJwdWMqdXYacKcJJowhKXF8ZQ0FIAVm666XBBWORfGjqUYLRbHiBohY3kurt7w0lB0ANXSdmCBIBLwgMolCf7vo=
X-Received: by 2002:a50:ed0c:: with SMTP id j12mr37675663eds.12.1620755519859;
 Tue, 11 May 2021 10:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1619811762.git.rgb@redhat.com> <bda073f2a8b11000ef40cf8b965305409ee88f44.1619811762.git.rgb@redhat.com>
 <CAHC9VhShi4u26h5OsahveQDNxO_uZ+KgzGOYEp5W7w6foA-uKg@mail.gmail.com> <20210511171356.GN3141668@madcap2.tricolour.ca>
In-Reply-To: <20210511171356.GN3141668@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 11 May 2021 13:51:48 -0400
Message-ID: <CAHC9VhQ9DgiMKScTt5xfyK25WM-KPUrFksFS7dH51u0+PemPLA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] audit: replace magic audit syscall class numbers
 with macros
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Paris <eparis@redhat.com>, x86@kernel.org,
        linux-alpha@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        Aleksa Sarai <cyphar@cyphar.com>,
        Arnd Bergmann <arnd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, May 11, 2021 at 1:14 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> On 2021-05-10 21:23, Paul Moore wrote:
> > On Fri, Apr 30, 2021 at 4:36 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > Replace audit syscall class magic numbers with macros.
> > >
> > > This required putting the macros into new header file
> > > include/linux/auditscm.h since the syscall macros were included for both 64
> > > bit and 32 bit in any compat code, causing redefinition warnings.
> >
> > The ifndef/define didn't protect against redeclaration?  Huh.  Maybe
> > I'm not thinking about this correctly, or the arch specific code is
> > doing something wonky ...
> >
> > Regardless, assuming that it is necessary, I would prefer if we called
> > it auditsc.h instead of auditscm.h; the latter makes me think of
> > sockets and not syscalls.
>
> The "m" was for "macros", since there are auditsc bits in audit.h as
> well, but I have no significant objection.

Yes, I figured as much, but my comment about it looking like a socket
"thing" still stands.  I'm open to other ideas if you don't like
auditsc.h, I just don't like auditscm.h.

-- 
paul moore
www.paul-moore.com

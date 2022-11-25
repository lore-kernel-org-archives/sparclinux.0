Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF543C4167B
	for <sparclinux@archiver.kernel.org>; Fri, 25 Nov 2022 11:38:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiKYLit (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 25 Nov 2022 06:38:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiKYLis (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 25 Nov 2022 06:38:48 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9E62C7
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:38:47 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id h206so2863971iof.10
        for <sparclinux@vger.kernel.org>; Fri, 25 Nov 2022 03:38:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hev-cc.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=E7IgBRLrN26csjoyOlj7OXuCSIOPcVr1KT0fOqHZPDc=;
        b=i+seDolEghhuGWo4CZLpJEYiXAPXra8oIC4ft92+JCY+rJv52518iM+XPtErh2QXlS
         JNrPO9SAq1CrpF3azQqUepsSDjBnSNsoGnS5ewsrnLxnxCHzOH24HyNMnJHubCC46Bn0
         zbwItDd0TcJ5fqoB+GVrawppY2ItfLbZM0jv0H8+BelmB5mqV5J1L55jev+H4WY3RldS
         6hqpi8HOP5AtktrnZ1sWeCHcX5m206I4+Gs3NTNlnMkBgtF1WtV7PwJpEJaH5vf5OKIQ
         SZ6Wrm4VRqpZELPQIRH1QS7sjLxguJPynk8nZmfUgpGvjGufNzVT0kSBcg3kAoK9GR2/
         EXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E7IgBRLrN26csjoyOlj7OXuCSIOPcVr1KT0fOqHZPDc=;
        b=AOY3+/BTNEa6OzS1gaXR3cytH8FqqLH25x5/hPzg+uYAnW6NRRGI+oQXiJ8ZMiO7m1
         eUMbGrRaK8DqOFSjG0aNC2sWhtYhEUr/QJZOOm5EZy4K+5F3lo4N4l8EiWSBAlLZwuu9
         5JYbfJKk61cJXs0g1CGJ+6BFwwIHdUA1FlFSPl8axH+4hjZ/BJEKTksD9qf+0/ptVC01
         A8DmwYsGtGUG6fC4ULUtoBjRWIYsgX0MwfaXkauhhKHfM4SYzeYg9fYG76YvIai28kpY
         /pdNP4jpVKt8M2SjKy6C5G57YJV7IIlQsOkHttWwdWfhDg4hx1OkTRGDxdPGnUxYqHz8
         p3XA==
X-Gm-Message-State: ANoB5plaLeKfiPNgGwv0ysjwmR0QqGpiap6AjqPn81wey467qJbAG/Dj
        qrMGnb7/H4lrtbqTlIAXlSXBMCKQgSETe84u2dJ3Hkj3t042M8L6ZHI=
X-Google-Smtp-Source: AA0mqf55LmzyS42LjSv7R5iHwxmtVimDa2+KoQzr2KnDWuGuNNL/pfG716wbX7eAWauoQodww+7KQQE34AqVc1tTDRc=
X-Received: by 2002:a02:ca45:0:b0:363:a4ae:5a80 with SMTP id
 i5-20020a02ca45000000b00363a4ae5a80mr17599519jal.105.1669376327025; Fri, 25
 Nov 2022 03:38:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
 <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com> <Y3vJt+im60gTCNJi@x1n>
In-Reply-To: <Y3vJt+im60gTCNJi@x1n>
From:   hev <r@hev.cc>
Date:   Fri, 25 Nov 2022 19:38:36 +0800
Message-ID: <CAHirt9jjjcj9FdhiJZJLhA-7iNRrWgsMYDYPpyOc0a_k7NhGqA@mail.gmail.com>
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

On Tue, Nov 22, 2022 at 2:55 AM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, Anatoly (or/and Hev),
>
> On Wed, Nov 16, 2022 at 01:45:15PM +0300, Anatoly Pugachev wrote:
> > On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
> > >
> > > Hello Peter,
> > >
> > > I see a random crash issue  on the LoongArch system, that is caused by
> > > commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> > > pmd").
> > >
> > > Now, the thing is already resolved. The root cause is arch's mkdirty
> > > is set hardware writable bit in unconditional. That breaks
> > > write-protect and then breaks COW.
> > >
> > > Here is a simple and fast testcase (It may be helpful for sparc64):
> > > https://gist.github.com/heiher/72919fae6b53f04cac606a9631100506
> > > (assertion: c sum == 0)
> >
> > Just tried on my sparc64 VM -  fixed vs old (non-patched) kernels...
> >
> > fixed kernel (6.1.0-rc5) running ./a.out:
> > mator@ttip:~$ ./a.out
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > c sum: 0
> > p sum: 35184372088832
> > ...
> >
> > old (non-patched) kernel (6.1.0-rc4) :
> > mator@ttip:~$ ./a.out
> > c sum: 35150012350464
> > p sum: 35184372088832
> > c sum: 35150012350464
> > p sum: 35184372088832
> > ...
>
> I've got another patch attached that might be nicer to fix this same
> problem for both archs but without dropping the dirty bit, could you help
> check whether it works?

The tesecase PASSED with this patch and without:
 * "Partly revert "mm/thp: carry over dirty bit when thp splits on pmd"
 * "LoongArch: Set _PAGE_DIRTY only if _PAGE_WRITE is set in
{pmd,pte}_mkdirty()"

Ray

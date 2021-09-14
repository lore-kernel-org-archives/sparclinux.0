Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E28DC433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 19:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A028610CE
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 19:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhINTuC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhINTuC (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 15:50:02 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413A0C061574;
        Tue, 14 Sep 2021 12:48:44 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bd1so812099oib.5;
        Tue, 14 Sep 2021 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F6PsShm2+LtRfF7zvUBuZb6sWSvD0FefZC4vf11za4g=;
        b=ftEVYmXtzBqtgPMuCUQK92nlXhVyaFSoDT+bYIlkiiKIMvqDadH4mSO1dIERn4gEEd
         +mCNnBQyYzd05jfVb6q5g36anr9co8J9dyiiABNwHw03o68G4BNeRVVNhDFroiB76Pgy
         J9A7KrlRcXjhoqiXdv1Kacuqks5rjrufLzjT6YSXt1n6aKj5bd00EqSTswj2YCnmYyu8
         bW7q4vl4/62EpYskk3Y/MHbVEmrMLV0C78/i7u8ArT7KrN2QqJXDvr2CfH53djfockAA
         XLbEolIWFIhVJgWPc7g1czGR/DoQRyuLptt1gjUjQ0oOcr88ArF+pixVCFa3ZXU63rrw
         e3hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F6PsShm2+LtRfF7zvUBuZb6sWSvD0FefZC4vf11za4g=;
        b=X2rAlUbI9We4jqvVuGtAvHM91aJXP1obmZ36N9Vz1WDZOgio4PWRzrOjENdjdpfwjL
         ZGizX0iCnYqytnAJCXf5YNud3M2Tjq/6PV88/VESAauTmy9AYcSsX5sf2tPUHDpp0C2l
         KFygTYKdKruE6PmaodkUteonhbV39zdif+eEiIFd88k8Ph8douah3V+i/eZtXsxinVPD
         bACEvK/JRbTPbsMljfxZJxL3bRhEpzP7nX0aXM0t4eK+ii+5Rj8LqMvSz0wh+BagXxZ8
         AljFZVvbflCP3Abj9IE/EyxSTdjRpNGc6mrm98ukSLGdvzGJHBgQafjqj3jFuWaQEf4+
         btRg==
X-Gm-Message-State: AOAM5333wBg64sndmJqyHbKDGkaufY6jatPIo7Ssj3QZLfWjWl16AS4E
        mtV8Cw/Cv6ssahjW62ppKIRo5Imp0RPR8Nk+qAQ=
X-Google-Smtp-Source: ABdhPJzmulVOve408+d4uWpQ3W0uTIjd3laX3vXZVJhsV8TXYBfwuMi48nlWry2DHtJD3C+p6c+qNZFmnxMn9erjRwc=
X-Received: by 2002:aca:ab06:: with SMTP id u6mr2676900oie.120.1631648922227;
 Tue, 14 Sep 2021 12:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210907100302.3684453-1-ray.huang@amd.com> <5e365947-4ae1-47a0-7565-7f0cdde0bd84@amd.com>
In-Reply-To: <5e365947-4ae1-47a0-7565-7f0cdde0bd84@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 14 Sep 2021 15:48:31 -0400
Message-ID: <CADnq5_PXOXiob3k5Z+cZz6K2k5iSCdzwNm0ZxKQOuC+PvdJxxg@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix the type mismatch error on sparc64
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Huang Rui <ray.huang@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 7, 2021 at 6:25 AM Christian K=C3=B6nig <christian.koenig@amd.c=
om> wrote:
>
> Am 07.09.21 um 12:03 schrieb Huang Rui:
> > __fls() on sparc64 return "int", but here it is expected as "unsigned
> > long" (x86). It will cause the build errors because the warning becomes
> > fatal while it is using sparc configuration. As suggested by Linus, it
> > can use min_t instead of min to force the type as "unsigned int".
> >
> > Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> > Signed-off-by: Huang Rui <ray.huang@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>

Is one of you going to push this to drm-misc?

Alex

>
> > ---
> >   drivers/gpu/drm/ttm/ttm_pool.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_p=
ool.c
> > index af1b41369626..c961a788b519 100644
> > --- a/drivers/gpu/drm/ttm/ttm_pool.c
> > +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> > @@ -382,7 +382,8 @@ int ttm_pool_alloc(struct ttm_pool *pool, struct tt=
m_tt *tt,
> >       else
> >               gfp_flags |=3D GFP_HIGHUSER;
> >
> > -     for (order =3D min(MAX_ORDER - 1UL, __fls(num_pages)); num_pages;
> > +     for (order =3D min_t(unsigned int, MAX_ORDER - 1, __fls(num_pages=
));
> > +          num_pages;
> >            order =3D min_t(unsigned int, order, __fls(num_pages))) {
> >               bool apply_caching =3D false;
> >               struct ttm_pool_type *pt;
>

Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7A0C433FE
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 20:03:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C56D6113B
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 20:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhINUEu (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 16:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232545AbhINUEs (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 16:04:48 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2D7C061574
        for <sparclinux@vger.kernel.org>; Tue, 14 Sep 2021 13:03:31 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id p15so891345ljn.3
        for <sparclinux@vger.kernel.org>; Tue, 14 Sep 2021 13:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Z+PxJcPDFHKhLidz43OpQIl4xQ/achkAfQ8Re5y2cOQ=;
        b=fcSz/fDM5ZUPGy3GEMeYii2Mxh/ipolL/v2vDh+qK9ADUjfXlFd3srXHg9A+o8Pmot
         n22YK0z4o/I8BYxXDzQ3BS6AWAC5kHEw+OHh03vX0v2TJL7SqBHx47TacnNtNh92CNRV
         fYIa/5xLSo1HRcb1pxNb1EXaluai7a63A3hPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Z+PxJcPDFHKhLidz43OpQIl4xQ/achkAfQ8Re5y2cOQ=;
        b=C6uivWNaOijQ7blC6W5w38itlZhYUgaJWnbVzJR5fAAhWQ0dR++uUPPzF1+EmhYYDu
         OiAAasS5/skdvpUaSiy+FJ6StPvlDS9VgHTnh+7cT07vsJ+2LoCLjBuXfQPZvMoy3OY6
         Vic3tK9vwGfFBUvnzV2Ggsq4J0J+aOM+97jQ0KpQUmboHdFoDJOTP9WfXqZPvEw9i8ad
         F7usGVRUk/pRcQEQ3kMSDaK1qp8s+68ln2nD/gMuE99x6mcbNVEYS/Rhb3OhFkLG6bi8
         rlsjkgAsYjvq9rogoDRHQ5RVGjS0zOTK9xO1yWhvDihNaMNGG4MEGWzKV9xHmREIQu3i
         mMTQ==
X-Gm-Message-State: AOAM5335odNdI7wI896e8k2lhRaVZVbFM3uzT4xbBu6ZmzyKCAjO4RHD
        +sHnnnM5TnaLbOq3zj/H8WA4x+mULJwt74lEwkA=
X-Google-Smtp-Source: ABdhPJxleglqUvvHsd8ZIXC5fnlhosKPgayzZBnDt5LGCRHy8oyGW/k2xjfCTdTipWxMNKUcflCrjg==
X-Received: by 2002:a05:651c:144:: with SMTP id c4mr16511713ljd.223.1631649807421;
        Tue, 14 Sep 2021 13:03:27 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id y32sm1198057lfa.171.2021.09.14.13.03.26
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 13:03:26 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id y28so1067780lfb.0
        for <sparclinux@vger.kernel.org>; Tue, 14 Sep 2021 13:03:26 -0700 (PDT)
X-Received: by 2002:a05:6512:3991:: with SMTP id j17mr3057776lfu.280.1631649806277;
 Tue, 14 Sep 2021 13:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210907100302.3684453-1-ray.huang@amd.com> <5e365947-4ae1-47a0-7565-7f0cdde0bd84@amd.com>
 <CADnq5_PXOXiob3k5Z+cZz6K2k5iSCdzwNm0ZxKQOuC+PvdJxxg@mail.gmail.com>
In-Reply-To: <CADnq5_PXOXiob3k5Z+cZz6K2k5iSCdzwNm0ZxKQOuC+PvdJxxg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 13:03:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=rz3trQgOJ76pe1poCtmFkat-Y_Dm9_x=fzb27OszJQ@mail.gmail.com>
Message-ID: <CAHk-=wi=rz3trQgOJ76pe1poCtmFkat-Y_Dm9_x=fzb27OszJQ@mail.gmail.com>
Subject: Re: [PATCH] drm/ttm: fix the type mismatch error on sparc64
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Guenter Roeck <linux@roeck-us.net>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Sep 14, 2021 at 12:48 PM Alex Deucher <alexdeucher@gmail.com> wrote=
:
>
> On Tue, Sep 7, 2021 at 6:25 AM Christian K=C3=B6nig <christian.koenig@amd=
.com> wrote:
> >
> >
> > Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Is one of you going to push this to drm-misc?

I was assuming it was there already.

I guess I'll just apply it directly.

         Linus

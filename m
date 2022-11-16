Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11129C433FE
	for <sparclinux@archiver.kernel.org>; Wed, 16 Nov 2022 10:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233976AbiKPK52 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 16 Nov 2022 05:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239119AbiKPK5C (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 16 Nov 2022 05:57:02 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217DD5B587
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 02:45:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o4so29091814wrq.6
        for <sparclinux@vger.kernel.org>; Wed, 16 Nov 2022 02:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9ZBAjbkLkpV5anbsbNDWejUnJR2b62hZHcD7RsLbbis=;
        b=hL4zzWhEnjPY50YGCD8ud9r0OmHyJZfvrX3qAIPsnxNHLvJaFEbQ1Kjv2ZZIydIzYe
         FrutDF/Wdd3WHpGyYGf8s7GNLsZ9SNbMMkeyZh4IIffWQ10Ebm4xNhDGHXIUEqiQz1wX
         Gabz7F7kpZGOmJn4Rsif9X8dR2cu/JkHkwHosTa6ZYdeoxjlc+4idPkmtgsmt1aQK5en
         rnRwV9VRXdxOFqwFWs1A2UNgjxajOpiKw2uIHdhpXv1NZevyrk/320lGjbah3S1PxgMO
         oW6aa8J8OuYcCWRCkqaX0lvzkiWEaMBx2bb/99lnkQAXh+BlQGKXIiaqDgVsCpC6djaT
         4fCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ZBAjbkLkpV5anbsbNDWejUnJR2b62hZHcD7RsLbbis=;
        b=0ifM1YS1T4Ol0nsYLDP5klkhkmblkT9HZsGm+RqdIBIprFM1XLzMo48GuSrmNSpQ4C
         XU0xd1YHoUSI5HvUQTfQvbjHOCAWCSDrCCwrAdV26xQcs7ezEzGaNftv02Yn7X54OH4q
         lXqwat1JNVGGcAlmobYeLE9lpBp1Mcx4zSASHuhoGrrHGsz2igqj3PDExhLbfhgBfbis
         T5mNPYdvkPxJyo0zT/8fOO5KacSvzSeZuwCRbZJW7t2GdZLCiVjntNPtbfD424IHxcXS
         Kg+1zsB7Nli+Zqb31pWiJwGDViWP9cKAgsb8CZejp5rfDfBJ79+vb5CHCbTEQ21SrhuG
         XsgA==
X-Gm-Message-State: ANoB5pk488eAsyRNlijrslJ6fT8ewSsEG0e0xwCMbb3bs+TPNB49Ig4g
        MqgKQ0tH25FSkv/VKzWdT/UX+e0RmEZk8LAOb7Yz62Ts
X-Google-Smtp-Source: AA0mqf7+DmFT97kRBREIFkUGHWrpaxmeKUlNSC4d9moCHH1H1BwVRUdG2A1B2cP4A844AAfd34C9gP6acoASGPF1TiA=
X-Received: by 2002:adf:bb43:0:b0:22e:6f0d:d69 with SMTP id
 x3-20020adfbb43000000b0022e6f0d0d69mr13757227wrg.134.1668595526582; Wed, 16
 Nov 2022 02:45:26 -0800 (PST)
MIME-Version: 1.0
References: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
In-Reply-To: <CAHirt9gr7oL87co3y1hCs3Ux4utzFP5oj6GFOFMZuJR2Vv8+rA@mail.gmail.com>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Wed, 16 Nov 2022 13:45:15 +0300
Message-ID: <CADxRZqxqb7f_WhMh=jweZP+ynf_JwGd-0VwbYgp4P+T0-AXosw@mail.gmail.com>
Subject: Re: Test case for "mm/thp: carry over dirty bit when thp splits on pmd"
To:     hev <r@hev.cc>
Cc:     Peter Xu <peterx@redhat.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Nov 16, 2022 at 11:49 AM hev <r@hev.cc> wrote:
>
> Hello Peter,
>
> I see a random crash issue  on the LoongArch system, that is caused by
> commit 0ccf7f1 ("mm/thp: carry over dirty bit when thp splits on
> pmd").
>
> Now, the thing is already resolved. The root cause is arch's mkdirty
> is set hardware writable bit in unconditional. That breaks
> write-protect and then breaks COW.
>
> Here is a simple and fast testcase (It may be helpful for sparc64):
> https://gist.github.com/heiher/72919fae6b53f04cac606a9631100506
> (assertion: c sum == 0)

Just tried on my sparc64 VM -  fixed vs old (non-patched) kernels...

fixed kernel (6.1.0-rc5) running ./a.out:
mator@ttip:~$ ./a.out
c sum: 0
p sum: 35184372088832
c sum: 0
p sum: 35184372088832
c sum: 0
p sum: 35184372088832
c sum: 0
p sum: 35184372088832
c sum: 0
p sum: 35184372088832
...

old (non-patched) kernel (6.1.0-rc4) :
mator@ttip:~$ ./a.out
c sum: 35150012350464
p sum: 35184372088832
c sum: 35150012350464
p sum: 35184372088832
...

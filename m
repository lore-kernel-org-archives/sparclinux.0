Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0909C77B61
	for <sparclinux@archiver.kernel.org>; Tue, 25 Apr 2023 16:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbjDYQKp (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234690AbjDYQKn (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 25 Apr 2023 12:10:43 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC530F8
        for <sparclinux@vger.kernel.org>; Tue, 25 Apr 2023 09:10:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4efefbd2c5eso3191230e87.0
        for <sparclinux@vger.kernel.org>; Tue, 25 Apr 2023 09:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1682439032; x=1685031032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzBCWhkUry18zVOWXW5QyNYiFJMq+EJv8KjCsvLzxVI=;
        b=BTMOhNKncKkgEuXrkg4iVOUvlKOamBULDwD87gwAUY4uTD9Uj8fOtJ8gnRCGGD3Y1Y
         EtcCG/CbuQPtv6M80WfxId3IXWcwWs9h5Lw0T8BF7gXn5EhdGbVOPoy+A21e0y6npPOT
         fckBUd7/6mSyrUkCfa67U2Xyq6C+WOQMzpITU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439032; x=1685031032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gzBCWhkUry18zVOWXW5QyNYiFJMq+EJv8KjCsvLzxVI=;
        b=d6mv2dVX7qZnJuYQrrGzR5ePxnpVVpHQJ6Ta1TgXMbSyoSDl/9qI76FlbL/m6KpPaZ
         HRctMGhkjuXGUCNjWa7aU24L8kNodNX2qtZZJdfgJMWwQfhY0vAZsnDs5bsS7dbZztjF
         T+MbG8f94+4FFlU3ujbsXLSrpOMNOBqlfHkWEdWHxgaGMxovLZ4OovHyHNVZTsHi6z4U
         4MSu/5Dnuf76qEwj+dVmc/4qrIkfGxNng6Z3Pv04AjBTy9Dx2OcszMFcwtsQT679XLsp
         4Ml1o2wBSCKoDG86+nTlu7lhjAztKCEC3snsUJYuvkRKqbrQ68xU8Oz2PpGGQXa6czWd
         OLcQ==
X-Gm-Message-State: AAQBX9dYAVN+B6h2L7RPbP/j00tjMS4u7yi2KmtsPxFcc0H/xY+OV0CO
        GEc4vky6/kVVuojrh5ZifWfJJiYhvOn0sZBrTq72M2/L
X-Google-Smtp-Source: AKy350YTfm1D4m2N563T7SVfkkKdb5AFlFcBNrQNAwHB888tofLTEhvPqqdCnvr2YbMfTt4l0LJvKA==
X-Received: by 2002:ac2:5198:0:b0:4eb:1048:1285 with SMTP id u24-20020ac25198000000b004eb10481285mr4145996lfi.47.1682439032292;
        Tue, 25 Apr 2023 09:10:32 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id q7-20020ac25147000000b004eedddd9de7sm2038265lfd.77.2023.04.25.09.10.31
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 09:10:31 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2a8a600bd05so56849821fa.2
        for <sparclinux@vger.kernel.org>; Tue, 25 Apr 2023 09:10:31 -0700 (PDT)
X-Received: by 2002:a05:6512:145:b0:4d7:44c9:9f4c with SMTP id
 m5-20020a056512014500b004d744c99f4cmr4233943lfo.4.1682439010843; Tue, 25 Apr
 2023 09:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org> <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com> <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
In-Reply-To: <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Tue, 25 Apr 2023 11:09:58 -0500
X-Gmail-Original-Message-ID: <CAFbkSA2hU+2V0i5OG0BBD-s3yNOAZwBmyGmxMLkbzoWZK6cxOQ@mail.gmail.com>
Message-ID: <CAFbkSA2hU+2V0i5OG0BBD-s3yNOAZwBmyGmxMLkbzoWZK6cxOQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Apr 18, 2023 at 5:22=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm.c=
om> wrote:
>
> > > It sounds nice in theory. In practice. EXPERT hides too much. When yo=
u
> > > flip expert, you expose over a 175ish new config options which are
> > > hidden behind EXPERT.  You don't have to know what you are doing just
> > > with the MAX_ORDER, but a whole bunch more as well.  If everyone were
> > > already running 10, this might be less of a problem. At least Fedora
> > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > accidental choice, we had to carry a patch to even allow it for a
> > > while.  If this does go in as is, we will likely just carry a patch t=
o
> > > remove the "if EXPERT", but that is a bit of a disservice to users wh=
o
> > > might be trying to debug something else upstream, bisecting upstream
> > > kernels or testing a patch.  In those cases, people tend to use
> > > pristine upstream sources without distro patches to verify, and they
> > > tend to use their existing configs. With this change, their MAX_ORDER
> > > will drop to 10 from 13 silently.   That can look like a different
> > > issue enough to ruin a bisect or have them give bad feedback on a
> > > patch because it introduces a "regression" which is not a regression
> > > at all, but a config change they couldn't see.
> >
> > If we remove EXPERT (as prior to this patch), I'd rather keep the range=
s
> > and avoid having to explain to people why some random MAX_ORDER doesn't
> > build (keeping the range would also make sense for randconfig, not sure
> > we got to any conclusion there).
>
> Well this doesn't seem to have got anywhere.  I think I'll send the
> patchset into Linus for the next merge window as-is.  Please let's take
> a look at this Kconfig presentation issue during the following -rc
> cycle.

Well, I am very sorry to see this going in as is.  It will silently
change people building with oldconfig, and anyone not paying attention
will not notice until an issue is hit where "it worked before, and my
config hasn't changed".  If EXPERT is unset, there is no notification,
just a changed behavior.  While it would be easy for me to carry a
patch dropping the if EXPERT, it will not help any users building on
upstream with our configs, whether for their own regular use, or while
trying to debug other issues,  I expect it will result in a reasonable
amount of frustration from users trying to do the right thing and
bisect or test patches upstream.

Justin

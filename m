Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D851C77B7F
	for <sparclinux@archiver.kernel.org>; Wed, 19 Apr 2023 11:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjDSL2K (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 19 Apr 2023 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjDSL2J (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 19 Apr 2023 07:28:09 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6B7449D
        for <sparclinux@vger.kernel.org>; Wed, 19 Apr 2023 04:28:07 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-94f0dd117dcso256872366b.3
        for <sparclinux@vger.kernel.org>; Wed, 19 Apr 2023 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1681903685; x=1684495685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=h+3Tomy+fZrVXH6RN/babMfjC3kI4c/tjjs+upF4u2X/jkiM2Y88CL0+Ndyv402wRA
         ZN8jK2RJQPiW1OrNQGOz0lJxhdDo0VxjNTL6Wi/rxTAXStbwCZ3oB5IF1CRRLFVGQxbQ
         T9gYcbmXuvxaBPI1B259kNHR7vtJA9q3ZKhrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903685; x=1684495685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8N99yfKqkNg/PzVluqPrnuo7/UXaVkUZ4pARZeRWAW0=;
        b=EZhOJ3Sk89H6h2Gn1njoalcerGVT5I8H47N7Exuwge0XsQDTYcLPMhxobV21UVfGU2
         pcx3qvX2lZG6lndKj1Q0YDHP7Bx5vbXqe9s1/ECZZoLwiEupt5lKt7K0tKIm4kDcrIHz
         cTOZ9793B12FdCKtI8OzcfrOxCZZsUPYHayKmVMJwtfZ/3mHNeuVRL3wV41kMk8nujv6
         s/yk02xo0eYK3tfysUtUHM0ZAArIq9iRrN5A19uPGjjqQTXbKWU/KSA2tYTwnEXWcwsb
         TJMi0XMPZvDKOG4bpg/jkyLp8DIiDEhFnzrzbTtmtood8RoYIL88eia5xbLQ5C0pusI0
         2JKQ==
X-Gm-Message-State: AAQBX9csRnNKKZnWVbnB4D3jmWsHG0lgOpzOdW/tsbGxYQJczCEzXI+w
        ls8nXuO0OdiPRC2u44hgRgbOZvMbOEgClteO+PEbbDlR
X-Google-Smtp-Source: AKy350YBrs0J4aCWvMF5HLQJO6PJhLaysWPMtMY38bwWrFHMBTEIxq+bKoOI0Bbyv0G3yPtJR+SqFQ==
X-Received: by 2002:a05:6402:5159:b0:506:84e0:a78a with SMTP id n25-20020a056402515900b0050684e0a78amr5696996edd.3.1681903685350;
        Wed, 19 Apr 2023 04:28:05 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id t10-20020a056402020a00b005049412d7b8sm7924179edv.22.2023.04.19.04.28.04
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Received: by mail-ej1-f53.google.com with SMTP id dx24so36733366ejb.11
        for <sparclinux@vger.kernel.org>; Wed, 19 Apr 2023 04:28:04 -0700 (PDT)
X-Received: by 2002:a2e:7012:0:b0:2a5:fe8f:b314 with SMTP id
 l18-20020a2e7012000000b002a5fe8fb314mr1874851ljc.5.1681903663880; Wed, 19 Apr
 2023 04:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230325060828.2662773-1-rppt@kernel.org> <20230325060828.2662773-3-rppt@kernel.org>
 <CAFxkdAr5C7ggZ+WdvDbsfmwuXujT_z_x3qcUnhnCn-WrAurvgA@mail.gmail.com>
 <ZCvQGJzdED+An8an@kernel.org> <CAFbkSA38eTA_iJ3ttBvQ8G4Rjj8qB12GxY7Z=qmZ8wm+0tZieA@mail.gmail.com>
 <ZDbp7LAHES3YFo30@arm.com> <20230418150557.ea8c87c96ec64c899c88ab08@linux-foundation.org>
 <ZD/K+Mof/Dx5yzjQ@arm.com>
In-Reply-To: <ZD/K+Mof/Dx5yzjQ@arm.com>
From:   Justin Forbes <jforbes@fedoraproject.org>
Date:   Wed, 19 Apr 2023 06:27:31 -0500
X-Gmail-Original-Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Message-ID: <CAFbkSA3yn_4Monrnk2u3CzfJ934Hy15rjAJ85AdFU40nV7KTkQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/14] arm64: drop ranges in definition of ARCH_FORCE_MAX_ORDER
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

On Wed, Apr 19, 2023 at 6:12=E2=80=AFAM Catalin Marinas <catalin.marinas@ar=
m.com> wrote:
>
> On Tue, Apr 18, 2023 at 03:05:57PM -0700, Andrew Morton wrote:
> > On Wed, 12 Apr 2023 18:27:08 +0100 Catalin Marinas <catalin.marinas@arm=
.com> wrote:
> > > > It sounds nice in theory. In practice. EXPERT hides too much. When =
you
> > > > flip expert, you expose over a 175ish new config options which are
> > > > hidden behind EXPERT.  You don't have to know what you are doing ju=
st
> > > > with the MAX_ORDER, but a whole bunch more as well.  If everyone we=
re
> > > > already running 10, this might be less of a problem. At least Fedor=
a
> > > > and RHEL are running 13 for 4K pages on aarch64. This was not some
> > > > accidental choice, we had to carry a patch to even allow it for a
> > > > while.  If this does go in as is, we will likely just carry a patch=
 to
> > > > remove the "if EXPERT", but that is a bit of a disservice to users =
who
> > > > might be trying to debug something else upstream, bisecting upstrea=
m
> > > > kernels or testing a patch.  In those cases, people tend to use
> > > > pristine upstream sources without distro patches to verify, and the=
y
> > > > tend to use their existing configs. With this change, their MAX_ORD=
ER
> > > > will drop to 10 from 13 silently.   That can look like a different
> > > > issue enough to ruin a bisect or have them give bad feedback on a
> > > > patch because it introduces a "regression" which is not a regressio=
n
> > > > at all, but a config change they couldn't see.
> > >
> > > If we remove EXPERT (as prior to this patch), I'd rather keep the ran=
ges
> > > and avoid having to explain to people why some random MAX_ORDER doesn=
't
> > > build (keeping the range would also make sense for randconfig, not su=
re
> > > we got to any conclusion there).
> >
> > Well this doesn't seem to have got anywhere.  I think I'll send the
> > patchset into Linus for the next merge window as-is.  Please let's take
> > a look at this Kconfig presentation issue during the following -rc
> > cycle.
>
> That's fine by me. I have a slight preference to drop EXPERT and keep
> the ranges in, especially if it affects current distro kernels. Debian
> seems to enable EXPERT already in their arm64 kernel config but I'm not
> sure about the Fedora or other distro kernels. If they don't, we can
> fix/revert this Kconfig entry once the merging window is closed.

Fedora and RHEL do not enable EXPERT already.

Justin

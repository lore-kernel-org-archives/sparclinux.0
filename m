Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4848EB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 16 Jun 2023 16:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjFPQoW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjFPQoT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 16 Jun 2023 12:44:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BBB2D4E
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 09:44:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-982af24987fso141493966b.0
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686933856; x=1689525856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlH6N4BeYWriIEzthku3f2s3TDY9tC006RTYxc81VbY=;
        b=fa3BWs6hKNUceKlPZqUdlR7I0P8QqsjOK+i/OFiac3mNZt2dxOUZOlmKSlTu5aYQsu
         EzcPzwmjqRXYlldsO6MYgpShNO/BNpVmFtcDWgrx+222WJXuhfVdfY01vmnfurSTrF84
         aFBqgk9j26KobSdQc17w8JcODnqZlcPFSePtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686933856; x=1689525856;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlH6N4BeYWriIEzthku3f2s3TDY9tC006RTYxc81VbY=;
        b=KYIZnByi3cvx1Gm734/5URhW7IyZEYLSvfOdu7rrP33ouQfJAr1g4wIB7aW4Bel/2L
         5114bYKhVoDdHnU7J5mLd6hMMqxMl0GlRI1w8UG4wiN/6t1DESU59Z4YNFWmaKBmHRkZ
         n7IUfQM0uDmtexUtdFBUP7c3bkRNQP6JAb3pbxj/cLTrtjIstEOZoPqjqtlrEW58bx25
         qoLz8+OSo5WB+CtGJpzFZng7zo1vLQxe3I+/vvFSCk991FYrRKagAovxGq9QcAP/WDQg
         fZEsFiO57GhHEhiAyuuN7aM++44XL1wY8zFr5N8Nrr1ovrLJRIgZ8Kq598ukAdlKuDHE
         Fuxg==
X-Gm-Message-State: AC+VfDxmonoLDxlK1dh4/QGpdgtWQU0nfbdigK43U+wyR+jKWxV7QNID
        dY0UdJmGrX6kjsebsCssGEcaKMHNhIxYoybtHK6sTI5B
X-Google-Smtp-Source: ACHHUZ5Q4xALbX6at/P86hBCYLV588tj1gC7drqI5kXoXj7C9FAutKP7ua5yf74MAJMDNsA0kcqfUg==
X-Received: by 2002:a17:907:7204:b0:94f:5847:8ac with SMTP id dr4-20020a170907720400b0094f584708acmr2748979ejc.51.1686933855686;
        Fri, 16 Jun 2023 09:44:15 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id zo18-20020a170906ff5200b0096ae4451c65sm11031264ejb.157.2023.06.16.09.44.15
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 09:44:15 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51400fa347dso117a12.0
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 09:44:15 -0700 (PDT)
X-Received: by 2002:a50:bac3:0:b0:506:b280:4993 with SMTP id
 x61-20020a50bac3000000b00506b2804993mr233742ede.2.1686933854748; Fri, 16 Jun
 2023 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230616150618.6073-1-pmladek@suse.com> <20230616150618.6073-2-pmladek@suse.com>
In-Reply-To: <20230616150618.6073-2-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Jun 2023 09:44:01 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XUWnjCAjZKb5wYcGhC=T8+hoUr+1junoH5ognge1aZHg@mail.gmail.com>
Message-ID: <CAD=FV=XUWnjCAjZKb5wYcGhC=T8+hoUr+1junoH5ognge1aZHg@mail.gmail.com>
Subject: Re: [PATCH v2 1/6] watchdog/hardlockup: Sort hardlockup detector
 related config values a logical way
To:     Petr Mladek <pmladek@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi,

On Fri, Jun 16, 2023 at 8:06=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> There are four possible variants of hardlockup detectors:
>
>   + buddy: available when SMP is set.
>
>   + perf: available when HAVE_HARDLOCKUP_DETECTOR_PERF is set.
>
>   + arch-specific: available when HAVE_HARDLOCKUP_DETECTOR_ARCH is set.
>
>   + sparc64 special variant: available when HAVE_NMI_WATCHDOG is set
>         and HAVE_HARDLOCKUP_DETECTOR_ARCH is not set.
>
> Only one hardlockup detector can be compiled in. The selection is done
> using quite complex dependencies between several CONFIG variables.
> The following patches will try to make it more straightforward.
>
> As a first step, reorder the definitions of the various CONFIG variables.
> The logical order is:
>
>    1. HAVE_* variables define available variants. They are typically
>       defined in the arch/ config files.
>
>    2. HARDLOCKUP_DETECTOR y/n variable defines whether the hardlockup
>       detector is enabled at all.
>
>    3. HARDLOCKUP_DETECTOR_PREFER_BUDDY y/n variable defines whether
>       the buddy detector should be preferred over the perf one.
>       Note that the arch specific variants are always preferred when
>       available.
>
>    4. HARDLOCKUP_DETECTOR_PERF/BUDDY variables define whether the given
>       detector is enabled in the end.
>
>    5. HAVE_HARDLOCKUP_DETECTOR_NON_ARCH and HARDLOCKUP_DETECTOR_NON_ARCH
>       are temporary variables that are going to be removed in
>       a followup patch.
>
> This is a preparation step for further cleanup. It will change the logic
> without shuffling the definitions.
>
> This change temporary breaks the C-like ordering where the variables are
> declared or defined before they are used. It is not really needed for
> Kconfig. Also the following patches will rework the logic so that
> the ordering will be C-like in the end.
>
> The patch just shuffles the definitions. It should not change the existin=
g
> behavior.
>
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> ---
>  lib/Kconfig.debug | 112 +++++++++++++++++++++++-----------------------
>  1 file changed, 56 insertions(+), 56 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A34CC7EE25
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbjFGXiC (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjFGXiB (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:38:01 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E54D2D47
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:37:39 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-33e5054ba6fso8136135ab.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181057; x=1688773057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN7QCcXv3GhQ50KYCOkYuc7v8/KdYJA2Wdn7x5ACZBs=;
        b=OFd9XXP49ttwm/PKxGs71xAJer/BAQHRSU2qZ024hG5TWCYw+doi+Dv17d85q6+M6W
         kbSmCvOmJ6yzveqLqM3pRDTOXrBA3dpLm628rMADxUaVrcaKaQ5eYdXs7+FbaJFPI1Mt
         DbFFpnMLG/X/LXsE7dKslbmGJK/Twy12+cLHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181057; x=1688773057;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EN7QCcXv3GhQ50KYCOkYuc7v8/KdYJA2Wdn7x5ACZBs=;
        b=UI7jJylXUmUfvDD8uG7RGxRAg9RsBx54XZFikNA2viFrwYT78MVkqOm8ucTb2h77CU
         ny33VPbx9de9dGDKkKCt4RkoGWq6COwAM3EoeDQUbMnindRWo8FKnET94FDX0CTzguT5
         OLptmvUgxLPA0vQpxzUAPDl2fpgf6JcK0IKds8fTD+cX+E7M0ziSodwxWMAsAsaDLfL5
         nQMXnfRAkFZtN5RkNaAdpqcXGSs8rlVrwXY/qThf4D761pzwBW936C0tcfpmbRYCsB0J
         dj7clIK3UxAq8LNvf1EshzO/OTyDsJXCGHgGwX22NVhQ8W1wHzfw51vqOBwBHmO3opw/
         Aq4g==
X-Gm-Message-State: AC+VfDzW7Mn5MPMZFJWmHl9TPjhuAZNj61Bo6PxRMcQsnVoKedO6BteH
        M0+LFB7fad5KwJd9r9/LjF4Zff+Xs2fweNQwvFw=
X-Google-Smtp-Source: ACHHUZ62w3d0JODsFErDIKshnGw3PvjQ9EkBEvgV8DLAm++N85/lY8e0WZmdxwSKAAqIoE2WypGwHg==
X-Received: by 2002:a92:d089:0:b0:33b:d12:4bf1 with SMTP id h9-20020a92d089000000b0033b0d124bf1mr10196647ilh.26.1686181057497;
        Wed, 07 Jun 2023 16:37:37 -0700 (PDT)
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com. [209.85.166.180])
        by smtp.gmail.com with ESMTPSA id eh27-20020a056638299b00b004161870da90sm3115028jab.151.2023.06.07.16.37.32
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:34 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-33bf12b5fb5so26345ab.1
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:32 -0700 (PDT)
X-Received: by 2002:a92:c54d:0:b0:33e:6b65:6f78 with SMTP id
 a13-20020a92c54d000000b0033e6b656f78mr16557ilj.27.1686181051931; Wed, 07 Jun
 2023 16:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-1-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:37:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=W=xamTf6BUmp-Yg-SEEgE8GRKw6Pnfv6t=Hviywj-N-g@mail.gmail.com>
Message-ID: <CAD=FV=W=xamTf6BUmp-Yg-SEEgE8GRKw6Pnfv6t=Hviywj-N-g@mail.gmail.com>
Subject: Re: [PATCH 0/7] watchdog/hardlockup: Cleanup configuration of
 hardlockup detectors
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

On Wed, Jun 7, 2023 at 8:25=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> Hi,
>
> this patchset is supposed to replace the last patch in the patchset clean=
ing
> up after introducing the buddy detector, see
> https://lore.kernel.org/r/20230526184139.10.I821fe7609e57608913fe05abd8f3=
5b343e7a9aae@changeid

I will let Andrew chime in with his preference, but so far I haven't
seen him dropping and/or modifying any patches that he's picked up in
this series. I see that he's already picked up the patch that you're
"replacing". I wonder if it would be easier for him if you just built
atop that?

-Doug

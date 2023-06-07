Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639ABC7EE25
	for <sparclinux@archiver.kernel.org>; Wed,  7 Jun 2023 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjFGXhx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 7 Jun 2023 19:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjFGXhv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 7 Jun 2023 19:37:51 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866492726
        for <sparclinux@vger.kernel.org>; Wed,  7 Jun 2023 16:37:32 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id ca18e2360f4ac-777a2ef8d45so172631139f.2
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686181049; x=1688773049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKF2b8Vjs6mvxh6WU02Nj8q7SFKUM+Iw8gQlZJ28woQ=;
        b=TIAdvQ0CAr1l60dKx3sJAAGIi9kA2nFSujlxbO2unFvogpfE/iKuioBPWzfY9Wl0rq
         JM5sjuWIO//k7jwZjWcFWrT+PiKMmI5dwBoSTJHLI/8xSGGmvFOF8MurlhE+yRXNLmdA
         6CGituzxce3lIC6LeHYHQTZLDVMUxBk1TA4kI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686181049; x=1688773049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKF2b8Vjs6mvxh6WU02Nj8q7SFKUM+Iw8gQlZJ28woQ=;
        b=CzK0joyIWtit7IJXs0EVGCH+8yHrRKJhTARInYRrcRu0n9i4zZTi0WKV3FiUJvv0cY
         QqhekoxAmh3jpHvDgkRCeKMZ6cORVd8KJh9qcqfJK7REct0YFJbQkBJ07X3wOdIj0rZd
         05Vg34AM6fq061gpDFCf6WwiMtZZk1x7ZOnQbVKDTNaYPOjumwpOckOjwiBIRByvryzN
         jzu81yURcj4cc46lFSj7yB0NC/D1NaqfSkAG6JBc5HW6Kjl05u82tvkUWDyhGVvd+pB3
         KGlZGA9c9ji6I86Xp4nPk6nsNYj86KCANmcmT79lXDBCHc1/S0YD97K6IDtYcJqF2ae1
         BmhA==
X-Gm-Message-State: AC+VfDyeu1uxhsWfpjgPYzrEQVT/0IADk9zxdoIYCB2IfVWkvh/2K5eO
        DQUxLUA3PqA2gGb6wITloMHvR3/ZulgZPqnbwXE=
X-Google-Smtp-Source: ACHHUZ7tJ3KV7ZXsq9aC9M28O427e4WmzXnK3OTn8JCECdEhRH6jh4GWGf77Pfe43LYWvhCrcTH3YQ==
X-Received: by 2002:a5d:9808:0:b0:77a:c494:b4bc with SMTP id a8-20020a5d9808000000b0077ac494b4bcmr2282767iol.20.1686181049481;
        Wed, 07 Jun 2023 16:37:29 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id h11-20020a056638062b00b0041d89b79fdasm3653838jar.20.2023.06.07.16.37.22
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 16:37:27 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33d928a268eso54755ab.0
        for <sparclinux@vger.kernel.org>; Wed, 07 Jun 2023 16:37:22 -0700 (PDT)
X-Received: by 2002:a92:cda5:0:b0:338:1993:1194 with SMTP id
 g5-20020a92cda5000000b0033819931194mr7952ild.2.1686181042584; Wed, 07 Jun
 2023 16:37:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230607152432.5435-1-pmladek@suse.com> <20230607152432.5435-8-pmladek@suse.com>
In-Reply-To: <20230607152432.5435-8-pmladek@suse.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 16:37:10 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Message-ID: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Subject: Re: [PATCH 7/7] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
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

On Wed, Jun 7, 2023 at 8:26=E2=80=AFAM Petr Mladek <pmladek@suse.com> wrote=
:
>
> @@ -1102,6 +1103,14 @@ config HARDLOCKUP_DETECTOR_BUDDY
>         depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
>         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
>
> +config HARDLOCKUP_DETECTOR_ARCH
> +       bool
> +       depends on HARDLOCKUP_DETECTOR
> +       depends on HAVE_HARDLOCKUP_DETECTOR_ARCH
> +       help
> +         The arch-specific implementation of the hardlockup detector is
> +         available.

nit: "is available" makes it sound a bit too much like a "have"
version. Maybe "The arch-specific implementation of the hardlockup
detector will be used" or something like that?

Otherise:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

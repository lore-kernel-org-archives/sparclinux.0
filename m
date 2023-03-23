Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0411FC76196
	for <sparclinux@archiver.kernel.org>; Thu, 23 Mar 2023 16:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjCWQZI convert rfc822-to-8bit (ORCPT
        <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbjCWQYv (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 23 Mar 2023 12:24:51 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DACE39D;
        Thu, 23 Mar 2023 09:24:49 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id t19so13118869qta.12;
        Thu, 23 Mar 2023 09:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679588689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j7GNIdZ5wgfU6KCXGbmsavLHJtcjfO2exto0gDOFK7Q=;
        b=tX79BWxHcUahc/bt/9F6km40DFTziSvqf+bX5Me9e15AFSWea8c6lDoYjXTBDi2kjK
         1JkbnMGNnphsDuPCyc8+Frl9ABg6gyqKkyW1dAzX9otgi+7iSu806zN/pSt9MNE7+Ndr
         byFS7jj8wAVxb9x0zchwX9ZyIc/dvxOhRlsyDGQ9wtjbXsOxwaUO5lyWWVn86KyVwC/w
         2Ab6s7Yj5to4HiNFNVsRMrpz9cl+15nYoZ0NnBrPVFyncXqwq05VDOibhMVacHrEclop
         vBkMaTqLCs7kpoid6tzmK5IJ7F5zFJVUt49l0X4cHAz8EgIZEEOL9pts+RmRWH1YC9U8
         FDNA==
X-Gm-Message-State: AO0yUKUsgkwBMmoHPqnR7cjiIfW/T8MyskNQg2JuNWEemtA8bL3CXi3o
        3OT0oULi6gPHK8CtfYUlRq17L3m1X8ccoB1/
X-Google-Smtp-Source: AK7set8WU0bVaUTRczdPJT4Befw5kVzTqAjb4FLlVquL+1m0k99Tm5cGcyB11prlrnz3BULfh/G5sw==
X-Received: by 2002:a05:622a:1745:b0:3bd:db4:b967 with SMTP id l5-20020a05622a174500b003bd0db4b967mr12619711qtk.58.1679588688932;
        Thu, 23 Mar 2023 09:24:48 -0700 (PDT)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id r80-20020a374453000000b007465ee178a3sm12171395qka.96.2023.03.23.09.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 09:24:48 -0700 (PDT)
Received: by mail-yb1-f176.google.com with SMTP id n125so25465784ybg.7;
        Thu, 23 Mar 2023 09:24:47 -0700 (PDT)
X-Received: by 2002:a05:6902:728:b0:a09:314f:a3ef with SMTP id
 l8-20020a056902072800b00a09314fa3efmr2593946ybt.12.1679588687557; Thu, 23 Mar
 2023 09:24:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230323092156.2545741-1-rppt@kernel.org> <20230323092156.2545741-7-rppt@kernel.org>
In-Reply-To: <20230323092156.2545741-7-rppt@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Mar 2023 17:24:35 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSE1OzYQfNx=cbP+yKZLkgv=nUS-Ddqk2ORv9qdWFahw@mail.gmail.com>
Message-ID: <CAMuHMdWSE1OzYQfNx=cbP+yKZLkgv=nUS-Ddqk2ORv9qdWFahw@mail.gmail.com>
Subject: Re: [PATCH 06/14] m68k: reword ARCH_FORCE_MAX_ORDER prompt and help text
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>, Guo Ren <guoren@kernel.org>,
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
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Mar 23, 2023 at 10:23 AM Mike Rapoport <rppt@kernel.org> wrote:
> From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>
> The prompt and help text of ARCH_FORCE_MAX_ORDER are not even close to
> describe this configuration option.
>
> Update both to actually describe what this option does.
>
> Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

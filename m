Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F135C7EE21
	for <sparclinux@archiver.kernel.org>; Fri,  5 May 2023 02:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjEECgL (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 22:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjEECgK (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 22:36:10 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD8C120B2;
        Thu,  4 May 2023 19:35:55 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6439b410679so456649b3a.0;
        Thu, 04 May 2023 19:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683254155; x=1685846155;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=evsRyVdUpm9tZ3zbpYtyLZiIFPAu7MWLlo8c04t+4vY=;
        b=bPL3OQA2wcMMOXheYlA8QxViGjC7iCOlxPhX4fuvTbvsINcXnCzBLieoUCDzT+56/k
         9oa+q6KgEYTU31LDEubBwLHoV00eSRef0d7RY6p7N+38ZnXUiPoVuqktGot/CApk96Jy
         mkcd9MflN/bd4aJpaHOyZrzKqFPxkUSgtFeghcahGyjw1M4LGoXeflS5xTbaaMroQ3lN
         TDdNlHzCw9doNfMqYFNpEN+WF6Q8tEWDbjhFSHNaJRFseTWy9ZNqsOe1xYRvqprN7XWn
         oaXxe0JlYPbYRI/LrFIdnf60TDci+s8NR28f2bWdctusrv2FqThGA2JB0SFqFGVL9us2
         jnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683254155; x=1685846155;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=evsRyVdUpm9tZ3zbpYtyLZiIFPAu7MWLlo8c04t+4vY=;
        b=RNtuerpmRsI74eonb1q67kUz6E0DitidZ6zdrjP60f0aDUESJpuFXhsQmErhpJ2AJP
         9COnoJBnUXMGkMC3w92WhrvIF9MW+zAZ6lc/CIp6Vglg5OtBXRqk1HQILIK6bmvBcqMW
         2lnow6aSWioM9cl6PfeWrJYKL5b+dxhXaPw1wF0xZIL8H9WP95vxKDAokRpRZmTZ/QOb
         buX424ObXy6FC945neBvBRtRTxjFEilRWgEnYjOH6IRu7dP3xkRVA34dacoP2jbH/88i
         +9itwkjagTkmZpwtdqWOes2/+ufFnmv0xO7jx2FU4XLfGBwMJaPcQYlFVRpIjaWlCcrI
         3BUg==
X-Gm-Message-State: AC+VfDxr8vNeLofr/wM5QTjIeLYq/ogHJUfNxHBeqlsuXpUy3NSHxqOZ
        B4j34WlvKYyRc2btTtaa2zk=
X-Google-Smtp-Source: ACHHUZ7SP5ujyT52IJy91MGux44+fALAl/Za+uzONf57QZ4t+E/ySlwSCIJZv2DqIpZSwxLv82pD9g==
X-Received: by 2002:a05:6a21:999a:b0:fc:8dfb:3195 with SMTP id ve26-20020a056a21999a00b000fc8dfb3195mr5404412pzb.23.1683254154649;
        Thu, 04 May 2023 19:35:54 -0700 (PDT)
Received: from localhost ([203.59.190.92])
        by smtp.gmail.com with ESMTPSA id g18-20020a62e312000000b0062dd9a8c1b8sm407591pfh.100.2023.05.04.19.35.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 19:35:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 05 May 2023 12:35:39 +1000
Message-Id: <CSDZSKA38AEF.FY7J3JXBJX4I@wheely>
Cc:     "Sumit Garg" <sumit.garg@linaro.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Matthias Kaehlcke" <mka@chromium.org>,
        "Stephane Eranian" <eranian@google.com>,
        "Stephen Boyd" <swboyd@chromium.org>, <ricardo.neri@intel.com>,
        "Tzung-Bi Shih" <tzungbi@chromium.org>,
        "Lecopzer Chen" <lecopzer.chen@mediatek.com>,
        <kgdb-bugreport@lists.sourceforge.net>,
        "Masayoshi Mizuma" <msys.mizuma@gmail.com>,
        "Guenter Roeck" <groeck@chromium.org>,
        "Pingfan Liu" <kernelfans@gmail.com>,
        "Andi Kleen" <ak@linux.intel.com>,
        "Ian Rogers" <irogers@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>, <ito-yuichi@fujitsu.com>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Chen-Yu Tsai" <wens@csie.org>, <christophe.leroy@csgroup.eu>,
        <davem@davemloft.net>, <sparclinux@vger.kernel.org>,
        <mpe@ellerman.id.au>, "Will Deacon" <will@kernel.org>,
        <ravi.v.shankar@intel.com>, <linuxppc-dev@lists.ozlabs.org>,
        "Marc Zyngier" <maz@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Daniel Thompson" <daniel.thompson@linaro.org>,
        "Colin Cross" <ccross@android.com>
Subject: Re: [PATCH v4 13/17] watchdog/hardlockup: detect hard lockups using
 secondary (buddy) CPUs
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Douglas Anderson" <dianders@chromium.org>,
        "Petr Mladek" <pmladek@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
X-Mailer: aerc 0.14.0
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
In-Reply-To: <20230504151100.v4.13.I6bf789d21d0c3d75d382e7e51a804a7a51315f2c@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> From: Colin Cross <ccross@android.com>
>
> Implement a hardlockup detector that doesn't doesn't need any extra
> arch-specific support code to detect lockups. Instead of using
> something arch-specific we will use the buddy system, where each CPU
> watches out for another one. Specifically, each CPU will use its
> softlockup hrtimer to check that the next CPU is processing hrtimer
> interrupts by verifying that a counter is increasing.

Powerpc's watchdog has an SMP checker, did you see it? It's all to
all rather than buddy which makes it more complicated but arguably
bit better functionality.

Thanks,
Nick

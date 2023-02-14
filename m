Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B66C6379F
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 07:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjBNHuv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 02:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjBNHuo (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 02:50:44 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49FD1F90F
        for <sparclinux@vger.kernel.org>; Mon, 13 Feb 2023 23:50:38 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m20-20020a05600c3b1400b003e1e754657aso4573329wms.2
        for <sparclinux@vger.kernel.org>; Mon, 13 Feb 2023 23:50:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ii6DcGK1K84V1+kD/7t9cY+JeAv8M4YfLE5v7j3CqOM=;
        b=I1VEcjUDawlpYy++x1xEBf0hshi+UUXZqEG9HnshtWtjouQctNrVLpruXuES2Oagrp
         iT7YoME1aVbcS+HEWbHCOCQW3VEns2uKQYoA6REYBpU62/Uoj2fvMlr/lKgBTypICKU6
         RlRdAMZM5t13vXultPXak34rbojAaTogCgdjH7JPgT2pl2yve8hxL7NLwSXIqO+JtT5M
         b1Hl+ZltCnx9hVWMPjRHj5zpUQimuVh/Wk+qQ13xgRkXT8eRD6o6z7+Wo4uFPKNBuG+p
         asTcY6LBV5DF6f903DUmo3adyNXv6RQgpVCmXBs06MynEcXA6awy5qbjtQTRzphXscd5
         kA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii6DcGK1K84V1+kD/7t9cY+JeAv8M4YfLE5v7j3CqOM=;
        b=UssY02OTbUSyAKuLSL+uz89L/K0qRk+Mre5Pb6xLEa1Ms7oCm7INbuW/z3NsFWTp7Q
         zUm2JsklLdXDESxRS5iFX0oznbP7J8YaTWylAtb+wW1cjh6PLCgYyPhHkvZKF+OP/uav
         fM6RTmpN53OGfI2RCvXW/HYITgb3gzl9VR/SuVvzUCU+15nyeKl63+nEco1Mt3K0yF5N
         CvM7XfVPMdtNH1+z5L1TBCcQXtfM/vIbXzp6xRrl1Hu+4WvmmjTnbJRyBpex3y8FLOVf
         6O3IqPG/8nEopD6sugRwpShenmYI1i8Ru2jkcneTEvMBCw2kAUSs1sAlrdnroTCLYB+u
         lkLQ==
X-Gm-Message-State: AO0yUKWzAN/vDIaFqbRFR3dJMyReu+0+1S3WHvghPth0O3P//BpGeAUl
        9+BZVYAGJd7N2ti3tNZ5vHhm+w==
X-Google-Smtp-Source: AK7set97VLx9CSMkn06NHBxIv+bzedPW3GdN3zp3QK+/mFpRkq7NBRCe2Roa8UAfgNvIUinTSZ/uQw==
X-Received: by 2002:a05:600c:91e:b0:3dd:af7a:53ed with SMTP id m30-20020a05600c091e00b003ddaf7a53edmr1359443wmp.11.1676361037280;
        Mon, 13 Feb 2023 23:50:37 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm18952962wmc.10.2023.02.13.23.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:50:36 -0800 (PST)
Message-ID: <c302c616-8c8d-0da1-c334-4d77cf2120bf@linaro.org>
Date:   Tue, 14 Feb 2023 08:50:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 10/24] mips/cpu: Make sure play_dead() doesn't return
Content-Language: en-US
To:     Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Cc:     jgross@suse.com, richard.henderson@linaro.org,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        will@kernel.org, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-ia64@vger.kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, loongarch@lists.linux.dev, f.fainelli@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, jiaxun.yang@flygoat.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linuxppc-dev@lists.ozlabs.org, ysato@users.sourceforge.jp,
        dalias@libc.org, linux-sh@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        linux-xtensa@linux-xtensa.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org
References: <cover.1676358308.git.jpoimboe@kernel.org>
 <b195e4da190bb06b7d4af15d66ce6129e2347630.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <b195e4da190bb06b7d4af15d66ce6129e2347630.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Make that more explicit with a BUG().
> 
> BUG() is preferable to unreachable() because BUG() is a more explicit
> failure mode and avoids undefined behavior like falling off the edge of
> the function into whatever code happens to be next.
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/mips/kernel/smp-bmips.c | 2 ++
>   arch/mips/loongson64/smp.c   | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878DC6379F
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjBNHwo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 02:52:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjBNHwV (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 02:52:21 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A816F1F4A2
        for <sparclinux@vger.kernel.org>; Mon, 13 Feb 2023 23:52:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id f23-20020a05600c491700b003dff4480a17so491278wmp.1
        for <sparclinux@vger.kernel.org>; Mon, 13 Feb 2023 23:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KCqNNvOOLTosMN7wz9mThItPfprRmoru8ZaaTukQ/o=;
        b=NH52649B5e9oWkZQI64CXOcKgWu0R/VPGanKvfobVBc0cMmqnap+INYCicv7uS6X/o
         ORaBA95en0nswtm5iauNHRRX1tzJJwrQBtdNsqTMHfCiqR9ZrY7h1MuCQ2B0q17Ifs5A
         ioeHa5yxwModQmREAq9Bxb+L+YLqf8rG90Up4ZVIWpnwTFsijBaf5q6dOkCfO+tz/ovm
         U3y8H7Zgzh9dHpI55aiO5P1iXbbs9Z3LAPaYswbStsroxSu4tPsIM+08/XuRi+FVAif0
         xNsv0LgQ2OrsB8MLr7DA4FoqeoCRAzACFYgbBPvqZiEGahLCS6fl3MGwo+50JJm9kDr6
         +jHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KCqNNvOOLTosMN7wz9mThItPfprRmoru8ZaaTukQ/o=;
        b=sY5Xeg1bP/Zrgy4UBxyeDSJUi9dKJ0clmyXiE6mjHEgXE5l10fbnuAjn+gXy01sx2k
         I7pHcC2KWEM8oMf+ohtCbKdSaoRXixqNraPe1liPFRlHBwW9P9MDxGktX6q3V8MiBKwp
         IbqS9lC3IkN+AMx+E8nDJxSoDyUM7NtQ7Kr4z9FxfyQjMilfIVZQrifBM+3Ktba1k1v1
         BsjllbQ3qo8UOJEBGxt5zFGO4efo5DkTgoGr3jN8uBt7gCOLD7M/B33DXDlKX7bmMQfV
         Y499ZzF4hqiOcK8bH9s2cw8rQH95I718S3/eyA7b/Qn2DuQmIcpTT+DQbKGKt3wVCvk1
         ZqZw==
X-Gm-Message-State: AO0yUKW0YUjbya1FHimsbgcxsfa4MUTFUH91/MrrBVFybQ8elS32rNWH
        ioVvAZFuEaYGC25g8YiWYu2QOQ==
X-Google-Smtp-Source: AK7set8pO3VU0fWGWiVYGzhKXFVM1laZtqm7B7bGikeNwcVBB/kJy44ARMxj6EJ67LsgVc8YXj6tsg==
X-Received: by 2002:a05:600c:2ac8:b0:3df:f2a5:49e0 with SMTP id t8-20020a05600c2ac800b003dff2a549e0mr1748597wme.40.1676361138280;
        Mon, 13 Feb 2023 23:52:18 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id k21-20020a05600c1c9500b003e01493b136sm19983423wms.43.2023.02.13.23.52.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:52:17 -0800 (PST)
Message-ID: <6989da47-3e94-fa1e-6edc-0c0bbbb1bbfe@linaro.org>
Date:   Tue, 14 Feb 2023 08:52:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 16/24] sparc/cpu: Mark cpu_play_dead() __noreturn
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
 <847fdb53cc7124bb7c94e3e104e443a29be85184.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <847fdb53cc7124bb7c94e3e104e443a29be85184.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> cpu_play_dead() doesn't return.  Annotate it as such.  By extension this
> also makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/sparc/include/asm/smp_64.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


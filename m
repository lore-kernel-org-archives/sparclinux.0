Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4648C6379F
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 07:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBNHzo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 02:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjBNHzj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 02:55:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979CA4EF5
        for <sparclinux@vger.kernel.org>; Mon, 13 Feb 2023 23:55:37 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id r2so14680854wrv.7
        for <sparclinux@vger.kernel.org>; Mon, 13 Feb 2023 23:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yp9YVWt295eBrVzLlEnMpa7WOgUH71k9lLJgF3DktSY=;
        b=h7M/SCUzNlOISn5jTGNmLltaLnbaZUtdxvRAjU33Milk2tpbKS2C1xqAq0HPm/BJRT
         FiJ/HCdDfWLCGCTNdK3VS2qjtc9bpTHe81E3CHaSYgmIq5P8HZR7PAW1a8s10oF2TIN2
         HojjglJNveA+nL0EeGaVfr3pzEZ9h17G9zgq7eukZMRTKZ2554cjMQl6XJfdOivXDkqk
         p6+UvsMCjwelsi/fnbvPZ4bmn5hfmGaZNsy5Ihf1d+h0B7f6xnfKvDzNoawdB3/hVkXh
         jP0nQULxasHEDW+waBz6yBAelaG8oXEN0PvGFOoSyLSbjEhs1hwBhQkj5fUqpkYkA3YB
         8MHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yp9YVWt295eBrVzLlEnMpa7WOgUH71k9lLJgF3DktSY=;
        b=3GD9bgW5JJjhojyeRC24PoQtMzhPjLbPdvXvCdIs6uRt1edcsbpH++30sy4UVQRYq5
         fk/dFiBXy6SAsyYRoaZQG5KNC8dvEUvZ9BfN4t9q+hYffiY7cq34rog3nOrn8BlS/a8q
         g2+bt3PxdOxRGwSwAxD11vxC0oT+bkZMQQ6EhxZx6yERY90U5zZ53oqFfZ9jIJKK6zFj
         XSrsZMTl/EtDnhknFPOidimR0KbP34sLx1tQOEteliYSl7OMr1E3oB8XcIYU/GlaSoYI
         rtjm29E8s1/R5Nuvd3lwD73KG72HNY2tF0UZj0X3E/GWhmjoK+dbtWudtLS6VafV/GM+
         gL+w==
X-Gm-Message-State: AO0yUKUvXmCWNs8ZAsUG2eD2B5ixoVFvZAhnralMPYfPLNQqkSmTrX/j
        ULumkYL4pTNHjXnVotbhFcz4tg==
X-Google-Smtp-Source: AK7set/rbY3MtHZ2OwQUg49PapdpOUKWpKu/tClY9KXy+Lf8mxXzVA+B1mGvCao1HrbQ7vXyzSy4uA==
X-Received: by 2002:a5d:498c:0:b0:2c5:595a:1c91 with SMTP id r12-20020a5d498c000000b002c5595a1c91mr1050356wrq.7.1676361336205;
        Mon, 13 Feb 2023 23:55:36 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id y1-20020a5d6201000000b002c3ea5ebc73sm12178299wru.101.2023.02.13.23.55.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 23:55:35 -0800 (PST)
Message-ID: <1b4afd82-83cb-0060-7cab-8e16d2e69ff9@linaro.org>
Date:   Tue, 14 Feb 2023 08:55:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 19/24] xtensa/cpu: Make sure cpu_die() doesn't return
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
 <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cca346b5c87693499e630291d78fb0bf12c24290.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Josh,

On 14/2/23 08:05, Josh Poimboeuf wrote:
> cpu_die() doesn't return.  Make that more explicit with a BUG().
> 
> BUG() is preferable to unreachable() because BUG() is a more explicit
> failure mode and avoids undefined behavior like falling off the edge of
> the function into whatever code happens to be next.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/xtensa/kernel/smp.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
> index 4dc109dd6214..7bad78495536 100644
> --- a/arch/xtensa/kernel/smp.c
> +++ b/arch/xtensa/kernel/smp.c

Can you update the documentation along? Currently we have:

   /*
    * Called from the idle thread for the CPU which has been shutdown.
    *
    * Note that we disable IRQs here, but do not re-enable them
    * before returning to the caller. This is also the behaviour
    * of the other hotplug-cpu capable cores, so presumably coming
    * out of idle fixes this.
    */

> @@ -341,6 +341,8 @@ void __ref cpu_die(void)
>   	__asm__ __volatile__(
>   			"	movi	a2, cpu_restart\n"
>   			"	jx	a2\n");
> +
> +	BUG();
>   }
>   
>   #endif /* CONFIG_HOTPLUG_CPU */


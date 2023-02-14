Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDD06C05027
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 08:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjBNIFf (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjBNIFP (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 03:05:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A219321971
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:05:12 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so10877203wmb.2
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JF52YzZhW4elUM7Kky6bPhzQenJZTY4P/46jrbrklX0=;
        b=evhLL97JMkNYAYn9bGpom2GYrZHUYt2CtyFeYuIEml6T8racA9Aij5ni53nA2qN2B/
         7ol3c+EAOiUcR3bb0Nbg6oEblv3Vg7fMwY7/0LEF5VCVPbgg/9qJMYGdcPWyfh/NzUJP
         nVm8iXoCxY27TAbyblLvNVZ54uQ2sCsTY83Lokf3aopdz/EdDYYXBo8GWIClq0AGjewl
         aTkyCiKCaGx5UjLiSjzaakSSVH5DgeZyjpiMZih++pjBLki4KH45JDUvESt1xmw+rXib
         kUDSlfXab71A8Mkvhrw8TlHo9Ob8++YPLFpUADMuiGoEgIwoLSkBvntwalRx8rWTfTF1
         ikQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF52YzZhW4elUM7Kky6bPhzQenJZTY4P/46jrbrklX0=;
        b=3VPW50yXaIMJBRclIArvisas3v9xzDtOMM2Ge3rSYa/+IELJw7uWtmcV8vPTJpTqxI
         6wex85L5+/BhjkTGMEjquTwK6K2c947n6tkbaqqCa9s3rc2gb8SE/rA7IKpjhRFECm9B
         f8srvK8k8AcMRRKeyScNq5kvUA7n2j0fd8bY0NS+9wFZ691z8HJa0vMkh0cwVCotBH76
         95mGei5lN9FdLE86TgzfCgrUhGUsnQfZL16mccq+Zrg32lPl5Udg0eiE8yrvRk5E5A9g
         ZikxshDWm0qm2uNcjq6kmp+08+pGdBRAzznY18NsXW54IkVs/rpYX99gtUxBLIop3Rg9
         b1nw==
X-Gm-Message-State: AO0yUKWfhtCyD1W4Bu6mQ8iyIw4vp4lXZE1oNLW08IaZ5LEyzCakaxNd
        X37++vtbe3rnQf7yOENjFh5ywQ==
X-Google-Smtp-Source: AK7set+HRG63gtrfZ+yNMRuCoXR1/Fc+yCbk1jg17GVbOh3n568w3mx2NtmeBnWmKBshSuBezAU6Uw==
X-Received: by 2002:a05:600c:3d98:b0:3e1:e149:b67b with SMTP id bi24-20020a05600c3d9800b003e1e149b67bmr8681792wmb.18.1676361911280;
        Tue, 14 Feb 2023 00:05:11 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id d5-20020a1c7305000000b003dc4baaedd3sm18757416wmb.37.2023.02.14.00.05.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:05:10 -0800 (PST)
Message-ID: <579b0715-dba2-246c-63a1-7e0ef4e9f9a5@linaro.org>
Date:   Tue, 14 Feb 2023 09:05:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 17/24] x86/cpu: Make sure play_dead() doesn't return
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
 <11e6ac1cf10f92967882926e3ac16287b50642f2.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <11e6ac1cf10f92967882926e3ac16287b50642f2.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> After commit 076cbf5d2163 ("x86/xen: don't let xen_pv_play_dead()
> return"), play_dead() never returns.  Make that more explicit with a
> BUG().
> 
> BUG() is preferable to unreachable() because BUG() is a more explicit
> failure mode and avoids undefined behavior like falling off the edge of
> the function into whatever code happens to be next.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/x86/include/asm/smp.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
> index b4dbb20dab1a..8f628e08b25a 100644
> --- a/arch/x86/include/asm/smp.h
> +++ b/arch/x86/include/asm/smp.h
> @@ -96,6 +96,7 @@ static inline void __cpu_die(unsigned int cpu)
>   static inline void play_dead(void)
>   {
>   	smp_ops.play_dead();
> +	BUG();
>   }

Similarly, smp_ops::play_dead() should be decorated noreturn first.

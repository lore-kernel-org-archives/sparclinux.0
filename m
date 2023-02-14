Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C147C05027
	for <sparclinux@archiver.kernel.org>; Tue, 14 Feb 2023 08:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjBNIGo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Feb 2023 03:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjBNIG0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Feb 2023 03:06:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041522D4F
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:06:25 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg5-20020a05600c3c8500b003e00c739ce4so10865849wmb.5
        for <sparclinux@vger.kernel.org>; Tue, 14 Feb 2023 00:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CexkYCgiU8jqIy3gLQMuVr94YSYODTF1ZIZpmznHWI0=;
        b=oq8fELe1ypAvc08FOz5CbHNTQBld5o23Jvdy+nLY0zG/DnFqza+VDZVuxwBfk8xIVm
         ImZ0fQYX3iD2kpEI2wrrJJ+EOv/ECI1pGCu4gDD9IhpbKAyXQe2Gg+36UgHDi0uWRsxw
         QKFTlhrsHNwTjUGRfM18bUeuqZqenYwJ9+lXPP+TIJmtJqj3qO11s6scjudecRVlXd8G
         yx+52LcS4QzLrkx17Mf0iokjziy/G8h1s4OnVBPi13160Z/MlgxAwmyWSoN4FxAoR886
         R7GzWQlscuhv0+syQCFg7BJqUBMsODphxlVZ4n5BE8SY37bZ4PSRi5tZBcsQ8dac5j5Y
         pIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CexkYCgiU8jqIy3gLQMuVr94YSYODTF1ZIZpmznHWI0=;
        b=LxaUxhDi72ryp0xIuNBRdx7Uzk1zKIqamWYGdAVqZIn7VVPJ44XowCSICXDth9Q6NT
         8xe4OBqglfu+BdwzcKH1D75WgSgvejUKvDrfhf5OT77ZsXuliwMCZWglim7sof5oSvH4
         gFhIyKOGqF/DxTat8LAoGgjblCBxCrEHhR8xDjMCdDNI3VWry4/5BjvoQLE9WmI58UM+
         gARW0DpIj6Dp0oBYuYeldF7WxIdQnNz6tySncqp3DSMz6D7CZwhGjMRJ4PtogTtgEnZZ
         btiWAKfruf52RmSGqu4+JBE++yGQ09olNNTH96RE3vUohDF5GrnJTCA/+1nHY1/hl0Q6
         LyXA==
X-Gm-Message-State: AO0yUKXEV6QSCmOJfvKlZnxFwS13FHoZTDB0yYRSPPGb6hWkSDoAFKB6
        qliLVne45UpPQk8URnDu2pWOkQ==
X-Google-Smtp-Source: AK7set/UWPyupxpQUXAnyOBo4TUryVO/JI+oWwYyspwHedd26Hv1CWYJdsr5ZpbLTAOsriaer/Ifsg==
X-Received: by 2002:a05:600c:a698:b0:3db:bc5:b2ae with SMTP id ip24-20020a05600ca69800b003db0bc5b2aemr1053106wmb.41.1676361983644;
        Tue, 14 Feb 2023 00:06:23 -0800 (PST)
Received: from [192.168.30.216] ([81.0.6.76])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003e1f6e18c95sm773496wmb.21.2023.02.14.00.06.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:06:23 -0800 (PST)
Message-ID: <fa2028d1-501f-523e-7b83-2e72d374812c@linaro.org>
Date:   Tue, 14 Feb 2023 09:06:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v2 08/24] loongarch/cpu: Mark play_dead() __noreturn
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
 <4da55acfdec8a9132c4e21ffb7edb1f846841193.1676358308.git.jpoimboe@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <4da55acfdec8a9132c4e21ffb7edb1f846841193.1676358308.git.jpoimboe@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 14/2/23 08:05, Josh Poimboeuf wrote:
> play_dead() doesn't return.  Annotate it as such.  By extension this
> also makes arch_cpu_idle_dead() noreturn.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> ---
>   arch/loongarch/include/asm/smp.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



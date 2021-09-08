Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF8AC433F5
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 13:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9F276109F
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 13:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbhIHNzW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbhIHNzV (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 09:55:21 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC647C061757;
        Wed,  8 Sep 2021 06:54:13 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso3056651ots.5;
        Wed, 08 Sep 2021 06:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KVSAsAmNU3tpwYv+FwBzgvsKBTEXiRMkI36CYU+m7jk=;
        b=YAuKZsUwSoXOmchxu4hDVApkdnFGSH6PtyETCFmTcUaM7xNM4jO1h/oZHjDmI5JUVZ
         FgDkoQosToFnrlF2bjOhMJANYz8N6fc0lHrNaKL/bCKekiluZz4VpJzRWd+HZbBwD2DP
         1/Zp28WFjqgllHezBDRwt1JYd6stJP3eypXuJ042O26P7++MII9tKH9ekDAsueMzLZwD
         WQMTY8dMxYfTruDB9cv7eUHjkUjnx/g7JKIgemRb3F3EmteWZfMPEofoQznUk/ZvAeYK
         DchBOgSH2o3HCyUmYt2QBscSwfFCSnuJZnNc9fdjb9ZSIjU7BeIf1Q1s3ruIUFN4mpSJ
         YaKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KVSAsAmNU3tpwYv+FwBzgvsKBTEXiRMkI36CYU+m7jk=;
        b=gsGW2mfAZl8UNwgXDDR/NO4ABkoc2DioQwVMJ9Fq+E2TOHuS3ZlkoHwtZ9xyej4zUH
         B52wfZK5bNPCodAhxvdHyqxwQ7qf4lLayaXArOLlrudBy17ui/iM9zu38U2zEo/KepxV
         uljjjiNXsUi+u/eMkGME4ca024o8Gk71puJ/JZRYgISLpe1O1WIG0B0RZ+S7D90YEr4V
         YkEM9TGvduWrEzoClM97yjLYVciglPWal2wIEavNEOiMk3W6FnVsSOwEOyOubFj6Oak5
         uD3wMxxyCJjV6qne9eh7T2x+9VNrWgWihsAbPvi+G8aRGhsjUB6rpvl5VVh529Bw5IqP
         reiQ==
X-Gm-Message-State: AOAM531xow0/Qm3sZfvp270MymZ9AtMVUJ/BN4omKj53DYIimH4eUvNS
        DLSx+c4Jrg4pMMkPNunEJLI=
X-Google-Smtp-Source: ABdhPJxs1yfSUHiv2n9ZH1xXSJpfR9JEQ1cOpJ3v7SWDCuJOyQRB4PqH3QQ2Wcgh8KQ4Kd8QoNxs6A==
X-Received: by 2002:a9d:5a9e:: with SMTP id w30mr3046135oth.378.1631109253346;
        Wed, 08 Sep 2021 06:54:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x22sm442213oox.26.2021.09.08.06.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 06:54:12 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>
References: <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
 <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk>
 <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
 <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
 <23b3a9ab-7205-9f4e-9425-17506aec3170@roeck-us.net>
 <YTi4RdEFfa7m/ufD@zeniv-ca.linux.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <1c1c54c4-efd9-e3da-022f-3396471d72d2@roeck-us.net>
Date:   Wed, 8 Sep 2021 06:54:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YTi4RdEFfa7m/ufD@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/8/21 6:19 AM, Al Viro wrote:
> On Wed, Sep 08, 2021 at 05:42:30AM -0700, Guenter Roeck wrote:
> 
>> Oddly enough, a memcpy on the 'rtc' variable doesn't fail,
>> neither with nor without volatile. Something else is going on.
> 
> While we are at it, would memcpy_fromio() complain?  Seeing that
> this is what's really intended there...
> 

It doesn't make a difference on m68k.

#define memcpy_fromio memcpy_fromio
static inline void memcpy_fromio(void *dst, const volatile void __iomem *src,
                                  int count)
{
         __builtin_memcpy(dst, (void __force *) src, count);
}

It boils down to the use of __builtin_memcpy(). m68k implements its own version
of memcpy(). If that is used, everything works fine. However, if a file includes
<linux/string.h>, memcpy is replaced with __builtin_memcpy:

#define __HAVE_ARCH_MEMCPY
extern void *memcpy(void *, const void *, __kernel_size_t);
#define memcpy(d, s, n) __builtin_memcpy(d, s, n)

and the compilation fails.

That also explains why only some architectures/files are affected.
Presumably those are the architectures which use __builtin_memcpy().

Guenter

Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B3FC433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 12:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28E6D60EE6
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 12:42:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234682AbhIHMnm (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 08:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbhIHMnl (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 08:43:41 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E862CC061575;
        Wed,  8 Sep 2021 05:42:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id i3-20020a056830210300b0051af5666070so2757157otc.4;
        Wed, 08 Sep 2021 05:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=v3tm0ULGt1MLK9wjIrtCbRkaasSMHbIa3xYVDcCKc4g=;
        b=DDn6Ldv2rEO//8YdRF+nEg4zSXuj/3qhUGw+UYAW+VPxQdERfT921hOkCGUhepN2Zz
         XuOriVj5nVbM0seJa++BtfRuEdujt/U9WqIC8i1G5usKQImpVLW15t2/AJeDUx7WZx0W
         OgJ0j+P+b6rjNLxq9QZRBrET6HJ2XnB2bYyZizWCOw4vVBHuhS5xawbdE0zqtjqiyypu
         YieurUNJtPx1uP4TiYj7QDmQ1mEywY3MZNhLBscvvQ2qyQlLbViMXuu9iMXgZq4b0tvc
         qAAdEVu/+IuiiN8dhuj1S+z//9JJgmCoz2lnMOBvmtK48lBWXlG5ZVlr0RfLB+xXV4lu
         tWqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=v3tm0ULGt1MLK9wjIrtCbRkaasSMHbIa3xYVDcCKc4g=;
        b=qkxFFttqG0qIDqmhyn3IWZ5eBazeUTTlcsaQP+GhEAqhRpxL3nULiI4entfF2+NVZi
         J2JE7Qy9EcVxP4YdkgmFCVxYZYraeY13CQ95tjIc6n+NidBf+9WNziHvV4ygONloPE7s
         hRhwH0ryYe4ofWNc7+bOqgJjH4hILs2P1gLjdha7C7V4pAznVjmvDdNSrvZ4YbAMVzn0
         gSN/IoPfN+LHRvAfP0ihsViOSvRt1cSoITxcv+uoNiVmOCCNQt24XriNMKTvcF6DtOGc
         IsGl5ua/K853BK44BbmYRGdo5Rl/5MeR1xYKdQXYaIwMYkWv2iLbUVQcplWaIQ3osbzM
         q6sQ==
X-Gm-Message-State: AOAM5312ovT8bZe5zeq/E5k80Ndl9XLU5U1cUbeqqWonA04XJpSCILZL
        QTeRqXBqEBXrrbnUojz2z3LCFvbuTAY=
X-Google-Smtp-Source: ABdhPJwx+37c/LXJFD/2Tw0Og5RHHbHSsUm9rLiJxlWFdm/IxOBaDB8jcNA9ZreyV1KhVzC45Ut65w==
X-Received: by 2002:a9d:527:: with SMTP id 36mr2890059otw.363.1631104953315;
        Wed, 08 Sep 2021 05:42:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l4sm414519oth.4.2021.09.08.05.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 05:42:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Martin Sebor <msebor@gcc.gnu.org>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
 <20210908042838.GA2585993@roeck-us.net>
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk>
 <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
 <CAMuHMdWhzL+aWosce71Xm-7dKsgXFyL42tQ2gV2HyEZp5r0N7A@mail.gmail.com>
 <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <23b3a9ab-7205-9f4e-9425-17506aec3170@roeck-us.net>
Date:   Wed, 8 Sep 2021 05:42:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3yJHvJaFHUh2+5GPm2n_g9gSfX2rFbrSLzDt6yC4eDog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/8/21 2:50 AM, Arnd Bergmann wrote:
> On Wed, Sep 8, 2021 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Sep 8, 2021 at 7:16 AM Guenter Roeck <linux@roeck-us.net> wrote:
>>> On 9/7/21 9:48 PM, Al Viro wrote:
>>>> On Tue, Sep 07, 2021 at 09:28:38PM -0700, Guenter Roeck wrote:
>>>>>       memcpy(eth_addr, sanitize_address((void *) 0xfffc1f2c), ETH_ALEN);
>>>>>
>>>>> but that just seems weird. Is there a better solution ?
>>>>
>>>> (char (*)[ETH_ALEN])?  Said that, shouldn't that be doing something like
>>>> ioremap(), rather than casting explicit constants?
>>>
>>> Typecasts or even assigning the address to a variable does not help.
>>> The sanitizer function can not be static either.
>>
>> So it can only be fixed by obfuscating the constant address in a
>> chain of out-of-line functions...
>> How is this compiler to be used for bare-metal programming?
> 
> I reported this as a gcc bug when I first saw it back in March:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> 
> Martin Sebor suggested marking the pointer as 'volatile' as a workaround,
> which is probably fine for bare-metal programming, but I would consider
> that bad style for the kernel boot arguments. The RELOC_HIDE trick is probably
> fine here, as there are only a couple of instances, and for the network
> driver, using volatile is probably appropriate as well.
> 
> I still hope this can be fixed in a future gcc-11.x release. Maybe we should
> add further instances of the problem on the gcc bug to boost the priority?
> 
>>> I don't know the hardware, so I can not answer the ioremap() question.
>>
>> Yes it should.  But this driver dates back to 2.1.110, when only
>> half of the architectures already had ioremap().
> 
> How does  mvme16x even create the mapping? Is this a virtual address
> that is hardwired to the bus or do you have a static mapping somewhere?
> I see two other drivers accessing the nvram here
> 
> arch/m68k/mvme16x/config.c:static MK48T08ptr_t volatile rtc =
> (MK48T08ptr_t)MVME_RTC_BASE;

Is that even correct ? I am always shaky with qualifiers, but doesn't
that mean that the pointer is volatile, not the object it points to ?

> arch/m68k/mvme16x/rtc.c:        volatile MK48T08ptr_t rtc =
> (MK48T08ptr_t)MVME_RTC_BASE;
> 
> The same trick should work here, just create a local variable with a
> volatile pointer and read from that.
> 

I had tried that; it doesn't work because then the compiler complains
that the 'volatile' qualifier is discarded when passing the argument.

drivers/net/ethernet/i825xx/82596.c: In function 'i82596_probe':
drivers/net/ethernet/i825xx/82596.c:1147:34: error:
	passing argument 2 of '__builtin_memcpy' discards 'volatile' qualifier from pointer target type

Oddly enough, a memcpy on the 'rtc' variable doesn't fail,
neither with nor without volatile. Something else is going on.

Guenter

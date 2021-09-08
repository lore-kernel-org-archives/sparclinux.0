Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26381C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 05:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00C6261100
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 05:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbhIHFrZ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245528AbhIHFrW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 01:47:22 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2928AC061575;
        Tue,  7 Sep 2021 22:46:13 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id v2so1685859oie.6;
        Tue, 07 Sep 2021 22:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oI034eT0o3xJiZ0XQLCTDDDSm6gdqB6B1NQ4npTSYHk=;
        b=HJhp2UpxJXFc+THZ2MvQqyB9sdi46546xOcIpM+/wZnoWg0u3azReP5bzAGRGEfozr
         jxZ/XInG5BgfbT1KgJEhtH8VUMbwSK9tsOhVIb5nKMjgd6kBE04wq7WAxfuypM+W9ZOK
         EabyF8QjvtAJKmYXoCcraYlwHEfWpLR59L4pe6X0ZY68hC7VRvU5wIB8vinwjNbsYJXS
         564g6wgYgxDnPuvc8Koc1duY73NKaum7bjhJ17QGwQhs5R0Sso//L3fSDHl7e95Bmf8U
         NWyRq0DaOTE1ZJlmtUTXClOUDxORGRfrpZFJIaZJJbsUnVrGRBiyLvp1q+e0JY8hP6V9
         x/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oI034eT0o3xJiZ0XQLCTDDDSm6gdqB6B1NQ4npTSYHk=;
        b=jZAv2uvX/YwyH3fkPQrFWs2j3a/TzHdnmR9q+52lJ8HeH8eXOvrrErZrYTIckuzVA/
         fqNcqVfgS7zf5fc4lSgVPMEiTnpAoaJejwJopNB9gcVLhWMhhab9KbFgWKyxb39c9vn1
         021pas6yO6JDTXZ/3dXZtFSNsGpLnap7uTECGzjZ2M1q12+T5z7+qf/bXFGqAXa/FJMb
         A7w6+HY0EKBxqVDQA65qYSnt7sZb+AEl8zR7NE4NtNO8nexWqY5jXq3G47WqoTpyWbFN
         v9Oc3d/5eJtviDmsQSMIom1iw4c0YA69KK2bfJdbTRNyYy5nW7Ha6t7wyGtkh1W3kHXm
         7e5A==
X-Gm-Message-State: AOAM5318oe+6tn2oZw+1Z4gIChue/DFpT+6ymdSmOYVSN/7s2FviXa+n
        hPko4WZJXwqJtYfI68CEr5rXBlHhNtM=
X-Google-Smtp-Source: ABdhPJwQoz4X84mHFzWwmg5UHCID8nHwzTKcCPrAtsiOCdwMC1gl8gg03UaPxhjDeHi8aUjXMBm/MA==
X-Received: by 2002:aca:ad07:: with SMTP id w7mr1238229oie.22.1631079972289;
        Tue, 07 Sep 2021 22:46:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c3sm270855oiy.30.2021.09.07.22.46.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:46:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
 <20210908042838.GA2585993@roeck-us.net>
 <CAHk-=whVDMcg==vcOopR0Mci2FQ8bzJjufyCg+WPh003K2i2ww@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <0428495c-fbf3-77f2-b296-cba4a59e52da@roeck-us.net>
Date:   Tue, 7 Sep 2021 22:46:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whVDMcg==vcOopR0Mci2FQ8bzJjufyCg+WPh003K2i2ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/7/21 9:55 PM, Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 9:28 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> It is seen with gcc 11.x whenever a memXXX or strXXX function parameter
>> is a pointer to a fixed address.
> 
> I wonder why I don't see it with gcc 11.2 here on x86-64.
> 

I see the problem only on some architectures. No idea what triggers it,
but it is definitely architecture dependent.

>> gcc is happy if "(void *) 0xfffc1f2c"
>> is passed to a global function which does nothing but return the address,
>> such as:
>>
>> void *sanitize_address(void *address)
>> {
>>          return address;
>> }
> 
> We have had reasons to do things like that before for somewhat similar
> (well, opposite) reasons - trying to disassociate some pointer from
> its originating symbol type.
> 
> Look at RELOC_HIDE().
> 
> It might be worth it having something similar for "absolute_pointer()".
> 
> Entirely untested "written-in-the-MUA" garbage:
> 
>     #define absolute_pointer(val) \
>          ({ void *__res; __asm__("":"=r" (__res):"0" ((unsigned
> long)(val))); __res; })
> 

or:

#define absolute_pointer(val) RELOC_HIDE(val, 0)

or maybe:

#define absolute_pointer(val) RELOC_HIDE((void *)val, 0)

would do the same (though the first variant needs a pointer as argument).
All of those compile.

I tested the first and the last option on qemu:parisc and confirmed that
both work as expected.

I'd be happy to send a formal patch. Which one do you prefer, and where
should I put it ?

Thanks,
Guenter

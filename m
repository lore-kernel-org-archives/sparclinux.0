Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF144C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 05:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9AD661152
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 05:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhIHFPx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 01:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbhIHFPw (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 01:15:52 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71310C061575;
        Tue,  7 Sep 2021 22:14:45 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id l7-20020a0568302b0700b0051c0181deebso1380041otv.12;
        Tue, 07 Sep 2021 22:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pyGzdXX+PpJNqBikj4EAmTcOGVssrcYKCfwJglYLCj0=;
        b=SEFgrGHC9E2SXS1BNTVsZcc/MwXjrCKJaIxMWTzPguzBTM76KVl95fr89wj5dDe8am
         uwoChaS/Vb+4ZshnhmDZHotWk5Hyk00mCqTKT4lcdZ/vFMmVfgzc6SDdiivfHkwOQL//
         LZnaByQM3sZRMdP28APGWamlH0IbjBKVAeiCy0VO7CavQq5J+AX3hvnmYK00CwQ70lHO
         QQaMQHX44JIZmv3wC2RtxknxD2MEatk5sCKYAEVJdIE45NTxEFB2Ez1tlIGV6ukJskkS
         h18KBQQuecqRbltdDbwQdlTVxRf94QlX8TUwxeKisQ/BubHevy6gPusbe4PFuYWVX54g
         z11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pyGzdXX+PpJNqBikj4EAmTcOGVssrcYKCfwJglYLCj0=;
        b=Q+zSgd22gm0+VN8FIsfv6WfrI3IA8kGFAPK91RcugYzQM5eP3MU1nyZYw06tPmluEm
         CbQuEq/kYrf12YKiKGqy0dcCG9dLdrSh7/i2TJ96nFtZChOW+o9IsLcvALtpS8VgWDdj
         M6FnvMCZZKbtrmvbIM1C82hZzFfjvFfllwtVXDMzfFGPMqpR+9hsvbd7tl2nOtOo0jbK
         UzIAEv1qBqtDT2/XWlC62idwr2VFR0VemNJf53rpQ6QwKBJpaI4iOnHUzX+DXVKXYk3g
         x5gpbSUwZFoV32VB8ZSt41KWVchbpgM9xkqPe0K01jR+tu3R+y+PZagce6226mGau0Wz
         MBCQ==
X-Gm-Message-State: AOAM533q5b+dMcJwRjD48YClVpdHHgojFGoAcTS2XwG92Xj6Zs4wm00R
        IWFoDEGC9TeG9rKHLlFjdRDtEryR9/0=
X-Google-Smtp-Source: ABdhPJwfoxZFnmDqIFU3Tx9LFM24pirkH+8yCM4hFLiexLDdw21H9Sxxekm8dUSlhUXRRe86Snkx4A==
X-Received: by 2002:a9d:458b:: with SMTP id x11mr1562574ote.313.1631078084569;
        Tue, 07 Sep 2021 22:14:44 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p65sm264176oif.57.2021.09.07.22.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 22:14:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
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
 <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <f4817c3d-c051-4030-e9ca-ea8b3f846119@roeck-us.net>
Date:   Tue, 7 Sep 2021 22:14:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YThAgIhKPQZq5UZn@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/7/21 9:48 PM, Al Viro wrote:
> On Tue, Sep 07, 2021 at 09:28:38PM -0700, Guenter Roeck wrote:
> 
>> 	memcpy(eth_addr, sanitize_address((void *) 0xfffc1f2c), ETH_ALEN);
>>
>> but that just seems weird. Is there a better solution ?
> 
> (char (*)[ETH_ALEN])?  Said that, shouldn't that be doing something like
> ioremap(), rather than casting explicit constants?
> 

Typecasts or even assigning the address to a variable does not help.
The sanitizer function can not be static either.

I don't know the hardware, so I can not answer the ioremap() question.

This is just one example, though; there are several sprinkled throughout
the code. Another is:

arch/parisc/kernel/setup.c:	running_on_qemu = (memcmp(&PAGE0->pad0, "SeaBIOS", 8) == 0);

where

#define PAGE0   ((struct zeropage *)__PAGE_OFFSET)

and __PAGE_OFFSET depends on the configuration.

That code runs early in setup; I don't think ioremap() would even
be available at that time. A workaround for that problem would be
a global variable pointing to PAGE0 (or of course an address sanitizer
function), but again that seems odd just to make the compiler happy.

Guenter

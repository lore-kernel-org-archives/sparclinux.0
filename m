Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19978C433EF
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 04:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFC861131
	for <sparclinux@archiver.kernel.org>; Wed,  8 Sep 2021 04:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhIHE3t (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 8 Sep 2021 00:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhIHE3s (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 8 Sep 2021 00:29:48 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618AC061575;
        Tue,  7 Sep 2021 21:28:41 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id q11-20020a9d4b0b000000b0051acbdb2869so1319625otf.2;
        Tue, 07 Sep 2021 21:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=t9l5/k4D6pzjZ7MocPD2eimRV3thvGM8utNt6GK2WrQ=;
        b=p+JOLQp9xHNZcwX7t+VbXx885EQaD3823d05jFB/l7sXsxIDt7OTyChvMv+t/TUYw5
         WP2zc8DxsToZJZ5UBPUpi7lwxYY4HHTaZoC6akasQBRYfyax30iaTN+X2Z7uoVq8nKuM
         2Sg5slGJlFgsDdDcE+RAy6hSQNMQdV7fuqj2FSgXBeblew1rjrBWlOCFare7pyIDek0u
         tbfjwWunEOLk0mGSM/ai9bWPyKSxxJ8CUVPVMpxkhq4i4vnJtih/bJNZ3LGU60cjC/JV
         T+uR+7HBnJ3mt7PWAYv9FxtfAvcYkAh/NZCoOplsKvpGoIM3l7xsYGtzQBCj/5n5v3+G
         ugmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=t9l5/k4D6pzjZ7MocPD2eimRV3thvGM8utNt6GK2WrQ=;
        b=RLrS/z9eo/arT2nqBoU63P4v/aY9Bal/LJoYbwLzrju1MMtX5/zWxejSvZd5vkdmu9
         GM9u7RtyWmQF011FyfLyCxu05KK+GGzAcaBPdePph150DFCSL3HohrknCTjTOseyprKN
         q6bq8ZwacyEQVQDSTDFtR7dVINTbc+i+p7r3bkNc7z1u1iWUWEZn+qWaa/QNasppcZNn
         WvED9s5s1oYCk2FddVWV7Hkp3tbLWuK7tlXm8LvkI8YxwHSTT+wnWjdVvYRf2a0cOEia
         douyWYLakeA4FxBEZWTefJgOmL6EeTJoXHmUKOljhTV191jyQFhKmM41thXxAiBeQbgh
         hHPw==
X-Gm-Message-State: AOAM5338rHscZDU9TkLg5dEhx1HQzL5rJKWq/ysBq97sKxHzT+nPZxlP
        pGcumTRBDIxhdmRPH3djKo4=
X-Google-Smtp-Source: ABdhPJxn9DzmF4MYeHp3QkJ2JjtnP/zwdytkKBiRik1yXQEfMb9ir76v4xkyoHNgen/xGyfWEqsN+A==
X-Received: by 2002:a9d:4a8d:: with SMTP id i13mr1559812otf.180.1631075321035;
        Tue, 07 Sep 2021 21:28:41 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bf6sm256727oib.0.2021.09.07.21.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 21:28:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 7 Sep 2021 21:28:38 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <20210908042838.GA2585993@roeck-us.net>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210906234921.GA1394069@roeck-us.net>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Mon, Sep 06, 2021 at 04:49:21PM -0700, Guenter Roeck wrote:
> On Mon, Sep 06, 2021 at 04:06:04PM -0700, Linus Torvalds wrote:
[ ... ]

> >  - at least a couple of stringop-overread errors. Attached is a
> > possible for for one of them.
> > 

I keep seeing problems like this.

drivers/net/ethernet/i825xx/82596.c: In function 'i82596_probe':
./arch/m68k/include/asm/string.h:72:25: error: '__builtin_memcpy' reading 6 bytes from a region of size 0 [-Werror=stringop-overread]
   72 | #define memcpy(d, s, n) __builtin_memcpy(d, s, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/ethernet/i825xx/82596.c:1147:17: note: in expansion of macro 'memcpy'
 1147 |                 memcpy(eth_addr, (void *) 0xfffc1f2c, ETH_ALEN);        /* YUCK! Get addr from NOVRAM */
      |                 ^~~~~~
cc1: all warnings being treated as errors

It is seen with gcc 11.x whenever a memXXX or strXXX function parameter
is a pointer to a fixed address. gcc is happy if "(void *) 0xfffc1f2c"
is passed to a global function which does nothing but return the address,
such as:

void *sanitize_address(void *address)
{
	return address;
}

and:

	memcpy(eth_addr, sanitize_address((void *) 0xfffc1f2c), ETH_ALEN);

but that just seems weird. Is there a better solution ?

Thanks,
Guenter

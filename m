Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02C8C433F5
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 02:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E68760E52
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 02:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhIGCa0 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 6 Sep 2021 22:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbhIGCa0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 6 Sep 2021 22:30:26 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9188CC061575;
        Mon,  6 Sep 2021 19:29:20 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id r26so11002579oij.2;
        Mon, 06 Sep 2021 19:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:to:cc:references:from:subject:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QS7GUVfDcM+Zq+PxXHCnRkp1yuhAzbzUijM6wRDYUU4=;
        b=FLvjX3pPxPhhEVKMGmdil4bQL0SQHfsRsx94xIWAgHdvhny5fHy1PPUTKhMrbLTGCg
         K7mrDngGO7KBG1liRCq+YWOH8O0auereuGgCEOvkzX5MXrRTWr/C0MjaYo3wmiNUc+fF
         xOWSOOg+zJjxdtZw28z6XqHnoTabXRT5JyVPTD+L+YXhIqznaTlVLigWbUhmieGURoiy
         UwNTbOaWENsgVhGEfyxy5QbzhAyRd+/nlAfNKYNtIZ4b4v2kBFr5EHcGb4YaieVVkive
         lEVxSx9WSzO3rw2LHT0c5IMm1KMxhzL8hbZ7pNb1MIy752LVW3RDkLGFUZkClkUAfguK
         0SDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:to:cc:references:from:subject:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QS7GUVfDcM+Zq+PxXHCnRkp1yuhAzbzUijM6wRDYUU4=;
        b=PVY2KOi1rq+GJfTJO1Mf14Iuqz+JWZiIVnF0jw9oZxUwuVNhdzGD2nvnwyU92D+TVV
         Qp2eVbuc5bDS2Nca4nQVFdMDT4LwX6ZHMEmbjgEM22jiUpHF0JI/6Cvc4igqSi4L2DOl
         8Pv2+5xWHgSENyn4k1uZxCnyotzByp/2eY+pAqbjaWeqHyqoLnZ1Ugyzp5+CTThxALVK
         MsKRbFfrsIu79w9yThbeH++JKfGLt7hTJzI2WhRXB0rDkZqtmGNiXK/LR0IcRkQGRtz/
         zM+CSXtpgScvBRxW5nmdBf2JBQU+I2kbodcde7pmaZFuQHNOZnq38Bk8UqH9r4PWGNkC
         CDQA==
X-Gm-Message-State: AOAM531UnWQgL5rhkCf5ICLY/8JqEXHk0HIc2OypbHEqTtKkdvxSIqfQ
        b6RNl4B8q4IiqWaKM8YejzY=
X-Google-Smtp-Source: ABdhPJy3KvT0zURKa9k7NPooWI+L/ozTIdnO2Po8lBH/H7Tk2Jfgd1t8HuNkOiov5NeFTg4uYHCICQ==
X-Received: by 2002:a54:4104:: with SMTP id l4mr1439362oic.126.1630981759821;
        Mon, 06 Sep 2021 19:29:19 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 4sm1810005oil.38.2021.09.06.19.29.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 19:29:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <c3790fb9-b83f-9596-18a1-21ace987c850@roeck-us.net>
 <CAHk-=wi4NW3NC0xWykkw=6LnjQD6D_rtRtxY9g8gQAJXtQMi8A@mail.gmail.com>
 <20210906234921.GA1394069@roeck-us.net>
 <CAHk-=wjvfUpPJLbWz6Jezr4ZNjhC6j2WYi5MHUd9bjK94JC24A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
Message-ID: <4fa776ea-c225-157e-6321-f852393422b9@roeck-us.net>
Date:   Mon, 6 Sep 2021 19:29:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjvfUpPJLbWz6Jezr4ZNjhC6j2WYi5MHUd9bjK94JC24A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/6/21 6:12 PM, Linus Torvalds wrote:
> On Mon, Sep 6, 2021 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>> but I'm not seeing why that one happens on sparc64, but not on arm64
>>> or x86-64. There doesn't seem to be anything architecture-specific
>>> anywhere in that area.
>>>
>>> Funky.
>>
>> Not really. That is because de->di_fname is always 16 bytes but size
>> can be 48 if the node is really a link. The use of de is overloaded
>> in that case; de is struct qnx4_inode_entry (where di_fname is 16 bytes)
>> but the actual data is struct qnx4_link_info where the name is 48 bytes
>> long. A possible fix (compile tested only) is below.
>>
>> I think the warning/error is only reported with gcc 11.x. Do you possibly
>> use an older compiler for x86/arm64 ?
> 
> No. Literally the same exact version. All of them are
> 
>      gcc version 11.2.1 20210728
> 
> from F34.
> 
> I suspect it's something about the config - a sparc64 allmodconfig
> presumably doesn't end up having some of the things x86-64 has enabled
> (because of different core config parameters), and then optimizes
> differently as a result and shows the issue that way.
> 
> Or something. <wild handwaving>
> 

Looks like Arnd stumbled into the qnx4 problem before:

https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578

He might have an idea how to fix it for good.

Guenter

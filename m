Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94ECDC433F5
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 15:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FAC26108D
	for <sparclinux@archiver.kernel.org>; Tue,  7 Sep 2021 15:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbhIGPvV (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 7 Sep 2021 11:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbhIGPvU (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 7 Sep 2021 11:51:20 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49EB9C061575;
        Tue,  7 Sep 2021 08:50:14 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so3055172ooe.0;
        Tue, 07 Sep 2021 08:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ogax7Hn2du6LFF8ec+bJATwLOn6GD0dmA5bAclndcIk=;
        b=ggRQSP8FTEPed7xT35spZwEld02mmPoC1B/XzF8hPC8MjmOx+0xuOvXUmToFH/JNI2
         UCfanRRhEZ8F32QKHAr2EvHBktME5sJcpj3/GPGC2vVnwwxAOKBZuV5lPPoKR+NQxNOu
         zEtoVRrMhuoyjbuB2ienXRvyq652b7gWbdcDcLvgMiYfKwbn0uL0FRqWh8BZA/6xwps7
         FD0HDph0uACn/8eGn/Dl5yng6Ts4pP9k5XLsOBBDadsgG82h3AVuJ+Eoz5TBrJ4QN0Px
         QPKYBgfhzvj0MrnFNaz/+h3r0Y3+JWicAnQ/JS+ZpJJazc7G3Uuu96hgNXJDl3vuS67R
         WcNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ogax7Hn2du6LFF8ec+bJATwLOn6GD0dmA5bAclndcIk=;
        b=ITxkRjEaj7ji097hSLNCWzG3h67wGZEE0pGBU25HzEwLjOS5wbwWRtKsrq7jE/gUBY
         rSj0KENrHc9PYYnvjbOFrdrpAT0lgp3QaAkDl+XK4PjvcqSaFIIoXoMgoTNZBLbapavh
         xAzCXLhaZrNVBCarldV0/rvD/UZvyfJ2wcGbfdrgBYVtBXnZdhcN9ZpjCmMz/ZA29dIG
         QFfkq9lESRlg2ICsGT6982BisLEjbEar/MWKSH5x3XicD2J0CPgiS0LZSwJm1WDLgBKD
         tUcHCJ2UfFvs/aknIz3d0HR0Uso06QwnBotD7I3Em0s6jOVJUkF2juIZDrlCZJCx83ty
         bZsA==
X-Gm-Message-State: AOAM530lcfvpYIErzQFT5aFGjIvZCt4dLruLXclPzSjaKtDIRM0GD3B/
        1JcarJMSoZomlAg2GjnJJUI=
X-Google-Smtp-Source: ABdhPJxO2HsjgSPUw/01ROuUYTNuOAEIcUMYpPSfnEzhrce9r08JL8YZiD0J3aFG6xuVaZyVCNhEMA==
X-Received: by 2002:a4a:88e2:: with SMTP id q31mr343033ooh.91.1631029813663;
        Tue, 07 Sep 2021 08:50:13 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c24sm2487574otf.71.2021.09.07.08.50.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 08:50:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
From:   Guenter Roeck <linux@roeck-us.net>
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
 <4fa776ea-c225-157e-6321-f852393422b9@roeck-us.net>
Message-ID: <f14e32ae-4a7c-44e6-97d3-1c7ef757cb19@roeck-us.net>
Date:   Tue, 7 Sep 2021 08:50:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4fa776ea-c225-157e-6321-f852393422b9@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/6/21 7:29 PM, Guenter Roeck wrote:
> On 9/6/21 6:12 PM, Linus Torvalds wrote:
>> On Mon, Sep 6, 2021 at 4:49 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>>
>>>> but I'm not seeing why that one happens on sparc64, but not on arm64
>>>> or x86-64. There doesn't seem to be anything architecture-specific
>>>> anywhere in that area.
>>>>
>>>> Funky.
>>>
>>> Not really. That is because de->di_fname is always 16 bytes but size
>>> can be 48 if the node is really a link. The use of de is overloaded
>>> in that case; de is struct qnx4_inode_entry (where di_fname is 16 bytes)
>>> but the actual data is struct qnx4_link_info where the name is 48 bytes
>>> long. A possible fix (compile tested only) is below.
>>>
>>> I think the warning/error is only reported with gcc 11.x. Do you possibly
>>> use an older compiler for x86/arm64 ?
>>
>> No. Literally the same exact version. All of them are
>>
>>      gcc version 11.2.1 20210728
>>
>> from F34.
>>
>> I suspect it's something about the config - a sparc64 allmodconfig
>> presumably doesn't end up having some of the things x86-64 has enabled
>> (because of different core config parameters), and then optimizes
>> differently as a result and shows the issue that way.
>>
>> Or something. <wild handwaving>
>>
> 
> Looks like Arnd stumbled into the qnx4 problem before:
> 
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578
> 

... and submitted a patch for it:

https://lore.kernel.org/lkml/20210322160253.4032422-6-arnd@kernel.org/

Looks like it got lost.

Guenter

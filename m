Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 813EBC433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F7860EFF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 14:25:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233437AbhINO0T (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 10:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhINO0R (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 10:26:17 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC2AC061574;
        Tue, 14 Sep 2021 07:24:59 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso18676857otu.0;
        Tue, 14 Sep 2021 07:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0h9K+ZzLZA7UXC/L2mBoDNn8jDxS8IhsAXryoGTLaqU=;
        b=IgsOvmsxIfMRqdKjzelCdzgEJhSFXLgDcuTTxsyujwRPqKuQ8V4MWnprKHZooxIBFr
         MHuPG9W88ibD0UCgvMhspe3iqTUkAuacj1PLoNwHgmp0PtkgM/aayvmNsXISwDazmpcK
         dF2FmC5JWxmOU1Qw0hzbcGLlzK2EiXNWr2Ja1Vo8Eo7xojk7LRObZ1GzbNQXUSVwSkcQ
         gzPZy9MJUYGMWhFb+zkiuqKl1GwLCg2DpVSCJtwXrv4h3JklKUczD0chaNiNdpnh4YeY
         lw42v3yAxpcpJumT+cvP+p/rPIDMZgNY8T+MFEfrHAX/3neQ6WFMedAhA64xS48y8uSW
         gMww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0h9K+ZzLZA7UXC/L2mBoDNn8jDxS8IhsAXryoGTLaqU=;
        b=e2bNNUfiOkLLZyBTb7qI2h1j6/nDaDiTT1+92VSyLFF1bz23EvFWQlX739cMfx2otT
         mjPCnwffyVVHVktCsBbhfGUAmfB3dlC3uQnmoPs121+h5NbPQoYjboCn8K0VALBfdREP
         dnGdGmcRQrzBf3aRBcY28S2PkaCMcScY0NsdmElWTWdE4IKbkcIRR8vDrU9NAUTSljS7
         KOCwpUL5oqvQjHc4Bcp+Yk9D2PFOrNvIrEnQT/+iiT7319jU05QRTzKOImujiC9rCkpi
         Kjg6jnyGfOuMrA6tzJnctUwG20g/OKqSeLfQ5ew1RRx+rZi27aX/Yrc1FpQcP6xdwyFo
         Btew==
X-Gm-Message-State: AOAM530KU13eBh9MRx027bgEwH3Ke7We57x/+79JKJJwPN8SRr45NLhZ
        dxLkalx4QZrLu7QC6POVugY=
X-Google-Smtp-Source: ABdhPJz5NE7bmO+/NYNy/QxFRX5ctI4zKv5Q2YFP1oIA1xVKuvuRrxH9DFfckw4vAKrOzancEzruHg==
X-Received: by 2002:a05:6830:20d0:: with SMTP id z16mr14592644otq.330.1631629499221;
        Tue, 14 Sep 2021 07:24:59 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f33sm2686090otf.0.2021.09.14.07.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 07:24:58 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
To:     David Laight <David.Laight@ACULAB.COM>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@kernel.org>
References: <20210913163712.922188-1-linux@roeck-us.net>
 <YT+SPIAl0IdWOAn/@ravnborg.org>
 <d0a4b46a-2f0e-f6a2-1342-777e738d9525@roeck-us.net>
 <2d8f45425f024fd9a3d91a4b4a1304cf@AcuMS.aculab.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <3b069cde-6f15-1df1-fbed-e8d94d0ef173@roeck-us.net>
Date:   Tue, 14 Sep 2021 07:24:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <2d8f45425f024fd9a3d91a4b4a1304cf@AcuMS.aculab.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 9/14/21 7:17 AM, David Laight wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: 13 September 2021 19:53
>> To: Sam Ravnborg <sam@ravnborg.org>
>> Cc: David S . Miller <davem@davemloft.net>; sparclinux@vger.kernel.org; linux-kernel@vger.kernel.org;
>> Arnd Bergmann <arnd@kernel.org>
>> Subject: Re: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
>>
>> On 9/13/21 11:02 AM, Sam Ravnborg wrote:
>>> Hi Guenter,
>>>
>>> On Mon, Sep 13, 2021 at 09:37:12AM -0700, Guenter Roeck wrote:
>>>> sparc64 images fail to compile with gcc 11.x, reporting the following
>>>> errors.
>>>>
>>>> arch/sparc/kernel/mdesc.c:647:22: error:
>>>> 	'strcmp' reading 1 or more bytes from a region of size 0
>>>> arch/sparc/kernel/mdesc.c:692:22: error:
>>>> 	'strcmp' reading 1 or more bytes from a region of size 0
>>>> arch/sparc/kernel/mdesc.c:719:21:
>>>> 	error: 'strcmp' reading 1 or more bytes from a region of size 0
>>>>
>>>> The underlying problem is that node_block() returns a pointer beyond
>>>> the end of struct mdesc_hdr. gcc 11.x detects that and reports the error.
>>>> Adding an additional zero-length field to struct mdesc_hdr and pointing
>>>> to that field fixes the problem.
>>>>
>>>> Cc: Arnd Bergmann <arnd@kernel.org>
>>>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>> ---
>>>> My apologies if a similar patch was submitted already; I was unable to find it.
>>>> I did find the following patch:
>>>>       https://git.busybox.net/buildroot/commit/?id=6e1106b4a9aee25d1556310d5cd1cb6dde2e6e3f
>>>> but I failed to find it in patchwork or on lore.kernel.org, and it
>>>> seems to be more expensive than the solution suggested here.
>>>>
>>>>    arch/sparc/kernel/mdesc.c | 3 ++-
>>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
>>>> index 8e645ddac58e..c67bdcc23727 100644
>>>> --- a/arch/sparc/kernel/mdesc.c
>>>> +++ b/arch/sparc/kernel/mdesc.c
>>>> @@ -39,6 +39,7 @@ struct mdesc_hdr {
>>>>    	u32	node_sz; /* node block size */
>>>>    	u32	name_sz; /* name block size */
>>>>    	u32	data_sz; /* data block size */
>>>> +	char	data[0];
>>>>    } __attribute__((aligned(16)));
>>>
>>> I do not think this will works.
>>> See following comment:
>>>    * mdesc_hdr and mdesc_elem describe the layout of the data structure
>>>    * we get from the Hypervisor.
>>>
>>> With the above change you increased the size from 16 to 32 bytes,
>>> and any code using sizeof(struct mdesc_hdr) will now point too far in
>>> memory for the second and subsequent entries.
>>>
>>> I did not take any closer look, but this was from a quick analysis.
>>>
>>
>> Sorry, I didn't realize that a field of size 0 increases the structure size
>> on sparc. I had checked the size of the old and the new structure with gcc
>> on x86_64 and didn't see a field size increase.
> 
> clang output doesn't change:
> 
> https://godbolt.org/z/bTeeq19j1
> 
> gcc ought to generate the same size.
> 
> It ought to be 'char data[];' though.
> 

I am never sure if [] or [0] is "correct". Anyway, is there agreement that this
is an acceptable solution ? I'll be happy to resend if that is the case.

Guenter

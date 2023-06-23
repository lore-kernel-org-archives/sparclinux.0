Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA14EB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 23 Jun 2023 19:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFWTUn (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 23 Jun 2023 15:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjFWTUn (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 23 Jun 2023 15:20:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6077FE7D;
        Fri, 23 Jun 2023 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=kfo1zbZuYiDeZ+TXOoYmOb6nZqrt/7kAU//dMtLFfCE=; b=Ez28FvmXwHY/ORA7QbFa1B6QPE
        K3/oyupL3AoeZj4wDQ4f5UVpMDj13SzClOufU/URlii8XxD65/0X244OYWSD6v0LKoFLSTYXIABg/
        TL0+72Rts8dqDvUmGiary2dOLVJFZ/xr8Q6EamR9butZypDjL3hSqvMN8BX7hTwzY6+iGY2h96T4U
        oXAqX37TpwWqkZG8hajGJRLzLc7uBnPMlUG3cR654Ts3KSRvLg4VnGb0c7Idq7NURL1ydrWAIjAb9
        4SIv+lSxX0n5qGNLJn+iSn+3VB2+BrAh2L4oiwr03nr2hGfCuRthoMz0E31Cpx9m8EnU0Vp37gten
        x6BOaZNw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qCmKb-004NTF-2i;
        Fri, 23 Jun 2023 19:20:29 +0000
Message-ID: <2b1f8eff-d612-4a8c-43e2-38d4239b561a@infradead.org>
Date:   Fri, 23 Jun 2023 12:20:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>, David Miller <davem@davemloft.net>
Cc:     macro@orcam.me.uk, schnelle@linux.ibm.com,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
References: <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
 <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
 <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
 <20230623.163329.1458342120776268478.davem@davemloft.net>
 <20230623172251.GA2531634@ravnborg.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230623172251.GA2531634@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 6/23/23 10:22, Sam Ravnborg wrote:
> Hi Davem,
> 
>>>
>>>>>  What happened to DaveM?
>>>>
>>>> I haven't seen him merge any arch/sparc/ patches lately.
>>>> I have a couple that are still pending.
>>>
>>>  Oh, I hope he's been doing good then, and it's just a change of life 
>>> priorities or suchlike.  Patch reviews can take a lot of mental effort, 
>>> and I can't claim I've been as effective as I wished to with stuff that 
>>> lands on my plate either.
>>
>> I'm good just too busy with networking and real life.
> 
> 
> Enjoy the real life!
> 
> 	Sam

I agree with that. :)

But is there an alternate route for sparc patches?

thanks.
-- 
~Randy

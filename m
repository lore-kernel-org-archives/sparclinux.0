Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B348EB64D7
	for <sparclinux@archiver.kernel.org>; Mon, 19 Jun 2023 02:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjFSCf1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 18 Jun 2023 22:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjFSCf0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 18 Jun 2023 22:35:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F461B4;
        Sun, 18 Jun 2023 19:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=LuA83bs6x4tpHCVAyfI7mXZwUb3oCY1lGprHb4B/e34=; b=ka5d9uLiuhXq2cEXhVkMmGgZ/B
        kEM+pkOYmxydGZogM41oeQ2yWUkYaxuaDlbft4M7+rZBWWxfqNU4s+6K/BprJGqRSVwNKcHplvTBI
        K9428z+k1Omi+v4Gwzn9tPqNQEDiSv+5QaB6vBEbUEkSnGEHJxTl7SfYhT6ecRv+cgwTw7gSldKRw
        VhEJzu2wMOKuU/gYZz3qGRgabQCpdYDGjdiAnidVlvxM/mgPkq5NIfEav0tVW3dNMwyhK6oljbjkZ
        Irq6puVhoMnBs4ITR56jX5EH+dEJChxOruq5TMpn+GsKC9wclkD0hKElH887lGXKPPqNrr23xqlu+
        orzxufHw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qB4je-007DcK-1r;
        Mon, 19 Jun 2023 02:35:18 +0000
Message-ID: <0b59e7f8-542a-dc2d-08bd-8b42e03e32aa@infradead.org>
Date:   Sun, 18 Jun 2023 19:35:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Content-Language: en-US
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
References: <20230406160548.25721-1-rdunlap@infradead.org>
 <alpine.DEB.2.21.2304062039260.44308@angie.orcam.me.uk>
 <20230406203207.GA1534216@ravnborg.org>
 <alpine.DEB.2.21.2304062144520.44308@angie.orcam.me.uk>
 <20230407200313.GA1655046@ravnborg.org>
 <alpine.DEB.2.21.2304072142290.62619@angie.orcam.me.uk>
 <a05558c3-8d5c-c389-ba4c-be134c75ac1c@infradead.org>
 <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
 <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
 <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org



On 6/18/23 18:29, Maciej W. Rozycki wrote:
> Hi Randy,
> 
>>>  What happened to DaveM?
>>
>> I haven't seen him merge any arch/sparc/ patches lately.
>> I have a couple that are still pending.
> 
>  Oh, I hope he's been doing good then, and it's just a change of life 
> priorities or suchlike.  Patch reviews can take a lot of mental effort, 
> and I can't claim I've been as effective as I wished to with stuff that 
> lands on my plate either.
> 
>>>  In any case after a couple of iterations I have made a succesful build of 
>>> a 32-bit SPARC toolchain now, which I was able to verify a fix with I have 
>>
>> Is your newly built toolchain for riscv hosting?
> 
>  Are you asking whether the SPARC toolchain has been built/installed on a 
> RISC-V system?  If so, then no, it hasn't.  It runs on POWER9.

Yes, that's what I was asking.
So you could have used the compilers that Arnd builds:
  https://mirrors.edge.kernel.org/pub/tools/crosstool/

Thanks.
-- 
~Randy

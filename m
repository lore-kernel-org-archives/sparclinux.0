Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA46C433E1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90B6361A23
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 17:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbhCXRx5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 13:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237121AbhCXRxj (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 Mar 2021 13:53:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F64C061763;
        Wed, 24 Mar 2021 10:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=9/3k0AHtaMfdxAZXGbthGhLvgi4daNXj7PuUxegsSz8=; b=SNB16JGMv3nP/anwx6zdfPnYY/
        hEF1sm4HF0sl37Lr+C95EDzFbmewzMHL7VgGYU0OmDPyZmpyzXLL+NDjlUSJXkB1pXBjgMF7j9OwT
        joWNIhgoCofzgNAjgHRsyI4Q2zlSqu/DoC/b2ceyDzBYqAqeKJyaMJQYOSJ0X4iHULQgfiGXW56Aq
        zDJSqJp5VlBpzhauIM41+iwd7K+dsmT5R5EHNKz9M7wiuQ7mSfnzD4+6Gn/kOuBar/QYcpCip8TDM
        MJ5ml32+4giqdmrYrlZqHh7Clh06NvLdIF82lzMn6zGdqc+p4gJeBGKF6pO1lkBYbfJPFZzW2N6Yn
        h52ae5Ag==;
Received: from [2601:1c0:6280:3f0::3ba4]
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lP7gm-00Begv-QS; Wed, 24 Mar 2021 17:53:16 +0000
Subject: Re: [PATCH] sparc/traps_64.c: Mundane typo fixes
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, davem@davemloft.net,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com,
        rob.gardner@oracle.com, rppt@kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210324060251.24208-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7d4e516c-bf33-2bd8-9101-54126a994279@infradead.org>
Date:   Wed, 24 Mar 2021 10:52:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324060251.24208-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 3/23/21 11:02 PM, Bhaskar Chowdhury wrote:
> s/conditon/condition/
> s/periof/period/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  arch/sparc/kernel/traps_64.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
> index a850dccd78ea..2353ba7e1469 100644
> --- a/arch/sparc/kernel/traps_64.c
> +++ b/arch/sparc/kernel/traps_64.c
> 
> -/* Return the highest priority error conditon mentioned. */
> +/* Return the highest priority error condition mentioned. */
> @@ -1853,7 +1853,7 @@ struct sun4v_error_entry {
>  	/* ID of the CPU */
>  /*0x24*/u16		err_cpu;
> 
> -	/* Grace periof for shutdown, in seconds */
> +	/* Grace period for shutdown, in seconds */
>  /*0x26*/u16		err_secs;
> 
>  	/* Value of the %asi register */
> --

Please fix line 378 (in linux-next) while you are
touching this file:

	 * is vectored thorugh data access exception trap with fault type



thanks.
-- 
~Randy


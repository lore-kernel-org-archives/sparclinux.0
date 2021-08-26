Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE7CC432BE
	for <sparclinux@archiver.kernel.org>; Thu, 26 Aug 2021 14:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 852A661053
	for <sparclinux@archiver.kernel.org>; Thu, 26 Aug 2021 14:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbhHZOho (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 26 Aug 2021 10:37:44 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46484 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242829AbhHZOho (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 26 Aug 2021 10:37:44 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BD08822235;
        Thu, 26 Aug 2021 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1629988615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AJYi8p48Mp7c2LVCCbbs7wQvg9zHNiToSE4X8bydgEo=;
        b=c5oNUgjCTZvPBtu/VYNVNHRoCyXWQE25wn9JKR3rEk72OLcWdhBBCIaE5V02e63f2fbcwa
        LMJoI4VZhYdTzoBmtUnTEYou6L56if3zXxcYnYv8pTMf55zMHcOpT/EDwJS6akNBEeNayV
        LPepd/PtGZRD6JBv9FXmYNAojRpfTEg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 47CA0A3B8D;
        Thu, 26 Aug 2021 14:36:55 +0000 (UTC)
Date:   Thu, 26 Aug 2021 16:36:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Pingfan Liu <kernelfans@gmail.com>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wang Qing <wangqing@vivo.com>,
        Santosh Sivaraj <santosh@fossix.org>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] kernel/watchdog: change prototype of
 watchdog_nmi_enable()
Message-ID: <YSenB+Rr/4OV8EHQ@alley>
References: <20210824031435.9664-1-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210824031435.9664-1-kernelfans@gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue 2021-08-24 11:14:35, Pingfan Liu wrote:
> The only caller does not handle the return value of
> watchdog_nmi_enable(). If there is an error, it seems to be reported by
> arch specific code.
> 
> Hence changing watchdog_nmi_enable() return value from int to void.
> 
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

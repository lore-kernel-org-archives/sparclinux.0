Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27587EB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 16 Jun 2023 17:13:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346009AbjFPRNG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 16 Jun 2023 13:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346035AbjFPRM4 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 16 Jun 2023 13:12:56 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 16 Jun 2023 10:12:49 PDT
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E262101
        for <sparclinux@vger.kernel.org>; Fri, 16 Jun 2023 10:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=JRm5O171hLwJHO6q62bbB0qic6uO26bMaqkYvzkG0Lc=;
        b=k3SzAQoZr2DWkrjtdjn0CN+zfTGAUOpUcN0qLBf2qlmwIYlt8jActbEF+HXei14T29sW6/pwB9ZKu
         RmCf/mNJZe6vbPmYiIqzOvsrKdhSk0rmd44SfbKdK59N16HL4/YXGoVSyhK2yQ1sykXrvNAYTrsHjG
         kXqJAkyitSfTJ3w3tMH7mVoqbKRKuZcfcR4ve4HGttPMiLfMqfmxmV8ooo3WWLMDtkIfTKQ1h6bd2X
         KFPymf2G2fuzsAbUCRUKKc1EzWxe7xXu/TFH4xrnffTtE3/xxEK+CatMRtyIhNpoju9ZmfESGjU4ky
         aa97ypoZx0hlY7GKgHiHNycWxJATdAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=JRm5O171hLwJHO6q62bbB0qic6uO26bMaqkYvzkG0Lc=;
        b=CYtfgZjEyyWxf/Tanh/i/yhmljUFwTS1wia9aDB9yl8Tf0IMyZmCd1u/3+rp/LQFB3QKmz8x34xrW
         RYgCLK1Cg==
X-HalOne-ID: c41ad6c4-0c66-11ee-a64a-55333ba73462
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id c41ad6c4-0c66-11ee-a64a-55333ba73462;
        Fri, 16 Jun 2023 16:56:43 +0000 (UTC)
Date:   Fri, 16 Jun 2023 18:56:42 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: Fix invalid .section syntax
Message-ID: <20230616165642.GD1697490@ravnborg.org>
References: <ZIyBGdriWti6AsvH@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZIyBGdriWti6AsvH@decadent.org.uk>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Ben,

On Fri, Jun 16, 2023 at 05:34:49PM +0200, Ben Hutchings wrote:
> From: Ben Hutchings <benh@debian.org>
> 
> gas supports several different forms for .section for ELF targets,
> including:
>     .section NAME [, "FLAGS"[, @TYPE[,FLAG_SPECIFIC_ARGUMENTS]]]
> and:
>     .section "NAME"[, #FLAGS...]
> 
> In several places we use a mix of these two forms:
>     .section NAME, #FLAGS...
> 
> A current development snapshot of binutils (2.40.50.20230611) treats
> this mixed syntax as an error.
> 
> Change to consistently use:
>     .section NAME, "FLAGS"
> as is used elsewhere in the kernel.
> 
> Also change the one correct use of:
>     .section "NAME", #FLAGS
> to be consistent with the rest of the kernel.

The commit also changes from the solaris compatibility names to the
standard gas names.
The change surprised me while reading the patch, and I was not happy
until I found out that the current flags are compatibility names.
So please add this info to the changelog.

With that fixed:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

I expect someone else to pick it up.

	Sam

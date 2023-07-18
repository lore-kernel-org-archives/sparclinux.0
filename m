Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C358EEB64DA
	for <sparclinux@archiver.kernel.org>; Tue, 18 Jul 2023 15:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjGRPXV (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 11:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbjGRPXT (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 18 Jul 2023 11:23:19 -0400
X-Greylist: delayed 963 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 18 Jul 2023 08:22:48 PDT
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFBBA1
        for <sparclinux@vger.kernel.org>; Tue, 18 Jul 2023 08:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=vyEZJ3inuQ/drrg7KWkIF8gn8/as59CH2fhpQzstjf4=;
        b=HcOZMxPijEbqKI3meVpHDG+7YZ/XFuBzIwrq9Vvjud/ZYwtHQQ5P1H50ZOD7Sq8C3nWvh43Z3j3nf
         EfA0Z4gpEdA3KxKZFDqeWlcV4xF70Wxr6ptb4JJwWy6t6zGdxtHPv+IrBvP47yvL2sm5S+N3+BzssR
         wi4RzectEmiPPYm1GJsau9ECttzatfV3VOcVsW3yqUtU6qA9EPEhRepwTzc/dJ8lHOdBjU9BfwG+v/
         JnfvPgy7i4gkkrdZF3jYA/8s12GU637AN6vwNNA2ayFW5uh1EnITkgOQfy36H5hAHHEnzOcujajc0T
         oFv/ZGUn1JfXfrw7CyZoS95M/OFHDlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=vyEZJ3inuQ/drrg7KWkIF8gn8/as59CH2fhpQzstjf4=;
        b=W6/FZX9ZTJ3J88yjvuHGgxdUrP1+ozpvtpcu01tYBsMEBNa49W239TnumnzX4tu4jX0EOrwmT1wfp
         zFm8PzqCw==
X-HalOne-ID: b2bec156-257c-11ee-95ab-5ba399456a4a
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id b2bec156-257c-11ee-95ab-5ba399456a4a;
        Tue, 18 Jul 2023 15:06:43 +0000 (UTC)
Date:   Tue, 18 Jul 2023 17:06:41 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     sunran001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc: add missing put_device()
Message-ID: <20230718150641.GC688726@ravnborg.org>
References: <20230718085619.17403-1-xujianghui@cdjrlc.com>
 <19b84a97cb5487c22fcd3cc232abe860@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19b84a97cb5487c22fcd3cc232abe860@208suo.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Ray Sun,

On Tue, Jul 18, 2023 at 04:57:06PM +0800, sunran001@208suo.com wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> ./arch/sparc/kernel/of_device_common.c:36:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 30, but without a
> corresponding object release within this function.
> ./arch/sparc/kernel/of_device_common.c:50:1-7: ERROR: missing
> put_device; call of_find_device_by_node on line 42, but without a
> corresponding object release within this function.
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>

This patch looks OK.
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>


The challenge is to find someone to process sparc patches as the current
maintainer is busy with other stuff.
I suggest to find another subsystem with active maintenance as you may
find a higher success rate there to get stuff applied.

And no, I am not in a position to take sparc patches.
Too little time for this :-(

	Sam

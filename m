Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370F3C0015E
	for <sparclinux@archiver.kernel.org>; Sat, 15 Jul 2023 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjGOKrY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 15 Jul 2023 06:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjGOKrW (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 15 Jul 2023 06:47:22 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612C3A86
        for <sparclinux@vger.kernel.org>; Sat, 15 Jul 2023 03:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=+y08/Sz0j0ceiva4EnYXZhe0QdQSUP910NVfEzb7p30=;
        b=qQ8LzKqCqB4Me2Z6mRU5utFJiV8Z8MhKhmpjQzjZioWnGCJTgFwTW3uvgRQ0CJ1JH1YIJIcVG0U6C
         eeoUZG3EUwleXDFjOze4lZEdNZw2shweIhrpRZcuhtpk8WgUFpmfWsDHBJbvAxnZUr5jMhK8osX/KI
         GKbVntwb71vAD120WZenoyMCIW5EruriGYAIJUfWA8uhf5oWSl+qmrs7Z9wh5/REzDEtwaUEMBAeFe
         zRgnJgjT6nNYTb7wmiorpHXJYhsYshFwponmWUCNmLnwW0SOS92DZVM7FqWM7snUhjYdqP8A4e5/gr
         dqiFkSl8PPaTt0vsqO/Ubw9q1OoNe5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=+y08/Sz0j0ceiva4EnYXZhe0QdQSUP910NVfEzb7p30=;
        b=q5gAgGxWm+Lq82yVCxruopEp8Q15KK7JPg5M0rlZHoroDgpt+UV3v6TmTa1/jWhSs5JS/m0jDvhWL
         +ozmuloAw==
X-HalOne-ID: f7413334-22fc-11ee-b310-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id f7413334-22fc-11ee-b310-b90637070a9d;
        Sat, 15 Jul 2023 10:47:18 +0000 (UTC)
Date:   Sat, 15 Jul 2023 12:47:16 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: Explicitly include correct DT includes
Message-ID: <20230715104716.GA251436@ravnborg.org>
References: <20230714174048.4040702-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714174048.4040702-1-robh@kernel.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Rob.

On Fri, Jul 14, 2023 at 11:40:46AM -0600, Rob Herring wrote:
> The DT of_device.h and of_platform.h date back to the separate
> of_platform_bus_type before it as merged into the regular platform bus.
> As part of that merge prepping Arm DT support 13 years ago, they
> "temporarily" include each other. They also include platform_device.h
> and of.h. As a result, there's a pretty much random mix of those include
> files used throughout the tree. In order to detangle these headers and
> replace the implicit includes with struct declarations, users need to
> explicitly include the correct includes.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
Looks fine, for good measure I did a defconfig build of sparc32 and
sparc64. Both were OK.
There were a trivial conflict when applying to current master - but that
is expected for a patch touching this amount of files.

Acked-by: Sam Ravnborg <sam@ravnborg.org>

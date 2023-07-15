Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4105C0015E
	for <sparclinux@archiver.kernel.org>; Sat, 15 Jul 2023 10:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjGOKsA (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 15 Jul 2023 06:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGOKr5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 15 Jul 2023 06:47:57 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E133A84
        for <sparclinux@vger.kernel.org>; Sat, 15 Jul 2023 03:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=hJKuyUGhxmtOjD6kuHJpi0wsrKNzXYtETGeFgeXc7II=;
        b=Ucn6CxYxKvVLUdqvXK/zV8JuQ0wNHIPEYcb0pJoQHqQ8+LD6unz7fqTc2oSc5lqqu7Ibmoh1yIo7N
         TGekQlit/GMH5TY9jkx5I4VQbdt3HK04NI/44y/hTTzhJ5NDz15EtWymT6O3F3EYxBqE2wA4P4KlqH
         NVhhRUOOHpjrMFPjGgR18xSr0gavVOBTghE8Rtkae71MvZrMVDX5/lAbKoN3f63xCQVORSSUuZe9+e
         3UiWLbMUMVnPzHvwgL1jHjb0fqTU0oB3aWCEF7f5zIeLbrLdmreGwo1ovBzxVJn/+zZeETPk1O4MOG
         QZnVV+ZRNIo9bp60/P/r9eFqQphNWCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=hJKuyUGhxmtOjD6kuHJpi0wsrKNzXYtETGeFgeXc7II=;
        b=QSHCG+TTDqqScOMMkMX5MCSUEPNB30xqbjj+ZHx+D5zA152EKUJw4H6fom0gYsdJnxUz8oOFfgrye
         PxB/85MCw==
X-HalOne-ID: 0c1f8229-22fd-11ee-b315-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 0c1f8229-22fd-11ee-b315-b90637070a9d;
        Sat, 15 Jul 2023 10:47:55 +0000 (UTC)
Date:   Sat, 15 Jul 2023 12:47:53 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sbus: Explicitly include correct DT includes
Message-ID: <20230715104753.GB251436@ravnborg.org>
References: <20230714175048.4066006-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714175048.4066006-1-robh@kernel.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Jul 14, 2023 at 11:50:48AM -0600, Rob Herring wrote:
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
Acked-by: Sam Ravnborg <sam@ravnborg.org>

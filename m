Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9CEEB64D7
	for <sparclinux@archiver.kernel.org>; Fri, 23 Jun 2023 17:22:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232242AbjFWRW5 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjFWRW5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 23 Jun 2023 13:22:57 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB82184
        for <sparclinux@vger.kernel.org>; Fri, 23 Jun 2023 10:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kQ06KJQYlLVfI7f4/WIVDHiUCorFJUhI1beynN30qUo=;
        b=igQwXgmqv1iMbq00HQTBWM8qNlKtlsBr78AS9o7I8iLPcKzEbe0vl+8bXJQSwxfCBg7Vx865D3Jyo
         dYXlBAX5D1vpB8wX0myFGFknPwdiOhPgXrQsIglZlkWNLCEqpMrhBJevdXl9URlsWDqyi5OBPIq5j0
         Pq/jkvU1l5FnKUyFO0ymZXfk6ZdI6GsAN392vaoxy14nzDyXH7xR4aHj6PloysyV0P837n+Nn6TcQi
         1BL+JDjz0Sj2SFB6NfeBeaGLuPVpafGzq9QsmFRDZLt6EaRyVVovY34ot6z/ebw3nz0EGILcYHZzI/
         0n9UH77htOVdYMVB6JapWDzpeDupBbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=kQ06KJQYlLVfI7f4/WIVDHiUCorFJUhI1beynN30qUo=;
        b=/tzGDJw6Fi8LaDZPq3ywP2HYDM0ngRbt2Ul6EBz190pJO+P7PLLUUrH3FoZADprRsiy3yS80DLQjk
         EPI8jOJBg==
X-HalOne-ID: 94ce3375-11ea-11ee-9609-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id 94ce3375-11ea-11ee-9609-b90637070a9d;
        Fri, 23 Jun 2023 17:22:53 +0000 (UTC)
Date:   Fri, 23 Jun 2023 19:22:51 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     David Miller <davem@davemloft.net>
Cc:     macro@orcam.me.uk, rdunlap@infradead.org, schnelle@linux.ibm.com,
        linux-kernel@vger.kernel.org, sudipm.mukherjee@gmail.com,
        sparclinux@vger.kernel.org, linux-parport@lists.infradead.org
Subject: Re: [PATCH] parport_pc: don't allow driver for SPARC32
Message-ID: <20230623172251.GA2531634@ravnborg.org>
References: <alpine.DEB.2.21.2306190000530.14084@angie.orcam.me.uk>
 <ea8b0e25-fd2e-4fe1-3157-7556e29eee87@infradead.org>
 <alpine.DEB.2.21.2306190202050.14084@angie.orcam.me.uk>
 <20230623.163329.1458342120776268478.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623.163329.1458342120776268478.davem@davemloft.net>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Davem,

> > 
> >> >  What happened to DaveM?
> >> 
> >> I haven't seen him merge any arch/sparc/ patches lately.
> >> I have a couple that are still pending.
> > 
> >  Oh, I hope he's been doing good then, and it's just a change of life 
> > priorities or suchlike.  Patch reviews can take a lot of mental effort, 
> > and I can't claim I've been as effective as I wished to with stuff that 
> > lands on my plate either.
> 
> I'm good just too busy with networking and real life.


Enjoy the real life!

	Sam

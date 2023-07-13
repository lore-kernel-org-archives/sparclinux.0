Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C33C0015E
	for <sparclinux@archiver.kernel.org>; Thu, 13 Jul 2023 14:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjGMOzv (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 13 Jul 2023 10:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjGMOzq (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 13 Jul 2023 10:55:46 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1AC2D57
        for <sparclinux@vger.kernel.org>; Thu, 13 Jul 2023 07:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=jad+tXIpl6N85zTK0BSX3q69+1wDiPSRaHeN/P0YlBA=;
        b=bf/KI0K+9G6+rZHTqn8JdavswtZdYn1IVhxQexoZmQistU2RPJqsmWgsKhcFxJprq+CSNF+ASKwzL
         a5RPbe8/wy/lRoYiSTgR5WKnkugRM6bgq3pmr0UUvU1YUIP0dmzNvINxuXC4r+F8KHZREK3UKd30Kr
         Cz4wCrn9t3rRyrYuzNgM79YDZRulfhAYe6tQN0vSxd2TU5VC7ci1H+peKUNQO1mgMklAUAdhSG7jRT
         ggMGm36Vqho107TpvIriPjvy/sYEe6dq9ZbZua8JNPEQY5eKyXb6LVrjtOkXpawjpjzbMwgFFqI3fL
         /Jb4LIkhz95zzFIEYuGTS3PhaOnWs7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=jad+tXIpl6N85zTK0BSX3q69+1wDiPSRaHeN/P0YlBA=;
        b=xPz0tSOlKXa0Aoup20n+LKmo7Ta+a07sayuvreb2RVr5QZvv83I5UZx4cik6quk5qo61m4FlrxdpY
         wP6PmLsAQ==
X-HalOne-ID: 52e9fef0-218d-11ee-923c-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 52e9fef0-218d-11ee-923c-99461c6a3fe8;
        Thu, 13 Jul 2023 14:55:37 +0000 (UTC)
Date:   Thu, 13 Jul 2023 16:55:36 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        sparclinux@vger.kernel.org, kernel@pengutronix.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] sparc: Use $(kecho) to announce kernel images being ready
Message-ID: <20230713145536.GA5300@ravnborg.org>
References: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713075235.2164609-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Jul 13, 2023 at 09:52:35AM +0200, Uwe Kleine-König wrote:
> My build test setup compiles allmodconfig all various architectures
> (arm64 m68k powerpc riscv s390 sparc64 x86_64) using make -s. If there
> is no warning, the only output is
> 
>           kernel: arch/sparc/boot/image is ready
>           kernel: arch/sparc/boot/zImage is ready
> 
> from the sparc64 build. Copy the incantation from x86 which is silent
> when building with make -s and also mentions a version indication.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I hope Arnd or someone else can pick it up as davem is not active on
sparc for the time being.

	Sam

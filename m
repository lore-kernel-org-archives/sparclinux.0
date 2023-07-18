Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E803DEB64DA
	for <sparclinux@archiver.kernel.org>; Tue, 18 Jul 2023 15:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjGRPCj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbjGRPCi (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 18 Jul 2023 11:02:38 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AEE2E56
        for <sparclinux@vger.kernel.org>; Tue, 18 Jul 2023 08:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=y8DiZ9DaYKzWZXSoeqnxiZrwlikXlYCM9vqzWTsn3Vk=;
        b=c9Z4wU+n5kZhkkkN4N9AUyV4ozt8L1ErdRSkk7ydE6btnzIbcBFDD5Gf66R4Ow4qRcY782FNkxrXo
         7JsWXpiAev2xGBn59COCfLhj0V9nl254Rmeg2myflHFb6CJE7h2iTrK6NATo618wfPn3SN9L6b6S2N
         hYEa72uAH2cARyw0AhKjKZH60Eq6a/8QZAtv6wTz/DyjcpejERmsXAdlLroNlDDe4/dOAuqF8CBg7X
         Qe2iHCz7VJggtf8eLuD6ZQC12YPtpL1JzwtAb7Dj21A7smoQZtLbvQ9x8HSsAnFJjgpq/FMmt/ihk2
         CKdKeej4HdfYLDQsI9LA2YgryLZJWYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=y8DiZ9DaYKzWZXSoeqnxiZrwlikXlYCM9vqzWTsn3Vk=;
        b=KTzPlEJSyKfdGrp7GCfuH0gQq6M3faQhtZwsKv8uV7jwAet+yhXo6jAI1HMWk/OcXOWU3HNNDcr58
         ylSBBzdAw==
X-HalOne-ID: 1f00be72-257c-11ee-a6d6-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 1f00be72-257c-11ee-a6d6-99461c6a3fe8;
        Tue, 18 Jul 2023 15:02:35 +0000 (UTC)
Date:   Tue, 18 Jul 2023 17:02:33 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     sunran001@208suo.com
Cc:     davem@davemloft.net, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: kernel: add missing put_device()
Message-ID: <20230718150233.GB688726@ravnborg.org>
References: <20230718072514.16432-1-xujianghui@cdjrlc.com>
 <4125a3a7bda2d099b59e32e20f733a92@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4125a3a7bda2d099b59e32e20f733a92@208suo.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Ran Sun,

On Tue, Jul 18, 2023 at 03:26:31PM +0800, sunran001@208suo.com wrote:
> The of_find_device_by_node() takes a reference to the underlying device
> structure, we should release that reference.
> 
> Detected by coccinelle with the following ERRORS:
> ./arch/sparc/kernel/pci_psycho.c:308:2-8: ERROR: missing put_device;
> call of_find_device_by_node on line 290, but without a corresponding
> object release within this function.
> ./arch/sparc/kernel/pci_psycho.c:350:0-1: ERROR: missing put_device;
> call of_find_device_by_node on line 290, but without a corresponding
> object release within this function.
> 
> Signed-off-by: Ran Sun <sunran001@208suo.com>
> ---
>  arch/sparc/kernel/pci_psycho.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/sparc/kernel/pci_psycho.c b/arch/sparc/kernel/pci_psycho.c
> index f413371da387..45f8370bbfad 100644
> --- a/arch/sparc/kernel/pci_psycho.c
> +++ b/arch/sparc/kernel/pci_psycho.c
> @@ -305,6 +305,7 @@ static void psycho_register_error_handlers(struct
> pci_pbm_info *pbm)
>       */
> 
>      if (op->archdata.num_irqs < 6)
> +        put_device(op->dev);
>          return;

Missing {}

	Sam

> 
>      /* We really mean to ignore the return result here.  Two
> @@ -347,6 +348,7 @@ static void psycho_register_error_handlers(struct
> pci_pbm_info *pbm)
>          PSYCHO_PCICTRL_EEN);
>      tmp &= ~(PSYCHO_PCICTRL_SBH_INT);
>      upa_writeq(tmp, base + PSYCHO_PCIB_CTRL);
> +    put_device(op->dev);
>  }
> 
>  /* PSYCHO boot time probing and initialization. */

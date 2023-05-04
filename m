Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E61C7EE29
	for <sparclinux@archiver.kernel.org>; Thu,  4 May 2023 15:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjEDPhX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 4 May 2023 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjEDPhU (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 4 May 2023 11:37:20 -0400
Received: from mailrelay1-1.pub.mailoutpod2-cph3.one.com (mailrelay1-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:400::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3AF7468B
        for <sparclinux@vger.kernel.org>; Thu,  4 May 2023 08:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9OJXCjk1pQ5JPAczTbrYybaJ9yabhk+psqf49vWpZU0=;
        b=qvdNlqsBf3EoYvHRBBEpiAYN3JzfiOdN6jSoMib4fSHXY6tHmBqjeEye3YBBnQuOKlWgJbulyd9UO
         jXb4IaCN8kX7dVnV05joCTZniXryC4lrp6RnU2s7jkJl8wdsPp6Q9OZJRYK7vfSOzXS4rmS40/eTZk
         Oj8wFMqUI5Uf91JBzDLM6lwl/AI9nYaZL5MM0+ScxSnZS/IO/f0jfqapazU7a2UnCPXICl2bDXeIun
         cpFA4+5zlWP+xxx7duxSDE9p2dLtJQt9zPGpmx+m59A/DqeQkbQKqGGVNVvHnMEXAS+E65XGv8vXxP
         Xw2bDTTmGVCCvcUOan+7GsoDw8Ub2IQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=9OJXCjk1pQ5JPAczTbrYybaJ9yabhk+psqf49vWpZU0=;
        b=A41ejzmStbYNhncUAuSBS4onolrQNPxZTtME0No712Sqv3KLgK2LD8qZyKm6pcZPa7vmoiglPmcsF
         +lL4ka5AQ==
X-HalOne-ID: 87f70a6c-ea91-11ed-bbbe-99461c6a3fe8
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1 (Halon) with ESMTPSA
        id 87f70a6c-ea91-11ed-bbbe-99461c6a3fe8;
        Thu, 04 May 2023 15:37:12 +0000 (UTC)
Date:   Thu, 4 May 2023 17:37:10 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@hansenpartnership.com, arnd@arndb.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH v4 4/6] fbdev: Include <linux/fb.h> instead of <asm/fb.h>
Message-ID: <20230504153710.GA518522@ravnborg.org>
References: <20230504074539.8181-1-tzimmermann@suse.de>
 <20230504074539.8181-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504074539.8181-5-tzimmermann@suse.de>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Thomas,

On Thu, May 04, 2023 at 09:45:37AM +0200, Thomas Zimmermann wrote:
> Replace include statements for <asm/fb.h> with <linux/fb.h>. Fixes
> the coding style: if a header is available in asm/ and linux/, it
> is preferable to include the header from linux/. This only affects
> a few source files, most of which already include <linux/fb.h>.
> 
> Suggested-by: Sam Ravnborg <sam@ravnborg.org>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks,
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

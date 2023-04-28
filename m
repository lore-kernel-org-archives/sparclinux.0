Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E8CC77B61
	for <sparclinux@archiver.kernel.org>; Fri, 28 Apr 2023 13:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbjD1NHM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 28 Apr 2023 09:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345489AbjD1NHL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 28 Apr 2023 09:07:11 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CEC1FC3
        for <sparclinux@vger.kernel.org>; Fri, 28 Apr 2023 06:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=m4sJ+fThLhFeWg7X6kLvwa3/DCsUq6Addkr6Ox/63p0=;
        b=bIWcbnCVTMxSTG2/SQkpkiauTRzdjLlitM8+y6JLCZq45eKjII3dhIT9CX/k6z3u48vGxGMScqx9G
         n5WQVZPQD0rNLUlKVdnlAOEvwqZ1sY8/bjLQ4/AuTeSVglaIYAjpG8D201DeL/wpaoJREkGbHO6fJ4
         alPDaPVFLLrpGalDRW2MOeDlKD92IsU2Fck6fN4uSatZvzNk1k/kA5Hb8QlXIcz94LDN0CPkMu8YEt
         hRyeUJJqTKB7xhgnQfl1I0N/pQWQw22WdPWLnymZNB3FBOSYNYaC/7+XDT/spP+i3I7/VmeYNmjE/i
         PPJfosYGRWa3MwoQwx/hnbJhWvQRNEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=m4sJ+fThLhFeWg7X6kLvwa3/DCsUq6Addkr6Ox/63p0=;
        b=qNBtiTicBN3wXCrqOwcNqd0yQGLKWp9PsyJHm2ixxR+jqNPJfF+zvhggJjKoBx35Pnw1WhT1mEY5q
         gcEohH4AA==
X-HalOne-ID: 904541fb-e5c5-11ed-95bb-13111ccb208d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id 904541fb-e5c5-11ed-95bb-13111ccb208d;
        Fri, 28 Apr 2023 13:07:04 +0000 (UTC)
Date:   Fri, 28 Apr 2023 15:07:02 +0200
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
Subject: Re: [PATCH v2 4/5] fbdev: Include <linux/io.h> in drivers
Message-ID: <20230428130702.GD3995435@ravnborg.org>
References: <20230428092711.406-1-tzimmermann@suse.de>
 <20230428092711.406-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428092711.406-5-tzimmermann@suse.de>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Apr 28, 2023 at 11:27:10AM +0200, Thomas Zimmermann wrote:
> Fbdev's main header file, <linux/fb.h>, includes <asm/io.h> to get
> declarations of I/O helper functions. From these declaratons, it later
> defines framebuffer I/O helpers, such as fb_{read,write}[bwlq]() or
> fb_memset().
> 
> The framebuffer I/O helpers pre-date Linux' current I/O code and will
> be replaced by regular I/O helpers. Prepare this change by adding an
> include statement for <linux/io.h> to all source files that use the
> framebuffer I/O helpers. They will still get declarations of the I/O
> functions even after <linux/fb.h> has been cleaned up.
When fb.h uses a symbol from io.h, then it shall include that
file so it is self contained.
So it is wrong to push the io.h include to the users of
fb_{read,write,xxx}. Maybe fb.h only uses macros as is the case here,
but that is no excuse nt to include io.h.

Drop these changes.

> Driver source
> files that already include <asm/io.h> convert to <linux/io.h>.
This is a nice cleanup - we should keep that.

	Sam

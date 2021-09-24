Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A018CC433F5
	for <sparclinux@archiver.kernel.org>; Fri, 24 Sep 2021 04:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DD261241
	for <sparclinux@archiver.kernel.org>; Fri, 24 Sep 2021 04:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242513AbhIXEqx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 24 Sep 2021 00:46:53 -0400
Received: from mail.avm.de ([212.42.244.94]:55920 "EHLO mail.avm.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231256AbhIXEqw (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 24 Sep 2021 00:46:52 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Fri, 24 Sep 2021 00:46:52 EDT
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
        by mail.avm.de (Postfix) with ESMTPS;
        Fri, 24 Sep 2021 06:38:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
        t=1632458338; bh=hrS2vruFomzG2zzj3THpUoYTXKDp+n82KQpCxTdYZhQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dc4cUut2J/4Siq+MOHgo+gPhzZLqw3LR3Eq2c4wEMOx5G02sKdmLFTGMcuczynMZ0
         Ro38BrBI2SlVwP92vC6uWVJJpvWWTwuzKXV4xEpq09OTDVux6kEVnEBHnZlzF1B1UH
         xGG3FeGEa1A3VQg5yjCxE04EwSjKLfv6jLh+o+D8=
Received: from deb-nschier.ads.avm.de (unknown [172.17.24.144])
        by mail-auth.avm.de (Postfix) with ESMTPSA id CE3328048F;
        Fri, 24 Sep 2021 06:38:57 +0200 (CEST)
Date:   Fri, 24 Sep 2021 06:38:56 +0200
From:   Nicolas Schier <n.schier@avm.de>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sparc: Add missing "FORCE" target when using if_changed
Message-ID: <YU1WYLN4eptJhuIX@deb-nschier.ads.avm.de>
References: <20210923215418.3936726-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210923215418.3936726-1-keescook@chromium.org>
X-purgate-ID: 149429::1632458338-000004DC-899091C6/0/0
X-purgate-type: clean
X-purgate-size: 1966
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Sep 23, 2021 at 02:54:18PM -0700, Kees Cook wrote:
> Fix observed warning:
> 
>     /builds/linux/arch/sparc/boot/Makefile:35: FORCE prerequisite is missing
> 
> Fixes: e1f86d7b4b2a5213 ("kbuild: warn if FORCE is missing for if_changed(_dep,_rule) and filechk")
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Nicolas Schier <n.schier@avm.de>

> ---
> I'm not sure if this should go via sparc or via kbuild. :)
> ---
>  arch/sparc/boot/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
> index 849236d4eca4..45e5c76d449e 100644
> --- a/arch/sparc/boot/Makefile
> +++ b/arch/sparc/boot/Makefile
> @@ -22,7 +22,7 @@ ifeq ($(CONFIG_SPARC64),y)
>  
>  # Actual linking
>  
> -$(obj)/zImage: $(obj)/image
> +$(obj)/zImage: $(obj)/image FORCE
>  	$(call if_changed,gzip)
>  	@echo '  kernel: $@ is ready'
>  
> @@ -31,7 +31,7 @@ $(obj)/vmlinux.aout: vmlinux FORCE
>  	@echo '  kernel: $@ is ready'
>  else
>  
> -$(obj)/zImage: $(obj)/image
> +$(obj)/zImage: $(obj)/image FORCE
>  	$(call if_changed,strip)
>  	@echo '  kernel: $@ is ready'
>  
> @@ -44,7 +44,7 @@ OBJCOPYFLAGS_image.bin := -S -O binary -R .note -R .comment
>  $(obj)/image.bin: $(obj)/image FORCE
>  	$(call if_changed,objcopy)
>  
> -$(obj)/image.gz: $(obj)/image.bin
> +$(obj)/image.gz: $(obj)/image.bin FORCE
>  	$(call if_changed,gzip)
>  
>  UIMAGE_LOADADDR = $(CONFIG_UBOOT_LOAD_ADDR)
> @@ -56,7 +56,7 @@ quiet_cmd_uimage.o = UIMAGE.O $@
>                       -r -b binary $@ -o $@.o
>  
>  targets += uImage
> -$(obj)/uImage: $(obj)/image.gz
> +$(obj)/uImage: $(obj)/image.gz FORCE
>  	$(call if_changed,uimage)
>  	$(call if_changed,uimage.o)
>  	@echo '  Image $@ is ready'
> -- 
> 2.30.2
> 

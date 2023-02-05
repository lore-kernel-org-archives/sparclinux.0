Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C636DC636CD
	for <sparclinux@archiver.kernel.org>; Sun,  5 Feb 2023 09:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjBEJLO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 5 Feb 2023 04:11:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEJLN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 5 Feb 2023 04:11:13 -0500
X-Greylist: delayed 964 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Feb 2023 01:11:12 PST
Received: from mailrelay6-1.pub.mailoutpod2-cph3.one.com (mailrelay6-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:405::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C6A1F5C5
        for <sparclinux@vger.kernel.org>; Sun,  5 Feb 2023 01:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=048w4mMGx18wsnXMKlj9cLwJ8F73CyxBdkjcWuROSEo=;
        b=0+ratF2/X1QIflCTtfzRzlNip+Pv4C5PFD7RpCc64W8o2cGJLLktwWRJQpVjcpXCGkSIyAUEQd2qC
         A4JByyMsZkARH44l0QvnYrSoUgY8pKOq3B9ksAGD4Pka7KSg19G9lFL9euVXiyJvCvjuU6sMK5HLzw
         Lk0l62cUXtkKCNV7DJSk2Sa5xe1wk2z4Z9tRWMcV9tmfjAyTAfdg+RaksVosiYQz6hjchf7bJSD/EE
         sAnlQzB4PwsLP2JspC5t+ex8aQ2uqvND2PT3I0I6xK6QqeBxhpPr0UIMXwWRiP85oBTy11wvFeOUpT
         v9jxDbVDuOWduqccsUl0CwXJBJP9HCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=048w4mMGx18wsnXMKlj9cLwJ8F73CyxBdkjcWuROSEo=;
        b=wL3tIP90z6C+hrkREz1fP5ZAXPEoL6H/y421bkUE3yXdtUlSk6epSrLZNQ/WEDZaUeh9KrPHSclv5
         yMUfrOJDg==
X-HalOne-ID: c7fbbd74-a532-11ed-a1af-cde5ad41a1dd
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay6 (Halon) with ESMTPSA
        id c7fbbd74-a532-11ed-a1af-cde5ad41a1dd;
        Sun, 05 Feb 2023 08:55:06 +0000 (UTC)
Date:   Sun, 5 Feb 2023 09:55:05 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] sparc: allow sparc32 alias for archhelp
Message-ID: <Y99u6Z6InryAkRCn@ravnborg.org>
References: <20230205012915.11330-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230205012915.11330-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sat, Feb 04, 2023 at 05:29:15PM -0800, Randy Dunlap wrote:
> Currently, entering
> $ make ARCH=sparc32 help
> prints the archhelp text for sparc64.
> 
> Since "sparc32" is documented (Documentation/kbuild/kbuild.rst)
> to be a recognized alias for 32-bit sparc, also support that
> string in sparc's archhelp by allowing either ARCH=sparc or
> ARCH=sparc32 for sparc32 archhelp.
> 
> Fixes: 5e53879008b9 ("sparc,sparc64: unify Makefile")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
Acked-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Cc: Andrew Morton <akpm@linux-foundation.org>
I hope Andrew picks this up.

	Sam

> ---
>  arch/sparc/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff -- a/arch/sparc/Makefile b/arch/sparc/Makefile
> --- a/arch/sparc/Makefile
> +++ b/arch/sparc/Makefile
> @@ -83,7 +83,7 @@ vdso_install:
>  KBUILD_IMAGE := $(boot)/zImage
>  
>  # Don't use tabs in echo arguments.
> -ifeq ($(ARCH),sparc)
> +ifeq ($(ARCH),$(filter $(ARCH),sparc sparc32))
>  define archhelp
>    echo  '* image        - kernel image ($(boot)/image)'
>    echo  '* zImage       - stripped kernel image ($(boot)/zImage)'

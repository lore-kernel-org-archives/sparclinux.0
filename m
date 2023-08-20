Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0605CEE49A5
	for <sparclinux@archiver.kernel.org>; Sun, 20 Aug 2023 08:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjHTILE (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 20 Aug 2023 04:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjHTILA (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 20 Aug 2023 04:11:00 -0400
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com (mailrelay2-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:401::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06344211
        for <sparclinux@vger.kernel.org>; Sun, 20 Aug 2023 01:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=oodxccrBzg4XqtTHjS1zOVx29jRaoidsP8nWpOw14RY=;
        b=YChe1TstpygT2d7vJcZ5IwdPR+kSaf21KzzXmQll++iu7yuzYcAnzHlTN6halrPeLc2KVXvX6tznV
         9yMrOYTU66je84cTH5GleM4MWZJkrRxVeYFB9AZUIcJvla3IacQPJSAOSYgf0XA2xm/vRlk3vDJuL/
         zBevqngA/0bSOlZV3aN0mkAnhM4KJYimHkGBNmXiQXCEoE3T9DRJm04LxsQHu7DRskkO4qVkgNjObq
         LPGmRnlPKq4zjd2avylsV/VvoJDsf2rb5yA3+D+CIh34R5KzkPTmgEwju3hmDi2sDwRPX3kuZrdVJF
         9LZ0Q4/SRqH9S7kFMFt/rBTDsr+m3Qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=oodxccrBzg4XqtTHjS1zOVx29jRaoidsP8nWpOw14RY=;
        b=wWxdp0MRt9zae2m3fbs1Gl8bOxxUf916XR8GRqaHv44hyFrRPq/ekzhjeTEv9KUyS9VIQvnY4QYyp
         ttAUTiGCw==
X-HalOne-ID: c02c422d-3f30-11ee-9303-13db1c4e5356
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2 (Halon) with ESMTPSA
        id c02c422d-3f30-11ee-9303-13db1c4e5356;
        Sun, 20 Aug 2023 08:08:33 +0000 (UTC)
Date:   Sun, 20 Aug 2023 10:08:31 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-arch@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/6] sparc: replace #include <asm/export.h> with #include
 <linux/export.h>
Message-ID: <20230820080831.GA206827@ravnborg.org>
References: <20230819233353.3683813-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230819233353.3683813-1-masahiroy@kernel.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Sun, Aug 20, 2023 at 08:33:48AM +0900, Masahiro Yamada wrote:
> Commit ddb5cdbafaaa ("kbuild: generate KSYMTAB entries by modpost")
> deprecated <asm/export.h>, which is now a wrapper of <linux/export.h>.
> 
> Replace #include <asm/export.h> with #include <linux/export.h>.
> 
> After all the <asm/export.h> lines are converted, <asm/export.h> and
> <asm-generic/export.h> will be removed.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks,
Acked-by: Sam Ravnborg <sam@ravnborg.org>

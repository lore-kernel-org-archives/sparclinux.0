Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE134EB64DC
	for <sparclinux@archiver.kernel.org>; Fri, 30 Jun 2023 06:29:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjF3G3Z (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 30 Jun 2023 02:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjF3G3X (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 30 Jun 2023 02:29:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D682D71;
        Thu, 29 Jun 2023 23:29:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 446A2616D0;
        Fri, 30 Jun 2023 06:29:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276E3C433C0;
        Fri, 30 Jun 2023 06:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688106561;
        bh=+deePIa1085/REYZ8uHg602pH8rUsFTFyjfVM/LP49o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2oVEnUEH43h5OVHMbw6dEkdbXZUDVR15a3xLxuhBa7N0p6REOuKib7BsJaFP/yWGK
         +9gfSzla00j3Zdz5UiQcNNYF1nCCYQZXyp/w1AgbgFCg1GNe24nrljY4nnQtgnRnwG
         9a4V9zNM2b8k9ayVjp1c64twR3snP5JTFvQ30e3M=
Date:   Fri, 30 Jun 2023 08:29:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
        patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
        patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
        jonathanh@nvidia.com, f.fainelli@gmail.com,
        sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
        conor@kernel.org, linux-parisc <linux-parisc@vger.kernel.org>,
        sparclinux@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Helge Deller <deller@gmx.de>,
        Jason Wang <wangborong@cdjrlc.com>
Subject: Re: [PATCH 6.4 00/28] 6.4.1-rc1 review
Message-ID: <2023063001-overlying-browse-de1a@gregkh>
References: <20230629184151.888604958@linuxfoundation.org>
 <CA+G9fYsM2s3q1k=+wHszvNbkKbHGe1pskkffWvaGXjYrp6qR=g@mail.gmail.com>
 <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whaO3RZmKj8NDjs4f6JEwuwQWWesOfFu-URzOqTkyPoxw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Thu, Jun 29, 2023 at 11:16:21PM -0700, Linus Torvalds wrote:
> On Thu, 29 Jun 2023 at 22:31, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
> >
> > arch/parisc/mm/fault.c: In function 'do_page_fault':
> > arch/parisc/mm/fault.c:292:22: error: 'prev' undeclared (first use in this function)
> >   292 |                 if (!prev || !(prev->vm_flags & VM_GROWSUP))
> 
> Bah. "prev" should be "prev_vma" here.
> 
> I've pushed out the fix. Greg, apologies. It's
> 
>    ea3f8272876f parisc: fix expand_stack() conversion
> 
> and Naresh already pointed to the similarly silly sparc32 fix.

Ah, I saw it hit your repo before your email here, sorry about that.
Now picked up.

greg k-h

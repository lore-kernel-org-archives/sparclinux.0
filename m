Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F772EB64DD
	for <sparclinux@archiver.kernel.org>; Sat, 12 Aug 2023 01:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjHLBGm (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 11 Aug 2023 21:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjHLBGm (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 11 Aug 2023 21:06:42 -0400
Received: from mx.treblig.org (unknown [IPv6:2a00:1098:5b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA96E3;
        Fri, 11 Aug 2023 18:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0nOmPoc7/KaXqqM6sll/NFw0+f3JP8V3LF0ylnj3aUg=; b=UkDNE7OR+2FQhUwLK3KJg/Hfn2
        jwk2TroflmJguxb1eP+geoe8B8X+Gix7L5IWt1sGr0Evd/9Qd0tMGfziO68Dg4IcQVxqJ3v/mWHPa
        UaAmKkZSWnW1/GJ2iYKtElUR6UE4XlxxZRnmpXQCnff5Ni3XA6B+hf4yXMofzGCRtMQmQQ6t21G/H
        j3va8taMPmtuDD5/jwx/rSVBCSDs8R5wLG5Ho69zp2Q576GYPBwYbjVqOzLE/ZXMam1ZD8VCHiOg7
        7he6Ye9TklpLVFPBoLutDA6VDFN3/x4EWFzymHmXYpjDBe4Xi39DO73rfox2qivfR6Xyl7rqjJ/IE
        87BGkTow==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
        (envelope-from <dg@treblig.org>)
        id 1qUd5H-006WX2-7m; Sat, 12 Aug 2023 01:06:27 +0000
Date:   Sat, 12 Aug 2023 01:06:27 +0000
From:   "Dr. David Alan Gilbert" <linux@treblig.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "David S. Miller" <davem@davemloft.net>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sparc: Use shared font data
Message-ID: <ZNbbEyLRZG+CGePc@gallifrey>
References: <20230807010914.799713-1-linux@treblig.org>
 <8c0ea24d-9993-492c-a7bd-fbdac7800479@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c0ea24d-9993-492c-a7bd-fbdac7800479@web.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 01:05:33 up 36 days, 10:37,  1 user,  load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

* Markus Elfring (Markus.Elfring@web.de) wrote:
> …
> > v3
> >   Added 'select FONT_SUPPORT' (to stop modconfig causing the font to be
> >    linked into a module rather than the main kernel)
> >
> > ---
> >  arch/sparc/Kconfig        |   2 +
> …
> 
> I hope that the placement of the version description (or the marker line) will be reconsidered once more
> for the final commit.

Oops yes, I think I got this right in the v3 of the PPC one I just sent.
Do we want a new version sent to move that --- or will someone (who??)
fix that up during commit?

Dave

> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc5#n711
> 
> Regards,
> Markus
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

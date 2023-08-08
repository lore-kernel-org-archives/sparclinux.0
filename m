Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2106FC04FE1
	for <sparclinux@archiver.kernel.org>; Tue,  8 Aug 2023 19:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjHHTOQ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 8 Aug 2023 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232855AbjHHTNz (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 8 Aug 2023 15:13:55 -0400
Received: from mailrelay3-1.pub.mailoutpod2-cph3.one.com (mailrelay3-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:402::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6973BF1DAD
        for <sparclinux@vger.kernel.org>; Tue,  8 Aug 2023 09:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=c9z8RVjZ7lQ880LjvAt57vVXjzE5csvAjG7iIrLBhZ4=;
        b=mwSPOhNmuWDV/o20X/nws6qqJggdK6I/mZBnYqc93rfSuOpXOE6pKaWOHC4fp5HyaBINvIDsXuCCi
         psPUVwtH43Wia3/RFJIZfU3hzu/wwRCC29io1O7uxdFKespkpGVJFHiltrFZF6vLYlzohwNwKnEMwY
         A8XChEKbG6xk0M0Z5bdO/1Ij8Mb40yBjTZyD5V27na4qrSm3/mh/3ibHmPBl1RfjMdipJxxKDUIUh1
         rOWqX6acRneRwJBUGK1JXpYTWlI1KgcfeZidO+jy0xPz82hgfiIPvsNttfFqlnwkng3oOByq20BoEv
         4KoME0tIFmr/iT5qtyXBBYrKZeSwQZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=c9z8RVjZ7lQ880LjvAt57vVXjzE5csvAjG7iIrLBhZ4=;
        b=C3RqrrJ60S86qYxEDTh8ynvQ2MOmTnI/Li/vLN8AKM9P8jBFRwRT/uGcCqxE500sQfvoIXOWfl2fv
         rg7chk5CQ==
X-HalOne-ID: acc3d1c5-3609-11ee-84ae-b90637070a9d
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay3 (Halon) with ESMTPSA
        id acc3d1c5-3609-11ee-84ae-b90637070a9d;
        Tue, 08 Aug 2023 16:36:10 +0000 (UTC)
Date:   Tue, 8 Aug 2023 18:36:08 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux@treblig.org, davem@davemloft.net, benh@kernel.crashing.org,
        akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v3] sparc: Use shared font data
Message-ID: <20230808163608.GA358064@ravnborg.org>
References: <20230807010914.799713-1-linux@treblig.org>
 <90be12db-6aa5-cb8d-df98-fca3c994e4e8@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90be12db-6aa5-cb8d-df98-fca3c994e4e8@infradead.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Aug 08, 2023 at 08:51:16AM -0700, Randy Dunlap wrote:
> 
> 
> On 8/6/23 18:09, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > sparc has a 'btext' font used for the console which is almost identical
> > to the shared font_sun8x16, so use it rather than duplicating the data.
> > 
> > They were actually identical until about a decade ago when
> >    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
> >                         "broken bar" to "vertical line"")
> > 
> > which changed the | in the shared font to be a solid
> > bar rather than a broken bar.  That's the only difference.
> > 
> > This was originally spotted by PMD which noticed that PPC does
> > the same thing with the same data, and they also share a bunch
> > of functions to manipulate the data.
> > 
> > Tested very lightly with a boot without FS in qemu.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> 
> This survives lots of build testing with no problems, so
> 
> Acked-by: Randy Dunlap <rdunlap@infradead.org>
In that case:
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

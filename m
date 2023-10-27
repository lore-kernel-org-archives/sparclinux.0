Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949F2C25B48
	for <sparclinux@archiver.kernel.org>; Fri, 27 Oct 2023 19:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjJ0TC1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 27 Oct 2023 15:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0TC0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 27 Oct 2023 15:02:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F92B0
        for <sparclinux@vger.kernel.org>; Fri, 27 Oct 2023 12:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=r7o4V8ovGiSy2PD80p49LOhyCbl03NPruhWEOPs/U7Q=; b=j232c85Zwh5NPyY6Bb72zntoch
        014HomdCBK9ywzn0fsMqr/6bTp9GpC8oFW/c4cHjuX003YgDYHgfQbkeHdrc9kGhinXpjDu2AvZDD
        Re6N2Teg3lIOb0BlmW0M6pyzvaEh1yisOedoIFGrCZf/cCFfozJQdhmywGrCjg95RhOxzTtRv25Nn
        UK9Gmw4CaSMkH0dA/Om0IEKTzykFwWPeMlvxCKDI+SP1EdE0Hzvd/6mikeM7oGJTbBeECrDO2ZZCn
        I+mIvjpLtxzZ6EnJA+/y0p0TKoZQm6v4L/UCTs0ICW3MXDwuRyWoCPh70/5VvzPT37C2jpLryQMib
        Jne5Cl6g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qwS68-006hV1-2V;
        Fri, 27 Oct 2023 19:02:21 +0000
Date:   Fri, 27 Oct 2023 20:02:20 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc32: fix a braino in fault handling in
 csum_and_copy_..._user()
Message-ID: <20231027190220.GL800259@ZenIV>
References: <20231026021613.GI800259@ZenIV>
 <20231027184753.GA1048069@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027184753.GA1048069@ravnborg.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Oct 27, 2023 at 08:47:53PM +0200, Sam Ravnborg wrote:
> Hi Al,
> 
> On Thu, Oct 26, 2023 at 03:16:13AM +0100, Al Viro wrote:
> > Fault handler used to make non-trivial calls, so it needed
> > to set a stack frame up.  Used to be
> > 	save ... - grab a stack frame, old %o... become %i...
> > 	....
> > 	ret	- go back to address originally in %o7, currently %i7
> > 	 restore - switch to previous stack frame, in delay slot
> > Non-trivial calls had been gone since ab5e8b331244 and that code should
> > have become
> > 	retl	- go back to address in %o7
> > 	 clr %o0 - have return value set to 0
> > What it had become instead was
> > 	ret	- go back to address in %i7 - return address of *caller*
> > 	 clr %o0 - have return value set to 0
> > which is not good, to put it mildly - we forcibly return 0 from
> > csum_and_copy_{from,to}_iter() (which is what the call of that
> > thing had been inlined into) and do that without dropping the
> > stack frame of said csum_and_copy_..._iter().  Confuses the
> > hell out of the caller of csum_and_copy_..._iter(), obviously...
> 
> I wonder how you managed to find this?

Looking at the csum_and_copy_... instances on various architectures,
noticing that and going "how the fuck could it possibly work and
what moron had broken it?  Oh, lovely - it couldn't, it doesn't
and that moron had been myself ;-/"

> Do you actually use sparc32 these
> days?

qemu image only, TBH - I have an SS20 box, but it hadn't booted for
about 10 years...

> You could also kill the EX2 define while touchign the file,
> it is no longer used after ab5e8b331244.

Er?  No EX2 in checksum_32.S...  There is one in copy_user.S,
but that one _is_ used -

copy_user_table_end:
        be      copy_user_last7
         andcc  %g1, 4, %g0

        EX(ldd  [%o1], %g2, and %g1, 0xf)
        add     %o0, 8, %o0
        add     %o1, 8, %o1
        EX(st   %g2, [%o0 - 0x08], and %g1, 0xf)
        EX2(st  %g3, [%o0 - 0x04], and %g1, 0xf, %g1, sub %g1, 4)

> > Fixes: ab5e8b331244 "sparc32: propagate the calling conventions change down to __csum_partial_copy_sparc_generic()"
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

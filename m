Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85D0C25B48
	for <sparclinux@archiver.kernel.org>; Fri, 27 Oct 2023 20:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbjJ0UP6 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 27 Oct 2023 16:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0UP5 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 27 Oct 2023 16:15:57 -0400
X-Greylist: delayed 5214 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 27 Oct 2023 13:15:53 PDT
Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 946941AA
        for <sparclinux@vger.kernel.org>; Fri, 27 Oct 2023 13:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=5vY2ZoDSecfIR7/H+Diw/8PUAC75Hdwev/yWO6chghw=;
        b=SnHeV070deH7zZUa1RQClOZGjaunUP4qNOF8KC5AsiVdndhJ7iw4vC4vg49wSy0OcJuOmZhYK8cAZ
         RYdaEy25bH5vsl/1F80OZOzU1cK6zm4i9esS8JyKD69pNhMuchyBr1rzkV/ItCdrTsB+iM0wknemPS
         kTJ6SkTrTsB506nx+/8GCsZ0mSFIvrEgEfN5jtdXRbmo2d3YgwXIw0TT8AO07D7Zedjtt4qL7SnBya
         Nb4YTM6sO8WUKuuTO2bgzjtDX9lcrPsgccW0BuVvDnlQYh9M4fMcKC5pQYN53o0xRoSfjueVOqshB0
         +3EOVk/qRScJROec1WZqRedqV1LPnsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed2;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=5vY2ZoDSecfIR7/H+Diw/8PUAC75Hdwev/yWO6chghw=;
        b=svofhtiZdyW7IpvIK3EB5r0LeMdG+rT3eF6SZVyGZpSJy9o4xx2XOsPe2LMAoyNZwWxiCxDQ6e9aZ
         lx3XYIhBg==
X-HalOne-ID: 799dfa96-7505-11ee-a9d8-d73d96f03fed
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay4 (Halon) with ESMTPSA
        id 799dfa96-7505-11ee-a9d8-d73d96f03fed;
        Fri, 27 Oct 2023 20:14:48 +0000 (UTC)
Date:   Fri, 27 Oct 2023 22:14:47 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     sparclinux@vger.kernel.org
Subject: Re: [PATCH] sparc32: fix a braino in fault handling in
 csum_and_copy_..._user()
Message-ID: <20231027201447.GA5545@ravnborg.org>
References: <20231026021613.GI800259@ZenIV>
 <20231027184753.GA1048069@ravnborg.org>
 <20231027190220.GL800259@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027190220.GL800259@ZenIV>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Al,

> 
> Looking at the csum_and_copy_... instances on various architectures,
> noticing that and going "how the fuck could it possibly work and
> what moron had broken it?  Oh, lovely - it couldn't, it doesn't
> and that moron had been myself ;-/"

:-)

> 
> > Do you actually use sparc32 these
> > days?
> 
> qemu image only, TBH - I have an SS20 box, but it hadn't booted for
> about 10 years...

Looked at my "museum". At least 5 pcs of sparc32 boxes but I guess
the NVRAM needs repair on all of them.

I have a LEON4 board somewhere on the shelf too.
None of this powered up for years either - but I cannot make myself
getting rid of it. Because maybe one day I find time...

All that said - I have also once suggested to drop sun4m support,
keeping only the LEON parts. Back then there was some resistance,
but all for sentimental reasons and I can relate to that, since
I kept the sparc32 boxes around.

> > You could also kill the EX2 define while touchign the file,
> > it is no longer used after ab5e8b331244.
> 
> Er?  No EX2 in checksum_32.S...  There is one in copy_user.S,
> but that one _is_ used -
> 
> copy_user_table_end:
>         be      copy_user_last7
>          andcc  %g1, 4, %g0
> 
>         EX(ldd  [%o1], %g2, and %g1, 0xf)
>         add     %o0, 8, %o0
>         add     %o1, 8, %o1
>         EX(st   %g2, [%o0 - 0x08], and %g1, 0xf)
>         EX2(st  %g3, [%o0 - 0x04], and %g1, 0xf, %g1, sub %g1, 4)

Yeah, I'm blind. Somehow the grep output tricked me.

	Sam

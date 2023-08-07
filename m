Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EE3C001B0
	for <sparclinux@archiver.kernel.org>; Mon,  7 Aug 2023 17:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbjHGRMS (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 7 Aug 2023 13:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjHGRMN (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 7 Aug 2023 13:12:13 -0400
Received: from mailrelay5-1.pub.mailoutpod2-cph3.one.com (mailrelay5-1.pub.mailoutpod2-cph3.one.com [IPv6:2a02:2350:5:404::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435E199D
        for <sparclinux@vger.kernel.org>; Mon,  7 Aug 2023 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=+9IbfP2CSPzFxpkIvm3WvTvZOE7woxgn8Sa1Kw2IcCU=;
        b=QV8Ww9SziknJE9qZWxxvRNMReo9pk86vVLzzkQhvlMiIwNEgcTkosc2zSshaNflJIy4rQD/0RSz32
         DKS2Ze+lG9k+srPrqh6x4jI/dpVna/x9vI0eigIAISGlIRVLTgcFGeTXfoZ8sXcupxQjckNsrIreJs
         GMpTcirnMF89F0RsFnxwEqiraWeWtEpAWkj3QZ4EQxxAUBHK2Fr2KhkFoqQX80PdQUdriE78A0ScXi
         Z02N1vY+/IiGo0ZhrLvaM/VWaTIK+bCGod9/CbweKb++ltLDEQ7xi6g+29u3Wgr51BLsMLCWOc2kd3
         gY/U9rpcaH45PXpa4FCTZ8lpQsAMwOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
         from:date:from;
        bh=+9IbfP2CSPzFxpkIvm3WvTvZOE7woxgn8Sa1Kw2IcCU=;
        b=Y3XShcWCeHuqcw9hmJaD/zitcSYoMjq3q1ZKYOc7mMgUWwThSAfqw7SFDGxFCn4ROEoJp9YxEaK4P
         9/hVhW4DA==
X-HalOne-ID: 854b52c3-3545-11ee-8818-55333ba73462
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay5 (Halon) with ESMTPSA
        id 854b52c3-3545-11ee-8818-55333ba73462;
        Mon, 07 Aug 2023 17:12:02 +0000 (UTC)
Date:   Mon, 7 Aug 2023 19:12:00 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux@treblig.org
Cc:     davem@davemloft.net, benh@kernel.crashing.org,
        akpm@linux-foundation.org, sparclinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v3] sparc: Use shared font data
Message-ID: <20230807171200.GC281773@ravnborg.org>
References: <20230807010914.799713-1-linux@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807010914.799713-1-linux@treblig.org>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi David,

On Mon, Aug 07, 2023 at 02:09:14AM +0100, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> sparc has a 'btext' font used for the console which is almost identical
> to the shared font_sun8x16, so use it rather than duplicating the data.
> 
> They were actually identical until about a decade ago when
>    commit bcfbeecea11c ("drivers: console: font_: Change a glyph from
>                         "broken bar" to "vertical line"")
> 
> which changed the | in the shared font to be a solid
> bar rather than a broken bar.  That's the only difference.
> 
> This was originally spotted by PMD which noticed that PPC does
> the same thing with the same data, and they also share a bunch
> of functions to manipulate the data.
> 
> Tested very lightly with a boot without FS in qemu.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

	Sam

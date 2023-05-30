Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E2AC77B73
	for <sparclinux@archiver.kernel.org>; Tue, 30 May 2023 14:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjE3Omb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 May 2023 10:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjE3Oma (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 May 2023 10:42:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7257AB2;
        Tue, 30 May 2023 07:42:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DB9051FDD8;
        Tue, 30 May 2023 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685457746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aD9ZEOWoaqRaDaOGqzkCoyKy74GVA/ok3TJS5xm11zk=;
        b=ohGewJyXy7GILzNKMuH3pmyRCNjWuCqfknJFD0LnUtw981rBavMZe85EgNmbvK/LM5xOsW
        Qr4Kog1Q/N8iA2RtgfayrxVDbcR4fpoLEPgvFhn73JczL1UgCJvKC+WoXU9ew1SnzRJWm8
        kHK1i0HBZ/UrW3sQMHDTqVn8XvEFeAc=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9A3D42C141;
        Tue, 30 May 2023 14:42:26 +0000 (UTC)
Date:   Tue, 30 May 2023 16:42:26 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 05/10] watchdog/hardlockup: remove softlockup comment in
 touch_nmi_watchdog()
Message-ID: <ZHYLUsKaFebd5gvR@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.5.Ia593afc9eb12082d55ea6681dc2c5a89677f20a8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.5.Ia593afc9eb12082d55ea6681dc2c5a89677f20a8@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-26 18:41:35, Douglas Anderson wrote:
> In the patch ("watchdog/hardlockup: add comments to
> touch_nmi_watchdog()") we adjusted some comments for
> touch_nmi_watchdog(). The comment about the softlockup had a typo and
> were also felt to be too obvious. Remove it.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

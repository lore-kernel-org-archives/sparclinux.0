Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED17C77B73
	for <sparclinux@archiver.kernel.org>; Tue, 30 May 2023 14:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbjE3OQI (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 May 2023 10:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233000AbjE3OQH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 May 2023 10:16:07 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72B3CF1;
        Tue, 30 May 2023 07:15:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 71C5D1FD96;
        Tue, 30 May 2023 14:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685456136; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f03SjuaWbgPFKDNHkccYfxdvERRD4V1UOqT9AnVf20c=;
        b=qwneuzT8aVE62UwAlpeyfFZ8eI36IDinEAOaWAF5L4znVMIaf6zMod/lkB42XEy/NcnL2A
        C+hZu4NVw46mIT0SZgCF7kkibghDwAAeOiAUxhgDsFJLco5k09k1bbmKdbw6adC+Nk7rpu
        CJ0MBEUmWwYed0L2p4tEgaYiUAzHSJQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DEA372C141;
        Tue, 30 May 2023 14:15:33 +0000 (UTC)
Date:   Tue, 30 May 2023 16:15:33 +0200
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
Subject: Re: [PATCH 01/10] watchdog/hardlockup: Keep kernel.nmi_watchdog
 sysctl as 0444 if probe fails
Message-ID: <ZHYFBUnXmjAvhUFT@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.1.I0d75971cc52a7283f495aac0bd5c3041aadc734e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.1.I0d75971cc52a7283f495aac0bd5c3041aadc734e@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-26 18:41:31, Douglas Anderson wrote:
> The permissions for the kernel.nmi_watchdog sysctl have always been
> set at compile time despite the fact that a watchdog can fail to
> probe. Let's fix this and set the permissions based on whether the
> hardlockup detector actually probed.
> 
> Fixes: a994a3147e4c ("watchdog/hardlockup/perf: Implement init time detection of perf")
> Reported-by: Petr Mladek <pmladek@suse.com>
> Closes: https://lore.kernel.org/r/ZHCn4hNxFpY5-9Ki@alley
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Looks good to me:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

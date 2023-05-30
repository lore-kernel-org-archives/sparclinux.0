Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7212EC77B73
	for <sparclinux@archiver.kernel.org>; Tue, 30 May 2023 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjE3PBJ (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 May 2023 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232793AbjE3PAr (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 May 2023 11:00:47 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A079B10D;
        Tue, 30 May 2023 08:00:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 5DA861F8C8;
        Tue, 30 May 2023 15:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685458845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lzf8k9OeD6CxKARnPSlUMY/zE2d/0eZgKuThx3A5Fj4=;
        b=EVny03Fpuk0L/eAxDq5AtkoQdDuOqfyJ7Ynis5eAo/QQE/uz4JFp9wkFa6GWJxxvIp89AX
        qC2iLiX+no6dVa9Q1Ggo/++xFZeUCnro6XI6oWHE917EOtE/68yB2PQvonkyCzRTjHLJav
        3s8c4Qs1zP94tZouCjAYz0nd2cpW40E=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 175C82C141;
        Tue, 30 May 2023 15:00:45 +0000 (UTC)
Date:   Tue, 30 May 2023 17:00:43 +0200
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
Subject: Re: [PATCH 09/10] watchdog/hardlockup: Move SMP barriers from common
 code to buddy code
Message-ID: <ZHYPmxdzl0tOB_uY@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.9.I5ab0a0eeb0bd52fb23f901d298c72fa5c396e22b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.9.I5ab0a0eeb0bd52fb23f901d298c72fa5c396e22b@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-26 18:41:39, Douglas Anderson wrote:
> It's been suggested that since the SMP barriers are only potentially
> useful for the buddy hardlockup detector, not the perf hardlockup
> detector, that the barriers belong in the buddy code. Let's move them
> and add clearer comments about why they're needed.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

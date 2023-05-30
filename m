Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64193C77B7A
	for <sparclinux@archiver.kernel.org>; Tue, 30 May 2023 14:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjE3OjR (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 May 2023 10:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjE3OjQ (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 May 2023 10:39:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB838F;
        Tue, 30 May 2023 07:39:15 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 369D0219D2;
        Tue, 30 May 2023 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1685457554; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i7vF9JpsfadEYC3jOZr5CnXQ2XIUYn0nPXlK7fmlNPM=;
        b=Mcr0cPG0zlm7cRNAao1VppvBZ1sCLRrD+rMuZYSu+6XdmhVyW0iiRrmrUJyt2leTqHVJhu
        1s4NCviWMX7pM28Yd9JqjR4mYtBN5zpUwzN9jcD9J7TqAavc0OnX1t9qFLj6TLOLwggdmW
        ItUgQHnJiJLEGRPz35ogDWLtz8WnvXI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E94442C141;
        Tue, 30 May 2023 14:39:13 +0000 (UTC)
Date:   Tue, 30 May 2023 16:39:13 +0200
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
Subject: Re: [PATCH 03/10] watchdog/hardlockup: Don't use raw_cpu_ptr() in
 watchdog_hardlockup_kick()
Message-ID: <ZHYKkbcIMoXBa0Vu@alley>
References: <20230527014153.2793931-1-dianders@chromium.org>
 <20230526184139.3.I660e103077dcc23bb29aaf2be09cb234e0495b2d@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526184139.3.I660e103077dcc23bb29aaf2be09cb234e0495b2d@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-26 18:41:33, Douglas Anderson wrote:
> In the patch ("watchdog/hardlockup: add a "cpu" param to
> watchdog_hardlockup_check()") there was no reason to use
> raw_cpu_ptr(). Using this_cpu_ptr() works fine.
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

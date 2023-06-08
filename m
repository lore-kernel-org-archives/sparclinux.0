Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D132C7EE23
	for <sparclinux@archiver.kernel.org>; Thu,  8 Jun 2023 13:48:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbjFHNsI (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 8 Jun 2023 09:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbjFHNsH (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 8 Jun 2023 09:48:07 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F081FD6;
        Thu,  8 Jun 2023 06:48:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7FFAF219A2;
        Thu,  8 Jun 2023 13:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686232085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yP9xLPyYFMGMpi467QcNnB+YH/wlZqcYZh3EWd4dmcY=;
        b=m63+KFvTBQEoswSYPzhIsHPn1FjqqayGRiQzC/FIKdmwxak8gkx7w9F9rldbURg/etSpZc
        BICnIf8C0z7eVZcnDvN4FdSPCN3o9oRJ9oMQtLZEJ/cLQcCi3cF2Tr8r9iBwWpkH8zBjE5
        J6OpJnSRXarKOZcGInmiJWE83pipteA=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 45B052C142;
        Thu,  8 Jun 2023 13:48:05 +0000 (UTC)
Date:   Thu, 8 Jun 2023 15:48:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        sparclinux@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 7/7] watchdog/hardlockup: Define HARDLOCKUP_DETECTOR_ARCH
Message-ID: <ZIHcFDnQPuVe1vAc@alley>
References: <20230607152432.5435-1-pmladek@suse.com>
 <20230607152432.5435-8-pmladek@suse.com>
 <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=U8CTttqz9jL6TockdKTd1dM1ApR4Nw+X3OF5tgoagfRQ@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed 2023-06-07 16:37:10, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 7, 2023 at 8:26 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > @@ -1102,6 +1103,14 @@ config HARDLOCKUP_DETECTOR_BUDDY
> >         depends on !HAVE_HARDLOCKUP_DETECTOR_ARCH
> >         select HARDLOCKUP_DETECTOR_COUNTS_HRTIMER
> >
> > +config HARDLOCKUP_DETECTOR_ARCH
> > +       bool
> > +       depends on HARDLOCKUP_DETECTOR
> > +       depends on HAVE_HARDLOCKUP_DETECTOR_ARCH
> > +       help
> > +         The arch-specific implementation of the hardlockup detector is
> > +         available.
> 
> nit: "is available" makes it sound a bit too much like a "have"
> version. Maybe "The arch-specific implementation of the hardlockup
> detector will be used" or something like that?

Makes sense. Will do this change in v2.

> Otherise:
> 
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks,
Petr

Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81379EB64DB
	for <sparclinux@archiver.kernel.org>; Mon, 19 Jun 2023 09:55:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjFSJzM (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 19 Jun 2023 05:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjFSJzL (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 19 Jun 2023 05:55:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C566FA9;
        Mon, 19 Jun 2023 02:55:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 680A91F38A;
        Mon, 19 Jun 2023 09:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1687168508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BqmUWIwDB6MccYaGRsbpmDX+MgysrUEAbIREmqAE7tY=;
        b=kpNSnf7reRG026G37InlC9KBsz3JngC4BSohPCpE0Ofc8ydoyz5aDha+1hAEwNWXhASmzX
        JV7x4Bu/lZZHnRlKAzxfLi3A7L5vetPl1KZBY3/H/ktCk4Lt0ZiiylFlNJrfUgRwyPoKfP
        BcAm8JrzmAlSyJ7pzGIK0PKATklgyIU=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A3CCF2C141;
        Mon, 19 Jun 2023 09:55:06 +0000 (UTC)
Date:   Mon, 19 Jun 2023 11:55:06 +0200
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
Subject: Re: [PATCH v2 4/6] watchdog/hardlockup: Make HAVE_NMI_WATCHDOG
 sparc64-specific
Message-ID: <ZJAl-rznBaZubY3-@alley>
References: <20230616150618.6073-1-pmladek@suse.com>
 <20230616150618.6073-5-pmladek@suse.com>
 <CAD=FV=U=ox4ApMbDL7v=ivNF6x=UyG=dd4MU_Dt0rppNCEwCpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=U=ox4ApMbDL7v=ivNF6x=UyG=dd4MU_Dt0rppNCEwCpw@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-06-16 09:48:06, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 16, 2023 at 8:07 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > There are several hardlockup detector implementations and several Kconfig
> > values which allow selection and build of the preferred one.
[...]
> > Note that HARDLOCKUP_DETECTOR_PREFER_BUDDY, HARDLOCKUP_DETECTOR_PERF,
> > and HARDLOCKUP_DETECTOR_BUDDY may conflict only with
> > HAVE_HARDLOCKUP_DETECTOR_ARCH. They depend on HARDLOCKUP_DETECTOR
> > and it is not longer enabled when HAVE_NMI_WATCHDOG is set.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> >
> > watchdog/sparc64: Rename HAVE_NMI_WATCHDOG to HAVE_HARDLOCKUP_WATCHDOG_SPARC64
[...]
> > Also the variable is set only on sparc64. Move the definition
> > from arch/Kconfig to arch/sparc/Kconfig.debug.
> >
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> 
> I think you goofed up when squashing the patches. You've now got a
> second patch subject after your first Signed-off-by and then a second
> Signed-off-by... I assume everything after the first Signed-off-by
> should be dropped?

Ah, you are right. It seems that Andrew has fixed this when taking
the patch.

Thank you both,
Petr

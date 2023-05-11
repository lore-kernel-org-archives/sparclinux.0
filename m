Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9415BC7EE22
	for <sparclinux@archiver.kernel.org>; Thu, 11 May 2023 12:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236911AbjEKMpz (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 11 May 2023 08:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237558AbjEKMpx (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Thu, 11 May 2023 08:45:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626D24C39;
        Thu, 11 May 2023 05:45:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E882D1FE81;
        Thu, 11 May 2023 12:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683809149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9QB/4NQfxs6MWzEb4+Nqls4LUd5AWkLgrCPKn/rdQXM=;
        b=XHA7oE6mmCQVIyRFnHnwTxvsSvoMrqGwBeCZ1Y/UJ/YR+kR0CRB7zHy4Ed8vNjlnVuzLG3
        eFY8NJqs6DJA8SwBXvMchJIC0fvt24EmFidUVZ4kKuCrZxZjAMKJm1OxKXot92GupgIZsm
        bPTlKL8UJUfRozLbl/SROqJsU8Tfifs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A80F82C141;
        Thu, 11 May 2023 12:45:48 +0000 (UTC)
Date:   Thu, 11 May 2023 14:45:48 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephane Eranian <eranian@google.com>,
        Stephen Boyd <swboyd@chromium.org>, ricardo.neri@intel.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, ito-yuichi@fujitsu.com,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wens@csie.org>, christophe.leroy@csgroup.eu,
        davem@davemloft.net, sparclinux@vger.kernel.org,
        mpe@ellerman.id.au, Will Deacon <will@kernel.org>,
        ravi.v.shankar@intel.com, linuxppc-dev@lists.ozlabs.org,
        Marc Zyngier <maz@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH v4 08/17] watchdog/hardlockup: Style changes to
 watchdog_hardlockup_check() / ..._is_lockedup()
Message-ID: <ZFzjfK3QGCCTB-Pw@alley>
References: <20230504221349.1535669-1-dianders@chromium.org>
 <20230504151100.v4.8.I818492c326b632560b09f20d2608455ecf9d3650@changeid>
 <CSE0CI3TFK72.2I4E5TJIRHDGM@wheely>
 <CAD=FV=Vuad+gxrUirhyx8aFuLbh2M1hMnoY5NUVBxdycd8kFiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=Vuad+gxrUirhyx8aFuLbh2M1hMnoY5NUVBxdycd8kFiQ@mail.gmail.com>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-05 09:38:14, Doug Anderson wrote:
> Hi,
> 
> On Thu, May 4, 2023 at 8:02 PM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Fri May 5, 2023 at 8:13 AM AEST, Douglas Anderson wrote:
> > > These are tiny style changes:
> > > - Add a blank line before a "return".
> > > - Renames two globals to use the "watchdog_hld" prefix.
> >
> > Particularly static ones don't really need the namespace prefixes.
> 
> Renames are mostly at Petr's request. If I've misunderstood what he
> wants here that I'm happy to remove them.

IMHO, the namespace prefix makes sense here to distinguish hardlockup
and softlockup specific code. The original names did this as well
but they were another variants of the naming scheme mess.

IMHO, even longer prefix is better than a mess.

> > Not sure if processed is better than warn.
> 
> I can undo this one if you want. It felt like we were doing more than
> just warning, but if people think "warn" is a better way to describe
> it then that's fine with me.

The code seems to only print the warning and dump a lot of debug
information. Both _warned or _processed look good to me.

> > allcpu_dumped is better
> > than dumped_stacks though because the all-CPUs-dump is a particular
> > thing.
>
> OK, I can undo this and leave it as "allcpu_dumped".

I do not have strong opinion. Well, "allcpu" is another inconsistency
vs. "all_cpu" in sysctl_hardlockup_all_cpu_backtrace. So, it should
be "all_cpu_dumped".

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

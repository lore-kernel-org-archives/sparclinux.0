Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7D5C77B73
	for <sparclinux@archiver.kernel.org>; Wed, 24 May 2023 13:07:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbjEXNHx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 May 2023 09:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjEXNHw (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 May 2023 09:07:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC7C9B;
        Wed, 24 May 2023 06:07:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id C5C241F8AA;
        Wed, 24 May 2023 13:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1684933666; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1uzlbCLytRmf0lA+DtAHijJtX4O3Gwzv81/iHYbX4xM=;
        b=dNCKCmzrAguc4Zu0EVLMzkQBOnzySCfPWd6UAjSLLX4F7lVFU/qdF2897g72w3J9pbcyo7
        hMgY3ZZMBUMpYla7bUIKkhKJHRHTtECbW305O4opeysKGun6LgnV0dOKn6b9AFAsXyiSo6
        MTyA6XI74c0YA2S//W5ap7ZCPSlLK1c=
Received: from suse.cz (dhcp129.suse.cz [10.100.51.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B798F2C141;
        Wed, 24 May 2023 13:07:44 +0000 (UTC)
Date:   Wed, 24 May 2023 15:07:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Stephane Eranian <eranian@google.com>, mpe@ellerman.id.au,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linuxppc-dev@lists.ozlabs.org, Sumit Garg <sumit.garg@linaro.org>,
        npiggin@gmail.com, davem@davemloft.net,
        Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, sparclinux@vger.kernel.org,
        christophe.leroy@csgroup.eu,
        Catalin Marinas <catalin.marinas@arm.com>,
        ravi.v.shankar@intel.com, Randy Dunlap <rdunlap@infradead.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Ian Rogers <irogers@google.com>, ito-yuichi@fujitsu.com,
        ricardo.neri@intel.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-kernel@vger.kernel.org,
        Masayoshi Mizuma <msys.mizuma@gmail.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 11/18] watchdog/hardlockup: Move perf hardlockup
 watchdog petting to watchdog.c
Message-ID: <ZG4MIFNPi6zwO_WV@alley>
References: <20230519101840.v5.18.Ia44852044cdcb074f387e80df6b45e892965d4a1@changeid>
 <20230519101840.v5.11.I00dfd6386ee00da25bf26d140559a41339b53e57@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230519101840.v5.11.I00dfd6386ee00da25bf26d140559a41339b53e57@changeid>
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri 2023-05-19 10:18:35, Douglas Anderson wrote:
> In preparation for the buddy hardlockup detector, which wants the same
> petting logic as the current perf hardlockup detector, move the code
> to watchdog.c. While doing this, rename the global variable to match
> others nearby. As part of this change we have to change the code to
> account for the fact that the CPU we're running on might be different
> than the one we're checking.
> 
> Currently the code in watchdog.c is guarded by
> CONFIG_HARDLOCKUP_DETECTOR_PERF, which makes this change seem
> silly. However, a future patch will change this.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

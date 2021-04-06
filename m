Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A06C0C43461
	for <sparclinux@archiver.kernel.org>; Tue,  6 Apr 2021 17:38:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725F8613D3
	for <sparclinux@archiver.kernel.org>; Tue,  6 Apr 2021 17:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbhDFRit (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 6 Apr 2021 13:38:49 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:4421 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244714AbhDFRit (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 6 Apr 2021 13:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1449; q=dns/txt; s=iport;
  t=1617730721; x=1618940321;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wHC75exw7z/XvWxaqurh75hAcW+P/hc1Ce2AN8KLAVE=;
  b=G8CemyZRO1sUomjCmS+YE/C6uWze7voF3/OnkJPzCjlApsHtQw/NACu6
   IbzaOOj9YEiobtqOgYiAKbgbugARDCXIRPa+ZrNQSpdtmv1Zjt672WTLx
   0k1ILORDVGZtFP7Z+NpOxvDGSwgPkZcfBivMfAolYWZryTkHbcjWyFPfw
   w=;
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Ad70PFKyAZuY1VAyfgTLAKrPwkb1zdoIgy1?=
 =?us-ascii?q?knxilNYDZeG/b2q+mFmvMH2RjozBsQQmgng9CcOK+GKEmskKJdy48XILukQU?=
 =?us-ascii?q?3aqHKlRbsSj7fK7jX8F0TFnNJ1+rxnd8FFZeHYLV8/tsri5Rn9LtBI+qjizI?=
 =?us-ascii?q?mNpcPzi0hgVhtrbaYI1XYbNi++HldtTAdLQboVfaD82uN9qzCteWsaY62Abx?=
 =?us-ascii?q?FvY8H5q9LGj57gaxIdbiRG1CC1kTiq5LTmeiL34j4iVVp0rYsKwCzijxHz4L?=
 =?us-ascii?q?mlvrWdzBLRvlWjiah+qZ/G1sZJAtCKh4wuDgjUziysZIhnRtS5zVcInN0=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AGAAAsnGxg/4YNJK1aGgEBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBARIBAQEBAgIBAQEBQIE+BQEBAQELAYIqgU0BOY0XiTGQDYpcgXw?=
 =?us-ascii?q?LAQEBDQEBNAQBAYRQAoF2AiU0CQ4CAwEBDAEBBQEBAQIBBgRxE4VdhkUBBTo?=
 =?us-ascii?q?6BRALGC48GwaGDKtXdYE0gQGIH4FEIoEXAY1MJxyBSUKBE4MiPoo5BIJHghe?=
 =?us-ascii?q?gOZwpgxWBJptHMhCkYS24EQIEBgUCFoFUOoFZMxoIGxWDJU8ZDo4rFo5HIQN?=
 =?us-ascii?q?nAgYKAQEDCYw0XQEB?=
X-IronPort-AV: E=Sophos;i="5.82,201,1613433600"; 
   d="scan'208";a="611888528"
Received: from alln-core-12.cisco.com ([173.36.13.134])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 06 Apr 2021 17:38:39 +0000
Received: from zorba ([10.24.14.212])
        by alln-core-12.cisco.com (8.15.2/8.15.2) with ESMTPS id 136HcajD016593
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 6 Apr 2021 17:38:37 GMT
Date:   Tue, 6 Apr 2021 10:38:36 -0700
From:   Daniel Walker <danielwa@cisco.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     will@kernel.org, robh@kernel.org,
        daniel@gimpelevich.san-francisco.ca.us, arnd@kernel.org,
        akpm@linux-foundation.org, linux-arch@vger.kernel.org,
        devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        microblaze <monstr@monstr.eu>, linux-mips@vger.kernel.org,
        nios2 <ley.foon.tan@intel.com>, openrisc@lists.librecores.org,
        linux-hexagon@vger.kernel.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, linux-xtensa@linux-xtensa.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v4 19/20] mips: Convert to GENERIC_CMDLINE
Message-ID: <20210406173836.GW2469518@zorba>
References: <cover.1617375802.git.christophe.leroy@csgroup.eu>
 <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a01b6cdbae01fff77e26f7a5c40ee5260e1952b5.1617375802.git.christophe.leroy@csgroup.eu>
X-Outbound-SMTP-Client: 10.24.14.212, [10.24.14.212]
X-Outbound-Node: alln-core-12.cisco.com
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, Apr 02, 2021 at 03:18:21PM +0000, Christophe Leroy wrote:
> -config CMDLINE_BOOL
> -	bool "Built-in kernel command line"
> -	help
> -	  For most systems, it is firmware or second stage bootloader that
> -	  by default specifies the kernel command line options.  However,
> -	  it might be necessary or advantageous to either override the
> -	  default kernel command line or add a few extra options to it.
> -	  For such cases, this option allows you to hardcode your own
> -	  command line options directly into the kernel.  For that, you
> -	  should choose 'Y' here, and fill in the extra boot arguments
> -	  in CONFIG_CMDLINE.
> -
> -	  The built-in options will be concatenated to the default command
> -	  line if CMDLINE_OVERRIDE is set to 'N'. Otherwise, the default
> -	  command line will be ignored and replaced by the built-in string.
> -
> -	  Most MIPS systems will normally expect 'N' here and rely upon
> -	  the command line from the firmware or the second-stage bootloader.
> -


See how you complained that I have CMDLINE_BOOL in my changed, and you think it
shouldn't exist.

Yet here mips has it, and you just deleted it with no feature parity in your
changes for this.

In my changes I tried to maintain as much feature parity as I could with the
architectures. I did the same huge conversion a long time ago you've done here to be sure all
platforms have the features needed.

Daniel

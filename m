Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB51C433DB
	for <sparclinux@archiver.kernel.org>; Mon, 22 Mar 2021 21:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87B8C619A8
	for <sparclinux@archiver.kernel.org>; Mon, 22 Mar 2021 21:48:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCVVs1 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:48:27 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:55625 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229822AbhCVVsI (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Mon, 22 Mar 2021 17:48:08 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lOSP8-000IKz-30; Mon, 22 Mar 2021 22:48:06 +0100
Received: from p57bd9564.dip0.t-ipconnect.de ([87.189.149.100] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lOSP7-001fuD-Si; Mon, 22 Mar 2021 22:48:06 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Frank Scheiner <frank.scheiner@web.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>
Cc:     debian-sparc <debian-sparc@lists.debian.org>,
        Christoph Hellwig <hch@lst.de>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
Date:   Mon, 22 Mar 2021 22:48:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.149.100
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hello!

On 3/22/21 10:30 PM, Frank Scheiner wrote:
> Riccardo Mottola first recognized a problem with 5.10.x kernels on his
> Sun T2000 with UltraSPARC T1 (details in [this thread]). I could verify
> the problem also on my Sun T1000 and it looks like this specific issue
> breaks the mounting of the root FS or maybe mounting file systems at
> all. This affects both booting from disk and from network.
> (...)
> ...as first bad commit.
> 
> ```
> commit 028abd9222df0cf5855dab5014a5ebaf06f90565
> Author: Christoph Hellwig <hch@lst.de>
> Date:   Thu Sep 17 10:22:34 2020 +0200
> 
>     fs: remove compat_sys_mount
> 
>     compat_sys_mount is identical to the regular sys_mount now, so
> remove it
>     and use the native version everywhere.
> ```
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=028abd9222df0cf5855dab5014a5ebaf06f90565

Looking at this change, I think it's rather unexpected that this particular
change would break the kernel on a specific CPU target. Are you sure that
this is the right bad commit?

If you found the right commit, then I assume there is something wrong with
the syscall handling on UltraSPARC T1.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


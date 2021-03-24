Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31047C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAD6161A09
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 12:50:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhCXMtX (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:49:23 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:47451 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229889AbhCXMtG (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 08:49:06 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lP2wb-002tZ6-FV; Wed, 24 Mar 2021 13:49:05 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lP2wb-003BCX-9m; Wed, 24 Mar 2021 13:49:05 +0100
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
To:     Frank Scheiner <frank.scheiner@web.de>,
        Christoph Hellwig <hch@lst.de>
Cc:     Jan Engelhardt <jengelh@inai.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de>
 <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de>
 <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de>
 <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de>
 <de572001-6238-8fda-aab4-f2ca443f2057@web.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <e93db337-a995-d9ec-13e3-1d8a2d986ff0@physik.fu-berlin.de>
Date:   Wed, 24 Mar 2021 13:49:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <de572001-6238-8fda-aab4-f2ca443f2057@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hello Frank!

On 3/24/21 1:30 PM, Frank Scheiner wrote:
> Sorry, but I can't install `gdb` on my T1000 ATM, because it depends on
> "libpython3.8" for sparc64 (see [1]) and "libpython3.9" for the other
> architectures, but "libpython3.8" is actually not available for sparc64,
> "libpython3.9" is available for sparc64 though:

The reason for this is a bug in gdb [1] and the fact that we don't have cruft
in Debian Ports [2]. If someone knows how to disable individual tests in the
GDB testsuite, we could just disable the problematic test in src:gdb.

Adrian

> [1] https://sourceware.org/bugzilla/show_bug.cgi?id=26170
> [2] https://lists.debian.org/debian-sparc/2017/12/msg00060.html

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


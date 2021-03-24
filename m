Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85381C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D86D61A0D
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 13:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235267AbhCXNQg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 09:16:36 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:56823 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235232AbhCXNQ0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 09:16:26 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1lP3N3-0036gl-QM; Wed, 24 Mar 2021 14:16:25 +0100
Received: from suse-laptop.physik.fu-berlin.de ([160.45.32.140])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1lP3N3-003HW8-JJ; Wed, 24 Mar 2021 14:16:25 +0100
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
 <8600c0fc-7144-4b38-d6ae-4dbbabb125ba@web.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <dc37860d-168e-4e4e-475e-943556e8484f@physik.fu-berlin.de>
Date:   Wed, 24 Mar 2021 14:16:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <8600c0fc-7144-4b38-d6ae-4dbbabb125ba@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 160.45.32.140
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On 3/24/21 2:09 PM, Frank Scheiner wrote:> Kernel sources are not available on the T1000.
> 
> If need be, where do they need to exist and how should the directory be
> named - `/usr/src/[...]`?

Try installing "linux-source" and the "-dbg" package for your Debian kernel.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


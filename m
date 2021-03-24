Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 445C5C433C1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 16:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D6BC61A01
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 16:11:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbhCXQLU (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 12:11:20 -0400
Received: from verein.lst.de ([213.95.11.211]:37648 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230381AbhCXQKt (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 12:10:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1477968B05; Wed, 24 Mar 2021 17:10:46 +0100 (CET)
Date:   Wed, 24 Mar 2021 17:10:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     Jan Engelhardt <jengelh@inai.de>, Christoph Hellwig <hch@lst.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
Message-ID: <20210324161045.GA5969@lst.de>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de> <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de> <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de> <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de> <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de> <p1p52s61-n8p-s29n-n195-q22rs07qoq40@vanv.qr> <250aaeb3-40fe-60c7-044e-aa9daacd7c12@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <250aaeb3-40fe-60c7-044e-aa9daacd7c12@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Wed, Mar 24, 2021 at 04:58:39PM +0100, Frank Scheiner wrote:
> [   20.090279] [<00000000006c6494>] sys_mount+0x114/0x1e0
> [   20.090338] [<00000000006c6454>] sys_mount+0xd4/0x1e0
> [   20.090499] [<0000000000406274>] linux_sparc_syscall+0x34/0x44
> [   20.090697] Disabling lock debugging due to kernel taint
> [   20.090770] Caller[00000000006c6494]: sys_mount+0x114/0x1e0
> [   20.090926] Caller[00000000006c6454]: sys_mount+0xd4/0x1e0
> [   20.091133] Caller[0000000000406274]: linux_sparc_syscall+0x34/0x44
> [   20.091196] Caller[0000000000100aa8]: 0x100aa8
> [...]
> ```
>
> [1]: https://pastebin.com/ApPYsMcu
>
> Here the result for the suggested command:

Thanks.  And very strange, as i can't find what would free options
before.  Does the system boot if you comment out that kfree in line
3415 (even if that casues a memleak elsewhere).

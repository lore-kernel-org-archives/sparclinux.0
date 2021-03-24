Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8FF1C433DB
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71569619C2
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 08:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhCXI2Y (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 04:28:24 -0400
Received: from verein.lst.de ([213.95.11.211]:35982 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233498AbhCXI2T (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Wed, 24 Mar 2021 04:28:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6B43E68B05; Wed, 24 Mar 2021 09:28:17 +0100 (CET)
Date:   Wed, 24 Mar 2021 09:28:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Engelhardt <jengelh@inai.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
Message-ID: <20210324082817.GA2625@lst.de>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de> <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de> <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de> <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Tue, Mar 23, 2021 at 11:17:41PM +0100, Frank Scheiner wrote:
> 028abd9222df0cf5855dab5014a5ebaf06f90565
>
> ...is broken on my T1000.
>
> As I don't know how big attachments can be on this list, I put the logs
> on pastebin.
>
> A log for 028abd9222df is here:
>
> https://pastebin.com/ApPYsMcu

Just do confirm:  in this tree line 304 in mm/slub.c is this BUG_ON:

	BUG_ON(object == fp); /* naive detection of double free or corruption */

which would mean we have a double free.  In that case it would be
interesting which call to kfree this is, which could be done by
calling gdb on vmlinux and then typing;

l *(sys_mount+0x114/0x1e0)

Not that a double free caused by this conversion makes any sense to me..

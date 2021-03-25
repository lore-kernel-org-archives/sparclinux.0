Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E409BC433E6
	for <sparclinux@archiver.kernel.org>; Thu, 25 Mar 2021 07:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE43061A27
	for <sparclinux@archiver.kernel.org>; Thu, 25 Mar 2021 07:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbhCYHuz (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Thu, 25 Mar 2021 03:50:55 -0400
Received: from verein.lst.de ([213.95.11.211]:39975 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229651AbhCYHuj (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Thu, 25 Mar 2021 03:50:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3800268B05; Thu, 25 Mar 2021 08:50:37 +0100 (CET)
Date:   Thu, 25 Mar 2021 08:50:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Frank Scheiner <frank.scheiner@web.de>
Cc:     Christoph Hellwig <hch@lst.de>, Jan Engelhardt <jengelh@inai.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
Message-ID: <20210325075036.GA27022@lst.de>
References: <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de> <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de> <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de> <p1p52s61-n8p-s29n-n195-q22rs07qoq40@vanv.qr> <250aaeb3-40fe-60c7-044e-aa9daacd7c12@web.de> <20210324161045.GA5969@lst.de> <092f6c45-d4fe-ac02-d416-e644e2f26795@web.de> <b8e98852-8e90-2860-a051-2173da2805c7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8e98852-8e90-2860-a051-2173da2805c7@web.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

I have to admit I'm completely lost at this point.  This new trace looks
totally strange to me, and I'm pretty sure whatever symptoms you see are
due to different alignments / code sections etc just triggered by the
removal, we need help from the real sparc experts.

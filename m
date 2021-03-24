Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA58C433E1
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 15:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DACEA61A0F
	for <sparclinux@archiver.kernel.org>; Wed, 24 Mar 2021 15:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhCXPWW (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 24 Mar 2021 11:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236650AbhCXPWS (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 24 Mar 2021 11:22:18 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5E4C061763
        for <sparclinux@vger.kernel.org>; Wed, 24 Mar 2021 08:22:17 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 352265872FA43; Wed, 24 Mar 2021 16:22:16 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 32CCD60DD7283;
        Wed, 24 Mar 2021 16:22:16 +0100 (CET)
Date:   Wed, 24 Mar 2021 16:22:16 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Frank Scheiner <frank.scheiner@web.de>
cc:     Christoph Hellwig <hch@lst.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Sparc kernel list <sparclinux@vger.kernel.org>,
        debian-sparc <debian-sparc@lists.debian.org>
Subject: Re: Regression in 028abd92 for Sun UltraSPARC T1
In-Reply-To: <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de>
Message-ID: <p1p52s61-n8p-s29n-n195-q22rs07qoq40@vanv.qr>
References: <9ffdf604-ce04-9200-65c9-dd8921a45038@web.de> <186a7992-6e83-dc8a-1cfc-d07bb36935f5@physik.fu-berlin.de> <4d033ff9-329e-77e7-20de-720aa65bba3e@web.de> <n0n38p9-rn4s-213-n983-9o3o4oo8s54r@vanv.qr> <20210323165721.GA14577@lst.de>
 <d68767c2-e010-f90e-9f2c-bb5250465c58@web.de> <20210324082817.GA2625@lst.de> <a356b88c-2b75-3d8b-ba47-8f0c6d0420e0@web.de>
User-Agent: Alpine 2.24 (LSU 510 2020-10-10)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org


On Wednesday 2021-03-24 14:57, Frank Scheiner wrote:

> (gdb) l *(sys_mount+0x114/0x1e0)
> 0x6c6380 is in __se_sys_mount (fs/namespace.c:3390).

/0x1e0 does not normally belong there. Just

	l *(sys_mount+0x114)

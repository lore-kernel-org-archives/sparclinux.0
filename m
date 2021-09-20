Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F7AC433F5
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C18660F93
	for <sparclinux@archiver.kernel.org>; Mon, 20 Sep 2021 11:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236904AbhITLd2 (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 20 Sep 2021 07:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231279AbhITLd1 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 20 Sep 2021 07:33:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45661C061574
        for <sparclinux@vger.kernel.org>; Mon, 20 Sep 2021 04:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=3fwKldhIF+SfrMu2exsZ6H5YfyUB+uHDkkjYyOdveoc=; b=q7bWp1djQKbHu3rS7K2HvwP2iF
        uCQ0yRKuanpClj7VdX8NzNHiXAiCZmGta3oySjta1GGLeA4vmAcXTN+Qg8ymXDg9eiVJRwSVeT4yQ
        z1Evmy0qpH8RFJ5OI8Yvgmm3hyGAEW5cn7Bmrb0pqiU+zmTyam0AeL+NqiWU1Hp3ZGQnJmypHUk4H
        9gr5G4jiVIYuAcZPkq8p/k771Y1+42xNRuVgfZYS/KDXiH0kWllM7NCSFshBMGK8t6exChjAkPTt/
        MdZbgpmLCN6Fd/0wGGV/qV/XyHo+0PlW12j6oX6rqC8rknJ/3qce0tkuGCKJLI3DbqQVtBQjWy/5k
        fURarTgw==;
Received: from 213-225-6-64.nat.highway.a1.net ([213.225.6.64] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mSHVt-002cFa-It; Mon, 20 Sep 2021 11:31:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org
Subject: use the generic DMA remap allocator for sparc32
Date:   Mon, 20 Sep 2021 13:31:06 +0200
Message-Id: <20210920113108.1299996-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi Dave,

this series switches sparc32 to use the generic dma remap allocator
instead of its own version.

Diffstat:
 Kconfig         |    3 +-
 kernel/ioport.c |   76 +++++---------------------------------------------------
 2 files changed, 10 insertions(+), 69 deletions(-)

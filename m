Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E88C7619A
	for <sparclinux@archiver.kernel.org>; Sun, 26 Mar 2023 23:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCZXId (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sun, 26 Mar 2023 19:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCZXIc (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sun, 26 Mar 2023 19:08:32 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E050F4231;
        Sun, 26 Mar 2023 16:08:31 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A34EF68B05; Mon, 27 Mar 2023 01:08:28 +0200 (CEST)
Date:   Mon, 27 Mar 2023 01:08:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sparc: remove obsolete config ARCH_ATU
Message-ID: <20230326230828.GA19291@lst.de>
References: <20230324103438.28563-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324103438.28563-1-lukas.bulwahn@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

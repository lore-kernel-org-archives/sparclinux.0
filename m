Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923D1C433F5
	for <sparclinux@archiver.kernel.org>; Mon,  8 Nov 2021 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F610617E5
	for <sparclinux@archiver.kernel.org>; Mon,  8 Nov 2021 19:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238186AbhKHUCl (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 8 Nov 2021 15:02:41 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:54156 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbhKHUCl (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 8 Nov 2021 15:02:41 -0500
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 83736500FB8EF;
        Mon,  8 Nov 2021 11:59:54 -0800 (PST)
Date:   Mon, 08 Nov 2021 19:59:44 +0000 (GMT)
Message-Id: <20211108.195944.2221481905505486609.davem@davemloft.net>
To:     bp@alien8.de
Cc:     linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v0 37/42] sparc: Check notifier registration return
 value
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20211108101157.15189-38-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
        <20211108101157.15189-38-bp@alien8.de>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 08 Nov 2021 11:59:55 -0800 (PST)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Borislav Petkov <bp@alien8.de>
Date: Mon,  8 Nov 2021 11:11:52 +0100

> From: Borislav Petkov <bp@suse.de>
> 
> Avoid homegrown notifier registration checks.
> 
> No functional changes.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Acked-by: David S. Miller <davem@davemloft.net>

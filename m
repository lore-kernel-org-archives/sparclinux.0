Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAA8C4332F
	for <sparclinux@archiver.kernel.org>; Mon, 24 Jan 2022 12:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242878AbiAXM7O (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 24 Jan 2022 07:59:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:41644 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242918AbiAXM7B (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 24 Jan 2022 07:59:01 -0500
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id DD61F83FD219;
        Mon, 24 Jan 2022 04:58:58 -0800 (PST)
Date:   Mon, 24 Jan 2022 12:58:54 +0000 (GMT)
Message-Id: <20220124.125854.376101757936359699.davem@davemloft.net>
To:     anshuman.khandual@arm.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        hch@infradead.org, akpm@linux-foundation.org,
        khalid.aziz@oracle.com, sparclinux@vger.kernel.org
Subject: Re: [RFC V1 06/31] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1643029028-12710-7-git-send-email-anshuman.khandual@arm.com>
References: <1643029028-12710-1-git-send-email-anshuman.khandual@arm.com>
        <1643029028-12710-7-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Mon, 24 Jan 2022 04:59:00 -0800 (PST)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 24 Jan 2022 18:26:43 +0530

> This defines and exports a platform specific custom vm_get_page_prot() via
> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> macros can be dropped which are no longer needed.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Khalid Aziz <khalid.aziz@oracle.com>
> Cc: sparclinux@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>

Acked-by: David S. Miller <davem@davemloft.net>

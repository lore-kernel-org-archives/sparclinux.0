Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E6FC433B4
	for <sparclinux@archiver.kernel.org>; Fri, 14 May 2021 21:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C344161440
	for <sparclinux@archiver.kernel.org>; Fri, 14 May 2021 21:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbhENVnO (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 14 May 2021 17:43:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:60088 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229889AbhENVnN (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Fri, 14 May 2021 17:43:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 65D7B613BE;
        Fri, 14 May 2021 21:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1621028521;
        bh=XNFnNyGz6oUK6QJyJFeGVcriHVVQmYNR7kf6dc3QbV4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jOQtYFhvMMhMCLAqpSoLHUosNvCeTNGx8SsJo7Wij8CrKzQsK+R7EucispteADeFq
         /iRzUHeknwXZEXYV2g/hZ6OW9cPG73D5mIDTdO4aq2WmaOAZjGJuAgjN3MUXzH2gIE
         kgT4+Z0Irv3DFzZaosEJDhP37DaK1uhXbYlior+4=
Date:   Fri, 14 May 2021 14:42:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@kernel.org>, naresh.kamboju@linaro.org,
        linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sparclinux@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] arm64: Define only {pud/pmd}_{set/clear}_huge when
 usefull
Message-Id: <20210514144200.b49ee77c9b2a7f9998ffbf22@linux-foundation.org>
In-Reply-To: <73ec95f40cafbbb69bdfb43a7f53876fd845b0ce.1620990479.git.christophe.leroy@csgroup.eu>
References: <73ec95f40cafbbb69bdfb43a7f53876fd845b0ce.1620990479.git.christophe.leroy@csgroup.eu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

On Fri, 14 May 2021 11:08:53 +0000 (UTC) Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> When PUD and/or PMD are folded, those functions are useless
> and we now have a stub in linux/pgtable.h

OK, help me out here please.  What patch does this fix?

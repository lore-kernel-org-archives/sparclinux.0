Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E581C433FE
	for <sparclinux@archiver.kernel.org>; Tue, 18 Jan 2022 07:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244562AbiARHsn (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 18 Jan 2022 02:48:43 -0500
Received: from verein.lst.de ([213.95.11.211]:35899 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234433AbiARHsm (ORCPT <rfc822;sparclinux@vger.kernel.org>);
        Tue, 18 Jan 2022 02:48:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 45C3468AFE; Tue, 18 Jan 2022 08:48:36 +0100 (CET)
Date:   Tue, 18 Jan 2022 08:48:36 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Vineet Gupta <vgupta@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Michal Simek <monstr@monstr.eu>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, openrisc@lists.librecores.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-arch@linux-xtensa.org,
        linux-kernel@linux-xtensa.org
Subject: architectures that still need to remove set_fs()
Message-ID: <20220118074836.GA20994@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Hi all,

you are in this list because your architecture still implements and
uses address space overrides using set_fs(), which are deprecated and
have been removed from all mainstream architecture ports.  To help
cleanup the core kernel it would be great to make progress on removing
set_fs entirely.

The following steps are required:

 (1) implement the __get_kernel_nofault and __put_kernel_nofault
     helper to access kernel memory without page faults, replacing
     the get/put_user under set_fs(KERNEL_DS) abuse.  Mips has a good
     example for a trivial implementation for architectures that use
     a common address space in commit 04324f44cb69
 (2) remove any architecture specific use of such constructs.  This
     only affects ia64 and sh.
 (3) stop selecting the SET_FS and remove all the set_fs-related
     infrastructure.  The above mips commit is a good guide once again.

Thanks!

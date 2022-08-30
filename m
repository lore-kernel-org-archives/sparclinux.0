Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AFC8ECAAA1
	for <sparclinux@archiver.kernel.org>; Tue, 30 Aug 2022 06:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiH3Gxd (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 30 Aug 2022 02:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiH3Gxc (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 30 Aug 2022 02:53:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC2EBD2A0;
        Mon, 29 Aug 2022 23:53:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4728D6146B;
        Tue, 30 Aug 2022 06:53:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14459C433D7;
        Tue, 30 Aug 2022 06:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661842410;
        bh=WZxYgPjZxU7c0eL5H4bK4Uo9kDBByWGt0wFQ+gNBmEk=;
        h=From:To:Cc:Subject:Date:From;
        b=nufhHi0HplC5xFdh2kg+QheRPNhIBp5dtQjaCmd+6ZPvzj08VHR5xtZboL753P4ny
         ai0R0O+TF4TCzz2Br11U8QeePHhqlTcZ3h920Rhfjbwtzc38HBKb0TqxiLzkSZf/4G
         b2jyRtmeyHeBjipaSz1J1M0jHE91/z1Ha6ALWyZA+o9OMd9mgpcsYTf1RN5ZCWTAk1
         XSzBPuOt0iojskPui2Stdz8tczdibVXbu5wVzb6EvkAbSJcv4vrQvW0t1wrlJVe7yp
         vImRZAIdL+vVqVqltFgWZrIPu3Vacn4cXi5FmD2j75nFwkYEivtVEZX7JOZ0Fsg9w3
         /AQ8KMH3fteqA==
From:   guoren@kernel.org
To:     oleg@redhat.com, vgupta@kernel.org, linux@armlinux.org.uk,
        monstr@monstr.eu, dinguyen@kernel.org, palmer@dabbelt.com,
        davem@davemloft.net, arnd@arndb.de, shorne@gmail.com,
        guoren@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-snps-arc@lists.infradead.org, sparclinux@vger.kernel.org,
        openrisc@lists.librecores.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 0/3] arch: ptrace: Cleanup ptrace_disable
Date:   Tue, 30 Aug 2022 02:53:13 -0400
Message-Id: <20220830065316.3924938-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This series cleanup ptrace_disable() in arch/*. Some architectures
are duplicate clearing SYSCALL TRACE.

Guo Ren (3):
  riscv: ptrace: Remove duplicate operation
  openrisc: ptrace: Remove duplicate operation
  arch: ptrace: Cleanup ptrace_disable

 arch/arc/kernel/ptrace.c        |  4 ----
 arch/arm/kernel/ptrace.c        |  8 --------
 arch/microblaze/kernel/ptrace.c |  5 -----
 arch/nios2/kernel/ptrace.c      |  5 -----
 arch/openrisc/kernel/ptrace.c   |  1 -
 arch/riscv/kernel/ptrace.c      |  5 -----
 arch/sparc/kernel/ptrace_32.c   | 10 ----------
 arch/sparc/kernel/ptrace_64.c   | 10 ----------
 kernel/ptrace.c                 |  8 ++++++++
 9 files changed, 8 insertions(+), 48 deletions(-)

-- 
2.36.1


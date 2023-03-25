Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1361C6FD20
	for <sparclinux@archiver.kernel.org>; Sat, 25 Mar 2023 06:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjCYGJx (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Sat, 25 Mar 2023 02:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbjCYGJg (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Sat, 25 Mar 2023 02:09:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06D196B7;
        Fri, 24 Mar 2023 23:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9497B825B3;
        Sat, 25 Mar 2023 06:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33E5C4339B;
        Sat, 25 Mar 2023 06:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679724561;
        bh=i1yTqNQJAv9j+hn+e6Je6fypgZ2V4l+VQdL1xKFdNt8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MMKlT72mhQ2PYx2QKkpW7HIAd5YEdN2UUzXyp5OPY+RVH81GJReBKAnOuYcH/8N4l
         WOHExhClj+i4GsKcl4zdXGJ/CprKpWL0bI5GpGBCxZyea7sKd2OIYtrtZiy90mx7iP
         0qHiAZsnOgHMoi72FY7hEINbeJBOh3/EeS8V3nvmVCzKqUV6n6DBCHHXTLE1AWz3Dq
         4GoZvWhAYCKBEXH9aJN/k8T3WtR2fD7HwWoTTYdoUdw7nbJQTNAsVr3z/1/BqnLANs
         D6+61HAH1iAjlONcqOhnWOyQ0JjCv+vYxkn4cq7lC62id+2QwXz/RT+SPOr7yLWLT2
         2GhWUJOebp2pw==
From:   Mike Rapoport <rppt@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S. Miller" <davem@davemloft.net>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guo Ren <guoren@kernel.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@kernel.org>, Rich Felker <dalias@libc.org>,
        Russell King <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Zi Yan <ziy@nvidia.com>, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        sparclinux@vger.kernel.org
Subject: [PATCH v3 05/14] ia64: don't allow users to override ARCH_FORCE_MAX_ORDER
Date:   Sat, 25 Mar 2023 09:08:19 +0300
Message-Id: <20230325060828.2662773-6-rppt@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230325060828.2662773-1-rppt@kernel.org>
References: <20230325060828.2662773-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

It is enough to keep default values for base and huge pages without
letting users to override ARCH_FORCE_MAX_ORDER.

Drop the prompt to make the option unvisible in *config.

Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/ia64/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
index 0d2f41fa56ee..b61437cae162 100644
--- a/arch/ia64/Kconfig
+++ b/arch/ia64/Kconfig
@@ -202,8 +202,7 @@ config IA64_CYCLONE
 	  If you're unsure, answer N.
 
 config ARCH_FORCE_MAX_ORDER
-	int "MAX_ORDER (10 - 16)"  if !HUGETLB_PAGE
-	range 10 16  if !HUGETLB_PAGE
+	int
 	default "16" if HUGETLB_PAGE
 	default "10"
 
-- 
2.35.1


Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4163EC433EF
	for <sparclinux@archiver.kernel.org>; Wed,  1 Jun 2022 18:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiFASaY (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 1 Jun 2022 14:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiFASaX (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 1 Jun 2022 14:30:23 -0400
X-Greylist: delayed 215 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Jun 2022 11:30:22 PDT
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBCC6C54F
        for <sparclinux@vger.kernel.org>; Wed,  1 Jun 2022 11:30:22 -0700 (PDT)
Received: from conuserg-07.nifty.com ([10.126.8.70])by condef-01.nifty.com with ESMTP id 251ILWsX004031
        for <sparclinux@vger.kernel.org>; Thu, 2 Jun 2022 03:21:32 +0900
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 251IJkAT014364;
        Thu, 2 Jun 2022 03:19:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 251IJkAT014364
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654107590;
        bh=DfGX9X9js5EY/zBCax8VTjZW98hEg7RezVbzqZYSm80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TrhCoTXNyAtPJa6Y2ejgBAgPaoUU7j4Z5bIlZUgcrwGbF7sziHBowTEPAW0FSU/8B
         jlK60LFQOvNd01klVlgxiRlTHim6jeyWqWarpqj4R75RoH1FAZu0ml7sXHv3bJ/V1K
         QRcm16WRYwCivH2VtJfXJ6ICEbrSzotkkAcFrqpAouiFa77VqQ0oVObzvheDql1XUS
         pJDGvMo90/aeJozhby91dsaznEnp0Smq5NjtMfJyR9BJFyNssCNbDzfEjf9oVNsn26
         ymlSjknZNbJWPOytAtzl3N8eigmyNp5XB0bKapapxwpgmHz5Jmsc66AKtyqrmEPer9
         FO/tD4mccBNnw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Carlos Llamas <cmllamas@google.com>,
        Christopher Ferris <cferris@google.com>,
        Todd Kjos <tkjos@android.com>, linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH 3/3] sparc: fix mis-use of __kernel_{uid,gid}_t in uapi/asm/stat.h
Date:   Thu,  2 Jun 2022 03:19:41 +0900
Message-Id: <20220601181941.3706832-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220601181941.3706832-1-masahiroy@kernel.org>
References: <20220601181941.3706832-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Commit 31a088b664d6 ("sparc: add asm/stat.h to UAPI compile-test
coverage") converted as follows:

  uid_t  -->  __kernel_uid_t
  gid_t  -->  __kernel_gid_t

It changed the field widths of struct stat because Sparc uses 16-bits for
___kernel_{uid,gid}_t as in arch/sparc/include/uapi/asm/posix_types.h.

The safe replacements across all architectures are:

  uid_t  -->  __kernel_uid32_t
  gid_t  -->  __kernel_gid32_t

as defined in include/linux/types.h.

A similar issue was reported for the android binder. [1]

[1]: https://lore.kernel.org/all/20220601010017.2639048-1-cmllamas@google.com/

Fixes: 31a088b664d6 ("sparc: add asm/stat.h to UAPI compile-test coverage")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/sparc/include/uapi/asm/stat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/uapi/asm/stat.h b/arch/sparc/include/uapi/asm/stat.h
index e03d6f8ec301..47f54133a141 100644
--- a/arch/sparc/include/uapi/asm/stat.h
+++ b/arch/sparc/include/uapi/asm/stat.h
@@ -11,8 +11,8 @@ struct stat {
 	__kernel_ino_t st_ino;
 	__kernel_mode_t st_mode;
 	short   st_nlink;
-	__kernel_uid_t st_uid;
-	__kernel_gid_t st_gid;
+	__kernel_uid32_t st_uid;
+	__kernel_gid32_t st_gid;
 	unsigned int st_rdev;
 	long    st_size;
 	long    st_atime;
-- 
2.32.0


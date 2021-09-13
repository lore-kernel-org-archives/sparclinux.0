Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EE2C433F5
	for <sparclinux@archiver.kernel.org>; Mon, 13 Sep 2021 16:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A9D260E8B
	for <sparclinux@archiver.kernel.org>; Mon, 13 Sep 2021 16:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbhIMQic (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Mon, 13 Sep 2021 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhIMQib (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Mon, 13 Sep 2021 12:38:31 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B1DC061574;
        Mon, 13 Sep 2021 09:37:15 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id i8-20020a056830402800b0051afc3e373aso14156650ots.5;
        Mon, 13 Sep 2021 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ngso0sgJ+i+JYyIISNmNFgwsXPFlrsWw/gNEDeNepj0=;
        b=Qj+J68GZ95IwZZNtLj5ziS3RW+e1DqCpZQ33KCesLHHH39MLjtmN+h0xBjok8s546w
         yR+/AZZ56ZoAxg/duqcQ/sWLC/XL54nxXtdEQP3vU2Ul9Lz8dFDegsfyKjvog4tK225u
         dyXcNdJp5oqTgXbGItxGQX7xrwKcJL7isMNqvpIJT+6VnvsbQGW0g7YLXymMIdM6jCiK
         x3l6zdvvIPRmSli2hPtTBc6Qid7UpFgzsn0d5g/J3SAhkeuiFWUxrs1O1jAP0qppgwQn
         N2w6F26GqT0yTgHoWpxzpDPlNAZ7sRHBHuLPn4gK98tLRkS1nHWwtm4hlb5mkiLxyd/5
         uQUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ngso0sgJ+i+JYyIISNmNFgwsXPFlrsWw/gNEDeNepj0=;
        b=M7wiMMk8VJDn5VbYXLP8Krc1fMCz5nI9lhQrVJzlyhX3LHMV4Zw/hWiczLyEU1FRQ/
         uy91RnfKJlUCPA0Ojetr0IIUEeac/MVUu5tfTYZpnfc8HwgX6XCGpIYcntB2xXoDY1qX
         uw6IQJSVa2iXdLtppyx96df0eqgjeovNyT3fH0xgUjh8mrm8Qx9oKdLeAMnKVaal4fny
         Ml2Akq9xrEFz+h5F7k5jcGghY3iiTAux5qmhgPZ2PlshomNwxLICJVaDSjBBolzydV4r
         GISf5Ntue1iPuIiuRCj2h+7e9JFzDCzFxBM0sEbHm8UkLmKTSkDyfu3bspYw2PmeMNkB
         Fv3A==
X-Gm-Message-State: AOAM533HRtK7cMBnvR/0nJK0Y5JTmQADNR+CEyEDK/1BdRarPPUYhAI8
        9kajxPAkz5akSM3mrKL9x9I=
X-Google-Smtp-Source: ABdhPJyl5y3kZU60Tj71/dBx8tJ74o9W1OjZSkykOUpxUP2EYzQsRUqnx5/DIpi4FiQL82aPbJrGxA==
X-Received: by 2002:a05:6830:2108:: with SMTP id i8mr10669500otc.336.1631551035114;
        Mon, 13 Sep 2021 09:37:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l21sm1961033oop.22.2021.09.13.09.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 09:37:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH] sparc: mdesc: Fix compile error seen with gcc 11.x
Date:   Mon, 13 Sep 2021 09:37:12 -0700
Message-Id: <20210913163712.922188-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

sparc64 images fail to compile with gcc 11.x, reporting the following
errors.

arch/sparc/kernel/mdesc.c:647:22: error:
	'strcmp' reading 1 or more bytes from a region of size 0
arch/sparc/kernel/mdesc.c:692:22: error:
	'strcmp' reading 1 or more bytes from a region of size 0
arch/sparc/kernel/mdesc.c:719:21:
	error: 'strcmp' reading 1 or more bytes from a region of size 0

The underlying problem is that node_block() returns a pointer beyond
the end of struct mdesc_hdr. gcc 11.x detects that and reports the error.
Adding an additional zero-length field to struct mdesc_hdr and pointing
to that field fixes the problem.

Cc: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
My apologies if a similar patch was submitted already; I was unable to find it.
I did find the following patch:
    https://git.busybox.net/buildroot/commit/?id=6e1106b4a9aee25d1556310d5cd1cb6dde2e6e3f
but I failed to find it in patchwork or on lore.kernel.org, and it
seems to be more expensive than the solution suggested here.

 arch/sparc/kernel/mdesc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 8e645ddac58e..c67bdcc23727 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -39,6 +39,7 @@ struct mdesc_hdr {
 	u32	node_sz; /* node block size */
 	u32	name_sz; /* name block size */
 	u32	data_sz; /* data block size */
+	char	data[0];
 } __attribute__((aligned(16)));
 
 struct mdesc_elem {
@@ -612,7 +613,7 @@ EXPORT_SYMBOL(mdesc_get_node_info);
 
 static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
 {
-	return (struct mdesc_elem *) (mdesc + 1);
+	return (struct mdesc_elem *) (mdesc->data);
 }
 
 static void *name_block(struct mdesc_hdr *mdesc)
-- 
2.33.0


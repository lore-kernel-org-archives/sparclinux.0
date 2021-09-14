Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9739AC433EF
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 22:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7706C60F9F
	for <sparclinux@archiver.kernel.org>; Tue, 14 Sep 2021 22:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbhINWsb (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 14 Sep 2021 18:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbhINWsb (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 14 Sep 2021 18:48:31 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3951BC061574;
        Tue, 14 Sep 2021 15:47:13 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id r26so1483592oij.2;
        Tue, 14 Sep 2021 15:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U71ZYWLeUYGsb2ZWR/vh55TR4X5quf+gNn2D15nmqy8=;
        b=qs3xPb482ZOjCFLIEbuQgSD5/oQzzTlaI3YsIpJH6NxLSE+lkBmqkCiC1W/kBn1vdo
         r3Y1Sufkq5D5CvkTSrlUI2J56zBP4owwNdHbGZvXmQq30PH1VclcM9Kr+lveqQB8kcQd
         bGVjBhj828gqZKWTNpXEzeQxT5hUvZdbC6WWDI6ys8f86ci0nbHiLYKzwKtZ1IACNt3X
         20h5Se6NrvgtJjzXBHCcnjtjFeWPDLoQP2Wc+diTD+KLKD5r318UbV1W6xNFtMOkQKv0
         OSMU+INNRtu8zb8wE1OMcBj7+NNajkvIBaU7pEZ9EBCudGpPwuYYpCIAaivLcacWlYB5
         rH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=U71ZYWLeUYGsb2ZWR/vh55TR4X5quf+gNn2D15nmqy8=;
        b=flRWByR3M4HbQ3eF07yl7/sS7iIXYYx4RW1J2wwoJqCNlab7leV5FcHvt78IVDC/lD
         3FF8wm8hvZxdekOQ8Y764czv0KT/XSXVhu5lK7gZrP4CJQCKCEJI7VIKMaNC9/evv9TR
         tcp6d1BdJiwLASnu59sAJlyvmUIoNF4VWba8/16qpB/4GRM5SAqR7JO+RFarZ+Jvf2JE
         FKgn4Wz8/aC2Y9e3YIrss4Z6tAuWZuiL10n1AZDDlbckgj6vT3OssBWqFbiCMnLvVGn1
         /021bikHq5M5Of8n8PsBQd0qScy3J/Xdbe3ZKkcxLWOzrxudzGj6UdqSPpi/zoC3xbbe
         ELzg==
X-Gm-Message-State: AOAM532lH/IY9CnJM4nG3dkd92G6PSJBNlPM3X3/iV5eQIInYsX+kz0R
        nAhh3aBkIFVSYdWA9+yXBpi5IsgFkOU=
X-Google-Smtp-Source: ABdhPJyem2PzCAqZw7otUsRf0pAwj2UhqxvfHjiY7lB9sr3qAdIYb+swAfqWLvh0K0mozsXmF1ZLwA==
X-Received: by 2002:aca:accd:: with SMTP id v196mr3266817oie.152.1631659632620;
        Tue, 14 Sep 2021 15:47:12 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t30sm2634402oiw.42.2021.09.14.15.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 15:47:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     "David S . Miller" <davem@davemloft.net>
Cc:     sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Anatoly Pugachev <matorola@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH v2] sparc: mdesc: Fix compile error seen with gcc 11.x
Date:   Tue, 14 Sep 2021 15:47:09 -0700
Message-Id: <20210914224709.601156-1-linux@roeck-us.net>
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
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Anatoly Pugachev <matorola@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: data[0] => data[]

I am not sure if there was agreement to accept this patch or not, but
I was asked to resend it with the above change, so here it is. An open
question was if it is acceptable to have a structure named xxx_hdr
include an element pointing to the data following that header.

If this patch is not acceptable, the patch in buildbot may be a possible
alternative to consider.
    https://git.busybox.net/buildroot/commit/?id=6e1106b4a9aee25d1556310d5cd1cb6dde2e6e3f

 arch/sparc/kernel/mdesc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 8e645ddac58e..83e1f699bc32 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -39,6 +39,7 @@ struct mdesc_hdr {
 	u32	node_sz; /* node block size */
 	u32	name_sz; /* name block size */
 	u32	data_sz; /* data block size */
+	char	data[];
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


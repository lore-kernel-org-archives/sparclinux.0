Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B94C433B4
	for <sparclinux@archiver.kernel.org>; Wed, 28 Apr 2021 21:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B70E461441
	for <sparclinux@archiver.kernel.org>; Wed, 28 Apr 2021 21:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhD1V3R (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 28 Apr 2021 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbhD1V3Q (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 28 Apr 2021 17:29:16 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC9EC06138B
        for <sparclinux@vger.kernel.org>; Wed, 28 Apr 2021 14:28:30 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l2so12270785wrm.9
        for <sparclinux@vger.kernel.org>; Wed, 28 Apr 2021 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB1n9TgJkNbeC3v1luMbvQBiuZVUZtRFDXC6KlfAZ9I=;
        b=HJj5uDq/q3MJSPkYnaaQAtGlXDytAc4ze4C3T53Wim67nEVUvSh1hC8vIKo8j8Lpcf
         eNvTeEsiDl4NnK45J8C4coz10XPzJm5GilGnQD4m/cFsinZHWtNUaTyrOHKlVVP5+kzz
         aDCZbMCAxP7ryxaBYvx7AdkSJ1twJRk0gMc95uF6Pyv2OycTwY6f8cXIKqeh8q1AnaE+
         bB42N1ScMAwuLcMLt/WU2YhqIm9ubCjqmfNwxKV5hH+/iUJt+K3S6qcCozcN+9u2+app
         i8AtMi8ALjfWBU4M8xeGmgUuY58hDZGawLXAIBCFYeOkf3Gr75cm95bYSUUxMj3NkvVE
         MsvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AB1n9TgJkNbeC3v1luMbvQBiuZVUZtRFDXC6KlfAZ9I=;
        b=C5uJc9qXgcJ37k+2X09Cs5vZi+E5u8SpCMpG7yhGypZWsONeY+trek+fTPSCLWWwPp
         MMOPZFInDn4dnrbFzmoYGiO0vRevaC/ss/jKJTd156uBSgcFXT3M0APDSzWcs0UOcRkz
         DUoaq/E78PNmBsJxEVRJ24gJW5mjEsSewSpzvG0gTna/REsyfvmSsvVL8KMhlUfpKyi6
         lNHZfpCtZMW2kmDT5rLzmhK5AObuFx9Y4z9kvYkecMmJTJRyYfqxHsBlyztx4DoGiH0z
         rhmw9ShBbd0qtgyZU8V40gzbzQEWr8gPqdQ9JAKCNWteR93r2f3ZlxHzQoiJXw0yMOv+
         zXsQ==
X-Gm-Message-State: AOAM532ypb9szlFFkkbv80jJJAgDKSEEhX4xBtIouZ42x6GtW97rE7TF
        lFr0TtQ10GZr07aJEIFoUx4cHvg6gZ4=
X-Google-Smtp-Source: ABdhPJzhFeT3HEfiu/SXnN3GgjenroT0G3ihbmrFR14xErjkngRRLXg0imXL0eXHuXXLJloJteK8UA==
X-Received: by 2002:a5d:6885:: with SMTP id h5mr31438356wru.229.1619645309019;
        Wed, 28 Apr 2021 14:28:29 -0700 (PDT)
Received: from localhost.localdomain (2a01cb058f8a180002e04cfffe680084.ipv6.abo.wanadoo.fr. [2a01:cb05:8f8a:1800:2e0:4cff:fe68:84])
        by smtp.gmail.com with ESMTPSA id 3sm9804333wma.45.2021.04.28.14.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 14:28:28 -0700 (PDT)
From:   Romain Naour <romain.naour@gmail.com>
To:     sparclinux@vger.kernel.org
Cc:     Romain Naour <romain.naour@gmail.com>
Subject: [PATCH] sparc64: avoid stringop-overread warning to access Machine description datas
Date:   Wed, 28 Apr 2021 23:28:23 +0200
Message-Id: <20210428212823.3741332-1-romain.naour@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

gcc-11 warns about what appears to be an out-of-range array access but
stop the build due to -Werror added to cflags:

arch/sparc/kernel/mdesc.c: In function 'mdesc_node_by_name':
arch/sparc/kernel/mdesc.c:647:22: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
  647 |                 if (!strcmp(names + ep[ret].name_offset, name))
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/sparc/kernel/mdesc.c:77:33: note: at offset 16 into source object 'mdesc' of size 16
   77 |         struct mdesc_hdr        mdesc;
      |                                 ^~~~~
arch/sparc/kernel/mdesc.c: In function 'mdesc_get_property':
arch/sparc/kernel/mdesc.c:692:22: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
  692 |                 if (!strcmp(names + ep->name_offset, name)) {
      |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/sparc/kernel/mdesc.c:77:33: note: at offset 16 into source object 'mdesc' of size 16
   77 |         struct mdesc_hdr        mdesc;
      |                                 ^~~~~
arch/sparc/kernel/mdesc.c: In function 'mdesc_next_arc':
arch/sparc/kernel/mdesc.c:719:21: error: 'strcmp' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
  719 |                 if (strcmp(names + ep->name_offset, arc_type))
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
arch/sparc/kernel/mdesc.c:77:33: note: at offset 16 into source object 'mdesc' of size 16
   77 |         struct mdesc_hdr        mdesc;
      |                                 ^~~~~
cc1: all warnings being treated as errors

The issue was initially reported to gcc [1] where it was analized.
As suggested, change the struct mdesc_elem * accesses from the end
of mdesc to those from the beginning of the data array.

Update the prototype of node_block(), name_block() and data_block()
since the code really seems to want to do is to compute the address
somewhere into the chunk pointed to by hp.

[1] https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100262

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 arch/sparc/kernel/mdesc.c | 37 +++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 16 deletions(-)

diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 8e645ddac58e..3403555aa1e2 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -75,6 +75,7 @@ struct mdesc_handle {
 	refcount_t		refcnt;
 	unsigned int		handle_size;
 	struct mdesc_hdr	mdesc;
+	char			data[];
 };
 
 typedef int (*mdesc_node_info_get_f)(struct mdesc_handle *, u64,
@@ -610,26 +611,30 @@ int mdesc_get_node_info(struct mdesc_handle *hp, u64 node,
 }
 EXPORT_SYMBOL(mdesc_get_node_info);
 
-static struct mdesc_elem *node_block(struct mdesc_hdr *mdesc)
+static struct mdesc_elem *node_block(struct mdesc_handle *hp)
 {
-	return (struct mdesc_elem *) (mdesc + 1);
+	return (struct mdesc_elem *) hp + offsetof(struct mdesc_handle, data);
 }
 
-static void *name_block(struct mdesc_hdr *mdesc)
+static void *name_block(struct mdesc_handle *hp)
 {
-	return ((void *) node_block(mdesc)) + mdesc->node_sz;
+	struct mdesc_hdr *mdesc = &hp->mdesc;
+
+	return ((void *) node_block(hp)) + mdesc->node_sz;
 }
 
-static void *data_block(struct mdesc_hdr *mdesc)
+static void *data_block(struct mdesc_handle *hp)
 {
-	return ((void *) name_block(mdesc)) + mdesc->name_sz;
+	struct mdesc_hdr *mdesc = &hp->mdesc;
+
+	return ((void *) name_block(hp)) + mdesc->name_sz;
 }
 
 u64 mdesc_node_by_name(struct mdesc_handle *hp,
 		       u64 from_node, const char *name)
 {
-	struct mdesc_elem *ep = node_block(&hp->mdesc);
-	const char *names = name_block(&hp->mdesc);
+	struct mdesc_elem *ep = node_block(hp);
+	const char *names = name_block(hp);
 	u64 last_node = hp->mdesc.node_sz / 16;
 	u64 ret;
 
@@ -657,15 +662,15 @@ EXPORT_SYMBOL(mdesc_node_by_name);
 const void *mdesc_get_property(struct mdesc_handle *hp, u64 node,
 			       const char *name, int *lenp)
 {
-	const char *names = name_block(&hp->mdesc);
+	const char *names = name_block(hp);
 	u64 last_node = hp->mdesc.node_sz / 16;
-	void *data = data_block(&hp->mdesc);
+	void *data = data_block(hp);
 	struct mdesc_elem *ep;
 
 	if (node == MDESC_NODE_NULL || node >= last_node)
 		return NULL;
 
-	ep = node_block(&hp->mdesc) + node;
+	ep = node_block(hp) + node;
 	ep++;
 	for (; ep->tag != MD_NODE_END; ep++) {
 		void *val = NULL;
@@ -702,8 +707,8 @@ EXPORT_SYMBOL(mdesc_get_property);
 
 u64 mdesc_next_arc(struct mdesc_handle *hp, u64 from, const char *arc_type)
 {
-	struct mdesc_elem *ep, *base = node_block(&hp->mdesc);
-	const char *names = name_block(&hp->mdesc);
+	struct mdesc_elem *ep, *base = node_block(hp);
+	const char *names = name_block(hp);
 	u64 last_node = hp->mdesc.node_sz / 16;
 
 	if (from == MDESC_NODE_NULL || from >= last_node)
@@ -728,7 +733,7 @@ EXPORT_SYMBOL(mdesc_next_arc);
 
 u64 mdesc_arc_target(struct mdesc_handle *hp, u64 arc)
 {
-	struct mdesc_elem *ep, *base = node_block(&hp->mdesc);
+	struct mdesc_elem *ep, *base = node_block(hp);
 
 	ep = base + arc;
 
@@ -738,8 +743,8 @@ EXPORT_SYMBOL(mdesc_arc_target);
 
 const char *mdesc_node_name(struct mdesc_handle *hp, u64 node)
 {
-	struct mdesc_elem *ep, *base = node_block(&hp->mdesc);
-	const char *names = name_block(&hp->mdesc);
+	struct mdesc_elem *ep, *base = node_block(hp);
+	const char *names = name_block(hp);
 	u64 last_node = hp->mdesc.node_sz / 16;
 
 	if (node == MDESC_NODE_NULL || node >= last_node)
-- 
2.30.2


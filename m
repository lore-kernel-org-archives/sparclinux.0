Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1294EB64DA
	for <sparclinux@archiver.kernel.org>; Tue, 18 Jul 2023 08:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjGRI5Q (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 18 Jul 2023 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjGRI5P (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 18 Jul 2023 04:57:15 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CDB5
        for <sparclinux@vger.kernel.org>; Tue, 18 Jul 2023 01:57:13 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4t9v0Y8YzBQslb
        for <sparclinux@vger.kernel.org>; Tue, 18 Jul 2023 16:57:07 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689670626; x=1692262627; bh=faAI8ptA2c2nH0hKDuk1VCV5xnu
        S7/IGCMtQQ1GTXlE=; b=TtVDTgGquScTUBLq4YYjS9kBjFO1xknH85dilDQUSxq
        zBOBoMzDyrJ1Io+TVYv9rn4ISfo2TPdMBYH3NobqqLooDsCai3Fym27NUPvMc3rI
        JxdhdPxturrF8tKtNmuDQ1TrF4T8wKCyePaY5iDzGiV+BHVcwrjKoKMHT2RjB5t8
        U3XPyrNShtOgFH6snB4Kap6aQrZfCaySTJeFuJ1GGAf86qTkGU+FHGwFRv1G/Alw
        HEBPdXMef7RXb0IZQAgJvqnNcC9oxTM/mFObuqlIC2kIsp+4RqGVrUdbgGYG8Zk0
        WurqtpPtr9LF5jEQru78SNB623vm+zORuzJZx9rPZsw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PyL70ccFc7bA for <sparclinux@vger.kernel.org>;
        Tue, 18 Jul 2023 16:57:06 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4t9t6NxSzBJBfd;
        Tue, 18 Jul 2023 16:57:06 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 16:57:06 +0800
From:   sunran001@208suo.com
To:     davem@davemloft.net
Cc:     sparclinux@vger.kernel.org
Subject: [PATCH] sparc: add missing put_device()
In-Reply-To: <20230718085619.17403-1-xujianghui@cdjrlc.com>
References: <20230718085619.17403-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <19b84a97cb5487c22fcd3cc232abe860@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The of_find_device_by_node() takes a reference to the underlying device
structure, we should release that reference.

./arch/sparc/kernel/of_device_common.c:36:1-7: ERROR: missing
put_device; call of_find_device_by_node on line 30, but without a
corresponding object release within this function.
./arch/sparc/kernel/of_device_common.c:50:1-7: ERROR: missing
put_device; call of_find_device_by_node on line 42, but without a
corresponding object release within this function.

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/sparc/kernel/of_device_common.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/of_device_common.c 
b/arch/sparc/kernel/of_device_common.c
index 7851307de6d0..5e9847d0fbed 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -33,8 +33,8 @@ int of_address_to_resource(struct device_node *node, 
int index,
      if (!op || index >= op->num_resources)
          return -EINVAL;

-    put_device(op->dev);
      memcpy(r, &op->archdata.resource[index], sizeof(*r));
+    put_device(op->dev);
      return 0;
  }
  EXPORT_SYMBOL_GPL(of_address_to_resource);
@@ -47,8 +47,8 @@ void __iomem *of_iomap(struct device_node *node, int 
index)
      if (!op || index >= op->num_resources)
          return NULL;

-    put_device(op->dev);
      r = &op->archdata.resource[index];
+    put_device(op->dev);

      return of_ioremap(r, 0, resource_size(r), (char *) r->name);
  }

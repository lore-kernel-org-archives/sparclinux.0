Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42340C43334
	for <sparclinux@archiver.kernel.org>; Tue,  5 Jul 2022 13:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiGENtG (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 5 Jul 2022 09:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiGENsp (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 5 Jul 2022 09:48:45 -0400
Received: from mail-m963.mail.126.com (mail-m963.mail.126.com [123.126.96.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B9D412D1F
        for <sparclinux@vger.kernel.org>; Tue,  5 Jul 2022 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NmKwH
        V1L2jQvLWOXtBPIUiUaGLMX0dKxbY5xqonZg18=; b=DOxjPq9pdM7TqEyU5CQbS
        nHYivkB/FLDlPF9VkHJ2EY/ODfGvX73XwofqHtQgexN72OJ3vRdFAdbEfGvTe4iS
        9SFhZOyJRCUoMhRzxXGxqBlvdhMO64D6z8tp3iu4imLDSpV90lcImdBerROczLP9
        Lm3jYidQOrawkVmzio2t5o=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp8 (Coremail) with SMTP id NORpCgDndYI8OsRijukcHQ--.45984S2;
        Tue, 05 Jul 2022 21:18:54 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, sparclinux@vger.kernel.org, windhl@126.com
Subject: [PATCH] sparc: vio: Add refcount when a new reference is created
Date:   Tue,  5 Jul 2022 21:18:52 +0800
Message-Id: <20220705131852.296710-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NORpCgDndYI8OsRijukcHQ--.45984S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Zr4ktF1xKFy7Jw4xCr4rZrb_yoW8Aw1Dp3
        92kF9IvFyxGr1SkrZ0vF48ua4F9F1xtw48JrWYgFyrKrn8XFy0yw1jgryFqrn5ZFWrCw4Y
        qw4qqF4fX3WUW3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRt3kNUUUUU=
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi3Bw1F1pED3VkCwABso
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In vio_create_one(), when a new reference of 'device_node' is created
into 'vdev->dp', we should call of_node_get(). Besides, we should also
call of_node_put() before the 'vdev' is freed in fail path.

NOTE: As the for_each_child_of_node() will automatically increase and
decrease the refcount, it needs no more refcounting for the new
reference.

Signed-off-by: Liang He <windhl@126.com>
---
 arch/sparc/kernel/vio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 01122a208f94..10441a7ef976 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -362,16 +362,17 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 	vdev->dev.release = vio_dev_release;
 
 	if (parent == NULL) {
-		dp = cdev_node;
+		vdev->dp = of_node_get(cdev_node);
 	} else if (to_vio_dev(parent) == root_vdev) {
 		for_each_child_of_node(cdev_node, dp) {
-			if (of_node_is_type(dp, type))
+			if (of_node_is_type(dp, type)) {
+				vdev->dp = dp;
 				break;
+			}
 		}
 	} else {
-		dp = to_vio_dev(parent)->dp;
+		vdev->dp = of_node_get(to_vio_dev(parent)->dp);
 	}
-	vdev->dp = dp;
 
 	/*
 	 * node_name is NULL for the parent/channel-devices node and
@@ -386,6 +387,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 		if (err) {
 			pr_err("VIO: Could not get MD node info %s, err=%d\n",
 			       dev_name(&vdev->dev), err);
+			of_node_put(vdev->dp);
 			kfree(vdev);
 			return NULL;
 		}
@@ -398,6 +400,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 	if (err) {
 		printk(KERN_ERR "VIO: Could not register device %s, err=%d\n",
 		       dev_name(&vdev->dev), err);
+		of_node_put(vdev->dp);
 		put_device(&vdev->dev);
 		return NULL;
 	}
-- 
2.25.1


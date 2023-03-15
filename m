Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD454C61DA4
	for <sparclinux@archiver.kernel.org>; Wed, 15 Mar 2023 06:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjCOGMj (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Wed, 15 Mar 2023 02:12:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjCOGMi (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Wed, 15 Mar 2023 02:12:38 -0400
Received: from m126.mail.126.com (m126.mail.126.com [220.181.12.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFB015B437
        for <sparclinux@vger.kernel.org>; Tue, 14 Mar 2023 23:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=4eVdg
        adZcZyTlgv+0LHbZ4uwJ3CJ2/c/Zv/Sg9YnZ2Q=; b=MqR3UCLUF31R7QY70L1+9
        DjNsr6AxbICB7E4ShmQdalw6/aR8zdXor+NzOkJUcf4w1ro6wQ3dne9WnziHvo5U
        +3Vxk4r59sNSaumGYXyGPoe5xOYeuiyVn5Zic+QO2aSOW96r6iqDXeCbGej2rD0K
        r6JgrRqr2Vnt3nER/V1rWM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wBHFdSKYRFkOw11AA--.41981S2;
        Wed, 15 Mar 2023 14:11:22 +0800 (CST)
From:   Liang He <windhl@126.com>
To:     davem@davemloft.net, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, sparclinux@vger.kernel.org, windhl@126.com
Subject: [PATCH] tty: vcc: add check for mdesc_grab()
Date:   Wed, 15 Mar 2023 14:11:21 +0800
Message-Id: <20230315061121.1741454-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBHFdSKYRFkOw11AA--.41981S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1fGF4UWF1fAFy3uF18uFg_yoW3AFg_Ca
        12v34xZF1kur1rJrn0kr4fZrW0va1DZF1rZrnYv3sxZrWUZrn7XFyqvrnrGw17WrWrArW8
        trZ7try3CF1vgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUUyrW3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/1tbi5g4zF2IxlP12ywAAsL
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

In vcc_probe(), we should check the return value of
mdesc_grab() as it may return NULL. While the
vio_vdev_node() has the NULL-check, but if there
is still a call to mdesc_release() which may cause
a NPD bug.

Fixes: 5d171050e28f ("sparc64: vcc: Enable VCC port probe and removal")
Signed-off-by: Liang He <windhl@126.com>
---
 drivers/tty/vcc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 34ba6e54789a..e3ba63d0a91f 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -610,6 +610,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 
 	hp = mdesc_grab();
 
+	if (!hp)
+		return -ENODEV;
+
 	node = vio_vdev_node(hp, vdev);
 	if (node == MDESC_NODE_NULL) {
 		rv = -ENXIO;
-- 
2.25.1


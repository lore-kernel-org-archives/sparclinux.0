Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C527C04E83
	for <sparclinux@archiver.kernel.org>; Tue,  7 Nov 2023 23:24:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbjKGXYg (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 7 Nov 2023 18:24:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344485AbjKGXYX (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 7 Nov 2023 18:24:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAF41BCB;
        Tue,  7 Nov 2023 15:23:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9CA2C433C9;
        Tue,  7 Nov 2023 23:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699399416;
        bh=cBMEzm+BNyVJfpDMzEbm3zZpZXgxa4o8L43ZidS4czI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EwvhYqW5clS7YGtRytae7sEzs44cnmCgfvhJmo/uYbrrBfCPUsPXxqUcX370L+Dok
         8v1q6TwyGAlygr97Qju9S6I1Gc31DXGKGw8+jpP+wnvc0/JVuQKLnECi8Y+x3MZhwk
         BF+eoFIZ5EYIY7Sq+hmHEANaP/e9wrBYDEpV9cohDdDR809Xp7SsShbOBt4ZSZZ/Ev
         MtHjYgx98bjWMavtC83rcueJU6SEFlZ2D3XpCo67EkouvPuiDgpPqprqrwewnQMyh8
         QvZaG2kiE5ebLNkqPMWo7E+Jta2ml/0vWFyrLcVYfb8+L8kIn35n/+8pM32aH1zQJA
         0pAfinBjYoB1Q==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Yi Yang <yiyang13@huawei.com>, Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        sparclinux@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 03/18] tty: vcc: Add check for kstrdup() in vcc_probe()
Date:   Tue,  7 Nov 2023 18:22:58 -0500
Message-ID: <20231107232330.3776001-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232330.3776001-1-sashal@kernel.org>
References: <20231107232330.3776001-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.10
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

From: Yi Yang <yiyang13@huawei.com>

[ Upstream commit d81ffb87aaa75f842cd7aa57091810353755b3e6 ]

Add check for the return value of kstrdup() and return the error, if it
fails in order to avoid NULL pointer dereference.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20230904035220.48164-1-yiyang13@huawei.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vcc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 34ba6e54789a7..b8b832c75b856 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -579,18 +579,22 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		return -ENOMEM;
 
 	name = kstrdup(dev_name(&vdev->dev), GFP_KERNEL);
+	if (!name) {
+		rv = -ENOMEM;
+		goto free_port;
+	}
 
 	rv = vio_driver_init(&port->vio, vdev, VDEV_CONSOLE_CON, vcc_versions,
 			     ARRAY_SIZE(vcc_versions), NULL, name);
 	if (rv)
-		goto free_port;
+		goto free_name;
 
 	port->vio.debug = vcc_dbg_vio;
 	vcc_ldc_cfg.debug = vcc_dbg_ldc;
 
 	rv = vio_ldc_alloc(&port->vio, &vcc_ldc_cfg, port);
 	if (rv)
-		goto free_port;
+		goto free_name;
 
 	spin_lock_init(&port->lock);
 
@@ -624,6 +628,11 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 		goto unreg_tty;
 	}
 	port->domain = kstrdup(domain, GFP_KERNEL);
+	if (!port->domain) {
+		rv = -ENOMEM;
+		goto unreg_tty;
+	}
+
 
 	mdesc_release(hp);
 
@@ -653,8 +662,9 @@ static int vcc_probe(struct vio_dev *vdev, const struct vio_device_id *id)
 	vcc_table_remove(port->index);
 free_ldc:
 	vio_ldc_free(&port->vio);
-free_port:
+free_name:
 	kfree(name);
+free_port:
 	kfree(port);
 
 	return rv;
-- 
2.42.0


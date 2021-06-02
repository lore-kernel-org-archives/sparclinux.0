Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D3FC47080
	for <sparclinux@archiver.kernel.org>; Wed,  2 Jun 2021 01:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8117613BD
	for <sparclinux@archiver.kernel.org>; Wed,  2 Jun 2021 01:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFBBus (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 1 Jun 2021 21:50:48 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6127 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbhFBBur (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 1 Jun 2021 21:50:47 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvsLz6L99zYpmR;
        Wed,  2 Jun 2021 09:46:19 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:49:02 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 2 Jun 2021 09:49:01 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 1/1] sparc64: vcc: use DEVICE_ATTR_*() macro
Date:   Wed, 2 Jun 2021 09:48:39 +0800
Message-ID: <20210602014839.10587-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

Use DEVICE_ATTR_*() macro helper instead of plain DEVICE_ATTR, which makes
the code a bit shorter and easier to read.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/tty/vcc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 0355f4579ecf203..d06bcc3b4c07762 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -473,9 +473,9 @@ static struct vio_version vcc_versions[] = {
 
 static struct tty_port_operations vcc_port_ops = { 0 };
 
-static ssize_t vcc_sysfs_domain_show(struct device *dev,
-				     struct device_attribute *attr,
-				     char *buf)
+static ssize_t domain_show(struct device *dev,
+			   struct device_attribute *attr,
+			   char *buf)
 {
 	struct vcc_port *port;
 	int rv;
@@ -505,9 +505,9 @@ static int vcc_send_ctl(struct vcc_port *port, int ctl)
 	return rv;
 }
 
-static ssize_t vcc_sysfs_break_store(struct device *dev,
-				     struct device_attribute *attr,
-				     const char *buf, size_t count)
+static ssize_t break_store(struct device *dev,
+			   struct device_attribute *attr,
+			   const char *buf, size_t count)
 {
 	struct vcc_port *port;
 	unsigned long flags;
@@ -530,8 +530,8 @@ static ssize_t vcc_sysfs_break_store(struct device *dev,
 	return rv;
 }
 
-static DEVICE_ATTR(domain, 0400, vcc_sysfs_domain_show, NULL);
-static DEVICE_ATTR(break, 0200, NULL, vcc_sysfs_break_store);
+static DEVICE_ATTR_ADMIN_RO(domain);
+static DEVICE_ATTR_WO(break);
 
 static struct attribute *vcc_sysfs_entries[] = {
 	&dev_attr_domain.attr,
-- 
2.26.0.106.g9fadedd



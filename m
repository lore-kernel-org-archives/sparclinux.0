Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47512C04A95
	for <sparclinux@archiver.kernel.org>; Fri, 10 Nov 2023 17:44:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345895AbjKJRob (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 10 Nov 2023 12:44:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbjKJRny (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 10 Nov 2023 12:43:54 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7C3A8BA
        for <sparclinux@vger.kernel.org>; Fri, 10 Nov 2023 07:30:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006UG-4n; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0083Le-EO; Fri, 10 Nov 2023 16:30:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-00Gnxv-4B; Fri, 10 Nov 2023 16:30:49 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 47/52] serial: sunzilog: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:15 +0100
Message-ID: <20231110152927.70601-48-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1891; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=ojzyZIP8zF6K2DNhtlOtgImARvRZldsIavtDnrpT8Wg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyT9pPYdGOuXsE2mftrIDFjA2NX7qf3MYJzZ gXNnl/P6eKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MkwAKCRCPgPtYfRL+ TqwXB/9sVWYIfEjfSc7k1cFD1xLERa/PUMr8YfKawkOTlH5t6OyEIcbiS2hVu5DAFUhzNN35Mzj rQCC/45DUbJO3r4uCvYtF9WSvkxjfAY8FFzEo7vuQpRMv3TINXz5Bo4K/kewBIVJPoCWewOyRlH nsSgXewJhbrl+/9OCbSO+0hoR7lfTmG+WrQ7T11xTKKzCmCUYfw9qgAVHiCNFMdgt+C48FwFuCT bf1FzJepKnZ7+kVtxL2bI7eOpHlVEdEw2az5sUEYuJl9FPBoQthIcZ5YSZ01OMnwKLEH/xHUdeC raGPcyTUWccJUVe31YavFXsDfyv6TClut/HGmzQ5EKYlLyaM
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/tty/serial/sunzilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index d3b5e864b727..c99289c6c8f8 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1513,7 +1513,7 @@ static void zs_remove_one(struct uart_sunzilog_port *up)
 		uart_remove_one_port(&sunzilog_reg, &up->port);
 }
 
-static int zs_remove(struct platform_device *op)
+static void zs_remove(struct platform_device *op)
 {
 	struct uart_sunzilog_port *up = platform_get_drvdata(op);
 	struct zilog_layout __iomem *regs;
@@ -1523,8 +1523,6 @@ static int zs_remove(struct platform_device *op)
 
 	regs = sunzilog_chip_regs[up[0].port.line / 2];
 	of_iounmap(&op->resource[0], regs, sizeof(struct zilog_layout));
-
-	return 0;
 }
 
 static const struct of_device_id zs_match[] = {
@@ -1541,7 +1539,7 @@ static struct platform_driver zs_driver = {
 		.of_match_table = zs_match,
 	},
 	.probe		= zs_probe,
-	.remove		= zs_remove,
+	.remove_new	= zs_remove,
 };
 
 static int __init sunzilog_init(void)
-- 
2.42.0


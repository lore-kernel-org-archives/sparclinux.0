Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C16ADC4332F
	for <sparclinux@archiver.kernel.org>; Fri, 10 Nov 2023 21:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbjKJVCo (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 10 Nov 2023 16:02:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235839AbjKJVC0 (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 10 Nov 2023 16:02:26 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09933A8B9
        for <sparclinux@vger.kernel.org>; Fri, 10 Nov 2023 07:30:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006Tc-4o; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT7-0083La-6T; Fri, 10 Nov 2023 16:30:49 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-00Gnxr-Tj; Fri, 10 Nov 2023 16:30:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 46/52] serial: sunsu: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:14 +0100
Message-ID: <20231110152927.70601-47-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=bJvr6ajvc8acvcU6LpWDvOv5tO3tdCW3m+BAMBN9sSk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkySfFl2F/BTiBQOkgUXRv47nPJftRH90peJI DfvmZmIeAOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MkgAKCRCPgPtYfRL+ TnN7B/wLODkAOPQCFWUj4zF150l4kwLErWUwDX15OAohX+Bjvr3cvggKOwDd1eqQJyfRh2Aq3qd 0gtrGa09D2onXpxFGJU9gHHfCV73uttZTYRdbLqibO+mn88rJVLq+1GOZHnC3Ack3giSB4wqSs3 mExxuWH/y6zzdP7xViHRWx8v+dp48hKXcAwZXSLkPRRFvBmBss3omhCsdDvAtHyZQs0N8OGsNcE 6EpxsX4c8XIYx7USAYj2IJL3pf2+jY/A+8Dd7nBFcteFiCyWKX8Q6c8dMwl8IohKBBfogrsNjty VQzAvv3PfFA9hEzW6dIrTvJvmdPC5eAVqniqgA7/GRmi78VV
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
 drivers/tty/serial/sunsu.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 1e051cc2591c..c8b65f4b2710 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -1515,7 +1515,7 @@ static int su_probe(struct platform_device *op)
 	return err;
 }
 
-static int su_remove(struct platform_device *op)
+static void su_remove(struct platform_device *op)
 {
 	struct uart_sunsu_port *up = platform_get_drvdata(op);
 	bool kbdms = false;
@@ -1536,8 +1536,6 @@ static int su_remove(struct platform_device *op)
 
 	if (kbdms)
 		kfree(up);
-
-	return 0;
 }
 
 static const struct of_device_id su_match[] = {
@@ -1565,7 +1563,7 @@ static struct platform_driver su_driver = {
 		.of_match_table = su_match,
 	},
 	.probe		= su_probe,
-	.remove		= su_remove,
+	.remove_new	= su_remove,
 };
 
 static int __init sunsu_init(void)
-- 
2.42.0


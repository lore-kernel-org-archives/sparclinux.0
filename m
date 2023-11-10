Return-Path: <sparclinux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C0B5C05021
	for <sparclinux@archiver.kernel.org>; Fri, 10 Nov 2023 18:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345229AbjKJS1U (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Fri, 10 Nov 2023 13:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345981AbjKJSZz (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Fri, 10 Nov 2023 13:25:55 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2B03A8B7
        for <sparclinux@vger.kernel.org>; Fri, 10 Nov 2023 07:30:54 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT8-0006SM-4n; Fri, 10 Nov 2023 16:30:50 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-0083LP-Ke; Fri, 10 Nov 2023 16:30:48 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1r1TT6-00Gnxf-Bo; Fri, 10 Nov 2023 16:30:48 +0100
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, kernel@pengutronix.de,
        linux-serial@vger.kernel.org
Subject: [PATCH 43/52] serial: sunhv: Convert to platform remove callback returning void
Date:   Fri, 10 Nov 2023 16:30:11 +0100
Message-ID: <20231110152927.70601-44-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0.586.gbc5204569f7d.dirty
In-Reply-To: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
References: <20231110152927.70601-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1725; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=llndtvlKuh3KenmDXutZJxZei+wBMkW9I6d29pO6t4Q=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlTkyOFAZRC74BYIIXMCeykZ+4CQ2UN45XQcdcz ijLPRVQ+2SJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZU5MjgAKCRCPgPtYfRL+ TpZ/B/9CXQUxFkrIPFIC7Z0K6nLkI2cQC18Iq6UXAI6H66l2+IqcnCy08CJucrU+LqrNxycYVF5 5MKnngAPOJnfGEwEqJk9hI8QpWufgE6I8siCTRi6zNvVsEBiN77PaHRC794NuYRhirOTRiK5SWh yI50+e40KwTAISyJo9/VuNLPJHXtLbG3EajbGDTRik08n72NGr4WvTBNQVn2C2I0+1xe5pv9yl3 dUMslDER0wSodyOhH3tkizuQxCdZ56y3AlBBH0J9HO9N+pETtMkzB33JN3DWVk1svWCqcRu+z4W Vhe1y7TnQWZmb3qavqCZcXip+7oqi32HOwjQKiB8UElQKhlB
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
 drivers/tty/serial/sunhv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 5bfc0040f17b..8d612ab80680 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -595,7 +595,7 @@ static int hv_probe(struct platform_device *op)
 	return err;
 }
 
-static int hv_remove(struct platform_device *dev)
+static void hv_remove(struct platform_device *dev)
 {
 	struct uart_port *port = platform_get_drvdata(dev);
 
@@ -608,8 +608,6 @@ static int hv_remove(struct platform_device *dev)
 	kfree(con_write_page);
 	kfree(port);
 	sunhv_port = NULL;
-
-	return 0;
 }
 
 static const struct of_device_id hv_match[] = {
@@ -630,7 +628,7 @@ static struct platform_driver hv_driver = {
 		.of_match_table = hv_match,
 	},
 	.probe		= hv_probe,
-	.remove		= hv_remove,
+	.remove_new	= hv_remove,
 };
 
 static int __init sunhv_init(void)
-- 
2.42.0


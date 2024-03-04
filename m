Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A16D33CD1
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591443; cv=none; b=uOnHcd4fa6ptsotS3QtbEnH2sbcXqOY0rFCPD8eQcOC/xvYoM1iqBjyM5FTSXssp2js8eF33v2llLyj1YwqocoOWL9mdK0LyKQHuZ9rBh/tCnBdacGBTenJegWom0agMYZVObfhWvVfOFSPQTRC2LDnyGLTs7xrQuvcvBrNWKZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591443; c=relaxed/simple;
	bh=IXSRArmHBgUvyx2LKQTiYc/LS+CtwpTLFKSu3H4cqdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgdF/GZWV/eNuiPJKFHWplbIAmdSvfMBV8BIysPdLn22upP/yBjkMHxwA0OCTpiz1ZvLlhd7luQl9YlFV6RaoeYtcMHIWQOLyCFqmOG3SY/FRGi6hlAkQoER8e0VEGRxlVuEIwZb+t8ayzGnqTxHVmlE5GM75VWsYGPNOUQ5PUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00072j-Cy; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-004RAe-P3; Mon, 04 Mar 2024 23:30:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-00H7IN-2D;
	Mon, 04 Mar 2024 23:30:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 3/6] sbus: display7seg: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 23:30:10 +0100
Message-ID:  <dc10c77a6ababab6ffdb344982e8a04cc337bdc7.1709591118.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1709591118.git.u.kleine-koenig@pengutronix.de>
References: <cover.1709591118.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1800; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=IXSRArmHBgUvyx2LKQTiYc/LS+CtwpTLFKSu3H4cqdc=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRn3lVzeLb99ZrCPrV92ja+I2d6ytoj35v8TjBUkQ5aP GderClbJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATefeSg2E5U5V5xqbmrphp 7FVPgy5nGLHzmwazhOnasGikcj+pW382ZU7KZpkTj9RNLp+X8mStq5DiP7zBamNXXK1Q6/cXsp9 9+IvVf19g+LLsQXJ0ZMAdm5xHnr+5ZyiqTXvjFq143eW4VtbZd+ZRRwVDD8j8zOSbajn3pEiDqE t96EoG8R/5J/ZJTl2voyGy1PZW4Rfm+M3G+dd94q2Fr/6SDchP7Mksuzbhj/+hb04GOm++8cqfe p79w9fedxLzfH4lzsMm/nOkmJg67v1TMalIdLh7ZKZ25+VJETWZp+4v8Llc795sN2H/f/X9V+Sq 2zVU193juBBoPCnD/KCZZnJs6+ntYhEJ81nXsHk+c4wAAA==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org

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
 drivers/sbus/char/display7seg.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index 18e6f84e754f..521cf8affe65 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -229,7 +229,7 @@ static int d7s_probe(struct platform_device *op)
 	goto out;
 }
 
-static int d7s_remove(struct platform_device *op)
+static void d7s_remove(struct platform_device *op)
 {
 	struct d7s *p = dev_get_drvdata(&op->dev);
 	u8 regs = readb(p->regs);
@@ -245,8 +245,6 @@ static int d7s_remove(struct platform_device *op)
 
 	misc_deregister(&d7s_miscdev);
 	of_iounmap(&op->resource[0], p->regs, sizeof(u8));
-
-	return 0;
 }
 
 static const struct of_device_id d7s_match[] = {
@@ -263,7 +261,7 @@ static struct platform_driver d7s_driver = {
 		.of_match_table = d7s_match,
 	},
 	.probe		= d7s_probe,
-	.remove		= d7s_remove,
+	.remove_new	= d7s_remove,
 };
 
 module_platform_driver(d7s_driver);
-- 
2.43.0


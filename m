Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F22A8F44
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591442; cv=none; b=UVcSuF7BGZLAumg8lEZ3QN41kfHUJExA+v5CaaVu6WQElWkUZD+rz4ktGNSk+O9umC/QE4JDsQXaenCOFlzXnsACwj20vGqW2OWSyGdsqKRDuQMFcKFeNWSs8w3tHKcWjoO4OZbT8D+EBMw8wmPLBFXvCqNzTFTAbX9yTfQ/Qnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591442; c=relaxed/simple;
	bh=OAKDjDIddRlFTzMDovtXkPNXvM2o/xSAgM43YJwZtQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cltcCbyF3YoHlLbPKh4DdedHFUWpsG8h4iP8k91YE4Wb3i8wNuy182M1AiBnNdlxym0XNiZXJZeoGDDgL0PLhPqjad0g4LumVmwOikfbNhgOzu3mfWCgGBWdKQmPk26R+EsyNXROcZFZtAfy1ru7y9DovQQkRNrIN8t61MArKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00073T-Cy; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-004RAh-V5; Mon, 04 Mar 2024 23:30:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-00H7IR-2o;
	Mon, 04 Mar 2024 23:30:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Rob Herring <robh@kernel.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 4/6] sbus: envctrl: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 23:30:11 +0100
Message-ID:  <0b61ed6fb4ebe2880951b1e849551dbc63402802.1709591118.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1783; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=OAKDjDIddRlFTzMDovtXkPNXvM2o/xSAgM43YJwZtQ4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5kuAXvo05LDwFKtUVtrOzirfWwz5iPJddWwPo /jYPzzWl8KJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeZLgAAKCRCPgPtYfRL+ TnZYCACCtht62hhqQseRq7w50iq5eqlcVj5H1+z4KLevy0fVeOd3IvZL1th9Kvi0Qyv/DehKvch Pm5Mq3tXPe5yKrcTMLbCzPaqb0+75HA6HYW2jEEljj9GU/fD7BdrFkDMf2uhg3ncyqDV9bX8c5c ZzmIHN9m8tsg3RDplA8tGgUW95UZu8QDEgGQa9Jd+yvDn2vTILXQIvHp9vaStgWJ/Xv+dGUTKq5 FcYRMwiQjp3sqs7pfebSJHxVQRNwqaZJ7H6Gbg+w+nHHyKWRVlITihOcDYMFiA93+/sfR97h87i HxA3tBevRs5doMORDUwJbXqsst4K4LCstKhRiZ6j1I6EAqhm
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
 drivers/sbus/char/envctrl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 3dd7274cb0a3..491cc6c0b3f9 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -1097,7 +1097,7 @@ static int envctrl_probe(struct platform_device *op)
 	return err;
 }
 
-static int envctrl_remove(struct platform_device *op)
+static void envctrl_remove(struct platform_device *op)
 {
 	int index;
 
@@ -1108,8 +1108,6 @@ static int envctrl_remove(struct platform_device *op)
 
 	for (index = 0; index < ENVCTRL_MAX_CPU * 2; index++)
 		kfree(i2c_childlist[index].tables);
-
-	return 0;
 }
 
 static const struct of_device_id envctrl_match[] = {
@@ -1127,7 +1125,7 @@ static struct platform_driver envctrl_driver = {
 		.of_match_table = envctrl_match,
 	},
 	.probe		= envctrl_probe,
-	.remove		= envctrl_remove,
+	.remove_new	= envctrl_remove,
 };
 
 module_platform_driver(envctrl_driver);
-- 
2.43.0


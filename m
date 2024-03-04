Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12B29CFE
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591442; cv=none; b=VQM88qZG1xTUgRHo7nT0/Lxz2dSamj49evYFygGTWNOSMmbhdvM/Gio2mAaaZKk/sfy2oFG3hMJ8bytez+QJO9pVbZyKstBCZnnfazWEokuTWmrXyOWGkiOnrJZMIDdUav4OeezM6qqmI5jGqd0buaPNFlYtWIid7HKjNPJi89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591442; c=relaxed/simple;
	bh=yMGaQO67z+KNEEEHI+prlq7mK7nx4TgQCjmCDNAFxsI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nguI0aLsUnU5+I191PjIy5k05PaSSMATG3fX8UXHNyEL+oxhWAsMJbXfHlW3g/uRw05EFJEXipJYZElaV4exb5o+21RyVUO7KA2YbkILTo+U+hs5c6KJuORAOo6il9EXkPXKHKQSeiVl/XqwBadknrBcLWYx8Hg9deA3jCb9Mp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00073j-L9; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-004RAk-7G; Mon, 04 Mar 2024 23:30:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00H7IV-0S;
	Mon, 04 Mar 2024 23:30:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 5/6] sbus: flash: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 23:30:12 +0100
Message-ID:  <a9c6351fc24c40d011697cd7540950f412507965.1709591118.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1610; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=yMGaQO67z+KNEEEHI+prlq7mK7nx4TgQCjmCDNAFxsI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5kuGxLo3jT3R7aIaqIjDniACLL1ru7UgCHf87 typP0EkJvKJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeZLhgAKCRCPgPtYfRL+ TrveB/4jcS/kJq5vdriuBvivWI12j0Yd3qLhHK0Vj8MqcYDQRkSvdGjNdZ1Qgx5rWjyJli1sM2n fL6fvHD6aHnjmOHSrbgMTUI9mvutZgsAxp21sikLG4vnZv4FXDYGFW8wwcsQQpFOpykyc0HV4XO OsRijUdV4vwQmGZku2yobglCBN21XUdN/t5lyKZnOFQd9fZHuyJckSF+ZSlSOByHbn61ppNwj14 SU/nLWhA6rD3nHrjc3SXltdBxlR3df1G31jdaGS/4aaUfebhRVVOEYbiZ1SNafk0Sm/1Fi8OL/i b0hAkAdTqPw3lzE6lbpZfpxU2ZND+9an5fsyMX6upX1mNZJv
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
 drivers/sbus/char/flash.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index ea2d903ba673..05d37d31c3b8 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -187,11 +187,9 @@ static int flash_probe(struct platform_device *op)
 	return misc_register(&flash_dev);
 }
 
-static int flash_remove(struct platform_device *op)
+static void flash_remove(struct platform_device *op)
 {
 	misc_deregister(&flash_dev);
-
-	return 0;
 }
 
 static const struct of_device_id flash_match[] = {
@@ -208,7 +206,7 @@ static struct platform_driver flash_driver = {
 		.of_match_table = flash_match,
 	},
 	.probe		= flash_probe,
-	.remove		= flash_remove,
+	.remove_new	= flash_remove,
 };
 
 module_platform_driver(flash_driver);
-- 
2.43.0


Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBEF3FB07
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591442; cv=none; b=jId043i/gTzNxx4Nu0m4UDqOT/5Wu4Zt6HWM5+o6IpOTWmIQ7atY/p21wV9M9xBwqJ/tQyHdWw+4iJbditeOWdHFW85oXVqryeTYmYulxAtQdSuO+hiTEqyWELHIssIdDiKdd30uw0zNj9td8QndNwhpx7PDog58oOP9GPt2DAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591442; c=relaxed/simple;
	bh=j9XUp2kkW9l4W9pP1cAh3i09cR+kT420pW7hBoBCM+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jzab3WxmsoqdT9bc9wKtC3w+xU8HXVgE4TUSQaerFBO5IX7Bqc8qzpXOATCIhsqvHYGVnvGqq7smGDUxcaSbOZHqmWavblsxB/nqD4G8bvLUxqa32memMT6RYN+f0+DyFsIVciTFuU6NFMqA/KUw8n27+GU72Dl8g4y/PXhGJMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00072Y-Cz; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-004RAb-IB; Mon, 04 Mar 2024 23:30:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-00H7IF-1W;
	Mon, 04 Mar 2024 23:30:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/6] sbus: bbc_i2c: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 23:30:09 +0100
Message-ID:  <a5ba9d930451d1eeabc4208cc6c75184a92a248d.1709591118.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1794; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=j9XUp2kkW9l4W9pP1cAh3i09cR+kT420pW7hBoBCM+I=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRn3hWbubwvRorOjtINtnFke8pj7FfdX3xGxkzWc7uhe oWavG4nozELAyMXg6yYIot945pMqyq5yM61/y7DDGJlApnCwMUpABPh6mf/7z7lrMTEnzd/fnLK KSr3Y33luepAl5eXwcKOpXFnuVSy7raknG90V1h8wr88l024e98Bjqu3fz3+Ns2d+XBhj6xk80F vLdvr4f51Oms4vyXwMUis3R6/Zs7C6YmTb69++M81ulraN5P1467F7Nn5ikuZo45qmU1nX6v15O f+rQ/OV9YuiBW0/bTtkEbFvSscy19dc/qu9b16G2ddZO/xSVeC5HKmr2aPEJ6zUY5dZV3OElG2m xyqrtcMjhy0ytl+I3yb8eR5tvovXc5eq3jfosVTsbG0YtKddT7cmyo6rrXnm32zO8pU1hPmdPFF 48R18bzlOiUcb9T8JB3PzrK79V6HT2apI7fE6kIXb7NbAA==
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
 drivers/sbus/char/bbc_i2c.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 970e04d8937d..3192dcb83b86 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -382,7 +382,7 @@ static int bbc_i2c_probe(struct platform_device *op)
 	return err;
 }
 
-static int bbc_i2c_remove(struct platform_device *op)
+static void bbc_i2c_remove(struct platform_device *op)
 {
 	struct bbc_i2c_bus *bp = dev_get_drvdata(&op->dev);
 
@@ -396,8 +396,6 @@ static int bbc_i2c_remove(struct platform_device *op)
 		of_iounmap(&op->resource[1], bp->i2c_control_regs, 2);
 
 	kfree(bp);
-
-	return 0;
 }
 
 static const struct of_device_id bbc_i2c_match[] = {
@@ -415,7 +413,7 @@ static struct platform_driver bbc_i2c_driver = {
 		.of_match_table = bbc_i2c_match,
 	},
 	.probe		= bbc_i2c_probe,
-	.remove		= bbc_i2c_remove,
+	.remove_new	= bbc_i2c_remove,
 };
 
 module_platform_driver(bbc_i2c_driver);
-- 
2.43.0


Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912FC17555
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591443; cv=none; b=p2hASJDnxtG049PO6P4Wr4UeKtwqwtauR3UrCNHKfrd9bPevOxhtAocNaEt5Mei1NnW4Z9iT/w9N7vVC9maMIKzVH48JD6oUwBBSl4v8OSSDO3L9khDYlhVDdgxq/ONvZQhkoBcS84npVSia0Do5fKCZbt5fcUhcN/VWtpSbFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591443; c=relaxed/simple;
	bh=4dE2Azq88uOKKAhqZUbOT+fl+bmVSUe/rbNwkzV7mJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lw2AjnirQUGmfMQRoUo0Q9qevZkYuCzOQvp5D6ygqNAP4QBfFW5v4dPg/wDU26ty3D/68W6P8EW9HYcJkEZvJZa7aeAN9u1Sla/wsfjLL0nIUwk5/RjJFHVqMN6TpfddKf6ZqWlelyBmHjOu+m/XxGq+U3ENEH9OBWvbn6rodeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00074F-RD; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-004RAn-E8; Mon, 04 Mar 2024 23:30:36 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00H7Ib-18;
	Mon, 04 Mar 2024 23:30:36 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Sam Ravnborg <sam@ravnborg.org>,
	Rob Herring <robh@kernel.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 6/6] sbus: uctrl: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 23:30:13 +0100
Message-ID:  <59b07175ca590031ee28c11c5941384ab3603799.1709591118.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1738; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=4dE2Azq88uOKKAhqZUbOT+fl+bmVSUe/rbNwkzV7mJM=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5kuHtHm+0cTgMACjYgDr0HN56T1OTEWMYKUOu OzprIWzHBGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeZLhwAKCRCPgPtYfRL+ Tsh8B/sHpF4OcPiVUZEkLDvcP2uKUg8L8HnrqJcVYmd84egClvFcMyD4SHJ4uAYsJ2sF6kjb0+u 1E93VXsTEo/lSvh6S902D2DwzOdFvsVmEC7p9zM9Cf9eEHGMV3cV4uQWmwWu8G7Ce7SezJys/e9 tTdUCNSD9U0x4s6Q+MMse96N99jyItPoX3Sfq3h/qPEMOOcXDO8AkqSftXXvDy5nRtU0F4UJIQr obSkvknLOlnj3bsuF3aEdrb+U4urKmiDfqftyxNVU9FwoHA1RluRodll2FDd8epeqCRf0mrPoed 5tNpJBeAeERMy7HjEjgamOzHAaz3YUdIci9kuz0TZFLyqrLt
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
 drivers/sbus/char/uctrl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 0660425e3a5a..cf15a4186d03 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -399,7 +399,7 @@ static int uctrl_probe(struct platform_device *op)
 	goto out;
 }
 
-static int uctrl_remove(struct platform_device *op)
+static void uctrl_remove(struct platform_device *op)
 {
 	struct uctrl_driver *p = dev_get_drvdata(&op->dev);
 
@@ -409,7 +409,6 @@ static int uctrl_remove(struct platform_device *op)
 		of_iounmap(&op->resource[0], p->regs, resource_size(&op->resource[0]));
 		kfree(p);
 	}
-	return 0;
 }
 
 static const struct of_device_id uctrl_match[] = {
@@ -426,7 +425,7 @@ static struct platform_driver uctrl_driver = {
 		.of_match_table = uctrl_match,
 	},
 	.probe		= uctrl_probe,
-	.remove		= uctrl_remove,
+	.remove_new	= uctrl_remove,
 };
 
 
-- 
2.43.0


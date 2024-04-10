Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931B13D607
	for <sparclinux@vger.kernel.org>; Wed, 10 Apr 2024 13:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756119; cv=none; b=GDBLrzBOpsh36824RTmqC4UyTCw9UKVQxNVHi/HhMMbHTFNNfpnvoVe3wNIq5HtF06WBfCHgv12a2jg7wZSKRv6mqdTIfoeQtOhs+8jTqUJKZRf9CBXNLfBdmUWPwOIQcLgqjaRX1T4LxuHnM/7FWYGnmeMIcxa6ij5m1i6LDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756119; c=relaxed/simple;
	bh=9/aI6C1S1aJSIOesjnJTAKtzPhucx8Qmarc0aWUhi9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qCrvgtj4M8skoKU4L5x1mBK0vgQEiH+pNSYkTem+gl768P2xZcXlFIt9zgcw7YoJXEPMeVwobnCGGpTrMtiR7TOO1XSfzBrcMJPuqArCTkzhytCDl14Uga2W9Uqblg+RnjMmLyfvtMoClrK9zYgwRgfxPCbn8ozIMmn/nPW9OFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6a-00054X-PG; Wed, 10 Apr 2024 15:35:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6Z-00BVM2-H8; Wed, 10 Apr 2024 15:35:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6Z-00HaOo-1R;
	Wed, 10 Apr 2024 15:35:11 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Rob Herring <robh@kernel.org>
Cc: sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/2] sparc: parport: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 15:35:06 +0200
Message-ID:  <2765e090dba2d99f92e16c92b6aa55090aae053b.1712755381.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712755381.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712755381.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1827; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=9/aI6C1S1aJSIOesjnJTAKtzPhucx8Qmarc0aWUhi9E=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpWLdInwdJ2G1z13S0ieCecZ6McX2XQgwoJ8m RAtfI9gXQ+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhaViwAKCRCPgPtYfRL+ TkcsB/0btYWUDL7Q36v9OzDq2nPWaUQSIexcXAvo+x33U4nwn6JLsqG3ig3MPRZgqNqfXqoAMsH UPMrsjqvJkTleIAR8Udg8WUVWU0eKCzDPVDE1Qp/53qgR1QHHqrT1PCq+Vyg9WIv+8Luz42uNBJ GbF3yNGUkop3qmGrs+Ocq8g6SGdqjELj4FDNNmh33acBBzgMxPNl1tPzWTd8Ib4BcBrEVWu1woL 6OwGCDEqtX0R8ZxA7yfbBJDlcEytzNdGdKQurJFouPWIr9Yn7KGCcrWCo9j/TqawJrn9VCbFLfL f/q0ZwmSbBYSRUQ8SfEH8AShxKBUxm3SY9wBeVeFc8fxTm9e
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
 arch/sparc/include/asm/parport_64.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/parport_64.h b/arch/sparc/include/asm/parport_64.h
index 0a7ffcfd59cd..4f530a270760 100644
--- a/arch/sparc/include/asm/parport_64.h
+++ b/arch/sparc/include/asm/parport_64.h
@@ -196,7 +196,7 @@ static int ecpp_probe(struct platform_device *op)
 	return err;
 }
 
-static int ecpp_remove(struct platform_device *op)
+static void ecpp_remove(struct platform_device *op)
 {
 	struct parport *p = dev_get_drvdata(&op->dev);
 	int slot = p->dma;
@@ -216,8 +216,6 @@ static int ecpp_remove(struct platform_device *op)
 			   d_len);
 		clear_bit(slot, dma_slot_map);
 	}
-
-	return 0;
 }
 
 static const struct of_device_id ecpp_match[] = {
@@ -245,7 +243,7 @@ static struct platform_driver ecpp_driver = {
 		.of_match_table = ecpp_match,
 	},
 	.probe			= ecpp_probe,
-	.remove			= ecpp_remove,
+	.remove_new		= ecpp_remove,
 };
 
 static int parport_pc_find_nonpci_ports(int autoirq, int autodma)
-- 
2.43.0


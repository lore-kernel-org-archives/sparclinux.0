Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443B15E5B1
	for <sparclinux@vger.kernel.org>; Wed, 10 Apr 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756123; cv=none; b=VBpgneS1yTK8QfFGei8dRpX8/S2ciDRxbaqTDmwV4y8ZYEO+nVpEe2fjcIT5Ujo24Zs7R3jPnxoEhWXwfDGOOoCISdowrBj+Ahwvp3GJDVNa/AD0EtSxpYmlYWJH8hE7vxkzbvFB29Yn59eOu3URg0RhHEKGRnU4I8j9rGp72FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756123; c=relaxed/simple;
	bh=+3NCIwNoU3FZjXcssF0F4YqxUiatzW3IS6tXHFNtK+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hKybDsHXASei/K4w3bM12NWPGhuJjYZ8ETKH6d1hAT+DFHjFw66qEMcg8/mcmpj8CXN5fBcUvNtgWDvtpHJgqLsRsRxSBBq4DlijV30j8hLF+dYh0rCgdyPPZ4VfW1AAS1G0ZtAE/Ncq6SdKvghCglmX7OZ6mZ7nJU4LcmHNZ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6a-00054Y-TA; Wed, 10 Apr 2024 15:35:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6Z-00BVM5-OD; Wed, 10 Apr 2024 15:35:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6Z-00HaOs-29;
	Wed, 10 Apr 2024 15:35:11 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	=?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh@kernel.org>
Cc: sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 2/2] sparc: chmc: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 15:35:07 +0200
Message-ID:  <9fbd788bbca4efd2f596e3c56d045db450756c80.1712755381.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1755; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=+3NCIwNoU3FZjXcssF0F4YqxUiatzW3IS6tXHFNtK+A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpWMGP22wzIX9/fF6DhMGaGbzWvV/taUtdzWQ Hgml6ag8YqJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhaVjAAKCRCPgPtYfRL+ TnBxB/wKaQuw4EymJt1jrSWUqbt5VTwOxqAXz/AGkIBRnUp18Oln4B1nQ2+VfnkmsZGdebOJ0/+ TSnLv3/j6+4Y7MpGAmBFHqbCOQohUR+rj/lmxxr0VWTGjr45m3p/zfKfMGkjIIViTyPD9InmPrU s6hL9/WHjGuFexZZepxucsCXO0MOoH9zfuiTdWZ1WAeI80vqik1j7wHe0hZ4lbDi5B7SAxGK2Hi iP6TNIPkMED0eq5Ddi8ptk6R4C4At2QIoYK4PuWwAxq7iemHTq83tY6/z/drHrbjqgO3LfHcRAd 6qU00QXdQcDTEdsi5LJ6waEQxbb1MkqQOpPrZzLa0QBj89+U
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
 arch/sparc/kernel/chmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index 00e571c30bb5..e02074062001 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -788,7 +788,7 @@ static void jbusmc_destroy(struct platform_device *op, struct jbusmc *p)
 	kfree(p);
 }
 
-static int us3mc_remove(struct platform_device *op)
+static void us3mc_remove(struct platform_device *op)
 {
 	void *p = dev_get_drvdata(&op->dev);
 
@@ -798,7 +798,6 @@ static int us3mc_remove(struct platform_device *op)
 		else if (mc_type == MC_TYPE_JBUS)
 			jbusmc_destroy(op, p);
 	}
-	return 0;
 }
 
 static const struct of_device_id us3mc_match[] = {
@@ -815,7 +814,7 @@ static struct platform_driver us3mc_driver = {
 		.of_match_table = us3mc_match,
 	},
 	.probe		= us3mc_probe,
-	.remove		= us3mc_remove,
+	.remove_new	= us3mc_remove,
 };
 
 static inline bool us3mc_platform(void)
-- 
2.43.0


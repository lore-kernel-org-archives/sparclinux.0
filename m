Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7EB87AE70
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591443; cv=none; b=tbDo1M3uktWpquE1KQ8U4CaqlxS1JyNxnF6FCtOi5KMK60/A8fBJ0JdySNXspTq3uJaFLm0iqw2qqywhTwC+fdcU+Wmunro+cpM5bTcfhJFDDkuSepmH8KVXjrqSBL3UYWi+rrmOgUdXyoe80zC8tKJw3o1do6VKPUuUeaqCens=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591443; c=relaxed/simple;
	bh=1C2RRhC+gA4GspXgyfu7eSNuFyh5TLOvZzimMM7buYI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tOxjEuvykeespg5HfGbI64KdvyPuW3dtVOV8lbxAw9RflaLmw3DcUUNYX77lkUeOsRIaxpupQxAhMERQJP8rSC6xBgN3eWWB52/6P09m5cO/GdUlJm18R0+XpjkKTiS4Kjo76pNoLc/32rI8uaGNAquWYRaPFgp3uJtP/onBSew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00072W-Cz; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-004RAV-2a; Mon, 04 Mar 2024 23:30:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpO-00H7I7-3B;
	Mon, 04 Mar 2024 23:30:34 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/6] sbus: Convert to platform remove callback returning void
Date: Mon,  4 Mar 2024 23:30:07 +0100
Message-ID: <cover.1709591118.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1538; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=1C2RRhC+gA4GspXgyfu7eSNuFyh5TLOvZzimMM7buYI=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBl5ktxzCIFp2x1nQH6wuC3Yad6f0etptRFf78sn klRRVEBuM6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZeZLcQAKCRCPgPtYfRL+ Tp6+B/9HFetuwBQrwIUk6M5UoHgt955Xzfk7Lw3j4yxRCL9WnJotsi6YpmFuNnRLTqJxnShVQA6 w84URKljoRTloDMPnHfpMygUrr4eBjmBo3q/R1tZ017N1C93Br+78fo6KX3WzLenHMye7Apb+y3 OQ0SAREJtQ+htRezx7WVXj5JzcHVfYzF5iNX1s74W016mQTaTr9AYNtsbWzkxdwP1B82zS18vQ7 qqFyyB99fXiDVThNOBAEanijhb8y5FV7W4XjrFblfDX7s0wVeMH5nKUdFKpslRiat87yRFO57ty F1U/8UPDrk6FA15ndKQ+xrSpsMrkLemxI2Ggm7VeRTzybXDS
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org

Hello,

this series converts all platform drivers below drivers/sbus/platform to
struct platform_driver::remove_new(). See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

The first commit is a build fix. The remaining patches implement that
actual conversion. All conversations are trivial, because their
.remove() callbacks returned zero unconditionally.

Apart from patch #2 building on top of #1, there are no
interdependencies between these patches, so they could be picked up
individually. But I'd hope that they get picked up all together by
Andreas (or Dave?).

Best regards
Uwe

Uwe Kleine-König (6):
  sbus: Add prototype for bbc_envctrl_init and bbc_envctrl_cleanup to
    header
  sbus: bbc_i2c: Convert to platform remove callback returning void
  sbus: display7seg: Convert to platform remove callback returning void
  sbus: envctrl: Convert to platform remove callback returning void
  sbus: flash: Convert to platform remove callback returning void
  sbus: uctrl: Convert to platform remove callback returning void

 drivers/sbus/char/bbc_i2c.c     | 9 ++-------
 drivers/sbus/char/bbc_i2c.h     | 3 +++
 drivers/sbus/char/display7seg.c | 6 ++----
 drivers/sbus/char/envctrl.c     | 6 ++----
 drivers/sbus/char/flash.c       | 6 ++----
 drivers/sbus/char/uctrl.c       | 5 ++---
 6 files changed, 13 insertions(+), 22 deletions(-)

base-commit: 67908bf6954b7635d33760ff6dfc189fc26ccc89
-- 
2.43.0


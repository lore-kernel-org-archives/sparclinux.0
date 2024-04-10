Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919C13D607
	for <sparclinux@vger.kernel.org>; Wed, 10 Apr 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756122; cv=none; b=Ij282VtRs53hpiodCWgHqf4pyMJ/kHR8emsi/7nZyVFu+YyB8TzOF+acc8h+wUG5iMmpZ3dovYvsSI5qxm9fTA3R/jNv5QNRVKl/ZTid2zNl563O1Mej0wBsrxcxpE1P5zGnaIpBNS2ThI8gxUE4QBr9ObJHz3lpD2w2czpomTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756122; c=relaxed/simple;
	bh=JbfBkG0Pkafh7F1BPxqerBO3i1GG9MyvBioITFZO2U0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D0fpdzBNzW1MPyFw/O/cDdHkJmfi0bOV2gOEfa3bT+IDfNgbn56eZPIpxP32m6p2xFloiIhIW3/xFnL2/CxyVmwVHszvh0YSsaQ44Ef94CHqUG/Q5/q/ZwduNbSWbI4Nf7BIsKEHoSnUiXBNxm6gUz3fG3U6bEAXoQpX6DM1iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6a-00054W-T8; Wed, 10 Apr 2024 15:35:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6Z-00BVLz-9X; Wed, 10 Apr 2024 15:35:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruY6Z-00HaOk-0f;
	Wed, 10 Apr 2024 15:35:11 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Rob Herring <robh@kernel.org>,
	=?utf-8?q?Ahelenia_Ziemia=C5=84ska?= <nabijaczleweli@nabijaczleweli.xyz>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 0/2] sparc: Convert to platform remove callback returning void
Date: Wed, 10 Apr 2024 15:35:05 +0200
Message-ID: <cover.1712755381.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=937; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=JbfBkG0Pkafh7F1BPxqerBO3i1GG9MyvBioITFZO2U0=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFpWKQ1U1hP1GN+hioWZz67ZGKl0GltdC4O9Gv vdMgulApjaJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhaVigAKCRCPgPtYfRL+ Tqu/B/kBoyvUEsBM5mYGmQsbq0Opjt9ykvcyrRSVW95D3qt363OZ1ktA7SJZgOyNxnZH1KsTP3I +qmZUhSMzaSt0gblAPa/L1J7L9rx8j5BgeDaFdNIUnf41QjasYVCrvPEN91WC0+HBtjKliuLRDW iQpMucrXU+6psJGQyxG/127EepvyP5FI2nMQnyiFqi80E1jVVEH7i9IT15NjgIJPLKGqNhYUTxM c8xTtjp0m37XZzKEUPtIw61l/jpdhw8EeTV0zqL4J8KfjfmZqnP0rVSqNWANDf7KLHl5eTeBGTN chletPBGBZ4HSWc/Xd0FLopj3knJR3eFWGwBsa+UkjVw5iHC
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org

Hello,

this series converts the two platform drivers that have a remove callback below
arch/sparc to implement remove_new instead. See commit 5c5a7680e67b
("platform: Provide a remove callback that returns no value") for an
extended explanation and the eventual goal.

All conversations are trivial, because the driver's .remove() callbacks
returned zero unconditionally already.

There are no interdependencies between the two patches, so they could be picked
up individually if need be. This is merge window material.

Best regards
Uwe

Uwe Kleine-König (2):
  sparc: parport: Convert to platform remove callback returning void
  sparc: chmc: Convert to platform remove callback returning void

 arch/sparc/include/asm/parport_64.h | 6 ++----
 arch/sparc/kernel/chmc.c            | 5 ++---
 2 files changed, 4 insertions(+), 7 deletions(-)

base-commit: 6ebf211bb11dfc004a2ff73a9de5386fa309c430
-- 
2.43.0


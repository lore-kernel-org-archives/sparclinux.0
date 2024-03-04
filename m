Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE7B3D4
	for <sparclinux@vger.kernel.org>; Mon,  4 Mar 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709591444; cv=none; b=VFxrv8JXASG/2XXh5IwV0g/NpXQaOImxvjzAMExKztBvxyyhejnh3kLB4IomubvgXSJCNmfE2mZuNkG80RpTQKZU7FgNIWclmQOSQrFxXF6ikfIfV3onc7qkwDBS84O8SWTtaY1W58+2ubZhzsE5bzL39jwiv85Oln0cffQDhXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709591444; c=relaxed/simple;
	bh=GcjH/9kfyEXS9YEbG8nq/NtVg0wo03epd8gVuP1qfFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmbHnihI6QaGsjJkisUk5Al3IGWk5lIoM0m0mJ75zrJwMpJbjlNEbml6QVeUXGUyAbo//iYjW5qrw//sb4voWNHGcGeqx6UndlvPOZcx8i3lGJktsagq26lLFJV0nr6KNGScC3hl2EdgdI5YPN5TLOMqD3KjInGMYMcYoG+Drj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpQ-00072X-Cy; Mon, 04 Mar 2024 23:30:36 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-004RAY-BA; Mon, 04 Mar 2024 23:30:35 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rhGpP-00H7IB-0n;
	Mon, 04 Mar 2024 23:30:35 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Rob Herring <robh@kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>,
	sparclinux@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH 1/6] sbus: Add prototype for bbc_envctrl_init and bbc_envctrl_cleanup to header
Date: Mon,  4 Mar 2024 23:30:08 +0100
Message-ID:  <57bc3b43b405431a486162fb8c2558072e976747.1709591118.git.u.kleine-koenig@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=GcjH/9kfyEXS9YEbG8nq/NtVg0wo03epd8gVuP1qfFU=; b=owGbwMvMwMXY3/A7olbonx/jabUkhtRn3kVnZzLfuf2a82RMc9vM0NWvtjr7ZlirdPafP1a5i Zd/rlZxJ6MxCwMjF4OsmCKLfeOaTKsqucjOtf8uwwxiZQKZwsDFKQATUdjIwdBZcMT3xmoBG8bV N24oT50Z/eDGBxXbDMe62N46E49KhQ32Zx14K4+EeK2+KGL3MFDdWXalQv3dnar/zwXtm7bU87f cniyZy56W92fNL4pdsWzJrIzH/W32lxZXVDveLOgPl1B15VmSsnmfkqeh2sv2eutHIR5ekmaVz+ 9GCO8pO1lR7VommPR5h5yn9/enTm6FabKdkbocfNJhHfs+XYlVepNyV6LjrncIu27kfebjfu3xO 3ZeePRW8t/zd/Yuk3akJF/I0pw45Vb1PqNXWztO5i9N1fqSx7BypYri0rbSQ7zlQnGV07pb/I3n 7eO5aTsn/z/3dx2RA+s3epo/0XZYXHF95YVsrdsGVSr3AQ==
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: sparclinux@vger.kernel.org

This fixes the following build warning:

	drivers/sbus/char/bbc_envctrl.c:566:5: error: no previous prototype for ‘bbc_envctrl_init’ [-Werror=missing-prototypes]
	  566 | int bbc_envctrl_init(struct bbc_i2c_bus *bp)
	      |     ^~~~~~~~~~~~~~~~
	drivers/sbus/char/bbc_envctrl.c:594:6: error: no previous prototype for ‘bbc_envctrl_cleanup’ [-Werror=missing-prototypes]
	  594 | void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp)
	      |      ^~~~~~~~~~~~~~~~~~~

which in the presence of -Werror=missing-prototypes yields a compiler
error.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/sbus/char/bbc_i2c.c | 3 ---
 drivers/sbus/char/bbc_i2c.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index 1c76e27d527a..970e04d8937d 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -358,9 +358,6 @@ static struct bbc_i2c_bus * attach_one_i2c(struct platform_device *op, int index
 	return NULL;
 }
 
-extern int bbc_envctrl_init(struct bbc_i2c_bus *bp);
-extern void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp);
-
 static int bbc_i2c_probe(struct platform_device *op)
 {
 	struct bbc_i2c_bus *bp;
diff --git a/drivers/sbus/char/bbc_i2c.h b/drivers/sbus/char/bbc_i2c.h
index 7ffe908c62dc..6c748836754b 100644
--- a/drivers/sbus/char/bbc_i2c.h
+++ b/drivers/sbus/char/bbc_i2c.h
@@ -82,4 +82,7 @@ extern int bbc_i2c_readb(struct bbc_i2c_client *, unsigned char *byte, int off);
 extern int bbc_i2c_write_buf(struct bbc_i2c_client *, char *buf, int len, int off);
 extern int bbc_i2c_read_buf(struct bbc_i2c_client *, char *buf, int len, int off);
 
+extern int bbc_envctrl_init(struct bbc_i2c_bus *bp);
+extern void bbc_envctrl_cleanup(struct bbc_i2c_bus *bp);
+
 #endif /* _BBC_I2C_H */
-- 
2.43.0


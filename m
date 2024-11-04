Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [195.130.132.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21961D9A54
	for <sparclinux@vger.kernel.org>; Mon,  4 Nov 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730717643; cv=none; b=mtbxFlNljgKG4atysO1xRJqPkaZ13YErKYiziFgga9J7m7jkhZOn69695A4W2BBQDtdU+kcvU3Mi8FNuWu1RagmIqRk1t0qOzcvVrWlVZ//0tKw2nRcUUw6kAu5vWFHAw3/LZGLHktyL1JqGHosRIGPKgDoFHTDhrsJ5nX8gJgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730717643; c=relaxed/simple;
	bh=APcFNFk/zxuy3y5w8EFdvDprJvlMu8Z5AsSdBpSE1RE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VkKdcrq0llGOX/XRRH+vI26Nzgxp2xCGbAXe1M0vq6OAZsz3tE05QI66KDBY10/KAHvRu6bXbSmBeHLhzELHmbZuc18JdQp1FSTzg15COmBBl6pNZZTJbW+zepFXPuUJqnOFOibeMy7Xle1CG6D50SoFXcpBJXtZ3llBWP0Zqi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:cff2:a4e4:667a:351c])
	by xavier.telenet-ops.be with cmsmtp
	id Yatt2D0042b9NYg01attZ2; Mon, 04 Nov 2024 11:53:53 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t7uiD-006FYJ-Af;
	Mon, 04 Nov 2024 11:53:53 +0100
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1t7uiW-00E1KD-VE;
	Mon, 04 Nov 2024 11:53:52 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-gpio@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] gpio: GPIO_GRGPIO should depend on OF
Date: Mon,  4 Nov 2024 11:53:51 +0100
Message-Id: <aa59c35722c43d13eabbefc4617adae5f2f52e9c.1730717575.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the Aeroflex Gaisler GRGPIO driver has no build-time dependency on
gpiolib-of, it supports only DT-based configuration, and is used only on
DT systems.  Hence add a dependency on OF, to prevent asking the user
about this driver when configuring a kernel without DT support.

Fixes: bc40668def384256 ("gpio: grgpio: drop Kconfig dependency on OF_GPIO")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
---
v2:
  - Add Reviewed-by,
  - Depend on OF instead of OF_GPIO.
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 3eec4f0e47064fa6..d0d31a087ee9b369 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -340,6 +340,7 @@ config GPIO_GRANITERAPIDS
 
 config GPIO_GRGPIO
 	tristate "Aeroflex Gaisler GRGPIO support"
+	depends on OF || COMPILE_TEST
 	select GPIO_GENERIC
 	select IRQ_DOMAIN
 	help
-- 
2.34.1


Received: from andre.telenet-ops.be (andre.telenet-ops.be [195.130.132.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BC039FD9
	for <sparclinux@vger.kernel.org>; Wed,  5 Feb 2025 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.132.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760715; cv=none; b=S/sICRVfkeplvQ+a/6UuCXXTXiOCTZ30nhl6a2cpkOBfk9/bh8jbpMR0gj67pcAUhL84I/sXp0hddIt+iFrz9bcGw0juSLow6mzd+mvZNLJtfqvNzEeZf+tsMNOs7w08AOKqur4iDZc9yYIixMgu4m/L/ausDoLCFWL9dXmD6gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760715; c=relaxed/simple;
	bh=1lbD5u3awMB8FBEfYe3jiPTwSBQuoBo9YXz8XbKCjpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TfQootTIAb3h26NmXOTdn1U73kPpJKZX8785EoXIMg4J1YI3WdiwRXV8/Sdvek6QO8P9iehYoHObXKhcXEAA+z69K48bcolPOJfWuOykzPj13qg+tMxwgxrKn01J5jDWMlNUbsNghz9hFnBIiR+N7fDI3WD/ZYV6Ei7Mmy+D4Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.132.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:fa11:c14e:2df5:5273])
	by andre.telenet-ops.be with cmsmtp
	id 9p552E0053f221S01p55wz; Wed, 05 Feb 2025 14:05:05 +0100
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tff5I-0000000FvZS-3qWg;
	Wed, 05 Feb 2025 14:05:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.97)
	(envelope-from <geert@linux-m68k.org>)
	id 1tff5U-00000006PqT-41G4;
	Wed, 05 Feb 2025 14:05:04 +0100
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-gpio@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 resend] gpio: GPIO_GRGPIO should depend on OF
Date: Wed,  5 Feb 2025 14:05:03 +0100
Message-ID: <db6da3d11bf850d89f199e5c740d8f133e38078d.1738760539.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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
index 68c5e69342571495..285a93061daee717 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -338,6 +338,7 @@ config GPIO_GRANITERAPIDS
 
 config GPIO_GRGPIO
 	tristate "Aeroflex Gaisler GRGPIO support"
+	depends on OF || COMPILE_TEST
 	select GPIO_GENERIC
 	select IRQ_DOMAIN
 	help
-- 
2.43.0


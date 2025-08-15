Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39D301477;
	Fri, 15 Aug 2025 10:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254519; cv=none; b=qAyijpcRkP9Dul3HQ6oS5lP5xC57e1grLGUeW6nwwcJ+IqR2zPu/FCGo7UixzBYoerNumTPKJ2vbpq7yYXcY48ZO2Ut1VAnhLehimeH/T9bcHNuHgEp24XGwbodcp0jmNrBFhygJD39lTvyKljSfGHDFRT0GJ4vPMk19fsKbfZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254519; c=relaxed/simple;
	bh=iHrvFGNV5NlPwOHT9CAH917OiIs5mQw1vNrE9YUQ/ok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNxPKNh0ZU3hzBjTDWr+RkhSld/247WqvzxZlNeDZvFzYVxZp+STnJmLxB0YYV3JrHnosmamPBBmSdUK9e3xR60ZQ6Lu/awBxQTZnqSIqTVGVMrI072P6p6Tr5zmyusVFplI4DvP4RRvbzdz+cHx3+7LDrYsfPMRO3hzu7nFhHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jCHRahLW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9YY/99n0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jCHRahLW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9YY/99n0"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yFTisLxg3YqCYd6Iv5ovY8EeuzCRvAqVAjys88/tuc=;
	b=jCHRahLWCtRFepyca5LqX2O3SUrqu/tQbJxN/NdNXEslRAvVcpIsszrvn3U76QLqnQj96e
	gwJvhwzMOTluDd1m8nd3aytqEWLIXB1+0SWO7Wnzpg5xlHCNntrXRIfr1V2NhqDRCxrPIW
	QZrOpf8WnaDtteKH5Wb2d2wGfc2iYeaoqvk/CYcNZIyDQybz687dIWlgbDmRQ07fB0SAKp
	hUHDuEl/XEe7x/+QD7r5yF4vZ1d7hQDwAg6K7sanFTJb5b8Y9KEJIMhW5Dbf24h1CcRzkC
	GJDKUKG+BPczVT4I/XapSETs3bYLtGLy6oh/Kj11xRvMqPSbOhUHb8xkTJgtcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254516;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9yFTisLxg3YqCYd6Iv5ovY8EeuzCRvAqVAjys88/tuc=;
	b=9YY/99n0W6sNmpwc3TeddgOLiuaG4OvcuDx4nMKmgaUYhC9TZn2czdKyiuoUPAcFTf4eX0
	yduHt695gCO24UDg==
Date: Fri, 15 Aug 2025 12:41:22 +0200
Subject: [PATCH v2 13/13] clocksource: remove ARCH_CLOCKSOURCE_DATA
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-13-b5ff80672347@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
In-Reply-To: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
To: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Vincenzo Frascino <vincenzo.frascino@arm.com>, 
 Arnd Bergmann <arnd@arndb.de>, "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Nagarathnam Muthusamy <nagarathnam.muthusamy@oracle.com>, 
 Nick Alcock <nick.alcock@oracle.com>, John Stultz <jstultz@google.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=1684;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aSf9Jd5/ve0wXQ2JEfqCZQGKHbjrs6wOtqje+1SHbKU=;
 b=E1tDHEJDznZ0Dv1wdoHRpvGZUUSSSujH8rW9k/M1oxXMvWz/iNs45xZTzIQzr6j3OGe/9Ayru
 STXG3w4JLGSAyR4zhRNHuYHzf75v2f/kyOfTjtJ2yr1RBZwTRrKky3z
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

From: Arnd Bergmann <arnd@arndb.de>

After sparc64, there are no remaining users of ARCH_CLOCKSOURCE_DATA
and it can just be removed.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: John Stultz <jstultz@google.com>
[Thomas: drop sparc64 bits from the patch]
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/linux/clocksource.h | 6 +-----
 kernel/time/Kconfig         | 4 ----
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index 65b7c41471c390463770c2da13694e58e83b84ea..12d853b1883265cb47d93e33d8370e3957e7e695 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -25,8 +25,7 @@ struct clocksource_base;
 struct clocksource;
 struct module;
 
-#if defined(CONFIG_ARCH_CLOCKSOURCE_DATA) || \
-    defined(CONFIG_GENERIC_GETTIMEOFDAY)
+#if defined(CONFIG_GENERIC_GETTIMEOFDAY)
 #include <asm/clocksource.h>
 #endif
 
@@ -106,9 +105,6 @@ struct clocksource {
 	u64			max_idle_ns;
 	u32			maxadj;
 	u32			uncertainty_margin;
-#ifdef CONFIG_ARCH_CLOCKSOURCE_DATA
-	struct arch_clocksource_data archdata;
-#endif
 	u64			max_cycles;
 	u64			max_raw_delta;
 	const char		*name;
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 7c6a52f7836cef248e0949060b50baa293f446cf..fe33118770978682d0ff6c6e7990896f42703b50 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -9,10 +9,6 @@
 config CLOCKSOURCE_WATCHDOG
 	bool
 
-# Architecture has extra clocksource data
-config ARCH_CLOCKSOURCE_DATA
-	bool
-
 # Architecture has extra clocksource init called from registration
 config ARCH_CLOCKSOURCE_INIT
 	bool

-- 
2.50.1


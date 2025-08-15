Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601C22FC89B;
	Fri, 15 Aug 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254513; cv=none; b=lE0r/wQ3peJZfjoV2jvNVp+SAqhBtNevAFh7I3l7SSVFvd3wZlgKgjSmR1B0xziq9LlB5+/5VKzQqqC5QcC8nKGWEE3ldwclU83m6rDFYztYVaJzRLpko/eSbEbuuoveUrKm4feEfUjQeLidx3I/Aol/uE8zaiODV5BFbqnmOx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254513; c=relaxed/simple;
	bh=A2YNc0MwCxtVL2QJwYK0jWBU1Qh+09MjIWJv0XFIwVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nQErn+oOfC2kFW7wbYb6ejfm9rKDtBHIcKznGWZ7C58e23lMQqQX3Lu8XOLAunsX8Zs5mWJ+MqsZzaFB0d4uzmx7mPjRqHNLs88hYVyHZJ9H/DVlZdz21Ft3qJJ+Me6+92U6esIr0JNI3qcY2akFYyms7ICBeDr5nEsqZbXaMZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O0azHQVU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r0edVs2z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O0azHQVU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r0edVs2z"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0YJNOPK2tBNibBCGd9a6FHp1U2Oqwk6iytj2eWY/Z0=;
	b=O0azHQVU4f19/k7WeAShnuI7UnoXqsaf7til2fgLY+2Sxp5Y7+C9fV6LiygSyljY5O5Msc
	P/iKYTM9BPNpCbDFzqvcQxMYwOeC+pQ5OeDQzWcSfR/BwacMbeH65Au3OJReQ3rpNuJiOR
	k/OXC1+tGPccHpetuyuNbV8xLqoH491hVSGWRSQBibB2u5tKxxjrnjZ0T5KrqVWUMfig8p
	WqRUFAGbagvv+9dHm3+OX89ZG/dsW7Ftcs4dRKHUP83zAuGnotM6AgPWVjM1Zh3L70tx1r
	GcGoVIS+AJCt0o/tUZZB0qfiShGjSRwRKn8IzhnFF+ZFYHmnXU0Z/W+TlaKpMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b0YJNOPK2tBNibBCGd9a6FHp1U2Oqwk6iytj2eWY/Z0=;
	b=r0edVs2zZco8AojgjqQIXAkU7br7PVvWenA8fanz37dA7LgV1EKwdpixResbMivjllZYuc
	ES8CEs6wIGCiccCw==
Date: Fri, 15 Aug 2025 12:41:10 +0200
Subject: [PATCH v2 01/13] vdso: Add struct __kernel_old_timeval forward
 declaration to gettime.h
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-1-b5ff80672347@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=817;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=A2YNc0MwCxtVL2QJwYK0jWBU1Qh+09MjIWJv0XFIwVo=;
 b=NF6YMeWQmMaXIT9VB3H1Pb19dFOriba9vBsbVZkstMQoGXFy3pEojc0BJM4TBeQ3k7q8VQlST
 Dy/MGtkr/0rAXMo5IR44WlA+ulyGL/FsA0m9SRb7m/PiGPhjfDaJWvM
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The prototype of __vdso_gettimeofday() uses this struct.
However gettime.h's own includes do not provide a definition for it.

Add a forward declaration, similar to other used structs.

Fixes: 42874e4eb35b ("arch: vdso: consolidate gettime prototypes")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 include/vdso/gettime.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/vdso/gettime.h b/include/vdso/gettime.h
index c50d152e7b3e0670ea87cb51452c0a03b98403a0..9ac161866653a01c2a54702cb72fe5bda488ee2c 100644
--- a/include/vdso/gettime.h
+++ b/include/vdso/gettime.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 
 struct __kernel_timespec;
+struct __kernel_old_timeval;
 struct timezone;
 
 #if !defined(CONFIG_64BIT) || defined(BUILD_VDSO32_64)

-- 
2.50.1


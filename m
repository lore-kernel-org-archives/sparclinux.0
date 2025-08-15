Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52580301023;
	Fri, 15 Aug 2025 10:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254519; cv=none; b=CDFPMMTyrb7JIX+b2azy82Jkw0aqS3xigu3SH02WFoqIyZTNOZ5bqRK3H9EdViBssiO7rCV/XHVg2K+EzLJliq2kArLgAXw7QDyqbaiqKkdEYLNV2O6qAvwjKJZg4Arv/CDgUFAe3zs5RRnBTj/FYfhwyEg2U0olpk2gcwIFDYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254519; c=relaxed/simple;
	bh=Y6M/Dc0FZBj80nG5zGFZobavKx7lhX9RB9UpQJ8f6Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jg0xsjtUYZlgcDbR/ITNRjCZt7Jd3C/oOOyr70yYX0pTOvWoGjfsKmBbHwv8w/5Rb+kyBwXSc0LDfcOzOu1yqBHLdW0VjIHl6tDwEAQvNgQ9TiHP1Lg/YZ0MHBu/03gzQw75irwIk19sQpwlo5Ju8y56oSwPYoTD36P28hGBDlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AG6/qdUe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TDPNY6w5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AG6/qdUe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TDPNY6w5"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXeyczDo9DH2kvMYh8pqbFFU0887oaxfqSrotCzP+To=;
	b=AG6/qdUeHbPRpiOhJhB3pF9+uCGdlLxTp3o3gRwGo9e6cdhKRcRWLx+ugL6Y54SjUDOkef
	tethOxGWSWgZjF2JDTCLCeMb31TLzs8c+/npbWrtLl6BqNASnHv2aXVJjBDCCsHxRYujn5
	HOisFsuO5OVRR0XWJvW586ntzX9VnVeq/cL4/fUXAIZLOTLoJuU4ECYxz6vWqd7nXWsb9d
	JTi3wxM+3H7RighHPBa7pj0mqKiVy6FLPF9GrZvws4+jLYOTWOQ0UdIMaAVh0cHnKzMG/c
	qpIhJhSLNW4f4PSIq8ttDQldQzYlDGeTmvZz5EoyaCFgva/OZJhu3zFnAG+GoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LXeyczDo9DH2kvMYh8pqbFFU0887oaxfqSrotCzP+To=;
	b=TDPNY6w5eBaxwA7pMzjYMYY+pgxTihW9WBv+aEIN+kXLqJKLtLM+omxvJ+qbEFGpdx8Wc3
	Mw/b2jcccJboqxCg==
Date: Fri, 15 Aug 2025 12:41:20 +0200
Subject: [PATCH v2 11/13] sparc64: vdso: Implement clock_gettime64()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-11-b5ff80672347@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=1520;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Y6M/Dc0FZBj80nG5zGFZobavKx7lhX9RB9UpQJ8f6Io=;
 b=h00SjD4sg252eVHb0naX+rH8K0ZoJ5Hnrzd8a7b/c3Sgj9c5w56Ar5mp1S1uxTPopdN/e5XWv
 r4Y8s+r7HjWBCu3it90USdykoKyag1YCSb8BHYdk8tkYrb6dT+IL1Y/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

To be y2038-safe, 32-bit userspace needs to explicitly call the 64-bit safe
time APIs.

Implement clock_gettime64() in the 32-bit vDSO.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vclock_gettime.c    | 8 ++++++++
 arch/sparc/vdso/vdso32/vdso32.lds.S | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 093a7ff4dafce1cf0af5af4c303bef86e159858a..1d9859392e4cfd285349cf9155ca1fc25d3a7b41 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -48,4 +48,12 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__weak __alias(__vdso_clock_gettime);
 
+int __vdso_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
+int clock_gettime64(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_gettime64);
+
 #endif
diff --git a/arch/sparc/vdso/vdso32/vdso32.lds.S b/arch/sparc/vdso/vdso32/vdso32.lds.S
index 53575ee154c492f9503efdd8f995ac2a035203c7..a14e4f77e6f2222b855df27cc7a0d0a4f98bd4ac 100644
--- a/arch/sparc/vdso/vdso32/vdso32.lds.S
+++ b/arch/sparc/vdso/vdso32/vdso32.lds.S
@@ -17,6 +17,8 @@ VERSION {
 	global:
 		clock_gettime;
 		__vdso_clock_gettime;
+		clock_gettime64;
+		__vdso_clock_gettime64;
 		gettimeofday;
 		__vdso_gettimeofday;
 	local: *;

-- 
2.50.1


Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092C3002DA;
	Fri, 15 Aug 2025 10:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254517; cv=none; b=IGpGzYFsBzcnHArJPuwgtjz7HKxsRndOOJsqT4dl7zSRIG91LSNyeNH7WfBjIqGAkP7FiLAowfE7IoCnJPWMtgZc+ebybvKUKwsJUzUPvyeFA9yw9fyqyVbhkfp000JvMptofIjaT/P3AnQZ0jQfO/vGnSE5ZPMusbCLr6vA60k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254517; c=relaxed/simple;
	bh=fxgNwbguzm19mxOl+d1yMzx0FAgO/SMJ+Tt1yKD0hgU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sHTwFjCTHdUK+OM6qBCAPj4jHmgLup4L26CuSYAmNabSgBoZLgsieWAZ+x1ssU0XyEKWkntbY51zPB5Ukg3tGS/em84y1O/SG+sf+s2yEZLHe/u9AnLihraQm2iNG7p6lNi8HOXM7eqasPEXhi1aWNvlvPImaZweDBLpnqYTxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKbG/KPV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MmIT1xov; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKbG/KPV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MmIT1xov"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7Fn8+v2ScBzJFYv6AzzkLmPfAu+RY8HxbLfk2DOx3Y=;
	b=pKbG/KPV4AcW6a4MHsxtxnNGo9s8AGwrJmeAEc9Y10Md+v4M/CqzVMHZqbBedGsDsTMSk9
	qgy7OO08iG+/164uyIvY2SawYhoxW3wXdBvnJtcmm7y/ZkTyIrX5251RmfQ6aaRzqVL//j
	knkvOri+hRuJh1+NvnlrMinno8l98B5UsemfEQl0djtSL+Y7Lj3mktPXHwXvCub/3+e/bU
	pYTAGIi2/codoU2uKraofLNKhuNdsJz9smirs546bMLcqA6Ew1xjliJtC5mHoZnZ7k+MVc
	KDKIORxozI1+7GMpqGf0G/qVVeh/2+376/SyUFWxSGFz8bVlwXZaT/OtW0NQlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G7Fn8+v2ScBzJFYv6AzzkLmPfAu+RY8HxbLfk2DOx3Y=;
	b=MmIT1xovdGZgu6/SYnBuI4EhM6ozIshd3NnNwg2gTI7eLpO+Rq9tLvW2BpPCLL6iPYkYVa
	7tggsKc6AqC+4yBQ==
Date: Fri, 15 Aug 2025 12:41:18 +0200
Subject: [PATCH v2 09/13] sparc64: vdso2c: Drop sym_vvar_start handling
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-9-b5ff80672347@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=1958;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=fxgNwbguzm19mxOl+d1yMzx0FAgO/SMJ+Tt1yKD0hgU=;
 b=Qr98k0yOx1r9l0av8wZs8vCGw2a873vDWjVuiZmYNGk/0sT6xQpDZXxiA3n2lyRUJiAX2JJU2
 ey+ReVrjCeIBnt8XHvJgxHwm+2DxkNFl3oVNTrA2o8Ezczi+7w9SWQ9
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

After the adoption of the generic vDSO library this symbol does not exist.

The alignment invariant is now guaranteed by the generic code.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/include/asm/vdso.h | 2 --
 arch/sparc/vdso/vdso2c.c      | 6 ------
 arch/sparc/vdso/vdso2c.h      | 4 ----
 3 files changed, 12 deletions(-)

diff --git a/arch/sparc/include/asm/vdso.h b/arch/sparc/include/asm/vdso.h
index 59e79d35cd7384e2dd752e92d20bc599e38cb8b0..f08562d10215bd3e9a2d4eaa0aadc8400b40e256 100644
--- a/arch/sparc/include/asm/vdso.h
+++ b/arch/sparc/include/asm/vdso.h
@@ -8,8 +8,6 @@
 struct vdso_image {
 	void *data;
 	unsigned long size;   /* Always a multiple of PAGE_SIZE */
-
-	long sym_vvar_start;  /* Negative offset to the vvar area */
 };
 
 #ifdef CONFIG_SPARC64
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index b97af5ec9f35c01f2a976b6213b1768b677ad231..70b14a436fe2297ab446f778ab0d43155c272421 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -58,18 +58,12 @@
 
 const char *outfilename;
 
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-};
-
 struct vdso_sym {
 	const char *name;
 	int export;
 };
 
 struct vdso_sym required_syms[] = {
-	[sym_vvar_start] = {"vvar_start", 1},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))
diff --git a/arch/sparc/vdso/vdso2c.h b/arch/sparc/vdso/vdso2c.h
index 60d69acc748f2401156a730027fe34abfb9fb6bc..ba0794659eb5af53b8c86b24f3221a5d0b3f74ab 100644
--- a/arch/sparc/vdso/vdso2c.h
+++ b/arch/sparc/vdso/vdso2c.h
@@ -104,10 +104,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
 
-	/* Validate mapping addresses. */
-	if (syms[sym_vvar_start] % 8192)
-		fail("vvar_begin must be a multiple of 8192\n");
-
 	if (!name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;

-- 
2.50.1


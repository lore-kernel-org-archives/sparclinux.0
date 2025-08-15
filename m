Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6014C2F90EA;
	Fri, 15 Aug 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254513; cv=none; b=Goz4ZSm7YH+XYP82MufuVj1kP9Tol2fHRn4zesZpbJ8+MxtUsaQrGXYzcI7XgC8U6a69D55OTm3+TXm6+OpxHQTeHkpZgQEPKWm/Z2jVbwUz/e1OfepQn+zUalSXhV6gMzx5byTcmsZlfcwqsq5JRyP7bF1Rgyz+7Q+p8TLbOLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254513; c=relaxed/simple;
	bh=e8hdBfEAunWm5z5dBSxtAkNh8u9HgO3NtR7zDMo0nrE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iS4eOF24YdDDFsOHIgAn9DmGa94Rd83fYFkhd5m4e86eCzRUBD98J5oEpp+/s2dkQKBeHwFk2OR+gHak/8UOdzHerCLMcTybXCV8Ddz7bOWkR6gg8IRf/VH7cR8gIvEi9th6tiwnyVVIj4yVwKh1B4LV5b/CB1JCwvmM9TRtk80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wb/6x4b3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=StYWTHkc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wb/6x4b3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="StYWTHkc"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3UBXYrZSrikLXywyNQh7Nv7j5x2sJSuJodc6YeKRNI=;
	b=wb/6x4b3nzgTLDOYyHe575s//uHl6ZCxoOWCoBByEagipw/luAG2fvxip3PU5QWOp+8gHE
	3zD8LVnjN55ljS8BRpKE9J4/S9g6bW3Uw+SiVXlu6U2olcTzIC+TKaRhYE5I9FoUnHMP0+
	FWVh1O1CT4gsEBvvy65/Zw1F4zLkkBJbhZRMzaVOKQ/c4GtYgULXNX5FIPCReCs8nj09n5
	BedT8VGIhK9+ApGSYyiSiMDu21497aon7JOJjiduZaW6DHB0vKShEA7SW2rPKzxnTB58MX
	5NfXo392IkmowmNJfeyB7ol0enq64JLbtL8nGgMMQB9j0NotK4rYaG/A/xbECA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q3UBXYrZSrikLXywyNQh7Nv7j5x2sJSuJodc6YeKRNI=;
	b=StYWTHkc7ZVbdCXFhGeSCi1P2EwaG9HJq5kviZ/TCKq5GveD/BgUtlnA/z6GlLsnl0Sjdm
	xBcuGt5YI+GPieDQ==
Date: Fri, 15 Aug 2025 12:41:11 +0200
Subject: [PATCH v2 02/13] sparc64: vdso: Link with -z noexecstack
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-2-b5ff80672347@linutronix.de>
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
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 Arnd Bergmann <arnd@kernel.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=1408;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=e8hdBfEAunWm5z5dBSxtAkNh8u9HgO3NtR7zDMo0nrE=;
 b=6IGnznFkiTgziruG9hnkb52voPuyHP9xEqD7GDkolS8EhQtSDg+EYM1Xd1/VLG5n5h5Ehejbv
 EcLYXlnDR11BzJkQzAjFi+5C3Qggbup89kqpCsIHE6gsdTLygv5GbgC
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The vDSO stack does not need to be executable. Prevent the linker from
creating executable. For more background see commit ffcf9c5700e4 ("x86:
link vdso and boot with -z noexecstack --no-warn-rwx-segments").

Also prevent the following warning from the linker:
sparc64-linux-ld: warning: arch/sparc/vdso/vdso-note.o: missing .note.GNU-stack section implies executable stack
sparc64-linux-ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker

Suggested-by: Arnd Bergmann <arnd@kernel.org>
Link: https://lore.kernel.org/lkml/20250707144726.4008707-1-arnd@kernel.org/
Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 683b2d40822447849d1b4a8e3f85d35dcf9d727e..400529acd1c10e7f05fdb6c330593acc3c06b6f0 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -104,4 +104,4 @@ quiet_cmd_vdso = VDSO    $@
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
 		       -T $(filter %.lds,$^) $(filter %.o,$^)
 
-VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined
+VDSO_LDFLAGS = -shared --hash-style=both --build-id=sha1 -Bsymbolic --no-undefined -z noexecstack

-- 
2.50.1


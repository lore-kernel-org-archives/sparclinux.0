Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75933C19E;
	Mon, 22 Dec 2025 08:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766392164; cv=none; b=ctAVLN47I6KAVjAmnhhbm/r9x0/lYUhRXcrGdtrvmMhQQW0u8oCcXS20So+qQriw7G3piP+1lJuQgBRSM9ojjiyJkbbPSuIjWTM2NejZ1ZWkSYtzMSyIdf8jD/prBTTxeeVwc1gEt/JzKjYYVShS9tVQTZzZnEovy+72Z0Xr5Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766392164; c=relaxed/simple;
	bh=QEfLCFE3llszSMpe364z5DsCg336MAVthNV41WWbuLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kKk0WL3fgl68f0WzJxtGMm3uz4yKM5g//JLWoc3BcQ/K7wQ5CrpZRDZcm+knvvwllUe+HKbGXTDq4jkq+akWRPF2mLh1ZfmbS8ME308jX3yYABQ1xRRONaC/VxgQLu5mjY0yQ2L6nt8j4NcmxCNZuzXmvbpeK8p1aX7/uX4PPWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GFqVkJ7W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oGkUzitm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GFqVkJ7W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oGkUzitm"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766392161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fHBz60j63TpFG78FEfVfGYWoH5y8sth8ik3iZDlkOk=;
	b=GFqVkJ7WQOybnopHXw7ZdfX9ONo9nc/DiucuBDhlzN7+PGWs3UAALeCWjXV2/EzNvCb+o4
	oHACjsnqUrtbMHPnda2qZks+R8Msv0Ug232vyYOrBVqH6BKyEc7tXjukM/vBxe6x7ivnP6
	PMltakzvnUI0BYsRn0oYwJg0btbnQXTlC0RKAeAwmmzTtbJNafnFU1Jzy5rW5/M3fQM4oq
	Bi8/Stb4mcnXT6/hSks5PBblVGVtuV3PlAfjitpzJCyMbz3505kyulHzLhohsi5R4kcdVn
	CG57m4a5mFfiOGKRsrM8UOGegIlsqUpWLlRglhwgkRkOBrvzt8XqLVRjxHOYQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766392161;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=5fHBz60j63TpFG78FEfVfGYWoH5y8sth8ik3iZDlkOk=;
	b=oGkUzitmwVMEZyFIgl+iVGrRE+D12QpOIdISO0/5WLpUP/K413vNCC6faXyxZJuoXHZz+C
	BqwNFZOOaJq4iyCA==
Date: Mon, 22 Dec 2025 09:29:15 +0100
Subject: [PATCH] sparc: Implement ARCH_HAS_CC_CAN_LINK
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251222-cc-can-link-sparc-v1-1-1823e4f49480@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAFoBSWkC/x3MMQqAMAxA0atIZgNtpAheRRzaGDUotbQggnh3i
 +Mb/n+gSFYpMDQPZLm06BkrbNsAbz6ugjpXAxlyloiQGdlHPDTuWJLPjNZ1EnrhYIKD2qUsi97
 /c5ze9wNaYVGhYwAAAA==
X-Change-ID: 20251222-cc-can-link-sparc-153eb7ecb0b5
To: "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766392161; l=1251;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=QEfLCFE3llszSMpe364z5DsCg336MAVthNV41WWbuLI=;
 b=xMdkuba53nRvsoOH3R5BF+mR8Gm4tp+SQ4H8mPui/fqrSYmXv4wDd5eyu2vEUB2uN9ReWHSYT
 4kDA20m2LtiDTuZOfXKjfNsF60KAY+8AI2PKkpZcxjszxbCVxKM0dgY
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

The generic CC_CAN_LINK detection does not work for all architectures.

Make the logic easier to understand and allow the simplification of the
generic CC_CAN_LINK by using a tailored implementation.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a630d373e645..68b553a47d03 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -13,6 +13,7 @@ config 64BIT
 config SPARC
 	bool
 	default y
+	select ARCH_HAS_CC_CAN_LINK
 	select ARCH_HAS_CPU_CACHE_ALIASING
 	select ARCH_HAS_DMA_OPS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if SPARC64 && PCI
@@ -475,4 +476,14 @@ config COMPAT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
 
+config ARCH_CC_CAN_LINK
+	bool
+	default $(cc_can_link_user,-m64) if 64BIT
+	default $(cc_can_link_user,-m32)
+
+config ARCH_USERFLAGS
+	string
+	default "-m64" if 64BIT
+	default "-m32"
+
 source "drivers/sbus/char/Kconfig"

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251222-cc-can-link-sparc-153eb7ecb0b5

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


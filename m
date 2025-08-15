Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F4B2FD1B7;
	Fri, 15 Aug 2025 10:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755254514; cv=none; b=AAPQNAlOJcn1IxakuH7WVY9X9VZFaqrkmUrwkZhyug2yU6DWxrb2TbjUSzWaZYZtpR6ZE9IaaOO6gtt7XLYT2Tfq50Cp9V50uODWkKM+JY8ZuUPCGH5NvIebax+udblvr0rvkudaiRLBnDintvPeadHsB0tUM/ACK/pEhfJFp5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755254514; c=relaxed/simple;
	bh=/d7Kjsadf0MQRlQ8rFqan/QHEDoMwt3EGw/m83TdkFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BaDl9LnjHkziwbtp+DVUW/KsDoxMpcMsSOXFR0rWdkNNF9/68ZSLuefBl03EOZZtinaKnmrAXbEg+mcDVCrD0TZv2J8jn5kHfbtdQNeGgB/ZQTPMEEUGB+pzotJZI/oyjIBW9mCS58RV0Y+uQSNkYeVinbsxUQurzIUbsTMIOMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MRS5uzyA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HBZme7Gz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MRS5uzyA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HBZme7Gz"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755254511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnPjxZaxoUQoAn4OPvNzydHs4g6dzmGoN+Wts/M/WYo=;
	b=MRS5uzyALOzzbgqIhr/NW+nmRjpJu+QOVsGga4UsRDsYzq+7wKoSN5wMrZBmYsyN4AUex6
	dXY7Qx8GpaD/h3c0tv7ZWcdBjsuIkpRik2IQluiTnLQ/RmD7pc60u6NNO5eqRq81beUSQb
	fFbIrVWhCQaTA0B3ou8Cc4Of4EjDU+jiSB3CojIkH/J1b4fstgRXehDbanAmwu17yVRPdu
	L+THH6HpQO9lIOB874/AspJYWqCPv1mnLSYShwUQAbYuiQjt4brgDg0YL82Ew4Gd075+Bw
	KF4ayeZWZ0a7/klEVPupKXcayftkNoDJAgd/Myt3rL+EZfZZVupxM8jXMYchkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755254511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qnPjxZaxoUQoAn4OPvNzydHs4g6dzmGoN+Wts/M/WYo=;
	b=HBZme7GzSr4gGDyuWHkNNihJTMQ2ovo2bBJA20daPHSiH4TmEVrVlnVPy97p6AbZq0/OUP
	fyqHaf26Btks9MBA==
Date: Fri, 15 Aug 2025 12:41:12 +0200
Subject: [PATCH v2 03/13] sparc64: vdso: Remove obsolete "fake section
 table" reservation
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250815-vdso-sparc64-generic-2-v2-3-b5ff80672347@linutronix.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755254507; l=2564;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=/d7Kjsadf0MQRlQ8rFqan/QHEDoMwt3EGw/m83TdkFo=;
 b=aAJMYxAJOCSnDVjOGCL6ij9n9oPUK4D1ASxHPS9A822Lh6c08x9F5LBNwkSBxxqw8O0WPfWjb
 2S/GchAi9iuDa52mcVhfjGqR1iu0Ot4hJtThRuSSG44XDOIrDp6FJow
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

When the vDSO logic was copied from x86 to SPARC some unused remnants of
the fake section handling were copied, too. In x86 the original fake
section handling had already been removed incompletely in commit
da861e18eccc ("x86, vdso: Get rid of the fake section mechanism").
On x86 the reservation was only cleaned up in commit 24b7c77bbb24
("x86/vdso: Remove obsolete "fake section table" reservation").

Remove the reservation for SPARC, too.

Fixes: 9a08862a5d2e ("vDSO for sparc")
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 arch/sparc/vdso/vdso-layout.lds.S | 21 ---------------------
 arch/sparc/vdso/vdso2c.c          |  8 --------
 2 files changed, 29 deletions(-)

diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.lds.S
index d31e57e8a3bbffd3afb187cd631e2491fde64148..9e0804789d11696948f11be367480b530a1f18d9 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -4,16 +4,6 @@
  * This script controls its layout.
  */
 
-#if defined(BUILD_VDSO64)
-# define SHDR_SIZE 64
-#elif defined(BUILD_VDSO32)
-# define SHDR_SIZE 40
-#else
-# error unknown VDSO target
-#endif
-
-#define NUM_FAKE_SHDRS 7
-
 SECTIONS
 {
 	/*
@@ -47,19 +37,8 @@ SECTIONS
 		*(.bss*)
 		*(.dynbss*)
 		*(.gnu.linkonce.b.*)
-
-		/*
-		 * Ideally this would live in a C file: kept in here for
-		 * compatibility with x86-64.
-		 */
-		VDSO_FAKE_SECTION_TABLE_START = .;
-		. = . + NUM_FAKE_SHDRS * SHDR_SIZE;
-		VDSO_FAKE_SECTION_TABLE_END = .;
 	}						:text
 
-	.fake_shstrtab	: { *(.fake_shstrtab) }		:text
-
-
 	.note		: { *(.note.*) }		:text	:note
 
 	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
diff --git a/arch/sparc/vdso/vdso2c.c b/arch/sparc/vdso/vdso2c.c
index dc81240aab6fd31a72b8a751cc2a4a821a3c4e4e..b97af5ec9f35c01f2a976b6213b1768b677ad231 100644
--- a/arch/sparc/vdso/vdso2c.c
+++ b/arch/sparc/vdso/vdso2c.c
@@ -61,8 +61,6 @@ const char *outfilename;
 /* Symbols that we need in vdso2c. */
 enum {
 	sym_vvar_start,
-	sym_VDSO_FAKE_SECTION_TABLE_START,
-	sym_VDSO_FAKE_SECTION_TABLE_END,
 };
 
 struct vdso_sym {
@@ -72,12 +70,6 @@ struct vdso_sym {
 
 struct vdso_sym required_syms[] = {
 	[sym_vvar_start] = {"vvar_start", 1},
-	[sym_VDSO_FAKE_SECTION_TABLE_START] = {
-		"VDSO_FAKE_SECTION_TABLE_START", 0
-	},
-	[sym_VDSO_FAKE_SECTION_TABLE_END] = {
-		"VDSO_FAKE_SECTION_TABLE_END", 0
-	},
 };
 
 __attribute__((format(printf, 1, 2))) __attribute__((noreturn))

-- 
2.50.1


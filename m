Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0A550EBFE;
	Tue, 29 Sep 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689446; cv=none; b=LEH7OJA1y/l1gdt0mzE4+qKnjxfchSiimxF9TxzyTPs4BGp6IEvx441BKrwzgB4kL2BryOi6vdw7SsmRTdf5cpbVCBFm7N5cchoUif+PWDMzzjpGpGlMYhmKxENTE4Dx4IitDxery4QD7GozSh4vjD3Ri6QEb5YnEab5iPXdKe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689446; c=relaxed/simple;
	bh=N3GKe8jMHvYD+swhXPAL1qad5N0QDrikHieoWGqYX34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EfBLoPAXihktKqrxx1yoK2/xLu7VLFQPKOa0EODiZQrbG7kWqaxSLQzP6A4rO1eKukJNiu7UMFkVEzbrxpzflnKjoFJoCy0Oxr5Ogs9/Q3FjWkm0DWel8vCgK+vV3JKa+r3DJ3T+zV58pPs4ULN42SC3mE0MqHW9X5uioS2c1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=oIc1fdhg; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="oIc1fdhg"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790689442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZSHoR/nRUuVPLYyyleN3slwW8taNuQbKVWyFd4qCXmQ=;
	b=oIc1fdhgtrX/PRAe9WH08JxQtvoRuFfxZVXvIrChDISzYgm5b+hw8nPK9fgrDWMIpSveLw
	km1G6QhX92C40DBwPlc7+Ey0j6frIHR0+XsH+pBfysrjKHG9hq8p28rzn/XeppgzIsfaeR
	Gvvgtcm9ZS2ugp8d1YogBgwQqOkPNXc=
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 2/5] sparc64: Add the M7 capabilities carried in the hwcap-list
Date: Tue, 29 Sep 2026 15:43:50 +0200
Message-ID: <20260929134353.3879030-3-stian@itx.no>
In-Reply-To: <20260929134353.3879030-1-stian@itx.no>
References: <20260929134353.3879030-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A SPARC M7's machine description names four capabilities the kernel does
not know, so they never reach AT_HWCAP:

    vis3b pause-nsec mwait sparc5

Add them. hwcaps[] is indexed by bit position and only ever appended to,
so the four names take indices 28 to 31, in the order the machine
description lists them. That fixes their bit values.

Read from /dev/mdesc on a SPARC T7-1, where all 256 cpu nodes carry an
identical hwcap-list.

Closes: https://github.com/sparclinux/issues/issues/17
Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/elf_64.h | 8 ++++++++
 arch/sparc/kernel/setup_64.c    | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 694ed081cf8d9..714ca79c88d7e 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -99,6 +99,14 @@
 #define HWCAP_SPARC_CRYPTO	0x04000000 /* CRYPTO insns available */
 #define HWCAP_SPARC_ADI		0x08000000 /* ADI available */
 
+/* Linux has only AT_HWCAP, so these continue the single word.  They are
+ * ABI: a bit once assigned cannot be moved.
+ */
+#define HWCAP_SPARC_VIS3B	0x10000000 /* VIS3B insns available */
+#define HWCAP_SPARC_PAUSE_NSEC	0x20000000 /* PAUSE has nanosecond granularity */
+#define HWCAP_SPARC_MWAIT	0x40000000 /* MWAIT available */
+#define HWCAP_SPARC_SPARC5	0x80000000 /* SPARC5 insns available */
+
 #define CORE_DUMP_USE_REGSET
 
 /*
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 8ed65ad0e6081..d819ce65d1d44 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -387,7 +387,7 @@ static const char *hwcaps[] = {
 	"mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
 	"ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
 	"ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
-	"adp",
+	"adp", "vis3b", "pause-nsec", "mwait", "sparc5",
 };
 
 static const char *crypto_hwcaps[] = {
-- 
2.43.0


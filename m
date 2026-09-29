Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4DB52B1FB;
	Tue, 29 Sep 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689447; cv=none; b=lzQ8Q7taOMt/2RgpmraEG6kXzWPBTDtxJH7tGZNf8bf0pgb0jVfZ4kbOzaB+hLpc7LOf6L9NC7UmUyQGVXAZ/atZpY8lkzqNwDca1M9pMVM92cSr/F8gVpSbhC06HZ6OBJQK6FKKPhcuXOhoUqqVMxZiuSbqgEFczneE2DtKIaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689447; c=relaxed/simple;
	bh=qlyHS4iJQ7BrMrksXagii/UEoD+9i6v84/cW4b7sq6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAEvAsosLNoFkDLk+WMhml3ED8vPvRkaxdtBhs+2aykcXMC+2ROWBImF3WEuBfakoVwacC45EmFT+DT+Jjc4y6S7+J1GRBN+xb88z0P+OvXqQA2Ei+00exLmz6TIuI8T2Cu1gCaf9TxkwzYYwNN1mvebYH+rfVjl4K92WipXF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=EvejGk96; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="EvejGk96"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790689442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=adL1F/nYZDGIVACVvafixgvFG5DK1XHCfv0m2eLuaLs=;
	b=EvejGk96PQKff5J9haLGYmCeXRKBRS+rlvDu59BKapjR6m2xawHu0uYLy//3y6zYLNw9yj
	vzt70mxdBDN5OvnLx1M/sxu6hAdtFMn1E0jHOcSFI+zz3gWLu8FM8xz3I9m86XdZUJ2hGx
	po3IQglgyiue/IvgYLr5xxKlSTMz+Q8=
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 4/5] sparc64: Derive VA masking support from the machine description
Date: Tue, 29 Sep 2026 15:43:52 +0200
Message-ID: <20260929134353.3879030-5-stian@itx.no>
In-Reply-To: <20260929134353.3879030-1-stian@itx.no>
References: <20260929134353.3879030-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

VA masking is not named in the cpu node's hwcap-list. The machine
description carries va-mask-nz-mask instead, which is present and
non-zero only on a chip that has the feature. A SPARC M7 reports
0x80808080.

Read that property rather than matching on sun4v_chip_type, so the
kernel does not have to carry a list of every chip that implements VA
masking.

hwcaps[] gains "vamask" as well, for firmware that does name it. The M7
does not.

The bit lands at 32, so a 32-bit task cannot see it: compat_binfmt_elf.c
narrows AT_HWCAP to Elf32_Addr.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/include/asm/elf_64.h |  1 +
 arch/sparc/kernel/setup_64.c    | 32 +++++++++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 714ca79c88d7e..12832e1126d8a 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -106,6 +106,7 @@
 #define HWCAP_SPARC_PAUSE_NSEC	0x20000000 /* PAUSE has nanosecond granularity */
 #define HWCAP_SPARC_MWAIT	0x40000000 /* MWAIT available */
 #define HWCAP_SPARC_SPARC5	0x80000000 /* SPARC5 insns available */
+#define HWCAP_SPARC_VAMASK	0x100000000UL /* VA masking available */
 
 #define CORE_DUMP_USE_REGSET
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 71d30b3bf276f..6f3b1d56a8c79 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -387,7 +387,7 @@ static const char *hwcaps[] = {
 	"mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
 	"ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
 	"ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
-	"adp", "vis3b", "pause-nsec", "mwait", "sparc5",
+	"adp", "vis3b", "pause-nsec", "mwait", "sparc5", "vamask",
 };
 
 static const char *crypto_hwcaps[] = {
@@ -521,6 +521,33 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 	return caps;
 }
 
+/* VA masking is not named in the hwcap-list.  The cpu node describes it
+ * with va-mask-nz-mask instead, which is non-zero when the chip has it.
+ */
+static bool __init mdesc_cpu_has_vamask(void)
+{
+	struct mdesc_handle *hp;
+	const u64 *mask;
+	bool ret = false;
+	u64 pn;
+
+	hp = mdesc_grab();
+	if (!hp)
+		return false;
+
+	pn = mdesc_node_by_name(hp, MDESC_NODE_NULL, "cpu");
+	if (pn == MDESC_NODE_NULL)
+		goto out;
+
+	mask = mdesc_get_property(hp, pn, "va-mask-nz-mask", NULL);
+	if (mask && *mask)
+		ret = true;
+
+out:
+	mdesc_release(hp);
+	return ret;
+}
+
 /* This yields a mask that user programs can use to figure out what
  * instruction set this cpu supports.
  */
@@ -598,6 +625,9 @@ static void __init init_sparc64_elf_hwcap(void)
 					AV_SPARC_FMAF);
 		}
 	}
+	if (mdesc_cpu_has_vamask())
+		cap |= HWCAP_SPARC_VAMASK;
+
 	sparc64_elf_hwcap = cap | mdesc_caps;
 
 	report_hwcaps(sparc64_elf_hwcap);
-- 
2.43.0


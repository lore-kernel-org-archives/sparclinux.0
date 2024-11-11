Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AD314F9F9
	for <sparclinux@vger.kernel.org>; Mon, 11 Nov 2024 20:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731358180; cv=none; b=Gysjx+yOBwkb+8ODt0ZrUsdMtMKsotrH1QpDZ0UQnIlahfRhmeFVKPhXuBgiqXjoOABE1gEcFH/tnSeBhai6VukOlivhSNRQN6t9t/pJqhzkWSU27tcpOBY0CFKXgxPgfybkRkMwdZ+d15b74jPiq8HHoKg/Q5wHaAuOIytrMms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731358180; c=relaxed/simple;
	bh=D8s++4EnV2bNYvN5wrQ3WljRShbW0f+sEVQALGUlCUw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GtsrAed7Ck4T8zAnic8cXZqaRc2Q+yIjtTwamSAej4rga4iLsz5PYFNO2WubxMlrejL6Bw6H2wGV0UHs9crXI+XNkB8if4RYgnScHHR+HJ7W+Z4BkBQY3p5uKdg5Dxrct5M40L7U8SD8G1GIDm3K6+WblCijaqbF9WNhqnDI2lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=AHwC26w0; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="AHwC26w0"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731358176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bw/uAtfi/0ahqKcqeR+WxFJl39p2Qshd9Y7/NqgYqQM=;
	b=AHwC26w0YLZfSoXPU1Nx7tXF+glc9a2JSyh08+xfwrZpt+xV0HJVmVcmgIbQN/ZjAYZUkW
	tdxIkN4BXVuAbCAgkywWoND65FSoxP1pqGQOr2kJk3UHp7VHJ0FUI1ttLkYDRoluCHxIxf
	FvNOmxvA8WmH/pV1ZR+fvRIq6UbKros=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Arnd Bergmann <arnd@arndb.de>,
	Sam Ravnborg <sam@ravnborg.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-hardening@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] sparc: Replace one-element array with flexible array member
Date: Mon, 11 Nov 2024 21:47:21 +0100
Message-ID: <20241111204724.165263-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace the deprecated one-element array with a modern flexible array
member in the struct hvtramp_descr.

Additionally, 15 unnecessary bytes were allocated for hdesc, but instead
of fixing the parentheses in the open-coded version, use struct_size()
to calculate the correct number of bytes.

Link: https://github.com/KSPP/linux/issues/79
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Fix the number of mappings after feedback from Gustavo A. R. Silva
- Link to v1: https://lore.kernel.org/r/20241111200155.164621-3-thorsten.blum@linux.dev/
---
 arch/sparc/include/asm/hvtramp.h | 2 +-
 arch/sparc/kernel/smp_64.c       | 4 +---
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/hvtramp.h b/arch/sparc/include/asm/hvtramp.h
index 688ea43af0f5..ce2453ea4f2b 100644
--- a/arch/sparc/include/asm/hvtramp.h
+++ b/arch/sparc/include/asm/hvtramp.h
@@ -17,7 +17,7 @@ struct hvtramp_descr {
 	__u64			fault_info_va;
 	__u64			fault_info_pa;
 	__u64			thread_reg;
-	struct hvtramp_mapping	maps[1];
+	struct hvtramp_mapping	maps[];
 };
 
 void hv_cpu_startup(unsigned long hvdescr_pa);
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index e40c395db202..24d980220bf1 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -297,9 +297,7 @@ static void ldom_startcpu_cpuid(unsigned int cpu, unsigned long thread_reg,
 	unsigned long hv_err;
 	int i;
 
-	hdesc = kzalloc(sizeof(*hdesc) +
-			(sizeof(struct hvtramp_mapping) *
-			 num_kernel_image_mappings - 1),
+	hdesc = kzalloc(struct_size(hdesc, maps, num_kernel_image_mappings),
 			GFP_KERNEL);
 	if (!hdesc) {
 		printk(KERN_ERR "ldom_startcpu_cpuid: Cannot allocate "
-- 
2.47.0


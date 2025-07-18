Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4F298993;
	Fri, 18 Jul 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752830854; cv=none; b=sI1oinsJSpO28EXaTWljMtREG0w7zQZUIdvgJVV6p0XxGc0EVl/WtERGMMVmpW8ihLO/oqkNzp6USa5/Sfr8KW7IxWsW8iLP2Mx8DKk1+ajCWTMdaSm8ibxMfr/6QOr/N3DYSlp7AHjjCx1KsqNRhfW4EzngzcKwJ5Nl209yQts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752830854; c=relaxed/simple;
	bh=SBEJ5AN9yIAktlQ5TYSoFsfOz4ynEextl94SNkFwv40=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=cV7mZSDlHDFYl2o4JosaS/ZWocDKgnA/NeLV+DKCQwS5qRuh05YAjy+oK2y+Dktx344h4Qsosc8DGSDjY85DGhxg05Lm6n14K6Xos8xs/D5khtfYan7unKTLy/uNDc8/jIYYZvWAyZx9vX2DF4cLWjfPHg1TLoLRfoHr2ZZggY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=v26ZVjRc; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="v26ZVjRc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1752830543; bh=tLg5rpkVt1EnatvspzAi7dGN6Es58cpkXsX9othXW3w=;
	h=From:To:Cc:Subject:Date;
	b=v26ZVjRccDWOC8uao3KZu49yJyNa4cHOoQUiuiBlQhZV5w/TixpPqUesWPyPnwpcp
	 0xoSJ/WVlDhMrtQX6S+M9vpcZa/c3+cOzNe/ReT0/EZ8BU0LIxG962HrL/12jvUvQo
	 DeZ4OT2m5+TaTiaLhxY+OzdUaD+Lqj2PljXItRqk=
Received: from VM-222-126-tencentos.localdomain ([14.116.239.35])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id 59639C8E; Fri, 18 Jul 2025 17:22:22 +0800
X-QQ-mid: xmsmtpt1752830542trk0pn2rb
Message-ID: <tencent_C3DEC6F98F25C1BF6F35F3A1B0A629E0EA0A@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe08Xdcad3KRazsZsRNMM8TaodY2Q+cHcQ54aNO1ouL5IP2KT1T1
	 f+3SCFyr8o88wfxfLknU55vi8ZHbB4MpeE1/VC6+9q0rG6rf4JrX3FFs+T0c31IlxiLn3n1WwCpI
	 33NWAeXn52fCryP1RDrgmwx710edCElsX0vnkKbjGU4DulXh/D33wwrROqE6ow7Ug4lgdj1sHPTw
	 4PDyk4HsYALRXC6L22QHeOXsFZYaKx/pB1Cb/a8m3b9e1Dq7DCQJJ4SthwgbfEE5RPKJyuAlDc9y
	 CdidvsvBMMbbr2cvVMRDid0Auftb5XZykeZnxvRR5p6lS2eI/8LY2knL/zyOMbdgPmducqZ8whR8
	 u5cr4BEdHckL9Qh/MFxQa8zwttww/SlS+a51A/DtC7s4wBR1hG9gDvXTk8tDB4aopBUqe4JE24mx
	 4Tg9bdTBZUu8XJyQJzh6YkX4CV+EhJ9Fohqp6sZ/pwnBm1UGtlxPO6DSFQC+gK4n4IjeQRYKSRtr
	 K6gaf/E0NnLNvH28Uf506+1VkPckcHDeLHRiNCMaUCTXtT6p6CWa4rwHMgCBzlt9l5JyJx5UvO1V
	 F4wiB4liHRjb2rk1JnI4z3bEauU+HwPm+y2iqFqPdSq7m3EWU63vbKKusCAhBULQ2UE2rwbVE+J+
	 3eBWiWaZyP9aSq5CtMJMOD7mCa1hVGxHqwzbOwrhf5nbuAWPaNi7hSyParJQL9x+ydfb661/EO6R
	 XXb0diD3YV7CtGiHlIn3t3ELzwsJwQMQalW2rsjhYltHVDQDSZtwE9t4NQjD4iBGt+rZ8SiSr4p0
	 fOIdXHqcBUNEJxyNQA2GOLWJFuJZKiPHy6fbZFBBgFIjLx0/4E2pWmv/qkf9eZUypwjIIGEyN1Zk
	 KlddKpogZbG2eqE6X+Rdege3kTSdoXYeRIh4peh9leXfKCldkNrcUqsX2A+K617u07CLWX9DbQzM
	 gFhokcaSCHQI7e27aagmGj/EGPGqp1zJc7RrNE6gGgBLLejr5Sdj+Y0UtpQ6n2qdfpv8EgzjixDe
	 U/i6aP7G5k+h+rMtw3VvnIjKIxKyRwLoFg32CXmVDshQAMkgtPXk3kceb6u/Q=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jacky Liu <1972843537@qq.com>
To: davem@davemloft.net
Cc: andreas@gaisler.com,
	1972843537@qq.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arch: fix resource leak in chmc.c
Date: Fri, 18 Jul 2025 17:22:15 +0800
X-OQ-MSGID: <20250718092215.1892911-1-1972843537@qq.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Siyang Liu <1972843537@qq.com>

In the jbusmc_probe function, the device node mem_node fetched 
via of_find_node_by_path("/memory") is not properly freed 
on all code paths. 
This can lead to leakage of device node reference counts, 
which may result in kernel resources not being released.

This issue was detected by rule based static tools 
developed by Tencent.

Signed-off-by: Siyang Liu <1972843537@qq.com>
---
 arch/sparc/kernel/chmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/chmc.c b/arch/sparc/kernel/chmc.c
index d4c74d6b2e1b..a7040ee7e5bc 100644
--- a/arch/sparc/kernel/chmc.c
+++ b/arch/sparc/kernel/chmc.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2001, 2007, 2008 David S. Miller (davem@davemloft.net)
  */
 
+#include <linux/cleanup.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
@@ -397,14 +398,14 @@ static void jbusmc_construct_dimm_groups(struct jbusmc *p,
 static int jbusmc_probe(struct platform_device *op)
 {
 	const struct linux_prom64_registers *mem_regs;
-	struct device_node *mem_node;
+	struct device_node *mem_node __free(device_node) =
+			of_find_node_by_path("/memory");
 	int err, len, num_mem_regs;
 	struct jbusmc *p;
 	const u32 *prop;
 	const void *ml;
 
 	err = -ENODEV;
-	mem_node = of_find_node_by_path("/memory");
 	if (!mem_node) {
 		printk(KERN_ERR PFX "Cannot find /memory node.\n");
 		goto out;
-- 
2.43.5


Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FED246A09
	for <sparclinux@vger.kernel.org>; Wed, 15 Jan 2025 09:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736931857; cv=none; b=LUubagVUdfckArprrrsLyklBjti3wYzRmgRUxtBNXjrVQIQsJQTUNqG+yf6gXkfkMTyCd9mAXyVRL/Tig+O9JKTTNsyeBT9da/8HzFQTxg+fIoQxWf0qwjLuA2jUMGpfLmJQqiS9BpljCmuk0FzfGD1sj+CzNUIGAiQ3O5P3oB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736931857; c=relaxed/simple;
	bh=FW140magckJx2VEp+JBup5eKBV/WtjgEL3HKaK/dn9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sOXpsbUV3hwBdRDjlvMOokiNzkFuc4g6vFW/ijBc/iQL4iOsi9KDtdAMGtmQPOZrV0ZEFDW/oFhjiJHcswFyyONP0na69/4X5MIHpIdRqxCpr/Zavgqkzr7kBgma7gU209/zpnoE3z+17EwLS1+Lt0Y3u7y7Au/IzUIkVYzpcNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XT8PXDTy; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XT8PXDTy"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736931853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SjHFYiN2Q04s0wQvCMLw+2kUwZ3ouoGYQf4kxJbFIwQ=;
	b=XT8PXDTy85UR086uotA0XTY8n2008vagvuocS1pdfjdFEIa2m37nmtVQXXPtzNM/EVyGd3
	gs3rGbQ8IffkeyXD7GxdUY0/UuxHTuPUKJbR96bIB4hQ/YHwpA8njURLibPst6cjuQQneX
	Tb9gL//UYWwH2u5ifxOgeUCBR8O0P1U=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dawei Li <dawei.li@shingroup.cn>,
	Sam Ravnborg <sam@ravnborg.org>,
	Randy Dunlap <rdunlap@infradead.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc/irq: Use str_enabled_disabled() helper function
Date: Wed, 15 Jan 2025 10:03:43 +0100
Message-ID: <20250115090344.918290-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/irq_64.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 01ee800efde3..aff0d24f8c6f 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -22,6 +22,7 @@
 #include <linux/seq_file.h>
 #include <linux/ftrace.h>
 #include <linux/irq.h>
+#include <linux/string_choices.h>
 
 #include <asm/ptrace.h>
 #include <asm/processor.h>
@@ -170,7 +171,7 @@ static void __init irq_init_hv(void)
 
 	pr_info("SUN4V: Using IRQ API major %d, cookie only virqs %s\n",
 		hv_irq_version,
-		sun4v_cookie_only_virqs() ? "enabled" : "disabled");
+		str_enabled_disabled(sun4v_cookie_only_virqs()));
 }
 
 /* This function is for the timer interrupt.*/
-- 
2.47.1


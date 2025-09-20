Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71A5241664;
	Sat, 20 Sep 2025 12:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758372816; cv=none; b=ocp3vISJrFNjIOkf+/xmrbQS/1YeLCFOcp/RCGyC+TbpU4sFqTwazmUhx6mo+VrcoRfrEQ88Hhc7T6GBB6G/W3bFbnyYeZUyTHGLxIKK+Dq5rWlid3sLRtuTJq0wf5L7IeRcvY3aiWYYqS2hXe0lMnmBZkH/49KRIrb+0Q5B7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758372816; c=relaxed/simple;
	bh=F3Y0jp+sMwL2t11HK+ju1qlPSDUMGQ0dShUlHwo49OM=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HhUCcXvJI6x7c7UXIEDr9pFSw0QfpW2I81XHSgJ0ksKFTsuODHbkzSv69w6BuBPKZv/VevtmUfKE9ERXhipwAySNXli2C27EJzlx3DgLFB/LktlMZ99sc7Edk1sINBar+eK6JWkCEBlXgiPolpL/XJXr9kysRl1vWuWT8DsjJqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [202.112.113.212])
	by APP-03 (Coremail) with SMTP id rQCowAD3RH+5o85oKYTuAw--.32282S2;
	Sat, 20 Sep 2025 20:53:17 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: davem@davemloft.net,
	andreas@gaisler.com,
	make24@iscas.ac.cn
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3] sparc: fix error handling in scan_one_device()
Date: Sat, 20 Sep 2025 20:53:12 +0800
Message-Id: <20250920125312.3588-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:rQCowAD3RH+5o85oKYTuAw--.32282S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw45JFyrCr15ZF1DWrg_yoW8Zryxp3
	4kAF98JrWUuF1kCr47Xr1xZFyUCw1jy3WfWw15Cw1UKrn3WryrX3s29rZ5Kw15trZrCF40
	gF9Iqa10ya1UWw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCY02Avz4vE14v_Xr1l42xK82IYc2Ij64vIr41l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUn6wZDUUUU
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>

Once of_device_register() failed, we should call put_device() to
decrement reference count for cleanup. Or it could cause memory leak.
So fix this by calling put_device(), then the name can be freed in
kobject_cleanup().

Calling path: of_device_register() -> of_device_add() -> device_add().
As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: cf44bbc26cf1 ("[SPARC]: Beginnings of generic of_device framework.")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
Changes in v3:
- also fixed the same problem in arch/sparc/kernel/of_device_32.c as suggestions.
Changes in v2:
- retained kfree() manually due to the lack of a release callback function.
---
 arch/sparc/kernel/of_device_32.c | 1 +
 arch/sparc/kernel/of_device_64.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/sparc/kernel/of_device_32.c b/arch/sparc/kernel/of_device_32.c
index 06012e68bdca..284a4cafa432 100644
--- a/arch/sparc/kernel/of_device_32.c
+++ b/arch/sparc/kernel/of_device_32.c
@@ -387,6 +387,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
+		put_device(&op->dev);
 		kfree(op);
 		op = NULL;
 	}
diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index f98c2901f335..f53092b07b9e 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -677,6 +677,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
+		put_device(&op->dev);
 		kfree(op);
 		op = NULL;
 	}
-- 
2.17.1


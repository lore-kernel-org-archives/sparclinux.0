Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B5F1B0412;
	Tue, 15 Apr 2025 02:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744683519; cv=none; b=qrUsHlee/qs0HgBBS4b+5WFPyXoDtqOkcjh0FzaueMB7pq3LzHhk2Zn9BcYkC4Qo2/NZY5s/gPULFCD/OMyVnEoowrMCY3X5DSWXtE0lQCWHI4WsI6dNS3isZ3cskCUZPX1pApuHl6JEn6n9HizGdr6UnvDghaU4+mq36Z1SGFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744683519; c=relaxed/simple;
	bh=nGVvF6nK59wes4T4bei2C9AddEL7aiF3cGhmMHQLGzQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OQ8LMuAOY6E6NrLbpx2znNaTdQdV2eSMRbFVeHc6Vux2QRdHshnAQpyqWbsGxmYa7uQKBB9p0t9ahYwXXwbr0FgdLAH4FFk+QllTebZxDhRODYCHdWBy56xM6NhjDS2LqhGVgX8qxhvi6tqKYVw+2X0DHeoDDO5GbadIIRNV7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-01 (Coremail) with SMTP id qwCowAD3oQLqwf1n5O3rCA--.14844S2;
	Tue, 15 Apr 2025 10:18:21 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sam@ravnborg.org,
	dawei.li@shingroup.cn,
	make24@iscas.ac.cn,
	rob.gardner@oracle.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2] sparc: fix error handling in scan_one_device()
Date: Tue, 15 Apr 2025 10:18:12 +0800
Message-Id: <20250415021812.3106169-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAD3oQLqwf1n5O3rCA--.14844S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WryrKw45JFyrCr15ZF1DWrg_yoW8Gr4xp3
	s7Aas8JrWUur1vkws7XF18ZF1UCw4jy3Wruw45C3W0krn3WryrJ3yv9r4kK3W5trZrAF40
	qrZrtw10yF4Uu3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBI14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8v
	x2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

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
Changes in v2:
- retained kfree() manually due to the lack of a release callback function.
---
 arch/sparc/kernel/of_device_64.c | 1 +
 1 file changed, 1 insertion(+)

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
2.25.1


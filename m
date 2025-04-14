Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3661A18DB18;
	Mon, 14 Apr 2025 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629559; cv=none; b=nxPKLf31lsC3XfVy3bgxYY8ZbyG5iV1zwgu1sS/JsaaDfwuP0OavDETW8c9MypOWI+oZ/PiitdZ7sSSWuALNyvmssSl7Nm+9DjJ9a8BKsLFSwS5RYWBOeY1b7yLpX/Yza8X3K8THrTBKaOIBTkutiObqbSn1s/W7QQyj+m7J7I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629559; c=relaxed/simple;
	bh=4sYWNtAc4YF7YZg03HO0SzkfYuVw4goAQfDHPc5y0l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mUWkGrKRt7bSS7lINPJgQXJUhcCtTMUCMcncowfXpKPZdK1hrd7ViRyt6s8up4vkWNSznN54vvgbR7WHQ93lrCI3lkvcAzsSAW3EKQWvNPrqUtrcPjirMyL1tHYjtmKIiyWEJRm+2N6DcjEcgxoBdz3ciI/EKStQV7MajDHsX5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-03 (Coremail) with SMTP id rQCowABH9EAX7_xnqxTUCA--.8348S2;
	Mon, 14 Apr 2025 19:18:59 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: davem@davemloft.net,
	andreas@gaisler.com,
	make24@iscas.ac.cn,
	sam@ravnborg.org,
	dawei.li@shingroup.cn
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH RESEND] sparc: fix error handling in scan_one_device()
Date: Mon, 14 Apr 2025 19:18:45 +0800
Message-Id: <20250414111845.3084334-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABH9EAX7_xnqxTUCA--.8348S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GF13GrWUGF4kuFW8WF43GFg_yoWktwbEga
	12v34UWr1fAwsagw43Ar4a9r1xtrnFyFWrK34Iyr1kJayrXrZrWrs5Gw4vvr9rWa17Cr1D
	Za4qqrsFkr1SgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbVkFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAG
	YxC7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAI
	cVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kf
	nxnUUI43ZEXa7VUbQVy7UUUUU==
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Once of_device_register() failed, we should call put_device() to
decrement reference count for cleanup. Or it could cause memory leak.
So fix this by calling put_device(), then the name can be freed in
kobject_cleanup().

As comment of device_add() says, 'if device_add() succeeds, you should
call device_del() when you want to get rid of it. If device_add() has
not succeeded, use only put_device() to drop the reference count'.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: cf44bbc26cf1 ("[SPARC]: Beginnings of generic of_device framework.")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
---
 arch/sparc/kernel/of_device_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/of_device_64.c b/arch/sparc/kernel/of_device_64.c
index f98c2901f335..4272746d7166 100644
--- a/arch/sparc/kernel/of_device_64.c
+++ b/arch/sparc/kernel/of_device_64.c
@@ -677,7 +677,7 @@ static struct platform_device * __init scan_one_device(struct device_node *dp,
 
 	if (of_device_register(op)) {
 		printk("%pOF: Could not register of device.\n", dp);
-		kfree(op);
+		put_device(&op->dev);
 		op = NULL;
 	}
 
-- 
2.25.1


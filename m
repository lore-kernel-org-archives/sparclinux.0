Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459F61B4F0A;
	Mon, 30 Mar 2026 06:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774852177; cv=none; b=kJ+PcOoBpUgFChI+5apVKbSUENMWgFtfIVe06K0OV5OpWPmsUA5RbtTErGEJ0R7Ql04mGQzhrx3kiWxiNz7GGBB2ca2T0QZsUJSusVPOcq0V6fA/cyi87Bq94EFpXczh8Ob03go2RhkAvbqoZ0+DFc8QMoQsQIz+9Eg1e5JYAWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774852177; c=relaxed/simple;
	bh=RTry2/6w3o9ifRag6udpQB66EdMgoT4lfxjUgeE3yIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vCrxnCP4c6TZtpr8g1vDvCLbFoTYrqqiRyuQAM1FCa1qsaEeiJu2E3/ZvcSWUc763ht2MC7An2He3GLAJVH8/vaBS0/wVJ0JQIuXZDnL44iJs2d0PxWynyscVMom6RjJHZ9sUmonVNlS3SS2r4B9QN/Wqya9+WjbxXFCsHtq3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.197])
	by APP-05 (Coremail) with SMTP id zQCowAC3Sw9AGMppK4TpCw--.28726S2;
	Mon, 30 Mar 2026 14:29:20 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: davem@davemloft.net
Cc: andreas@gaisler.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pengpeng@iscas.ac.cn
Subject: [PATCH 2/4] sparc: led: reject zero-length proc writes
Date: Mon, 30 Mar 2026 14:29:20 +0800
Message-ID: <20260330062920.40786-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAC3Sw9AGMppK4TpCw--.28726S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw4rZFWxJFyrGr15ury5CFg_yoWfWFb_Wa
	9rCa45GrsIgr47Xw1ak3yfZryay3W7JayFk3s2qrZ8JF95JrySq395J39Yyr4UXr4rGrs0
	kwn5Za4qyw1qkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUYNVyDUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

led_proc_write() passes count straight through memdup_user_nul() and then
unconditionally inspects buf[count - 1] to strip a trailing newline. A
zero-length write therefore dereferences one byte before the allocated
buffer.

Reject empty writes before touching buf[count - 1].

Fixes: ee1858d3122d ("[SPARC]: Add sun4m LED driver.")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 arch/sparc/kernel/led.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index f4fb82b019bb..b9758fdbc054 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -70,6 +70,9 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 {
 	char *buf = NULL;
 
+	if (!count)
+		return -EINVAL;
+
 	if (count > LED_MAX_LENGTH)
 		count = LED_MAX_LENGTH;
 
-- 
2.50.1 (Apple Git-155)


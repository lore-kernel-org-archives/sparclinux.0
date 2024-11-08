Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 242031BD9DB;
	Fri,  8 Nov 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082316; cv=none; b=G+SToUlVO+gqgDrhJ6KEOG6odg50AT9xjs2z4dTIKTVc0vYVPvzHuMZWYKopp39J5NU2XDRrySj61REoG0lyJCEBtfkKVePi+qFJ8+3CoDoXAbgEz4ebSxiX/lPmO2rZauZyxAPv0FYaLiea/aN+uWtVvoMVsUWBmiUu/PaPx1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082316; c=relaxed/simple;
	bh=BL67pvH4j3efH+UVI+51SW7Xb2U0qpRD+nOVyfz+CBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MIXULk05Du+j8IpRYs0bvT2Ifxy6O962c6+TQOtcIH4gys+7h6X6wbrnmSV3+45UpH1WkaFIz2LueRnMbEm3TBOMKNvq2hxjF/RhwODtK6D6NetcEiUU7KSQkYynlC97cXnNKSX97L05NZJebWEpbGpmaG9inS+WptzZog1nxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=jKmNit+p; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jKmNit+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=aqtSp
	0oZdp/eJUvBGh7/YcUJhKmFpySwvw5FIpjT3NQ=; b=jKmNit+p/5bg3suPIXrr1
	XWX3Nd0LR7EIwgU8CLitlVGs/OH5+CNv9GX/wQ19tqx9/4KtM4MKgS6pJpYFmjt5
	D1SHIz+NmhhYCkZtWl+P7/XruZxaw6RhHwgtzSSa9q9B44W3KRJ9Rvz3H2q8Pg9H
	iXWPKKz3giSYB+Wl5/qboc=
Received: from localhost.localdomain (unknown [111.35.191.191])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnNzUsOC5n1UvUAg--.59311S4;
	Sat, 09 Nov 2024 00:11:31 +0800 (CST)
From: David Wang <00107082@163.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: linux-kernel@vger.kernel.org,
	sparclinux@vger.kernel.org,
	David Wang <00107082@163.com>
Subject: [PATCH 03/13] sparc/irq: use seq_put_decimal_ull_width() for decimal values
Date: Sat,  9 Nov 2024 00:11:23 +0800
Message-Id: <20241108161123.9637-1-00107082@163.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnNzUsOC5n1UvUAg--.59311S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF1xAFWDCr1rCw4DCFy3Arb_yoW8Zr1xpa
	95CFZ7Xw4xZr1jgryxJa4xZrn8tFn0yryagwn5W3yrG3WDGrykXr1S9r1Iqr1IgryxXr4a
	gF90gayUKa4UCw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRa9aDUUUUU=
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMwaRqmcuKsHRRwABs7

Performance improvement for reading /proc/interrupts on arch sparc

Signed-off-by: David Wang <00107082@163.com>
---
 arch/sparc/kernel/irq_32.c | 12 ++++++------
 arch/sparc/kernel/irq_64.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/irq_32.c b/arch/sparc/kernel/irq_32.c
index 8605dd710f3c..5210991429d5 100644
--- a/arch/sparc/kernel/irq_32.c
+++ b/arch/sparc/kernel/irq_32.c
@@ -199,18 +199,18 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 	int j;
 
 #ifdef CONFIG_SMP
-	seq_printf(p, "RES: ");
+	seq_printf(p, "RES:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).irq_resched_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).irq_resched_count, 10);
 	seq_printf(p, "     IPI rescheduling interrupts\n");
-	seq_printf(p, "CAL: ");
+	seq_printf(p, "CAL:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).irq_call_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).irq_call_count, 10);
 	seq_printf(p, "     IPI function call interrupts\n");
 #endif
-	seq_printf(p, "NMI: ");
+	seq_printf(p, "NMI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).counter);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).counter, 10);
 	seq_printf(p, "     Non-maskable interrupts\n");
 	return 0;
 }
diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index 01ee800efde3..9ab6e79b617b 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -304,9 +304,9 @@ int arch_show_interrupts(struct seq_file *p, int prec)
 {
 	int j;
 
-	seq_printf(p, "NMI: ");
+	seq_printf(p, "NMI:");
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", cpu_data(j).__nmi_count);
+		seq_put_decimal_ull_width(p, " ", cpu_data(j).__nmi_count, 10);
 	seq_printf(p, "     Non-maskable interrupts\n");
 	return 0;
 }
-- 
2.39.2


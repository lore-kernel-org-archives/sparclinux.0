Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E940C30AAB0
	for <sparclinux@vger.kernel.org>; Tue, 27 Jan 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769516213; cv=none; b=t8rHvNeZz0iLrRzDah9NVUG4Eoblq8PKjm1kWNcfG77dNNcUcmcbY0/QDrlq/d+oMunDrMzzYH8gBoIs09gRaAVzIjuN/+0UmNNgCEz3RcpQTrVxD2BJKuZy6G/j+wIdWrh3Te6toERZ0fK42bV5me23T1XxYuYutmQ7qeZh+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769516213; c=relaxed/simple;
	bh=RY9iG5O6CRC3b3IlwlQVEJmAqDrdvdhuqhPIwDBxGks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVwUpQ0cNYAfAmQ5TLiTeghjdLmKhH+p0K7efaP0rzTC02/XLsjwCAi3KJBrlOQ5XpvbVkhZrWo7xvwtAz5LD4z/uYvETYwxrsJ5g5NzYYCGPX+NgpQJgwOFk4WgCwiYmhGb9CvRpkRzZSKw5/6uuF3CYXY3I6KIRtBRfpG66wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wc/LzcSY; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wc/LzcSY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769516209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e0pQYHM1jhSwp9PHWAhzAtLgw7dAo1EQ0j0b9Rhu8lM=;
	b=wc/LzcSY84XUN/M01s5VcIBtD1/lXhQlVZzRwxMLJY1XGT2wxJOzGUzWA5oPCfbPCsb1/O
	ht9YXkU/ZBWYV/j9FZpfqWjqnjxWaip5QHGmFskLEMQc1kWqyHjiSkHOF+suDP3tIX1G7K
	JeMpI6zZYGFo3G12ozp0269DFGB3g9I=
From: Qi Zheng <qi.zheng@linux.dev>
To: david@kernel.org,
	andreas@gaisler.com,
	richard.weiyang@gmail.com,
	will@kernel.org,
	peterz@infradead.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	dev.jain@arm.com,
	ioworker0@gmail.com,
	linmag7@gmail.com,
	akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org,
	sparclinux@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH v4 6/8] um: mm: enable MMU_GATHER_RCU_TABLE_FREE
Date: Tue, 27 Jan 2026 20:12:59 +0800
Message-ID: <e2217546504668b8a87a39eb0e378839339a1bb4.1769515122.git.zhengqi.arch@bytedance.com>
In-Reply-To: <cover.1769515122.git.zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Qi Zheng <zhengqi.arch@bytedance.com>

On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
empty PTE page table pages (such as 100GB+). To resolve this problem,
first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
PT_RECLAIM feature, which resolves this problem.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 arch/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 8415d39b0d430..098cda44db225 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -42,6 +42,7 @@ config UML
 	select HAVE_SYSCALL_TRACEPOINTS
 	select THREAD_INFO_IN_TASK
 	select SPARSE_IRQ
+	select MMU_GATHER_RCU_TABLE_FREE
 
 config MMU
 	bool
-- 
2.20.1


Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B21CB31D;
	Fri,  6 Sep 2024 12:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725624580; cv=none; b=Kvo5mH0cMGizng3TfmMapE1RH2+f7RGRKPW9nUBZkQWE8M3YcpwtFgCf9+dUwojiyvXCQoDj3obdZ0Dab3qy81AfMQEea9nNxK4BohC/W7OYSVgm2szhCiAWmgfvXefwqoGFC0hLcZI/ND4HgxfSd/nnkzK2Pc7uwgHRvlXCCXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725624580; c=relaxed/simple;
	bh=5p+4Bl9mqbxouOtptcDfPPmou1wvxYkLSmiClXxVh3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lCfacO7Fbo2HvNMsbrZxMBZWDZhhnBiheSzlRJWAAEa46uqs77XTsy7xMSm0oFnMUa4ylVkrCHsLiLwUoLg5wZh8HDmydi8y59VvYAILgNJzWN7fDS19gpJjdp9SwL7jgzHFbZrwfPa7ZoHSI7SynO37ElmqfGTMu/P2iLiJxDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SrkJxtGM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SrkJxtGM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725624578; x=1757160578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5p+4Bl9mqbxouOtptcDfPPmou1wvxYkLSmiClXxVh3c=;
  b=SrkJxtGMHPJiX/RwVQt1DklGBHaJAIo8/yuvjl6J9smHuUb+FFRLDV+m
   SieNzKCj2vScjQ2+aQJtyB46He7Vb0VYUzA17/JX54ogQj4/aCF5KwhMa
   63+n4cquFujAImLUp7ctxLVyLlTrNYmqA+rhPlRXBa0q2Zamr17WDDEwO
   jtHDCmmZawa6vyyKfeXOFaZnqJj2uv0d4bUd9hbjhKhWc+3r9Qrho8IbW
   G7+Tn2mRfqqgYZTzvGozgb/usnPAYpFkjxMwWsXD/MN3ypPjY5rFg/fMM
   GvqcCIzZ8HJdvudLj+rGwEG/HxxoI+c5f2Md3cOFCke+coagG1mhncYYf
   g==;
X-CSE-ConnectionGUID: djVm1GvPTJ2W5AHWRNbOHQ==
X-CSE-MsgGUID: 12BQj/ELR1Cd1xsskltAYw==
X-IronPort-AV: E=McAfee;i="6700,10204,11187"; a="24535761"
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="24535761"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2024 05:09:38 -0700
X-CSE-ConnectionGUID: HprW+X66SaqXRjfUb/ltHQ==
X-CSE-MsgGUID: mTrxtkOGSAKpg0n5x8l8qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,207,1719903600"; 
   d="scan'208";a="70734766"
Received: from feng-clx.sh.intel.com ([10.239.159.50])
  by orviesa005.jf.intel.com with ESMTP; 06 Sep 2024 05:09:34 -0700
From: Feng Tang <feng.tang@intel.com>
To: Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	sparclinux@vger.kernel.org,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Feng Tang <feng.tang@intel.com>
Subject: [PATCH v3] sched/debug: Dump end of stack when detected corrupted
Date: Fri,  6 Sep 2024 20:09:33 +0800
Message-Id: <20240906120933.2176727-1-feng.tang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When debugging a kernel hang during suspend/resume [1], there were random
memory corruptions in different places like being reported by
slub_debug+KASAN, or detected by scheduler with error message:

  "Kernel panic - not syncing: corrupted stack end detected inside scheduler"

So dump the corrupted memory around the stack end to give more direct
hints about how the memory is corrupted:

 "
 Corrupted Stack: ff11000122770000: ff ff ff ff ff ff 14 91 82 3b 78 e8 08 00 45 00  .........;x...E.
 Corrupted Stack: ff11000122770010: 00 1d 2a ff 40 00 40 11 98 c8 0a ef 30 2c 0a ef  ..*.@.@.....0,..
 Corrupted Stack: ff11000122770020: 30 ff a2 00 22 3d 00 09 9a 95 2a 00 00 00 00 00  0..."=....*.....
 ...
 Kernel panic - not syncing: corrupted stack end detected inside scheduler
 "

And with it, the culprit was quickly identified to be ethernet driver
that it frees RX related memory back to kernel in suspend hook, but
its HW is not really stopped, and still send RX data to those old
buffer through DMA.

[1]. https://bugzilla.kernel.org/show_bug.cgi?id=217854

Signed-off-by: Feng Tang <feng.tang@intel.com>
Reviewed-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
Changlog:

  since v2:
    * Change code format (Adrian)
    * Add Reviewed tag from Adrian

  since v1:
    * Refine the commit log with more info, and rebase againt 6.8-rc3

 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f3951e4a55e5..0c5cc3bdc02b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5741,8 +5741,19 @@ static noinline void __schedule_bug(struct task_struct *prev)
 static inline void schedule_debug(struct task_struct *prev, bool preempt)
 {
 #ifdef CONFIG_SCHED_STACK_END_CHECK
-	if (task_stack_end_corrupted(prev))
+	if (task_stack_end_corrupted(prev)) {
+		unsigned long *ptr = end_of_stack(prev);
+
+		/* Dump 16 ulong words around the corruption point */
+#ifdef CONFIG_STACK_GROWSUP
+		ptr -= 15;
+#endif
+		print_hex_dump(KERN_ERR, "Corrupted Stack: ",
+			DUMP_PREFIX_ADDRESS, 16, 1, ptr,
+			16 * sizeof(unsigned long), true);
+
 		panic("corrupted stack end detected inside scheduler\n");
+	}
 
 	if (task_scs_end_corrupted(prev))
 		panic("corrupted shadow stack detected inside scheduler\n");
-- 
2.34.1


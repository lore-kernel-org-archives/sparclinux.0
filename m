Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB7D28751A;
	Tue, 20 May 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747765044; cv=none; b=kcFSIgFXAZcp6CHdcGt7x7Tvxk2o0DVTpyjjvSfR9ZEW4Se2GHq/xNW12YRFo1n7yQTkom3cPte3iYWgN+wGRYeIfCqBzj1cnG16yZuoSmgWnUQJPn5Hi0Q8mDXRGkWDPWY3f7vCg5O7t75KmZjvyA+tirf2NFgZfQH12mQKOcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747765044; c=relaxed/simple;
	bh=+LerS4ypY2xtEwvIwpQb+1sereJGijuBSIcL0NVDkSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VQZF3p5LjHg2ZN2VWjwUNxc90ttZjbe/OOJfrFCzuh0AI7+2PSlVgOiQl8mPaThHI1xvY+yhpqYYeJ6kKWVL8ZcJKbG2mGUqKDdpTIaL8IzMGsSY5EjZuPeTuCe1R+IzqexFy0AKMVDMZp8s6mDfUznnXU59c4SArNo1kEXI1VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VgOncb3F; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VgOncb3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747765043; x=1779301043;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+LerS4ypY2xtEwvIwpQb+1sereJGijuBSIcL0NVDkSQ=;
  b=VgOncb3FBudyiHqvWGxGYRlEbYeZLxoh7VxBOyDoQEW/h4C3hA6zRqDR
   VANtZKUh3jSHjWYXHS6Hq++06L1FOpa6vwZR1kb9cH99W1YWUzEsE4Zea
   cz7C8360i5wCOShHm12pGbFn/xoiS1SVp+GSnFijlWdXeqgiaYHWJvgqq
   1uSt3pKtblmRphbZlb8ZtIsKOkr7RNEs5o8/4+HqTlYJKDZdbMDOGlsec
   d4l0EhlU7EQCOr0LdwrcsDkZUpkZLOr2Id5R3s/cdFEWXiid9AfJCDJu9
   K33Aqs7w7AIFqIkTg2XZKvPVsWoZCJiXLtN8YZW3S+1h0prt/3izLpcdE
   w==;
X-CSE-ConnectionGUID: w7zYMWFjSU2rcY4OrqfO5w==
X-CSE-MsgGUID: 6KjH8gFkQpeF8f26Lneljw==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="49848046"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49848046"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 11:17:14 -0700
X-CSE-ConnectionGUID: cr8XOTUAT+SPa6g60OZ7lw==
X-CSE-MsgGUID: a4ZuTZ0RQCuFnKnQZwo38A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144514722"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa003.jf.intel.com with ESMTP; 20 May 2025 11:17:14 -0700
From: kan.liang@linux.intel.com
To: peterz@infradead.org,
	mingo@redhat.com,
	namhyung@kernel.org,
	irogers@google.com,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Cc: eranian@google.com,
	ctshao@google.com,
	tmricht@linux.ibm.com,
	leo.yan@arm.com,
	Kan Liang <kan.liang@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [PATCH V4 14/16] sparc/perf: Remove driver-specific throttle support
Date: Tue, 20 May 2025 11:16:42 -0700
Message-Id: <20250520181644.2673067-15-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250520181644.2673067-1-kan.liang@linux.intel.com>
References: <20250520181644.2673067-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kan Liang <kan.liang@linux.intel.com>

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index f02a283a8e8f..cae4d33002a5 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1668,8 +1668,7 @@ static int __kprobes perf_event_nmi_handler(struct notifier_block *self,
 		if (!sparc_perf_event_set_period(event, hwc, idx))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			sparc_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	finish_clock = sched_clock();
-- 
2.38.1


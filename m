Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B1E280CC9;
	Fri, 16 May 2025 18:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420172; cv=none; b=AVNN1bNt9eqTX3u3hehYpXTt49iwpxsc1T+OdEqlTJfpR87GSxPaJswSUORBMgogWSLg1zCn53Pd4z9PGlNTk547voTNFw/S8GOWRbNnKH85Drgr747yuia4je676rrhkjhK2zmqr9baqST1oclC7tirJXbHcNu0h4+sxBecW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420172; c=relaxed/simple;
	bh=+LerS4ypY2xtEwvIwpQb+1sereJGijuBSIcL0NVDkSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pSqHs8W5zZXEf7XWexfu/3aT6ob56O/E9cLaZYsPouxA88ZHJJqHhx1YXTnjAbMnrzHUjn8zf7dfEcG7hlQNkmdl1PuTW5+Yhp4ux9tfWFbKE64zsNhyemqRb8aBZ741ROMnmtuXSsBngSWdBhye00SgB7rh0672a7XYHmiAq+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bkx4cxBv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bkx4cxBv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747420170; x=1778956170;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+LerS4ypY2xtEwvIwpQb+1sereJGijuBSIcL0NVDkSQ=;
  b=Bkx4cxBvhzsiV7eeXNQoDcycvGoagaR/N+PTLZIrb8vlFTfOATUyxdeN
   rgbSfRohCPCMXOspwwhxR818FWVSOgNIgza0SNu6e1ib1gvrTrSOBQlfN
   oFIRfs/mdH4GQ6TpYVmMv4Op/p51OytoVIQdgowQK5E1VV8iw3qvoCK1M
   ntZTsPsbZj43y9nqmrE2KwfGm+IGQfHq4Xunp1xerfE2PktAXbnOw4eYJ
   pQoAkTleEHs0V+Iw6ib1STBM8pRi+dHK3W7Gpkwp0TXtBxjqFp4+Z4slf
   ixlEyts7DFUEf5CjOA+IloIMMd/yOS8yVSaKq9HpesdXzJrsPnZivBL61
   Q==;
X-CSE-ConnectionGUID: hLumWh4FQAalSkvXHv4Rmg==
X-CSE-MsgGUID: nic3fV/1R+qsvEId3Mz1kw==
X-IronPort-AV: E=McAfee;i="6700,10204,11435"; a="49328903"
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="49328903"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 11:29:25 -0700
X-CSE-ConnectionGUID: 8iG35NzeRb+9isGxoDwI7w==
X-CSE-MsgGUID: y2Qoh7c9QyK8MUp/LBJhww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,294,1739865600"; 
   d="scan'208";a="169802625"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa001.fm.intel.com with ESMTP; 16 May 2025 11:29:25 -0700
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
Subject: [PATCH V3 14/16] sparc/perf: Remove driver-specific throttle support
Date: Fri, 16 May 2025 11:28:51 -0700
Message-Id: <20250516182853.2610284-15-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250516182853.2610284-1-kan.liang@linux.intel.com>
References: <20250516182853.2610284-1-kan.liang@linux.intel.com>
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


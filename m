Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90B228937E;
	Wed, 14 May 2025 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747235694; cv=none; b=U0lotfXSpzFfkx6K6BEQ2qSmUdPPl5anbR4LwRnk55QvH6beprsOj17RpvENQt+jF2O/DZXVGphyDjODQHIPiCMvEl8rj77NnVBICQpKYnXkJhg25NvEARaRB8FlLuxttQPEY1JEqBYHGEWdz3hpgGA7Xa83WzZH3Nq3vQZwJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747235694; c=relaxed/simple;
	bh=+LerS4ypY2xtEwvIwpQb+1sereJGijuBSIcL0NVDkSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dse12Rc5QV4kPQdb8098geBlobFay7lzw4/eBox+uUSMmN7YNGze7wkM6yB6t4Byc5pgruTMIbR8sO9o+zEpi/bDncUb5Ods/yneP40U9++Xgs40IuqkOD6uJlvYeyVYbeMbQo8jZ/xNyjbWlMZ1qs+ZOKh6CbNv+RBtcG06GFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RxlF1gDc; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxlF1gDc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747235693; x=1778771693;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+LerS4ypY2xtEwvIwpQb+1sereJGijuBSIcL0NVDkSQ=;
  b=RxlF1gDcN9NR7eHqAZY2TjK/c6atlZR9vn+ONwMOxxQzC68dE3ct5B5n
   ntgWVYfDMGMMoywfhBOeLulk5B5AhCc5dxtqNFQI3VvhRFWXEU5e1jCxf
   QBu+t/f2SPJgbL80IqUiMpjxz9ZvtRcuJDnnRfAWUU5SGdV/QMQadiJ8+
   4iefnZq41jJwaS4xZswXYHbO8GOsC7gTLX5R+VIL8K6P7qUEjRN51L4gy
   p/vrnvGf4YEa9wEbIE3+mxSb5gisSm4o0ps2vGlU2sZPwQxWD+TOyT5zd
   yp6Y7+pi/dtyU5SeuH12w8YY/Nk6syEXPuUDlu6Cwmm1oAE1A55YzRKFN
   A==;
X-CSE-ConnectionGUID: jq08k84BQyizEeluuL9Nzg==
X-CSE-MsgGUID: /OrodaR2QrO7G5ON47sG2A==
X-IronPort-AV: E=McAfee;i="6700,10204,11433"; a="49072799"
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="49072799"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 08:14:48 -0700
X-CSE-ConnectionGUID: zRdsBm7kTuerEcSZEZ412Q==
X-CSE-MsgGUID: WE8p07L+SwKeBGqY14W5eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,288,1739865600"; 
   d="scan'208";a="142939178"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmviesa005.fm.intel.com with ESMTP; 14 May 2025 08:14:47 -0700
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
	Kan Liang <kan.liang@linux.intel.com>,
	"David S . Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [PATCH V2 13/15] sparc/perf: Remove driver-specific throttle support
Date: Wed, 14 May 2025 08:13:59 -0700
Message-Id: <20250514151401.2547932-14-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20250514151401.2547932-1-kan.liang@linux.intel.com>
References: <20250514151401.2547932-1-kan.liang@linux.intel.com>
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


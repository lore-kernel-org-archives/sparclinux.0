Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5EC4A3D41;
	Tue, 22 Sep 2026 20:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108138; cv=none; b=VivCtw+gIiiX4y1SwWXcrg4k9Tq66riazPp4qTKgBbGVJYsNNxc3JvYwL0pE9pyXl/1YlfssXWIVBU44DQfnkvMX+59qkuQurWKXLCNjNZ4IRtzIqVX05H29iw7EDvDXY6/LTp5VGbtwlw7N7z5jflZ07qo2ZWrmw6fTKTx9WvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108138; c=relaxed/simple;
	bh=3C+io7Yq19YmBExI43YBPe/62sja9K3kdCDyE7hhx4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VCdJll0jh9SEa3mY08H1xdfJ0kn/urC2mCXFhXokC+eyWISLjAVRAlMYmtinkYHnyqLhIfouEPabzh5Eh1XhdOKTRWp6vJWd+NKXvLtZoJF9pcSgq1jTO9XdzhdoSLSoZkCupVwsmh6js6h1y8xBCSLoIK37F0/bhj87GdTbe3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=eo7/i89U; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="eo7/i89U"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790108130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nwfjX7nuhFS4t6Nv0nmF2X/fHblO6tMBdc3Wj6hQel8=;
	b=eo7/i89UZ0HIz0CLDlU/oljgpvtONYBIGMWA3xV/H2IVX7AJ+x3Maw2VLTltYARLzJWM3J
	BXTbXnNAWi8ztANDCwa/ZTQk8DtFS6FAC+8hzF/V7UpEeBFkn9eOc8Qd0YRok4ADpJynbW
	Bor7nI2Qn6gn+EpKkikkA5idbW4l8d4=
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Magnus Lindholm <linmag7@gmail.com>,
	linux-perf-users@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [RFC PATCH v2 1/3] perf/core: Let an arch prepare the user stack before it is dumped
Date: Tue, 22 Sep 2026 22:15:05 +0200
Message-ID: <20260922201507.1719668-2-stian@itx.no>
In-Reply-To: <20260922201507.1719668-1-stian@itx.no>
References: <20260922201507.1719668-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_SAMPLE_STACK_USER copies the user stack as it is in memory, which
assumes the whole call chain is there. On sparc the sampled window's
%l and %i registers, including the frame pointer and return address an
unwinder starts from, may still be in the register file: they only
reach the stack when a window spills. perf_callchain_user() already
handles this for the callchain by calling flushw_user() first; the user
stack dump has no equivalent arch entry point.

Add perf_arch_prepare_ustack(), a no-op by default, called from
perf_prepare_sample() before the dump size is computed, so an arch can
write back whatever part of the user's stack state it still holds in
registers. Doing this in the arch PMU interrupt handler would not do:
software events such as cpu-clock reach perf_event_overflow() without
passing through it.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 include/linux/perf_event.h | 7 +++++++
 kernel/events/core.c       | 2 ++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5842552294c1..758b98b75346 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1815,6 +1815,13 @@ extern unsigned long perf_instruction_pointer(struct perf_event *event,
 #ifndef perf_arch_bpf_user_pt_regs
 # define perf_arch_bpf_user_pt_regs(regs) regs
 #endif
+/*
+ * Called before the user stack of the current task is dumped, for an arch
+ * that still holds part of the user's stack state in registers.
+ */
+#ifndef perf_arch_prepare_ustack
+static inline void perf_arch_prepare_ustack(void) { }
+#endif
 
 #ifndef perf_arch_guest_misc_flags
 static inline unsigned long perf_arch_guest_misc_flags(struct pt_regs *regs)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index db7b76d6b68a..90fb35c7d279 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8718,6 +8718,8 @@ void perf_prepare_sample(struct perf_sample_data *data,
 		u16 header_size = perf_sample_data_size(data, event);
 		u16 size = sizeof(u64);
 
+		if (data->regs_user.regs)
+			perf_arch_prepare_ustack();
 		stack_size = perf_sample_ustack_size(stack_size, header_size,
 						     data->regs_user.regs);
 
-- 
2.55.0


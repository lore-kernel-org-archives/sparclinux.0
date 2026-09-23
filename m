Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1A747ACF4;
	Wed, 23 Sep 2026 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790154292; cv=none; b=K1SEYo2GU9GVqkXg9e7xXweem13bS0uuODcP6T0hlW73hY7UtqSgIf2o5UAAmKHAldY28+jEDpV7/8RRJ/r7gigx96/uBqhGUsPTjmuBZfsJsryQ0YPmRpWFlntL+XGEHzqGzdAQt8YBK7o9axbi/BvfL+Aw0GKb4Hz10ubhHNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790154292; c=relaxed/simple;
	bh=9I6P5fj4M9aW3lOJEzB4O6F1qrex7/BFTYa9USvHkmI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpRX+EM5czI2qfYWYcVVCg6ytmy+VMFjcSS8I2IxQVUVOyJsLdaK9qveQ00gBB/UmTFL6RF2bwMASyKweiUaZnqD/1FU+5VeAm4LAZaA7Dx3m+0pG7wIod9DE0g2+8kisBZGwkUX6hKpb2RqCKElFag5ZIGynq7oeILs/dMLtKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=nPN0wWNb; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="nPN0wWNb"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790154287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ja7ThhMHEJvxh7E25icWLGG63X4wT5FTTa15Zn82Ghw=;
	b=nPN0wWNb5RfP75MsSW6XxtPQIGnq8JFwrOufmXXViztlxOGGg3O6vxihohnEIm93Cfu1M4
	nFiP7bKfImsnKrwP4C4G4bXyw29LgmJOc2fZ56C5aCfttuy5i//BhKehNuf3riwwypTJwx
	nofx5PSdszwRQ3JMJsB2Xdjl+rPac+A=
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
Subject: [RFC PATCH v3 1/3] perf/core: Let an arch prepare and locate the user stack dump
Date: Wed, 23 Sep 2026 11:04:26 +0200
Message-ID: <20260923090429.2026529-2-stian@itx.no>
In-Reply-To: <20260923090429.2026529-1-stian@itx.no>
References: <20260923090429.2026529-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PERF_SAMPLE_STACK_USER copies the user stack as it is in memory,
starting at the user stack pointer. Two things about sparc64 do not
fit that.

The sampled window's %l and %i registers, including the frame pointer
and return address an unwinder starts from, may still be in the
register file: they only reach the stack when a window spills.
perf_callchain_user() already handles this for the callchain by calling
flushw_user() first; the user stack dump has no equivalent arch entry
point.

And a 64-bit stack pointer is biased by 2047: the stack starts at
%sp + 2047. Starting the dump at the register value spends a quarter of
an 8K dump on memory below the frame, and gives no dump at all when that
page has never been touched, as for a leaf frame at the deepest point a
thread's stack has reached.

Add two hooks in the style of perf_arch_misc_flags():
perf_arch_prepare_ustack(), a no-op by default, called from
perf_prepare_sample() before the dump size is computed, and
perf_arch_user_stack_pointer(), user_stack_pointer() by default, the
address the dump starts at. Flushing in the arch PMU interrupt handler
instead would not do: software events such as cpu-clock reach
perf_event_overflow() without passing through it.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 include/linux/perf_event.h | 11 +++++++++++
 kernel/events/core.c       |  2 ++
 kernel/events/internal.h   |  2 +-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 5842552294c1..49aa22db43c0 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1815,6 +1815,17 @@ extern unsigned long perf_instruction_pointer(struct perf_event *event,
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
+/* Where the user stack dump starts, for an arch with a biased stack pointer. */
+#ifndef perf_arch_user_stack_pointer
+# define perf_arch_user_stack_pointer(regs)	user_stack_pointer(regs)
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
 
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index c03c4f2eea57..01b5f53d01d7 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -236,7 +236,7 @@ static inline bool arch_perf_have_user_stack_dump(void)
 	return true;
 }
 
-#define perf_user_stack_pointer(regs) user_stack_pointer(regs)
+#define perf_user_stack_pointer(regs) perf_arch_user_stack_pointer(regs)
 #else
 static inline bool arch_perf_have_user_stack_dump(void)
 {
-- 
2.55.0


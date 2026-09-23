Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FC356B869;
	Wed, 23 Sep 2026 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790192098; cv=none; b=fo4HmHr94eyZSgEIueG2kzu8fwuYJhbjCeEwssWf46CNhewjBfhuE+m3gRUAL9oe+pb3dCb8fK5Qcc0yGZIEQne5OqcoXnt3DmgpuKuQrpR8wzwucbuUwfbWTWoX9k4VNqsCWvud8boYzPzD1Mj0BdyWNDpvBWhPMY0efNPYMBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790192098; c=relaxed/simple;
	bh=wrGL0wwVyGK9nHh96veEfJ4JJ5Jk4X09XOinQDnsvTg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+pWKq5dk0sZqQ5GEmrWODCkoMW8H3Oom5KpbrpgKfNPPfGQv/LQ2ADpnspOKpz6SZ6zWdm7Ubs21OEfGn8uVrBH9vuQs0uJzzD1Yje6r2pn6QJ7FKojHBkx8FdNf1IaC/9H6KJPNgPsQeYEILll5jD7M2lezQCVQ+7/fkFGBho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=hTYmp3hk; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="hTYmp3hk"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790192082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+hb5O2E4A9GdhWtVdSbQkcDJZ9Y5yRBtqWH3lfgyqQs=;
	b=hTYmp3hkvPTw25eOYyoYrAVeYWxidds5iwf4RXBCq5499p+fW1vRMItJT7GuqjULYwt6Fr
	vltj6NUyvPGMcEtAhNhqLCPikk9Rrrh7+p/GqoM37vmhRp5o3QKlIvEoKcSC2nXSeBgRzA
	DrC5C+65AxNJ6GuDBs7VRDBpnqNDmmg=
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	James Clark <james.clark@linaro.org>,
	linux-perf-users@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH] perf unwind-libdw: Fix reading the stack of a 32-bit task
Date: Wed, 23 Sep 2026 21:34:32 +0200
Message-ID: <20260923193432.2489729-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memory_read() hands libdw 8 bytes whatever the sampled task's ABI. For a
32-bit task libdw keeps the low 32 bits (__libdwfl_frame_reg_set()), so
on a big-endian machine each word read from the stack or a DSO is the
one at addr + 4, and unwinding stops at the first frame restored from
the stack. On sparc the 8-byte load from a stack address that is only
4-byte aligned even traps, and perf dies with SIGBUS. Read 4 bytes for a
PERF_SAMPLE_REGS_ABI_32 sample.

A recording of the other byte order has each sample swapped in 8-byte
units when it is read (perf_event__all64_swap()), which leaves the
4-byte words of a 32-bit stack dump reversed and paired up wrongly.
Undo the swap of the unit holding the word and swap the word itself, as
__evsel__parse_sample() does for PERF_SAMPLE_CPU.

Suggested-by: Ian Rogers <irogers@google.com>
Signed-off-by: Stian Halseth <stian@itx.no>
---
Ian raised the cross-endian case in review of the sparc64 perf_regs
series:
https://lore.kernel.org/all/CAP-5=fUuRm3dWra4a-6eNF3F=tafcHvvDipqmDEXN5+ti-sW0A@mail.gmail.com/

Tested with 32-bit sparc programs (static, dynamic and multithreaded) on
top of that series, with a local change so perf recognises sparc32plus
binaries: natively on sparc64 perf died with SIGBUS before and unwinds
complete chains after; cross-endian on x86 no call chain was complete
before and all are after. 64-bit unwinding is unchanged in both.

Words read from a DSO rather than the stack dump are still not swapped
for a recording of the other byte order, whatever the word size, as
before this change.

 tools/perf/util/unwind-libdw.c | 46 ++++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/unwind-libdw.c b/tools/perf/util/unwind-libdw.c
index 4ccfcc7c2dfc..d49901b1571e 100644
--- a/tools/perf/util/unwind-libdw.c
+++ b/tools/perf/util/unwind-libdw.c
@@ -4,6 +4,7 @@
 #include <elfutils/libdw.h>
 #include <elfutils/libdwfl.h>
 #include <inttypes.h>
+#include <byteswap.h>
 #include <errno.h>
 #include "debug.h"
 #include "dso.h"
@@ -17,6 +18,8 @@
 #include <linux/types.h>
 #include <linux/zalloc.h>
 #include "event.h"
+#include "evsel.h"
+#include "memswap.h"
 #include "perf_regs.h"
 #include "callchain.h"
 #include "util/env.h"
@@ -203,9 +206,10 @@ static bool get_thread(Dwfl *dwfl __maybe_unused, pid_t tid, void *arg,
 }
 
 static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
-			  Dwarf_Word *data)
+			  Dwarf_Word *data, size_t len)
 {
 	struct addr_location al;
+	union u64_swap u;
 	ssize_t size;
 	struct dso *dso;
 
@@ -218,15 +222,38 @@ static int access_dso_mem(struct unwind_info *ui, Dwarf_Addr addr,
 	if (!dso)
 		goto out_fail;
 
-	size = dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 *) data, sizeof(*data));
+	size = dso__data_read_addr(dso, al.map, ui->machine, addr, (u8 *)&u, len);
 
 	addr_location__exit(&al);
-	return !(size == sizeof(*data));
+	if (size != (ssize_t)len)
+		return 1;
+	*data = len == sizeof(u32) ? u.val32[0] : u.val64;
+	return 0;
 out_fail:
 	addr_location__exit(&al);
 	return -1;
 }
 
+/*
+ * libdw expects a 32-bit task's words zero-extended.  A recording of the
+ * other byte order was swapped in 8-byte units when it was read (see
+ * perf_event__all64_swap()), so a 4-byte word is picked out of its unit with
+ * that swap undone, as for PERF_SAMPLE_CPU in __evsel__parse_sample().
+ */
+static Dwarf_Word stack_word(struct stack_dump *stack, int offset, size_t len,
+			     bool swapped)
+{
+	union u64_swap u;
+
+	if (len == sizeof(u64))
+		return *(Dwarf_Word *)&stack->data[offset];
+	if (!swapped)
+		return *(u32 *)&stack->data[offset];
+
+	u.val64 = bswap_64(*(u64 *)&stack->data[offset & ~7]);
+	return bswap_32(u.val32[(offset & 4) / 4]);
+}
+
 static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *result,
 			void *arg)
 {
@@ -234,11 +261,16 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	struct unwind_info *ui = dwfl_ui_ti->ui;
 	struct stack_dump *stack = &ui->sample->user_stack;
 	u64 start, end;
+	bool swapped;
+	size_t len;
 	int offset;
 	int ret;
 
 	if (!ui->sample->user_regs)
 		return false;
+	len = ui->sample->user_regs->abi == PERF_SAMPLE_REGS_ABI_32 ?
+	      sizeof(u32) : sizeof(u64);
+	swapped = ui->sample->evsel && ui->sample->evsel->needs_swap;
 
 	ret = perf_reg_value(&start, ui->sample->user_regs,
 			     perf_arch_reg_sp(ui->e_machine));
@@ -248,11 +280,11 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	end = start + stack->size;
 
 	/* Check overflow. */
-	if (addr + sizeof(Dwarf_Word) < addr)
+	if (addr + len < addr)
 		return false;
 
-	if (addr < start || addr + sizeof(Dwarf_Word) > end) {
-		ret = access_dso_mem(ui, addr, result);
+	if (addr < start || addr + len > end) {
+		ret = access_dso_mem(ui, addr, result, len);
 		if (ret) {
 			pr_debug("unwind: access_mem 0x%" PRIx64 " not inside range"
 				 " 0x%" PRIx64 "-0x%" PRIx64 "\n",
@@ -263,7 +295,7 @@ static bool memory_read(Dwfl *dwfl __maybe_unused, Dwarf_Addr addr, Dwarf_Word *
 	}
 
 	offset  = addr - start;
-	*result = *(Dwarf_Word *)&stack->data[offset];
+	*result = stack_word(stack, offset, len, swapped);
 	pr_debug("unwind: access_mem addr 0x%" PRIx64 ", val %lx, offset %d\n",
 		 addr, (unsigned long)*result, offset);
 	return true;

base-commit: edd8a9fe2eca009599e013a29c421c7a6b5ad1b9
-- 
2.55.0


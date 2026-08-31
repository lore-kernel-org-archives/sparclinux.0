Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3196042D777;
	Mon, 31 Aug 2026 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788197380; cv=none; b=TM0qab4Ar4x+7jYzVu/6kezmrBxPrOYxPuCsJuZVtg856eho/EqOLo9v/DZgr6kyVgB9N51xUSXqCI+1Xkg4AK2Vx3X8giWwd9j9xAP6W8WAqpmF3fxUw0VEEUAkGwTKT0kAmQsc2R68kVv+Zhm9kK4rGw4KEMQ8gDnDppuP7I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788197380; c=relaxed/simple;
	bh=lKZFVN8JLmInDHrp96Aem5GFnlnxOcTOHx3Yzjj1r44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VK+p6gSqt3yYkQ4gcmOtfodgFyRFNIsvmLxhVYWnsHFugunhYcin9NqG84i9j/Hq6Vjr7OC0WX2g586mmE/IpmiM/plQmSvYLsdDj+lRjrvtp9QiqG15Rlb4Ixm+8EMSZUKqz5SepSTxYQJbdyJp3kiXryMXuPLzdJc1nUcyl8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Xor3L9HU; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Xor3L9HU"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788197377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=as1Q7CFzcg3A1HVRGPPklx5tG13IWKXOKBiHIvgFoy8=;
	b=Xor3L9HU+bV+NUIPw2yR8REDwL6c/wcL/gfWVJs7ETIpdTc2bVWNgLjoXwEghyeOAlQjH9
	aurkkqLoZDsEC3+omIgshgJm3voGhoGJ4WEZ7JjgCRzy6r+GNHvACYuEkcv9+He6+OFsy6
	I8ju50AfRDXnX2irMIUabCaZyLX2b9E=
To: andreas@gaisler.com,
	davem@davemloft.net,
	sparclinux@vger.kernel.org
Cc: Tony Rodriguez <unixpro1970@gmail.com>,
	linux-kernel@vger.kernel.org,
	david.laight.linux@gmail.com,
	glaubitz@physik.fu-berlin.de,
	thuth@redhat.com,
	regressions@lists.linux.dev,
	nroach44@nroach44.id.au,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v2] sparc64: increase kernel thread stack size to 32K
Date: Mon, 31 Aug 2026 19:29:24 +0200
Message-ID: <20260831172928.3082853-1-stian@itx.no>
In-Reply-To: <20260519075809.8993-1-unixpro1970@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Rodriguez <unixpro1970@gmail.com>

Kernel stacks on sparc64 are 16K and this is no longer enough:
several machines (SPARC T5-2 among them) panic early in boot during
USB hub enumeration with "corrupted stack end detected inside
scheduler". sparc has not been converted to THREAD_INFO_IN_TASK, so
thread_info sits at the bottom of the kernel stack and a marginal
overflow corrupts it first; CONFIG_SCHED_STACK_END_CHECK then fires
from __schedule long after the deep path has unwound, which is why
the reported backtraces look shallow.

Measurements with CONFIG_STACK_TRACER on an UltraSPARC T4-1 show the
problem is frame count, not any single large frame. The high-water
mark of an ordinary successful boot is 12616 of 16384 bytes (77%),
reached in hub_probe() with a printk console flush and then a timer
interrupt (which runs on the task stack, and whose scheduler tick
performs load balancing and IPI delivery) stacked on top. Of the 66
frames in that path the largest is 408 bytes, and ~85% of them are
176-224 bytes - at or just above the SPARC V9 ABI minimum frame
(128-byte register window save area plus 48-byte argument save
area). An equivalent call chain on x86-64 costs roughly a third of
the stack, so a 16K stack on sparc64 provides far less effective
call depth than on other 64-bit architectures.

Double THREAD_SIZE to 32K (four 8K pages). The PAGE_SHIFT
conditionals are dropped: sparc64 only supports 8K base pages, so
the other branches were dead code. Kernel stacks become order-2
allocations; sparc64 has no VMAP_STACK, but stacks are allocated
once per thread and the trade against boot-time panics is a good
one.

Link: https://lore.kernel.org/all/20260519075809.8993-1-unixpro1970@gmail.com/
Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
[stian: reduced the diff to the THREAD_* defines, measured stack
 usage with CONFIG_STACK_TRACER and rewrote the changelog]
Signed-off-by: Stian Halseth <stian@itx.no>
---
v2:
 - drop the CONFIG_SPARC64 / PAGE_SHIFT conditional chain from v1;
   thread_info_64.h is only built on sparc64 and only 8K pages are
   supported, so define the three constants unconditionally
 - replace the panic backtrace in the changelog with stack tracer
   measurements answering David Laight's review comments:
   https://lore.kernel.org/all/20260520144104.618c75ca@pumpkin/
 - retitled from "unify thread stack sizing and add explicit 32KB
   stack"; the sizing logic for other configurations is unchanged

Tested on an UltraSPARC T4-1, booted with the stack tracer armed
("stacktrace") before and after this patch. The boot high-water mark
is 12616 bytes on both kernels - the worst path (hub_probe with a
printk and a timer interrupt on top) is deterministic - i.e. 77% of
the 16K stack before, 38% of the 32K stack after. DEBUG_STACK_USAGE
agrees: the peak boot-time task shows 9208 bytes left of 16K before
vs 25592 bytes left of 32K after (7176 bytes used in both).

 arch/sparc/include/asm/thread_info_64.h | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -99,13 +99,8 @@
 #define FAULT_CODE_BLKCOMMIT	0x10	/* Use blk-commit ASI in copy_page */
 #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
 
-#if PAGE_SHIFT == 13
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define THREAD_SHIFT (PAGE_SHIFT + 1)
-#else /* PAGE_SHIFT == 13 */
-#define THREAD_SIZE PAGE_SIZE
-#define THREAD_SHIFT PAGE_SHIFT
-#endif /* PAGE_SHIFT == 13 */
+#define THREAD_SIZE (4 * PAGE_SIZE)
+#define THREAD_SHIFT (PAGE_SHIFT + 2)
 
 /*
  * macros/functions for gaining access to the thread information structure
@@ -128,11 +123,7 @@
 #endif
 
 /* thread information allocation */
-#if PAGE_SHIFT == 13
-#define THREAD_SIZE_ORDER	1
-#else /* PAGE_SHIFT == 13 */
-#define THREAD_SIZE_ORDER	0
-#endif /* PAGE_SHIFT == 13 */
+#define THREAD_SIZE_ORDER	2
 
 #define __thread_flag_byte_ptr(ti)	\
 	((unsigned char *)(&((ti)->flags)))
--
2.53.0

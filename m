Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D181D314D37;
	Sun, 27 Sep 2026 21:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790544565; cv=none; b=dyQeqfvbUO5ogcinDT8QGL5vyjZ5hVgb4U4oS7xaf8jWDSLCQ7DyHG3mlJ5q0NbE3H8LBP3Kstko7VkRmYHk92PPOj++dIDP5Q7xlKKwEwZ6NRtjgcUVmNUz9pcopOB6pilCm+EJTIuMj5mOahrLhLMssrhlXTk9TlYi2jU8wac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790544565; c=relaxed/simple;
	bh=ZdP8akaIB+EYU8/7T2OgyYdXlnTQ5Dpskc4c1QXPRRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CV0ji9lv8hJYdpxgZUUB0wcswbIopcBB9eVFAFhQX+IqTWjHL9zICLUlH8cMgjgIG4qaKpdLA8bO8U/7Ni4tlUMVx5Ft6hXNsw1HF+M64F7K3IDewl4H1w4B5NNYzOQkNINxtGtMENVwoAP5+hQvq32UXEPF8ljjBm/+uwMm+KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=BQQC5+T4; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="BQQC5+T4"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790544556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vVk683zxNhz5LjQr1fmEFS9mghEkBEiP1XPaWUoGcpg=;
	b=BQQC5+T4b3jX/MAJXQsnSMRbZlIubq9awTf5texse1PFttMLddnymJESCEiLd/Mx7kibRa
	BV2rRV8I7ljnh/WjgsXXdJwHlbzVkD+aU6ob8a9b1Ut2EFiz/1NaupUbXpePfPcubUrNqR
	qbhbhkaJcUlTAnt0beIrZY4fLmb6zHs=
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
	kaloz@kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v3 1/2] sparc64: increase kernel thread stack size to 32K
Date: Sun, 27 Sep 2026 23:29:00 +0200
Message-ID: <20260927212913.3237082-1-stian@itx.no>
In-Reply-To: <20260927204912.3667-1-kaloz@kernel.org>
References: <20260927204912.3667-1-kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Rodriguez <unixpro1970@gmail.com>

Kernel stacks on sparc64 are 16K and this is no longer enough:
several machines (SPARC T5-2, Sun Ultra 45) panic early in boot
during USB hub enumeration with "corrupted stack end detected inside
scheduler". sparc has not been converted to THREAD_INFO_IN_TASK, so
thread_info sits at the bottom of the kernel stack and a marginal
overflow corrupts it first; CONFIG_SCHED_STACK_END_CHECK then fires
from __schedule long after the deep path has unwound, which is why
the reported backtraces look shallow.

Measurements with CONFIG_STACK_TRACER show the problem is frame
count, not any single large frame. On an UltraSPARC T4-1 the
high-water mark of an ordinary successful boot is 12616 of 16384
bytes (77%), reached in hub_probe() with a printk console flush and
a timer interrupt (which runs on the task stack) stacked on top. Of
the 66 frames in that path the largest is 408 bytes, and ~85% of
them are 176-224 bytes - at or just above the SPARC V9 ABI minimum
frame. An equivalent call chain on x86-64 costs roughly a third of
the stack, so a 16K stack on sparc64 provides far less effective
call depth than on other 64-bit architectures. On a Sun Ultra 45
(sun4u), which panics on 10 out of 10 boots with 16K stacks and USB
devices attached, a forced hub rebind peaks at 15832 bytes.

Double THREAD_SIZE to 32K (four 8K pages). Kernel stacks become
order-2 allocations; sparc64 has no VMAP_STACK, but stacks are
allocated once per thread and the trade against boot-time panics is
a good one.

Link: https://lore.kernel.org/all/20260519075809.8993-1-unixpro1970@gmail.com/
Tested-by: Imre Kaloz <kaloz@kernel.org> # Sun Ultra 45
Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
[stian: reduced to the minimal value change, measured stack usage]
Signed-off-by: Stian Halseth <stian@itx.no>
---
v3:
 - split per Andreas' review of v1: this patch is now only the size
   change (minimal diff as posted by Imre Kaloz); the removal of the
   dead non-8K-page branches moves to patch 2/2 with a Fixes: tag
   for 15b9350a177b
 - added Imre's Tested-by and Ultra 45 (sun4u) measurements
v2: https://lore.kernel.org/all/20260831172928.3082853-1-stian@itx.no/

 arch/sparc/include/asm/thread_info_64.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -100,8 +100,8 @@
 #define	FAULT_CODE_BAD_RA	0x20	/* Bad RA for sun4v		   */
 
 #if PAGE_SHIFT == 13
-#define THREAD_SIZE (2*PAGE_SIZE)
-#define THREAD_SHIFT (PAGE_SHIFT + 1)
+#define THREAD_SIZE (4*PAGE_SIZE)
+#define THREAD_SHIFT (PAGE_SHIFT + 2)
 #else /* PAGE_SHIFT == 13 */
 #define THREAD_SIZE PAGE_SIZE
 #define THREAD_SHIFT PAGE_SHIFT
@@ -129,7 +129,7 @@
 
 /* thread information allocation */
 #if PAGE_SHIFT == 13
-#define THREAD_SIZE_ORDER	1
+#define THREAD_SIZE_ORDER	2
 #else /* PAGE_SHIFT == 13 */
 #define THREAD_SIZE_ORDER	0
 #endif /* PAGE_SHIFT == 13 */
--
2.53.0

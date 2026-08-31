Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E563390CAC;
	Mon, 31 Aug 2026 18:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788199658; cv=none; b=VDZXXMEpdz2/zHiZ9JwJMmulEqGjnlEm7pfi4CXrsprSQywulux7bQrOjcJjQZIm5i1L0jbTcHIXE4ebWl8/aZ7yREJNiW5NkEIswCZc7Hhe2zLHlg0oYsxU4L6BK1pAN8fXE2up3IS0/PymKZGa/3j6V8In38qP5oPKoSs7P34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788199658; c=relaxed/simple;
	bh=wlBvWv5wAC+mYLHqVd2/cXFvgyXsx7SGWxIsHuZFY8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LBsPytWUo+12f0Gj3r6OAjGBrjipS1MCoAke7btC9oUWhcH+OK2ynJ3CBpf3qtwAaOeI7IVrMNefqzucm4tQrbIdlZTlA301RJ+ZLB96rxx17CV59x/Vna+AfHWki4MNbN7UBIYSNMk38hz3jb7eRK9XvkHYsfiTuLFunbbUjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=GPDavYa0; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="GPDavYa0"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1788199655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QWROxA68Nbt4khZYWg/OSJ5zjSHC+mroG5OsDJm8z2Q=;
	b=GPDavYa0rbB6zLs+pK0yXVZSusP0ltO+/BfAk70NqN6jOpyi0AZYVlj0PPWQURTfjOipSY
	+miF+BkQ+GPLjq9cMfbc/0Zx1ugirVnVYMxXjyI1dfsq3jobSOXuhTzWOMyaCxn3Dlu4Dl
	cUVEFFYPvCvCSK2B/VK7LfJipc39bIQ=
To: tglx@kernel.org,
	andreas@gaisler.com,
	davem@davemloft.net,
	sparclinux@vger.kernel.org
Cc: Tony Rodriguez <unixpro1970@gmail.com>,
	linux-kernel@vger.kernel.org,
	thomas.weissschuh@linutronix.de,
	regressions@lists.linux.dev,
	glaubitz@physik.fu-berlin.de,
	linux@leemhuis.info,
	torvalds@linux-foundation.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH v3] sparc64: Fix comparator problem with timer interrupts
Date: Mon, 31 Aug 2026 20:07:27 +0200
Message-ID: <20260831180728.3097740-1-stian@itx.no>
In-Reply-To: <20260519022421.5978-1-unixpro1970@gmail.com>
References: <20260519022421.5978-1-unixpro1970@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tony Rodriguez <unixpro1970@gmail.com>

The tick/stick/hbtick add_compare() implementations program the
comparator and then check whether the write took effect in time:

	exp = read_cnt() + delta_ticks;
	write_cmp(exp);
	return (read_cnt() - exp) > 0;

A nonzero return value means the expiry time was already reached
before the comparator write could take effect, so the interrupt may
never fire, and the caller retries with a new expiry:

	return tick.add_compare(delta_ticks) ? -ETIME : 0;

The check only fails the write when the counter has advanced past the
expiry time, but not when it is equal to it. In the equal case it is
unknown whether the comparator write took effect before or after the
counter reached the expiry value, so the compare match - and with it
the timer interrupt - may have been missed. add_compare() then
reports success, the caller does not retry, and the CPU is left with
no pending timer interrupt.

This results in stalled hrtimers and RCU stalls / hangs under load,
observed on SPARC S7-2 and T7-1 systems:

    rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
    rcu: rcu_sched kthread timer wakeup didn't happen for 5259 jiffies!
    rcu:     Possible timer handling issue on cpu=100 timer-softirq=15

Treat counter == expiry as failure as well, so the caller retries
with a new expiry time. After this change S7-2 and T7-1 systems no
longer hang.

Diagnosed-by: Thomas Gleixner <tglx@kernel.org>
Link: https://lore.kernel.org/all/87tssb6olo.ffs@tglx/
Link: https://lore.kernel.org/all/871pfcznw0.ffs@tglx/
Link: https://lore.kernel.org/all/20260519022421.5978-1-unixpro1970@gmail.com/
Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
[stian: rewrote the changelog per review of v2, retested]
Signed-off-by: Stian Halseth <stian@itx.no>
---
v3:
 - rewrite the changelog: describe the write/readback ordering and the
   direction of the equal-compare case per Thomas Gleixner's review
   https://lore.kernel.org/all/878q9fxywc.ffs@tglx/
   (the code change is identical to v2)
 - add the Link: tags to the original debugging discussion
 - picked up with Tony's agreement after v2 stalled
   https://lore.kernel.org/all/10382506-3f57-4b33-8356-34f23fb5f153@gmail.com/

Tested on an UltraSPARC T4-1 (sun4v, stick variant): 9.1M hrtimer
reprograms in 90s across 32 threads with 10-500us expiries, no
stalls, no lost wakeups (worst oversleep 657us).

 arch/sparc/kernel/time_64.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -146,7 +146,7 @@
 			     : "=r" (new_tick));
 	new_tick &= ~TICKCMP_IRQ_BIT;
 
-	return ((long)(new_tick - (orig_tick+adj))) > 0L;
+	return ((long)(new_tick - (orig_tick+adj))) >= 0L;
 }
 
 static unsigned long tick_add_tick(unsigned long adj)
@@ -277,7 +277,7 @@
 			     : "=r" (new_tick));
 	new_tick &= ~TICKCMP_IRQ_BIT;
 
-	return ((long)(new_tick - (orig_tick+adj))) > 0L;
+	return ((long)(new_tick - (orig_tick+adj))) >= 0L;
 }
 
 static unsigned long stick_get_frequency(void)
@@ -411,7 +411,7 @@
 
 	val2 = __hbird_read_stick() & ~TICKCMP_IRQ_BIT;
 
-	return ((long)(val2 - val)) > 0L;
+	return ((long)(val2 - val)) >= 0L;
 }
 
 static unsigned long hbtick_get_frequency(void)
--
2.53.0

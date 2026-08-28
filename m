Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876D144A3F9;
	Fri, 28 Aug 2026 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787920673; cv=none; b=QVErMikK0F7BVqaQMI5KT4nsw0dMuEjiDDVlj5iAOdnEXhkFixX1JJtZodpLhdCG16VFOIPBMUFSBs4n0sQW2s6D48jNtj78eEQEUEM4u9NeEEimBx6ikf/bGnBn9DqBa5DKvbpfRjSkprQBFA8T+03+cChdeyMrUAWCL443Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787920673; c=relaxed/simple;
	bh=A7X5hFPusa5b5cAVS+T4xcIgHawykE/UmG62q6yykk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r5ZNPrk9vNNsHbdo7LqNEZTkoTasceyvyw6ErMX+5UBlabznzEhpUyiCWvZ4O1Ma3IRJTKFX9LqEIekCj50f0VEypI/vxEyUWxer6ap8EgKeCtmMQ1OpudnNcSZBm18Hja/jILzdp2oT4d2nU+fKdEll8GjoDlI7fCNnBVpBPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=p0u6EeSF; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="p0u6EeSF"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1787920659;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UapoWzW2JEtGsyyZNPvSC9pLw+BrNnRNW91gs0uHYnE=;
	b=p0u6EeSFiwSQNAgS7thLIr69FsX2uZ86Cci3HDa2kYs+xVChxa1bMCM1eHfi54LthNknP0
	nlWxrwYG7cgbdNYkeo1OXrSbwqf/KhC8fwqfCm7TpOfvH0Nqqui8SVgMVjSqTmk3pZRXn7
	oPWwNKM2tVLE4mtKBG1XHbide7QsuQg=
To: davem@davemloft.net,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	glaubitz@physik.fu-berlin.de,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 0/3] sparc64: fix a window fill fixup lockup and two fault bugs
Date: Fri, 28 Aug 2026 14:37:04 +0200
Message-ID: <20260828123707.1852437-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A register window fill that faults is mishandled in three ways on
sparc64.  The first wedges the CPU in kernel mode and takes the machine
with it; the other two corrupt what the kernel reports about the fault,
and were found while chasing the first.

1/3 is the lockup.  user_rtt_fill_fixup_common() re-enters the kernel
without passing through etrap, so %asi is left as the ASI_AIUP that
rtrap set for the fill while the primary context has been restored to
the kernel's.  Every subsequent %asi-based user access then translates
in the kernel context, and a user address below the VA hole can never be
resolved: the fault repeats forever, the task survives SIGKILL, and RCU
eventually reports the CPU stalled.

The reproducer below moves %sp onto a page, flushes the register
windows, mprotects that page PROT_NONE and takes a signal, so the fill
on the signal return path faults.  It needs no unusual configuration and
wedges a stock kernel in a few seconds.  On a fixed kernel it prints
PASS and exits.

Mind where you run it.  On an affected kernel one CPU is pegged in
kernel mode permanently, the task cannot be killed, RCU grace periods
stop completing so fsync() and sync() hang, and the machine needs a hard
reset.

    cc -O0 -o wedge wedge.c && ./wedge

    #include <signal.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <sys/mman.h>
    #include <unistd.h>

    #define STACK_BIAS 2047
    #define REGION     (1UL << 20)

    static void segv(int sig)
    {
    	static const char m[] = "PASS: SIGSEGV delivered, kernel handled it\n";

    	write(2, m, sizeof(m) - 1);
    	_exit(0);
    }

    /* The normal stack is about to become unusable, so the handler needs its own. */
    static void arm(void)
    {
    	static char sigstk[256 * 1024];
    	stack_t ss = { .ss_sp = sigstk, .ss_size = sizeof sigstk, .ss_flags = 0 };
    	struct sigaction sa;

    	sigaltstack(&ss, NULL);
    	memset(&sa, 0, sizeof sa);
    	sa.sa_handler = segv;
    	sa.sa_flags = SA_ONSTACK | SA_NODEFER;
    	sigaction(SIGSEGV, &sa, NULL);
    	sigaction(SIGBUS, &sa, NULL);
    }

    static void wedge(void)
    {
    	char *region;
    	unsigned long sp;

    	region = mmap(NULL, REGION, PROT_READ | PROT_WRITE,
    		      MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
    	if (region == MAP_FAILED) {
    		perror("mmap");
    		exit(1);
    	}
    	memset(region, 0, REGION);

    	sp = (unsigned long)(region + REGION - 4096) - STACK_BIAS;
    	fprintf(stderr, "%%sp -> %p, flushw, then mprotect PROT_NONE\n",
    		(void *)(sp + STACK_BIAS));
    	fflush(stderr);

    	__asm__ __volatile__("mov %0, %%sp" :: "r"(sp));
    	__asm__ __volatile__("flushw");		/* windows now live in region */
    	mprotect(region, REGION, PROT_NONE);	/* ...and become unreadable */
    	__asm__ __volatile__("nop");		/* the refill on return faults */
    }

    int main(void)
    {
    	arm();
    	fprintf(stderr, "pid %d\n", (int)getpid());
    	fflush(stderr);

    	wedge();

    	fprintf(stderr, "returned normally - no fault triggered\n");
    	return 1;
    }

2/3 and 3/3 came out of that investigation.  do_fault_siginfo() decodes
the instruction at regs->tpc to compute si_addr, which is not the
faulting access when the fault came from a spill or fill; in one capture
it decoded a branch and reported the contents of %g5.  And the huge-page
path in the TSB miss handler tested TL after switching the global
register bank, so it consumed a fault code and a PTE that no longer
existed and killed the task with SIGSEGV at an address that had never
been mapped.  That one needs CONFIG_TRANSPARENT_HUGEPAGE and only
appears under load.

1/3 is reproduced and fixed on an UltraSPARC T4-1 (sun4v, Niagara4) and
on a Sun Fire V240 (sun4u, UltraSPARC-IIIi), which between them cover
both forms of the global register bank switch, SET_GL and the
PSTATE_AG|PSTATE_MG write.  2/3 and 3/3 are tested on the T4-1, where
with all three applied a Go toolchain build now completes five times
running with THP enabled, having previously died within a minute.

Link: https://github.com/sparclinux/issues/issues/87

Stian Halseth (3):
  sparc64: restore %asi in user_rtt_fill_fixup_common
  sparc64: use the fault address for si_addr on window fixup faults
  sparc64: decide the TSB huge-page window fixup before the bank switch

 arch/sparc/kernel/tsb.S       | 24 ++++++++++++++++++++----
 arch/sparc/kernel/urtt_fill.S | 15 +++++++++++++++
 arch/sparc/mm/fault_64.c      |  9 +++++++++
 3 files changed, 44 insertions(+), 4 deletions(-)

-- 
2.51.0


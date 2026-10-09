Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2C6547043;
	Fri,  9 Oct 2026 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569044; cv=none; b=AOBN/MRxAeVuNOmP1GpHjpp+jSJzU/3+Vdbei7R86CzIOosgMZ+XyxxUqL79tT6saWlCevZ2cVfjeyUTBS3D27pgE9/hlG6PtLdErhErFQ8nV/PfFz3rIFosclG79YX0T8I5MTFhW2ly9XhE8Hy39+Ek6fwWzlRio8uuvhvn27E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569044; c=relaxed/simple;
	bh=+buQxyx3i/t9XvkLpLS52uIWVTc/wk2y118JaW42B94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I0VgAiWTEz1PmkM83w9GQxdF0acbWx21SIZYw5ZaLRE8CBwAipaDAGc7eJpXT5p0kBaJhCxAQ8NYu4d8+K8PIBogMdKMnEEIbWoN/VJYpKj6K+otUjTdbM4Z7Rv/zTyv5Fn5H5dmdSqBN59FmvCONebsFdHFeovjlyG6Wi9q6dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=Wotf5ICm; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="Wotf5ICm"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1791569034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i5pbuo4my0SkJy/PBL1s23mRjVYhIVcoDh4EhMzJgu4=;
	b=Wotf5ICm8PcsxDRzsulzdf3fa6zQZ4OR8x9tGfcveCFgPGylIKHXFH9BC1WA95ob8Cy5iV
	2jchPCK5BoXPXNNDfqGD3ABJYacl8QJdrU76EvuwL9COlJbAb2E9dBenA+jHigb+7CRzO0
	pFt26OZWoRNxIlM0mufo97H15h8VUx8=
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 0/4] sparc64: kprobes: Make kprobes work on sun4v
Date: Fri,  9 Oct 2026 20:03:31 +0200
Message-ID: <20261009180336.1315684-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Any kprobe hit on a sun4v machine oopses, because the probed
instruction is single-stepped from memory that is not executable there.
Patch 1 moves the copy into an instruction slot from get_insn_slot(),
as other architectures do.

Once probes work, three older single-step bugs show up: a taken BPr or
FP branch resumes at the wrong address (patch 2), so does a probe on a
delay slot instruction (patch 3), and an annulled branch can skip the
break instruction after the copy (patch 4).

Tested on a SPARC T7-1 and T4-1 (sun4v) and a Sun Fire V240 (sun4u):
entry and return probes, probes on all 50 instructions of
__task_pid_nr_ns at once while checking getppid(), ps and /proc, probes
on the SPARC AES routines during AF_ALG encryption (sun4v), and refusal
of ba,a. Without the series the first probe hit oopses on sun4v, and a
probe on a taken brnz oopses on sun4u as well.

Stian Halseth (4):
  sparc64: kprobes: Single-step from an executable instruction slot
  sparc64: kprobes: Fix up register and FP branches after single-step
  sparc64: kprobes: Resume after a delay slot at the saved next PC
  sparc64: kprobes: Handle annulled branches

 arch/sparc/include/asm/kprobes.h | 10 +++--
 arch/sparc/kernel/kprobes.c      | 69 +++++++++++++++++++++++++++-----
 2 files changed, 66 insertions(+), 13 deletions(-)


base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
-- 
2.43.0


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795870393;
	b=YEvcrwxte4yefTK3UAGeY2JHPLPCiPoRmw5TKq1iyW9i/R4s2whX1SEbXJIAXssbpQvL
	 nfZgOoiClv/7r0VfcrB4qfwegZgVaWvtffQxaBeLn/GS8sma/JKt3wLukK9v1dJ33IdvX
	 Zdlp7rsaqNnXihILrxF4z56xTA0lAN2PrUR1J/XgETj4wrSj2qD3OMLWWiKpioeLIMGhY
	 SKf+5dHZbKHLz4joA6g+8VVsV5X5jhraeViRbf2HwfVvCYGPVaJ2S+jOXUoPRl/KoRtZv
	 71YDPDT6MM8U8Ddh0N0v9mxmMMWtPYBF8e3Qfn7wKVmw/DVfKI/pDOL2C987pRrtUpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795870393;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Le55nTgOnRmiMyY/pp4YijMrc6PTrM00ZvR48+ZIGeE=;
	b=GlmD3wJZBH8fozsKqeQv2ac686d9D4vSD+GUk59gKYU3Rq1k8jpBBYoVv6Km9OrePH3z
	 wR5s3FSoZlz5I9CNA2Q1byed/oCPMRIVb907roUyX3r/uoBVMX7qRH5FhV/qMoX8X9Rcc
	 zebRY+q/eH2OxzEj7jiyuEg8mfahxiNqAoaqetaqXLZI2VfmUM/gMzWkyJG1Q1LVQ9m8U
	 7gWXoBdO7m72jX1A5cFTTYSlJFUej+fcCHmOCKUw6xkLJyaWhRCsBjELwNLd36l4lVvVB
	 0z26SZH4MduRFymCD63GnmNLJqlabQ3R+WSKDG/B41h7JZo8FSvkGytZTC5bUp5P9gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QvSZAh6/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F053606A31F;
	Sat, 28 Nov 2026 12:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QvSZAh6/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787711F0089A;
	Sat, 28 Nov 2026 12:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795870392;
	bh=Le55nTgOnRmiMyY/pp4YijMrc6PTrM00ZvR48+ZIGeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvSZAh6/0FLJW+/BZCQqaEcCO0CQgljK41CG7lse5jrL1E9jvqzhUkr68Wefl9EeP
	 hXdysXiYd+aph334Kq9AuGLC4UUPtrDh/+QJdxk1RFkiw9WHXJSbrpaj4PWms7oSgH
	 HNTGR0EKdIG04S49GqkfHIiTADwlG1gLv6E0BE3424gOceT+LhEIsvwTo3Fx3uH9Fa
	 gM4HiJSeNHIVI9GgXBnHEZ2B29QXVitlxyulfpOtUY+Bc9WRoF8iV48bi/eauc19DE
	 4KMFzB1banzSMrBe1l2SNafy6z3x8izS8x578/ea1DuckFlLSMoss7gESR+VoA5elP
	 /wmFeQ2M+RjGg==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "David S. Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Stian Halseth <stian@itx.no>
Cc: Naveen N Rao <naveen@kernel.org>, Danish Khateeb <danishkhateeb03@gmail.com>, sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] sparc64: kprobes: Make kprobes work on sun4v
Date: Sat, 28 Nov 2026 21:53:08 +0900
Message-ID: <undine-1795870388603907145-0de276961caf0063@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261113144057.1697874-1-stian@itx.no>
References: <20261113144057.1697874-1-stian@itx.no>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Fri, 13 Nov 2026 15:40:53 +0100, Stian Halseth <stian@itx.no> wrote:
> Any kprobe hit on a sun4v machine oopses. The probed instruction is
> single-stepped from memory that is not executable there. Patch 1
> moves the copy into an instruction slot from get_insn_slot(), as other
> architectures do.
> 
> Once probes work, three older single-step bugs show up. A taken BPr or
> FP branch resumes at the wrong address (patch 2). So does a probe on a
> delay slot instruction (patch 3). An annulled branch can skip the
> break instruction after the copy (patch 4). Patch 2 overlaps Danish
> Khateeb's relbranch_fixup() fix from September. Whichever is applied
> first, the other is a small rebase.
> 
> Tested on a SPARC T7-1 and T4-1 (sun4v) and a Sun Fire V240 (sun4u):
> entry and return probes, probes on all 50 instructions of
> __task_pid_nr_ns at once while checking getppid(), ps and /proc, probes
> on the SPARC AES routines during AF_ALG encryption (sun4v), and
> refusal of ba,a. Without the series the first probe hit oopses on
> sun4v. A probe on a taken brnz oopses on sun4u as well.
> 
> v2: make flush_insn_slot() a no-op in patch 1 (Masami). The slot is
> flushed in arch_prepare_kprobe() when it is written. A killed probe
> has a NULL slot pointer. init_aggr_kprobe() flushed through it.
> Patch 4 no longer touches the macro. Rebased onto 7.4-rc3. Build
> tested on the T7-1.
> v1: https://lore.kernel.org/all/20261009180336.1315684-1-stian@itx.no/
> 
> Stian Halseth (4):
>   sparc64: kprobes: Single-step from an executable instruction slot
>   sparc64: kprobes: Fix up register and FP branches after single-step
>   sparc64: kprobes: Resume after a delay slot at the saved next PC
>   sparc64: kprobes: Handle annulled branches
> 

This series looks good to me from kprobes point of view.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

David, Andreas, can you pick this series?

Thank you,

>  arch/sparc/include/asm/kprobes.h | 14 +++----
>  arch/sparc/kernel/kprobes.c      | 69 +++++++++++++++++++++++++++-----
>  2 files changed, 66 insertions(+), 17 deletions(-)
> 
> 
> base-commit: b3dfbde62cf1981c4638939c159dfd087b7a72e9
> -- 
> 2.43.0
> 
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

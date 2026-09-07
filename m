Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D236C5B2
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 04:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756708; cv=none; b=cmLG7dsQ/NOIoBPskzIOjW79Rc40ihzZT1ZyWN7gjuS2rSBmgMYr67ERWWwyKuSSSJyUe79x0lcec17Eun2RYFuyMeVZTBu400O06y6gSOItkStTUfd5qLk2Z1OqWlt2Aq4RQFvjSR5T9rteckjgpp/K7nFxe4i6hRuenysh0oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756708; c=relaxed/simple;
	bh=GYLGPTz7B4DR+c4lAIA8hn1QEzqtbEK6fanc+u3joVg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=niVBLRPkYkDRWmxRxDyDlUvR7cAh5/D9CB2OFKjld7gZa+3UBXHoew6dMPdocbBftirxni+Q/TtPVsasWLILP4guk2auxvCQd5NgmfcxBvNGhykdvi2GyPzH4VbBZnw/H/jW3CBaKWMtJL245CD9WAGckvBCX1nThJny8Aks9xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnRN3Zzx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnRN3Zzx"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-398a5aad413so2240466a91.3
        for <sparclinux@vger.kernel.org>; Sun, 06 Sep 2026 21:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756706; x=1789361506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
        b=fnRN3Zzx+m/zlZ8cev3X69P2unCU/hKmk9KjTIB3yjMi8U152ulGdkf7hT/RomEYNI
         XuYqllVVPpP67DyqhwAO5tpBTEatOmP/7k5ybHQErlPeSHslie07gjN+XwRst7xjKrtt
         8YFQNXz4EqT0gN7d289pFJ0/TyownBzAv1nJKSsshKAVbPUSed1KJsb/dgFRzqDaSPPL
         OSWkArHfoZK/XeqQnBvR4j8olsKFu9t528W0R/d0+ahTHcfwTqkNVWjamdJ7cMmkLpVz
         q9R4iQ5uYJoAyPcXs58eKuia1X4/81NoH1Kg9HTUOXRa7j21BfB6Phi9wJ1dfFatS0Kp
         N2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756706; x=1789361506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dSkZ75+revt0e4KyfnrpcrTujkH4yPeuqSBvDGGLspk=;
        b=dJpPwcmCRR8GoZpqvSH160CnOz3hzN4KDX5k8Cn4JOxeBiqlc1otx2yRluIydTIoBK
         /XsHXE0yhsF1ROjyuaGsQARh4xdx+tCSv5MboJEcCPMJfAGe8U8njnK4i9g7dd646NYe
         FkTaDidBsxHSlNQqGWlFQPHu8gFKbBUf20sTIW5D/Gj/4tqPDltemX0E8Ahm8CbF6Bjt
         it40PFESsD1UrWG69M8xgIlHSfNwME7WhScB4iCR5hDG7CVVmH/JyaLovSAViU1/4A7E
         f0cgo+8eLKPP+sS4vldN3FI6JQVBp5LPOSgOahZ3RHeZlXvDXBMvv+khBxB/8XtZQil3
         1obA==
X-Forwarded-Encrypted: i=1; AKwUvBz5n8JbMlbhaGiPu+2+JP70goxZlz8UJ/ux41/8KHOMBcKB8NYFQDDalfcezSJ8o6qgUc2c51ENq4eO@vger.kernel.org
X-Gm-Message-State: AFuF++muV49E41YTGUbt2kFGkL9k0vgRF0pjEwtwS2JrW+DMBXHHvgMe
	ewTh68td3+lp0w7H5KC8FnjRrhIqfn793RjBvZ2UszeUJM01Gc0dlQdK
X-Gm-Gg: AYBFou2sYeN/KKFQ293KURBxq1ZzYzvW727/ooWF2sUBNeICCvuWpy0NtXz3nyllAPp
	CVShxeHSiu0Se5PELh8x2OH2CtTne8bQIWAiyuMnT89sGFQsY/9aJ2VumwLKxqkvdusgTFAG0ED
	uAayRC+gRZ3ZqUzB6G4YaIDMmzhImMii+Um6xkgRcSKHvc2pVh5Kyh3Jl5JbJO5ttAuvRTB6hEy
	TYKOaRdks7mN/OMIGgINCpITmvmnHHU7F3ELX4PC/IWC02ncJktZG+FqeMMH0tXspoPKZWnDc6D
	ai5d0E7P/0P9A6QtlPQpBOVodtsfCDCmjcWRdGFGn9VXIUJEUvXf0dWs8GBen+C/ZlpSSb7Eoc4
	FI8tKsptfv3f18lEUFn7gjmJtDh/fmgp4tyK7VQaA2wKBR9Vb9D5e+CQtQs2utcG1y3Q92Ad/q3
	7pl4hdHCMGHp2LkDBR7xutBR7lYBZjpmAqKEcb8TvAzBy/UpFtTZkJ7ORDBsSYJS1a3yqUaHXoV
	O23M3qsHLWQJw==
X-Received: by 2002:a17:90b:1643:b0:380:21b7:e727 with SMTP id 98e67ed59e1d1-39b26272f04mr30192034a91.14.1788756706071;
        Sun, 06 Sep 2026 21:51:46 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:51:45 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 0/7] bpf: fix typos and repeated words in comments
Date: Mon,  7 Sep 2026 10:21:28 +0530
Message-ID: <20260907045135.13317-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v2 of the spelling fixes for this tree.

Changes since v1:
Subject prefixes corrected: 'selftests: bpf:' becomes 'selftests/bpf:'
and the tools/lib patch becomes 'libbpf:', as the CI bot suggested.

Only comments change; no code is touched.

 arch/arm/net/bpf_jit_32.c                                    | 2 +-
 arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
 arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
 include/linux/filter.h                                       | 4 ++--
 kernel/bpf/reuseport_array.c                                 | 2 +-
 kernel/bpf/stream.c                                          | 2 +-
 tools/lib/bpf/btf.c                                          | 4 ++--
 tools/lib/bpf/usdt.c                                         | 2 +-
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)


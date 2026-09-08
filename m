Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1CB374E74
	for <sparclinux@vger.kernel.org>; Tue,  8 Sep 2026 05:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846547; cv=none; b=dx1gH2873pu4tDd/j6c7Wc987rSGckuG33soLDieOS7uWksaUVbSjGC5aDZ0CFvBmnUJVt3IXhza6q3AObEYspk5rdWAFTcbNrRLN0CCEJzoBCiOkBRrbGg78nm2uZv2f6BYxZFHrvfSln6H7WBxab6xPF3Mt1AHrsppy4Y8mSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846547; c=relaxed/simple;
	bh=VyhIDkMGxjIHBAZdaTDfNNTavhuZAK2+hkjy/GcRv8g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iqAFN5iutRWRy4FuD9ZTKh8CJxKvPJBX8LU84fu5Qqp7RxMusKVrnnU1aV0IbaRisa6a8J/vCk34VQp6fBDa1tHf9XtT/2Po5GKgw6MaipuDfMAI/uKP3SUSVJie7GLkxkrMEiTU1PnOJTAflCDh46pBRbSbZEgoYdcjBHbFjvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIxqxowJ; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIxqxowJ"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2817034b3a.1
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846545; x=1789451345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3Hk+XNhijnUk0JrFp3DVPvigSnryVRt/+DzNzROaqfU=;
        b=XIxqxowJdju9k542yAl5qdvceLTQwlt5Enxen4g/8x5W0oKqWFiURRWEBZmkac+h82
         k0BsV1KKSaJKStBBqxqBnLGkI46TCD0/0NYfC2CP/9oa+3o8UF/A+NOkDwbZOvn1sBIM
         NBUXWWrcc8dI70Gi8uQ0WxVuGppknP5LWHWjULAI8vENPOOmCOFGRHgnEO9vjhqpcn3t
         hAq866hwuAFW6uHkme/Mf+ketRBxfT6DKjLeGLY4wwHkrE36s9DG8YmMKjEQsP95gXAQ
         r47C6bellblHD53QH2c3h508qgd6nwzTwuaBUgNNjBQNttkcqGLQSJqGoVSFmBxVrV/9
         S7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846545; x=1789451345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3Hk+XNhijnUk0JrFp3DVPvigSnryVRt/+DzNzROaqfU=;
        b=hiPPd763BepQM1xAiVe1TYwXrcpGzEWAO2UV/dLCyr66aabyazcnGm/2RydnPgfnVq
         C74WgfyQYCCRooTagenbee6gzA3aC5oMqHfscZfJRCe60q0ZMvFtt5sdwp7k1PiVEp0c
         Qd0o2ucbF/z8q/tBTxFJ/+S/zHzR7pekWXutbNBedR7OgFwob2hVMht/x9Hc7/BwQGT7
         4B1x/q6bZQa4pQmLbm6RT0GVB6f+oZ8E25NxfmkBl00ZQciLQ5nF0rtR9swnwrSrIb/W
         kwM2vGSnnO2ArwudDJ9ug+Xc6MzAtVKZYUiceMPUjwDeywBWcpspzPuxuIRzocrC5E6X
         TyJw==
X-Forwarded-Encrypted: i=1; AKwUvBxNwalgdLiffS89s1YDrkawv7Hr0JvFVqK+rzn1CR33XjX0/cpNLOlETIUSwAbwQfHiVwOoKG6Bgjip@vger.kernel.org
X-Gm-Message-State: AFuF++nTUbT6yt4CQacULz3p/zgbtM9VSX1TK2Do/FEDFQsQxH9zk5WR
	+DbRd74X0Rn4QPQGhVWxTuWsCyjydVudJ4O+kIEHFiqUROFeixFUkTr4
X-Gm-Gg: AYBFou3GSelA1IfLC1rRygr/DPD+Cl0iYvTDiMJqERmWL2QDwSO8yMftbzR886i/sMN
	8vR9Mv0iWpjjG6p790uVy2j4zwbvnJPFuEWWd6L64CaDzzoSTlCBA6I9GwIQ64iOkdmTPvVNM0V
	3NUhSY94gRWEXIeyGRcwAm22MTeMVUQpZ7uiVxldkigCPGhdrzy0S19iJWjO9zf6L8IWhJb1K5v
	Nes2KsPnYrebuRjbdKIDGc0ib1i2sftGwmGC4+Ba4aCWyrEci8VFyxJ+l9HuyD1Ax41dx52bj+j
	h2sQFafG487sTelF9AsjQZ/NnEIyiiCXMpkna2+RILXmbTFLDsVK/8x3X8lxYczl15jlhIGbDKc
	+ldrd7tdR4T4hPQs2z+uNE868sQNbw+1b4kHsF/1Goho1EDH8mW4sFkA8NMoma2nk03qc7wk/Os
	U3vbeCxKSSnmt2zlVwkVq5pyJiTyQ2lTspQlK6aowiiE0XO58CP12UBeK6BFI30sEXVCXCC+B8m
	fV49I/2mt08Xg==
X-Received: by 2002:a05:6a21:38c:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3da3a0cc91cmr42893779637.24.1788846544946;
        Mon, 07 Sep 2026 22:49:04 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:04 -0700 (PDT)
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
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v4 0/7] bpf: fix typos and repeated words in comments
Date: Tue,  8 Sep 2026 11:18:46 +0530
Message-ID: <20260908054853.13820-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix misspellings and repeated words in comments, found with
scripts/checkpatch.pl using the misspelling list in scripts/spelling.txt.
Comments only, no code changes.

Changes since v3:
 - rebased onto bpf-next.  CI reported a conflict on v3 and asked for a
   rebase and resubmit; the tree has moved on since and the series
   applies cleanly again.  The patches are otherwise identical to v3.

Changes since v2:
 - moved from mainline to bpf-next, which resolved the earlier conflict
   in stream.c where the typo had already been fixed upstream.
 - renamed the selftests patches to the selftests/bpf: prefix used by the
   rest of that directory, as CI suggested.

Hemanth Selam (7):
  ARM: net: fix typo "arithmatic" in comment
  bpf: fix typos in comments
  powerpc: net: fix typo "upto" in comments
  selftests/bpf: fix typos in comments
  sparc: net: fix typo "evalute" in comment
  libbpf: Fix typos in comments
  selftests/bpf: fix repeated words in comments

 arch/arm/net/bpf_jit_32.c                                    | 2 +-
 arch/powerpc/net/bpf_jit_comp32.c                            | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c                            | 4 ++--
 arch/sparc/net/bpf_jit_asm_32.S                              | 2 +-
 include/linux/filter.h                                       | 4 ++--
 kernel/bpf/reuseport_array.c                                 | 2 +-
 tools/lib/bpf/btf.c                                          | 4 ++--
 tools/lib/bpf/usdt.c                                         | 2 +-
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c          | 2 +-
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c                    | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

-- 
2.48.1


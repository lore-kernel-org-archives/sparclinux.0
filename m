Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18068472F74
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 12:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782484; cv=none; b=L1AkrESahLPGJOUu2ylxDLsO1CInJw7Wijc72xch590qDmdVsli/OCXhsFHkChhLejEKF6YfUM10lgbyE1fOSBH7GYpZZUgwy3Tymw1qaBlv1ce+NX0POifdTx9QKB+NIciFA0MfRFNkNC2CWgH1xm67codBP6YnrK5m8sKLITc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782484; c=relaxed/simple;
	bh=JtFt4j8cgUgUtFZaywPAlg51vNEpvkwM47kq5mj/13w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbVPxMgJWyLrY21YAqw3uTHxVUac2YwcL56tfRWSyOuvEMOLJ93sDtBftgdGY2pRhKOkDh4zHpVj4RsFf94bBe2yV0f3H7LLZWKbdtO/1YnH4oSfAs+8ZYq1Nu9eiPXecOx0/H301pZJSYkmq8QuZYpP3OTvNNolLIgnynNgT2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFNPLVNd; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFNPLVNd"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e9ef94c0e2so2043434a34.3
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 05:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782482; x=1789387282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=AFNPLVNd4Lm+6lIv4uOnh94r/o9zZg5GHHTMpqPjjvPYd7EASDDZkCiEXtiBRhzT8i
         ca/Oqgh/H2n2GQJIQ5J438InETfBbwadtt6QyuQqGchrGl6OalA+fdvvUEMt1FKEbqDI
         WsFSSzlqqKNcqZECmehxN1NsH+uDmmRwljkYVJuZr4DcB5539Gmni0UHUDdqZqQyL+Ox
         5CUWcx2oLbufAYUViJ4OZbQaDHeCvu55Cu7yYUVpEDdxMqlmoiaAEIClX+qEh1ErTnMe
         Irsvu9wou18zaI6F6s82b3eBNy+eQN1dwPqaB+/bDrNJEd/eyf7OfBcrEi78v7G7FTNR
         HZrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782482; x=1789387282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gH9gg1qvejjX/sPdW+X7GvG6xfgdjVwQ/p+bz1yISpM=;
        b=gh6gP8z0zGzc4HgROW0thiDGlY2uBXEYnqdqATN7lBCeT3B04yHSDlV8jDpyEBFAOo
         4sS/iCMdrqql8rM5kolAEUqezJlTpktwLfmm0Z+Ph7MsZCrNKeKgIY012lb2KbDSGop3
         xRKrxVVT8H7cbVgH5Y4bZAdFFHIJm99PilcDBXPCFd9ZQyR0z9+T3fo7o2JI6us+lqGt
         yggRxK9QNRj3HtrZUGhJ1wjsXTHbfQFMiKE9lrhUUMsbubmMfCjPITYZaEHR9km2jiqG
         mJMyVEc7yRaIqd6veeSuCpU86DllE5oCpDDhOLtvDCVd95JpmnUsDsJHf954T3hsu/p0
         Hofw==
X-Forwarded-Encrypted: i=1; AKwUvBwLTdH6cXlVd6VWHBHDg/stD7kOF3AO7QpJsTzL50LcL53gorxDo6hErv7KALTgjnKddBU1oudjWycb@vger.kernel.org
X-Gm-Message-State: AFuF++lWmoW7nfsr+vTW6y1Hmgwb1jmKBp3XQgoFGeq9GgaBoMdvgbT1
	Hx5jwgNy36hXnZfI3b3U9/f1J06bhI4mNBioXiANu6ArKSAj7QrjKOj9
X-Gm-Gg: AYBFou1qdyNpRYmPSaM+x90WgoI14gqA5HgVv/UHRbCLgUPz8L/77l5K0u2xZ9Bva9V
	rpoN+EULFsiCtkkjqqKq3S1PudUR4NYE2ssQvH5OPvjavrIESoCtXsdadl+2SGKkB6xL2Us19fq
	dm3e4twyR9/V5EEuBmns/B5yrVBAuhdK/bb87k4diJrh8fGfqa5UbQiyDejdgz4FPi/Y13cYPHS
	9pN039dEWeuFryIL6omZCfkgca5Gj527XwV5j1q5kp3OGcRuihAjSvn8mcUPB9gzbz35vS0AAml
	Ok6l71syhl8SSuSU7xw7jgGV5TAt0zayS0KiIOH2ilk0NH8qsxFxd2BULEPTar5s4uOH6hwglzk
	HnF3YaHPouw9Qj3Cd5HyJKw/LaWMhr2Muyo7Z4g0+3Lxi0VJygGj0mpT9FJG1KG0qA9VkhUzUhR
	lLKeS+wuAWuKuRMLxOJ5qaMTlELv06+qOi2Rv1ZqnbhxEb5fNucxBG2TYGH+qi0z43+0W/ynH0m
	ApTDp5lhZEZhQ==
X-Received: by 2002:a05:6820:a0e:b0:6b6:d425:53f3 with SMTP id 006d021491bc7-6b6fddbd240mr13817787eaf.33.1788782481883;
        Mon, 07 Sep 2026 05:01:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 3/7] powerpc: net: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 17:30:39 +0530
Message-ID: <20260907120043.36894-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907120043.36894-1-hemanth.selam@gmail.com>
References: <20260907120043.36894-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "upto" to "up to", reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/powerpc/net/bpf_jit_comp32.c | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp32.c b/arch/powerpc/net/bpf_jit_comp32.c
index bfdc50740da8..cf8c1b49da25 100644
--- a/arch/powerpc/net/bpf_jit_comp32.c
+++ b/arch/powerpc/net/bpf_jit_comp32.c
@@ -23,7 +23,7 @@
  *
  *		[	prev sp		] <-------------
  *		[   nv gpr save area	] 16 * 4	|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 16		|
  * sp (r1) --->	[    stack pointer	] --------------
  */
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index fc9db691e820..8a1a00026c69 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -23,7 +23,7 @@
  * Stack layout with frame:
  * Layout when setting up our own stack frame.
  * Note: r1 at bottom, component offsets positive wrt r1.
- * Ensure the top half (upto local_tmp_var) stays consistent
+ * Ensure the top half (up to local_tmp_var) stays consistent
  * with our redzone usage.
  *
  * tail_call_info - stores tailcall count value in main program's
@@ -35,7 +35,7 @@
  *		[   nv gpr save area	] (6 * 8)	|
  *		[ addl. nv gpr save area] (12 * 8)	| <--- exception boundary/callback program
  *		[    local_tmp_var	] 24		|
- * fp (r31) -->	[   ebpf stack space	] upto 512	|
+ * fp (r31) -->	[   ebpf stack space	] up to 512	|
  *		[     frame header	] 32/112	|
  * sp (r1) --->	[    stack pointer	] --------------
  *
-- 
2.48.1


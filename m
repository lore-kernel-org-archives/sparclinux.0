Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E65C37B40A
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 04:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756733; cv=none; b=pdCymQ7YKDWVeRBw+B5V+DRgtSc1m7XFLjZEhodQMnmsnkFIq02q+UQUPRaonq3CgmaxOmUfqeOqyEcqM9I5LvwGm4nM8nyk6YUyYR8ZQ3HXpz+58/zeR8wdcfeF9rxvgsllm9lqcd9WmbldS8lw+l441GxlG8LOykg0yjHFEtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756733; c=relaxed/simple;
	bh=p8E1QK/4FioG1d4S1YkCrtoTmqQDudh5HjsVGvHc+yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5kd5H/bi3z7oPUm/hB3Co/0RcUAk9oUPTbJUQC55MKnE9QpdrxTmPUuWj7GRNZhJ0jY7YlOdX428LO2yu2IkliT3Kt037Ng0AYXp2H71poxSXd8ZqWHr0J3dFZJRLlhbLiq3QBI0tAGX9xyavL0al6pmKv1zIlgJCrLaehHkK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNE/yBgc; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNE/yBgc"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38511175ad3so2678964a91.2
        for <sparclinux@vger.kernel.org>; Sun, 06 Sep 2026 21:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756732; x=1789361532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lGe5bwb/eYgn9AMup9CCvH2ogR87NmRNuEpL6c/z+js=;
        b=TNE/yBgcZxbGPAdOq2yiMpEsl86HD0pULin3jKN+bYleIdqSCo82bIK3nb4jVDnbRm
         5K+bl+kvgXkeddLJLnATBuAKWGD6O6L+4vz1coLHfkTFoziLcpEEXszSfxBekqW4bPPv
         OIh3GKTZyZp0JuS15PlkU1IZTilkuwHDZi2ZBT0GWgYu6SX9GV375vih7iiomFKREv6y
         U2pfGH7HIt+hlCty8fkqF7EOYMkoyfAXvvE6VH2kWQx6W1cKsOZJcrmXOraeVGJyWf1d
         CPbndhJJZelS/W/rumZnff/BsqxOd/duZ3q4CAewD2wAaS37h/LMJYRKUAqXe5wBOuyB
         mG0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756732; x=1789361532;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lGe5bwb/eYgn9AMup9CCvH2ogR87NmRNuEpL6c/z+js=;
        b=H1wkK2isKVQezGGaonAoTnmeiD+3Avt3vzWKhEwuc6Hno5Psi2ofguH2PlQ3I4/zoU
         RkcMzeAF4lP1Uy/kr++2woCNu0n359KRENGzp8shG7uXdTXa7DXHAgeobbnI9ydRB4sX
         VzcxD4CuthTAhOm34YwvqwHoTPXOqQb9hFwIQ0mzncKWFrPqHcFTu0eAD3koRn5gFbR2
         I+HdhyPRvXJQaiT2XUspCb8n1K/n6O0KBaMeQcxsIz2Ew4CwdTbkLJrRSlQirxyqS1kW
         hdfDZDkbe+dNxwfW4omKzSTtsWHJwz+qNJr6EcUYTWTfmI9ibBgVFGKxLWnqy5AT+Ayp
         ZAxw==
X-Forwarded-Encrypted: i=1; AKwUvBx6Herew95AK3M3508DW/qfKEe9dlJmztgeMEN1CkrDcVjf6plMDpwkexFU8QwF+YhHTubywtXDsL0o@vger.kernel.org
X-Gm-Message-State: AFuF++lDxJGSNeWHnwo1PQTa5lopjVevxmtBnBnneqfTbseIrCZvIGmQ
	utdWqbbepbOuOMLLRq7gsnasxzRiP8guxy46CB/vyOaHEtfNMpbr5Wri
X-Gm-Gg: AYBFou1rYbeY8RIcve4FYbxX2U/OhFioPKIEG7Mjj32kgck8rE6SNQTeO1NkjFQ7bBm
	BTGDHVzpOsYLyWSl/BsCZAK2qP2Jl4IdzZ9CDc4cMwhlU2VYuZI20EMPTGAiF/FFPSBQQZ99i0B
	WStbXSMGMRKktuQdPlHlUHt5q6sUALTvEHhYrm4ICHkL4ZV0DjTgZD3Uw3ceNJn2bxZOY64upc5
	ZNZveWYqXKXwFtw0f+fp/Znn6Kp4I2PqEpMDmd6jVlGJUXcNSxQLCRFS6LXq9osJ+2KCL70AUT+
	+aFiS/Hvx7E5vDP5/xjIy9Y9EoEasdl55PHoaMJTMqIqpRP/Vc18UBnFmGCqGGc5JUXSdB0Xx6E
	R5xOTkuqdC+Gsot3uoNj6HlEBdSBXEq2l/3Zu4IRiFzVnQ52r/usJ66YVXlmiwY/U68UwLxjqe0
	nRA2H3+cBiMWRe08q1G85xrnyltJ/DoZE1VZQpsjU+PrJWvtq49tplgYlBsOMM11h05+jLyZF+r
	rzMb2Tj/f9uHw==
X-Received: by 2002:a17:90b:4c4a:b0:398:bc52:825b with SMTP id 98e67ed59e1d1-39b2624c32amr28690908a91.21.1788756731628;
        Sun, 06 Sep 2026 21:52:11 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:11 -0700 (PDT)
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
Subject: [PATCH v2 3/7] powerpc: net: fix typo "upto" in comments
Date: Mon,  7 Sep 2026 10:21:31 +0530
Message-ID: <20260907045135.13317-4-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907045135.13317-1-hemanth.selam@gmail.com>
References: <20260907045135.13317-1-hemanth.selam@gmail.com>
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

Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D952737DABD
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756759; cv=none; b=MZvZOoImwXPnaC/43XrKVCnJnRZBmHLORu6L6x+qkendbHo2vsEwJBScuEjDp5eTdDEe7XhQWhsXUVn1jCn46Q9l60GJH5hc7fm7T46gUlMAQIwGl6rAJKgVJK/GcmXxYczWYB3/3HESgUh5K9HF2hkariomwksK2/jEBqivZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756759; c=relaxed/simple;
	bh=gzMW80CjGFwMFzpHisixnilwRNm+5xQBt6SorGvCuho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PrkTOQASUVwCUv3CXdDMDICjRJhhazRvZc7zEIuD8KS/qj+QJ34TVBsrWhBbmCsor4OxSnpBaLTlLuug8MXIOiyrTosS9AnwYAP2vNPvvROOXpoOVafEp8sDckv/It9cWD2Gs0MGvUAqrl+lkT0Sj3EcD7pLVJcCMbjN5cVkx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sdST4BeZ; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sdST4BeZ"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso3008616a12.1
        for <sparclinux@vger.kernel.org>; Sun, 06 Sep 2026 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756757; x=1789361557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fv/8WAsrrZD9Z6WoNFeiwDVhsb+FhzzkoAYrTP/tCf8=;
        b=sdST4BeZFCtcWiOr6aBdIvksM3gW6Ne/O5+asnsg+4QyJC8CHyWu4KMB4hHdlWhRQj
         EiZ05wDWBCibNWFR9Qk2l4e6l/Se9fILCGCzuQbRN/nasMWpajXBgErE2iyuKbN9eKoo
         Zt/4//V0haMkAh5B0laGV32l/8StRIWp5bJjcUhLm26UYHKfrsUMWq445A2U7l1qxA3m
         HxNagJ+qOh8pYjYz9KmjwcfYGO2CdC3Gi8LCGiHgKfrsW584ZBoOW5fIWTUrR/UF5W1C
         NGKfwIuOYo+6j4aw5pP8xxdTYYB5S2BZuV6pc+XHBEX3GHyfQqXpiIYcNr7NNY3DJ1/Z
         8obw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756757; x=1789361557;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fv/8WAsrrZD9Z6WoNFeiwDVhsb+FhzzkoAYrTP/tCf8=;
        b=SlGt8s/UB/nlSjMnZgi0ftiCwsRo/G1tYwkdtYSGpvfAoq40m9xHL19fxLbbv70s7D
         EmIPrN5+XTEiSiHPYCyJJaNGlR/H6k9dOOWKpZK8OjjJX+rjKIlPl5toTmOw14F0vojQ
         wBq3g6H0m+8tKaXncuDT/BWmw2uOKVrMJaU521ThY+7KNTFpOp+ZWYKiOvQZQ+MoaxPW
         sdh14g3EQPFhecpZQyQ955KiQD0yeSx6UbEDckCrRrhIiE+IzfLC1vOr2iD/m1/Fh1MN
         UgTScBG1BvC6U5fAoGOYuNL6r+MZOMK1I8RukyemP8oL0dGVRGAKDRJ1QzJSP7fl4WGW
         vMjw==
X-Forwarded-Encrypted: i=1; AKwUvBwcztp/AgOEMm+l+Pnpafs+scPwDzuT6SGJMYfriaZla3+Xbe9IKU/juN2sD5UdeU3kv2DvJyYNLlAz@vger.kernel.org
X-Gm-Message-State: AFuF++kKh2KK6eiHgrNX+ybK6V9JuTTMwzE3fD28hcBjoTyR1P8+t4YL
	mcXNvKUwH/r/BBSAEX3vrmTD41EG3JdMkbERHyxyqTkPiAfzx40P4McS
X-Gm-Gg: AYBFou1MG0kb/jhH3WlA5zxI6R5II35jzUg1s5OXnOFXKjd4rT49K/La0mubCd+nlSe
	t4Yuo7D40JHyxGFKfVLDGtSNiO+AW+PzHbKCrQcGRMCfjai8IHwaHRH6DsJIvZMbxE0B4vavubh
	XK8aK0Wdmp+324j4tg5woMsgT7OghQhTz8jLwwRyT2N9vukq8YXN6XOolvsFkI6/yP+bsTsEs1T
	gso4SodUIADmWbIK13sK9EjTDDYchg5wsJ8xugTYpKiBXdmoSmcB44/weoA68pfmLx2hUPs63ee
	V+fShLb+R+6k/1Eyo2g1aZPyKI5Vmt3nlfcTiEIIr6yUkdB3/Z9o33N+3BcGgPTtU0ulqXp1Hc1
	s2VgsJs13EI/6rryBT28zN534tDnD7nOJjtLyHFSWySLnpbSbeedWhb0kN4Zh9HJkIb68/0aBAw
	FL1MKccsYFL7VSFQ5agCJX0dr4xDpuzxdd8E1eOK1alt7nJ6F9geRBQxxmleGUM/zHFHQy3bFG6
	tK5V53t8nlkyw==
X-Received: by 2002:a05:6a20:72a6:b0:3d1:e510:905f with SMTP id adf61e73a8af0-3da39b3a6b3mr28486268637.1.1788756757103;
        Sun, 06 Sep 2026 21:52:37 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:36 -0700 (PDT)
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
Subject: [PATCH v2 6/7] libbpf: Fix typos in comments
Date: Mon,  7 Sep 2026 10:21:34 +0530
Message-ID: <20260907045135.13317-7-hemanth.selam@gmail.com>
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

The subject changed since v1, from "tools/lib: fix typos in comments":
both files are under tools/lib/bpf/, where the prevailing form is
"libbpf: Fix ...".

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/lib/bpf/btf.c  | 4 ++--
 tools/lib/bpf/usdt.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index 8417de92d028..c1745bee37c0 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -3843,7 +3843,7 @@ static int btf_dedup_remap_types(struct btf_dedup *d);
  * types, in general, can form graphs containing cycles, not just DAGs.
  *
  * While algorithm does deduplication, it also merges and resolves type
- * information (unless disabled throught `struct btf_opts`), whenever possible.
+ * information (unless disabled through `struct btf_opts`), whenever possible.
  * E.g., in the example above with two compilation units having partial type
  * information for structs `A` and `B`, the output of algorithm will emit
  * a single copy of each BTF type that describes structs `A`, `B`, and `S`
@@ -5644,7 +5644,7 @@ static int btf_dedup_resolve_fwds(struct btf_dedup *d)
  *
  * After we established for each type its corresponding canonical representative
  * type, we now can eliminate types that are not canonical and leave only
- * canonical ones layed out sequentially in memory by copying them over
+ * canonical ones laid out sequentially in memory by copying them over
  * duplicates. During compaction btf_dedup->hypot_map array is reused to store
  * a map from original type ID to a new compacted type ID, which will be used
  * during next phase to "fix up" type IDs, referenced from struct/union and
diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
index 2e56e3ab5b6c..c0933580930b 100644
--- a/tools/lib/bpf/usdt.c
+++ b/tools/lib/bpf/usdt.c
@@ -144,7 +144,7 @@
  * about. This state has to be maintained per-BPF object and coordinate
  * between different USDT attachments within the same BPF object.
  *
- * Spec ID is the key in spec BPF map, value is the actual USDT spec layed out
+ * Spec ID is the key in spec BPF map, value is the actual USDT spec laid out
  * as struct usdt_spec. Each invocation of BPF program at runtime needs to
  * know its associated spec ID. It gets it either through BPF cookie, which
  * libbpf sets to spec ID during attach time, or, if kernel is too old to

Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A836F433
	for <sparclinux@vger.kernel.org>; Tue,  8 Sep 2026 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846556; cv=none; b=iICOgX0+Irls/nxfBCuggL92j/qcA69n/hi6SPIPZ71mUgcMgto32+UTbuY3tgfsTiOioQg4PJtTZuYnPpw/3LDZzh/7WOocc848Nu4nWmEwWljfXApVQ/TsWAuoj/kGAqtsuGYk2Rv30JNfTLZhH03xvlCkeBQO9/QbL+5nTx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846556; c=relaxed/simple;
	bh=pXIKNBJZ7VpWZJHYVm5d/JqZ2uDmSW/zMvrAvNFtAkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRVRdRiuhOjvMU+CMaDc+gG17vBKnCFVy6LUZ5iwg9su62Fct+JqcBdEQZqcdf8z4sTADWliVjbtZOPjnCgHYEGYgcQTBwpR+CZPl15q0lOGIOfuZLmCo8KN+vEAz64rYZ7bV9XZjGOH/PV2mn5T+/zZfSpH7tB2ANZqgwKxIEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfsNLBwL; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfsNLBwL"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc439aa0078so3419330a12.0
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 22:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846553; x=1789451353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=bfsNLBwLJFE5kmZRE18vQqHhCpNRYpM+jKE+pWk7zjxnY/OGP3v7I74RFK/SmvhqII
         FlJPppMcwj52rIOBWptl5TpJEkecDmaXlKoajwHQ+xRAu+SDJr8f/kocqeyorT9BPZz+
         wsgCAw6FPcCfpK82VJtJP/4qmhE+OfkawNWt6mFWHjUZI/QqxCKhAEN5BjK7FViRDoyC
         1EbAXDAmgm1mGZKEEJITj9XdWH0oOKXr0NO6+i2U0hOI24xDnEIWdGg0GB5UBcCQ9p25
         DzEfHUy4kVUliuelE3TKG2dMLMMNtMjv91AsT3H+xviVKGmrMuiIaAYO0NtauecARKH2
         ZErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846553; x=1789451353;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjnURsU06dXJhEmQk8UgpVeNwhEKlwAdFOshlqNlRoY=;
        b=GCTMbLsrUAthh4Hr8zcuQ67ozON2ewzWzNqqEYll6wurReSHRUpvULzYbCPifcf+xu
         6nIutftm3P9kFCvwxEoofaNe9TJ+DyTlwNKtMma3+JKLfxGRqogq3K6xFvKnKdjxdEgx
         Ww8BmCqtzWqH+bp9IBUi7HNHGNueb0dT0mFviVemCdmjd8n+Y486DlX0v4ivKiWbZz2u
         UyZyCaDt9VLhgubon9BYPM4QFj2rA2dfbir2OwErlVPKCHyBVqzZ2DWgxb2G2IHgEZF5
         vEwZUH86pCe2sgNBTGvTXVsl8fCmdTEN+7H5vxaNiBQrWPORvqiuZzIZrY3LOCFZivw0
         QW+Q==
X-Forwarded-Encrypted: i=1; AKwUvBxapn74IMxzHrSAM1imn8CC8eRdvlx8pfK5GtQuOXfJud58ycM7vsunZWDNG7PEeUZCSFdn/72fwRsK@vger.kernel.org
X-Gm-Message-State: AFuF++lPU4/jt7wv6IdTi3cGluj/P8NTKP02lGG4smsKf+UcfqXngAtd
	P29ckzttBm0RgbIjOLTSFP3T44GxOQa/pjmkt0jxncv7zK6HJObf/lu9
X-Gm-Gg: AYBFou1yA4fHP/mMuVGadkTPGJxjWPvuYqY7r0hh3Tv0PYnuRKMFjlYkKqsX+tuBMSU
	MIoL/fkJJnpjOSpcZLf81OV61NitEVdp2lHj4sbO1TTjovLiIhDJduhVAcUpW6w4O+QjmU7V7/U
	BJqVHbc5XTMIE7C39PJU13R75vYzRwcSkyCHan+xiWKVzCrbsVlL6Cxc3k7s3sNKal14wCN7LHz
	mFm0OkSR7zFIhWLF17ULbv0lTum7lpWdwdv5LGrOeNck/FQOGdPvggwejagwznGjWzqHUWcQVMJ
	5GiS/ydo66lI/VpHgqc5z0dOaLyYNq6G4wO2YctTXuVjvWpZOwsGojFdNXqBtOiPeJ67Xs88Yru
	x8wDlnJYatiL9vC9jDU3ZaoWqocEFiX51xGFM0RE9XJ+0hviVDV1bqDIN5HdI8VahCUwdngQbWJ
	TavB603BfJLGltzZsyLoOyTZoeTal8dVo9vZDA/hPdFozYH47llMrAiV1986vuKU7LQgmrxXVG3
	skTwSI95kcjMw==
X-Received: by 2002:a05:6a21:38c:b0:3d3:ae1f:d7f8 with SMTP id adf61e73a8af0-3da3a0cc91cmr42894753637.24.1788846553447;
        Mon, 07 Sep 2026 22:49:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:13 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 1/7] ARM: net: fix typo "arithmatic" in comment
Date: Tue,  8 Sep 2026 11:18:47 +0530
Message-ID: <20260908054853.13820-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "arithmatic" to "Arithmetic", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..b1c21c014c9c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1346,7 +1346,7 @@ static inline void emit_ldsx_r(const s8 dst[], const s8 src,
 	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
-/* Arithmatic Operation */
+/* Arithmetic Operation */
 static inline void emit_ar_r(const u8 rd, const u8 rt, const u8 rm,
 			     const u8 rn, struct jit_ctx *ctx, u8 op,
 			     bool is_jmp64) {
-- 
2.48.1


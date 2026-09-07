Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D663793D3
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756750; cv=none; b=nBj8FR2dTuiNR67NMmkBHN1SgzW/4TZEPojtelWMOpUqOwJgpTeFb28g4O7yysHOSjXXurBNNHRXb0DYR9Aui8nebBU8dvDx99/rb87cOAUUJyZT3Y2Lc/9nyxSVPFwkWXi7vA4RHk9nPw5UpsIOkMRLsRA7zUnR99ohQ6HMEYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756750; c=relaxed/simple;
	bh=geshVPPC/sFWfefds6yEfFfn1FmETpgHyUfVVTDRiS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ItpfnSfD29/Sm33sobCAzFdQvfys+plOBeDihFasiTE5elr9FRSknFXJrw1YLJzTSvQYfUuCrvn1EZzhwNksq0wdz78PRmI8mILQiHH1szNW55SQeQKhvke8VcXC3A5HMT8hDuepLtnWLpXtoxztt5WsRWQnwwXSAjiZwitopF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rvOfb/s9; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvOfb/s9"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso2317329a12.1
        for <sparclinux@vger.kernel.org>; Sun, 06 Sep 2026 21:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756749; x=1789361549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vm/cehq7ZbHazeTz6lyclFSjgW2pMvi5dQ4X+rlCVtE=;
        b=rvOfb/s9Vdc251YWBJQCImIBUK5EVF+NEtByLkNZ+RU6aGQ/ls4rr5OexxTcPzx7Ly
         s8pYx5Enu32yf17Qjck5Hz/OCGoiN7SC0WAcz4YGp7i0ma4UU+Da9YMi4ZwXGSi+oldg
         StQCNPcTQ/KWCNHBLMlAeCuYcCeHFMdsI3xBcntUWhnk3wBfREC9EyrqPM6gZDntf2MS
         43WKrVC7QGYKAt4YwVuUjLP4K1qvd0zOGYr+i/kxJwIEzFQqBMOZ7G91dum51kYp97rP
         1ZazDT/WlFAy9HgqnNRkpt3L01mFET7YA7fiYdGXAjiaQj8SGofujSRdB9gPStHJLrM4
         UH2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756749; x=1789361549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vm/cehq7ZbHazeTz6lyclFSjgW2pMvi5dQ4X+rlCVtE=;
        b=m2lDKrHg/IhbeYjd1wBvSppSaw65jDj9y/KY5esaMpiDcx2ANnNY5BMT/w/gU0UC91
         RI+eNt5kNhJCBR4eEMPRHtO0t9x1l4wb7/u2lNhREKfZ+QXIuomI8BtMxBCs9ch4g122
         gUhWMWsv3RvHjwR5Gc3Baa4jheVEKjFI0YNtw8ZDjL/U5BFcVMAeXZuS7RTfyg02tMRk
         hwWaxtudUXlE9Tadki+G3z/GqarahAhmIeXvhJUs2gvGKCQF6WUccVHlfRUZlF7E6OGR
         Kgf+ntelKdmcSd0l386M1/62e/F3S7u3cfPbBXMmnC6+90I4Q8qJnWYtrPiCM7Qek6ZC
         tnsw==
X-Forwarded-Encrypted: i=1; AKwUvBy55mKoD5HWxCzw6xXj7CtFmZR3gbbH6mFztOc6iA5JUmYoKp/OCCHQuKRtVdbeWUdnitqxaROH4wNZ@vger.kernel.org
X-Gm-Message-State: AFuF++mQgNTtYhFU7qbvNd0r5UwVaK4g/Hry9IpTn33LIr9PspsZMUWH
	DTWXYdda0MzP48VWJ1g3sKiuQGoy7Wfze6eK9weQ1jil9kxARwUPcC7c
X-Gm-Gg: AYBFou098naxQyeUshFOovuNHYXbQzuo3DNgsi8/hNqoynY6WSI+T3EJnqZn2SNDYWh
	95NATjrWKdkxXBY0h3ZA0KjPr4nXrY6O+UYWwp5KnpzyIr7O0puRjeQaLXEuTtgV2bYDJ2site2
	+/dnhMQ6VTr1vPGL1GS6adROkgJFiXef5p6H1r3DsAZ6q0JkM7gjs4u1HQIMp+/Ml4YWogWWo+h
	lSdQF/ILFmz3Yvn5rchldbiBA9YsUMKV1ilPRVZt9ARLnk1PkNmOayweh5Ysq37kd5P1U1kb6zx
	twzjyaDMGfENjryWrZraWFDYDJJdrAxJogwjSsxormyYX7XaFFnj09JPAnqQcq9f9r9ybVzFr3F
	8zpP5ZLMun4MD0I+kmjl7widKYwG3gJaKFbjRClv9ErSc67Qrm9HULEiLXfbykLumyvQljVcRNT
	GP61Y5Qq5wY6w3s0LUL4WWTNqR9ZZjYvtHUlcA0VH9mFpw6ca2Xr2EbwtVtUQsTUAE4KqRORoWJ
	4ouCjJ6jb6Low==
X-Received: by 2002:a17:90b:4c4e:b0:399:1b64:e0d7 with SMTP id 98e67ed59e1d1-39b262aaf32mr32153720a91.19.1788756748582;
        Sun, 06 Sep 2026 21:52:28 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:28 -0700 (PDT)
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
Subject: [PATCH v2 5/7] sparc: net: fix typo "evalute" in comment
Date: Mon,  7 Sep 2026 10:21:33 +0530
Message-ID: <20260907045135.13317-6-hemanth.selam@gmail.com>
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

Correct "evalute" to "evaluate", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/sparc/net/bpf_jit_asm_32.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/net/bpf_jit_asm_32.S b/arch/sparc/net/bpf_jit_asm_32.S
index a2e28e0464a3..81430f065ac9 100644
--- a/arch/sparc/net/bpf_jit_asm_32.S
+++ b/arch/sparc/net/bpf_jit_asm_32.S
@@ -195,7 +195,7 @@ bpf_error:
 	/* Make the JIT program return zero.  The JIT epilogue
 	 * stores away the original %o7 into r_saved_O7.  The
 	 * normal leaf function return is to use "retl" which
-	 * would evalute to "jmpl %o7 + 8, %g0" but we want to
+	 * would evaluate to "jmpl %o7 + 8, %g0" but we want to
 	 * use the saved value thus the sequence you see here.
 	 */
 	jmpl	r_saved_O7 + 8, %g0

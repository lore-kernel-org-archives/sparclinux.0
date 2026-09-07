Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D50485CEA
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 12:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782501; cv=none; b=YDUIFHA+mu+e9EKGVBGCSbMUoA1XLuRRXhaGGkvGmlomTpc0H7beCGLUYM650sAb8JoiDsnW84ihjQuUHl9tnb+KrsWhytazJep7666H3UhaQHhFLf5/ctzBoLEKSN7qsQPOu7kan5y/4hBFeBByvlhR3QWYBCX91YXmzfUO5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782501; c=relaxed/simple;
	bh=UErhiAlzr8WjMoBRENwt/AEHPbueyU1pd5tdq23Ux3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKh57PeepYBQj+Ij1XUl1wzZYolW21LGmd1VE+gpPyFLPykI3q+POJBp2/eLuY7GBGiHwFnoYRt9rfjQpLq2rMk2uVdF1EK7ON0x/Miv8hBlDO4y4YiZj8XYnearo2au21n/OcpUJtyYrUro/GF2LqQgFjYaoScSVaFkHgXtUuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKLw3sWI; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKLw3sWI"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6b1c75f0049so2630970eaf.3
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 05:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782499; x=1789387299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=MKLw3sWItGMWoBAJDSwPgLxNFsv4bLhi9OtS/fVxpEzCSQyNSELMl8Fa1ZaETi0Ttp
         BZeRdVqlc9u9NzQPAK3QebtH7TuDpb2eG3alIPFZE8HvRzDGb7GFu2IJJbBPjQ8iq4h2
         zxhmYjip+cmDvgUWDOv1BDb/oD4pb6KCe7fZFAKb6amOmcWm5dlLKqFwRYURIiiu2mpO
         luN4hzCYHHDO91zmaRpsh+X3JSIbHcRfTHfsNj0/bpk/wE1b5C1pQbnY1RgV/uuHSc35
         QS+FnoqEwAX7aVZq5jWBxQ6w+sesuRcV3TW/lXCEnQkMeGZ0xSdRhw9F8TWQHhWXWnhE
         CgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782499; x=1789387299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=QAZzc2xxnzDZLTD2EjDvQx4GTiSC0xISVtol3SxhjDMw9TxgK8is02T6utpNPa6NvN
         ntSYjofXqlKwYZzzxgGT1mAeebRc01ih5NGO5mH9QazLf/DYKwwfXS7gXwj9X1krfnZS
         6xTKIsIRPIt57TSiM+9t83r1ZPJYwWy0neqrkjTgLMRPZYPFOdoJlROkUIjlqw9V5xD2
         GWywGuXdqP+RlhafWKbbAeoEB/P6yztQLx5uhXeu55xTdJPa6YdxtQV6PFLFEPMHSqkH
         RGgQfuHjsXzlNmmE0RTT4qOI8vRzZ4I+jqRbX9N4ZpjuYym6CHOeEFGfHgSqP0nZGh8J
         yGUQ==
X-Forwarded-Encrypted: i=1; AKwUvBwy/yZdS6U72B9SjwsW4dZYRXCcxX6LMcNF7AyofdO3rsQBth0S0kUa6nrw53/06ThL4T+nrMYaC8X8@vger.kernel.org
X-Gm-Message-State: AFuF++kBVWAzYs0le4aAu6iApC1Jm7BgUnrQTdx/4KqzOV2l4kREGR4E
	N2gFg42BXKrIzXd93U391M+/Br1weEOH7h99kJSyO4P99JqqFHe6nicy
X-Gm-Gg: AYBFou1qxikiUYZvyionMj9Q5dDvX1i0cZoQLVFHaoTxBpSvFgIgCYdtusbUJyFNRsT
	d3oADky6pxh5eb7z4hpm5RL6t6PZ39osYQjNr0vZkTqsmaGQPqmUXzSf6aAcjv8/TqQ+bA6hJRF
	XFW2Qu+uDAdkfyyAKgVV1sBjmHWove/Xdzgs0cjiWZNWvRcnfjrOMr4BPNSS89hMHPQXJgnWT/K
	GERqaapcPltMMP3OUvPoVli9oYFZxTnS49YlZ43T2HgQxBWPKyEoczWCzrhmWbMCRHNQyQupQt+
	Prbg2Lkr+8Ox5WOC7SdKugJq65PrSAMHUM2LBlgZKPyLzusi5IegOFkzgsCIy8bQnY5pJAEBIN7
	99Qgbw53g3SlHZi6HYTo49JqTmZNjqTktiuxAeZ/ebVMozukwozdh6KKJ1aDpejEnSmQ01h4e5y
	9DVnzliQEijivUm8lbUlzxgp2v1bAEjtuf22zUIZ9dK1mfIxzNX9HPPibKszvAZc+t2cNSZAQy8
	YqRgEbJ2FBXvg==
X-Received: by 2002:a05:6820:c91:b0:6b1:535a:eb8 with SMTP id 006d021491bc7-6b6fa8e02aamr12552198eaf.2.1788782498996;
        Mon, 07 Sep 2026 05:01:38 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:38 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 5/7] sparc: net: fix typo "evalute" in comment
Date: Mon,  7 Sep 2026 17:30:41 +0530
Message-ID: <20260907120043.36894-6-hemanth.selam@gmail.com>
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
-- 
2.48.1


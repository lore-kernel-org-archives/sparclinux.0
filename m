Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB24A64CB
	for <sparclinux@vger.kernel.org>; Fri,  4 Sep 2026 10:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519503; cv=none; b=ILxqkY0YQxjsCXidAlLtOm0bOTm5XDGlaToclJR+lAaW18EkW/jzl/nYHttrt4AiSOes8tUU1T2n6NuyZQc8b+0+YC7AwUZsQQzkV4fy+KtxOGJCUK7gbbPoVPtfPfYriStvIAl9P34msN5QowBzK5vg4NT87LGVTN6eyfrWReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519503; c=relaxed/simple;
	bh=UErhiAlzr8WjMoBRENwt/AEHPbueyU1pd5tdq23Ux3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kf12S5OssxkX44eM+WMPWaNrBPKwUmJVdmroU3mQRVV3Kz9RiRe4YYSep5s00LihqBu8raNGJjA/fF6Zd6pGJ/Dqt3uzm9rHI/phUJrcV3EwllxsBU5sZ039n4Vr5vOeDkEFGNczGWAxCKNEjMIYfxt3u55JrhBLBjHUfJsPgeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cFIB7euh; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFIB7euh"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2d6e954afbdso5654165ad.2
        for <sparclinux@vger.kernel.org>; Fri, 04 Sep 2026 03:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788519498; x=1789124298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=cFIB7euhW/DhRND+ISPXgptzdey+XjnRWiEP6Cm7kIE9Hrpfez9VwAvWG8xanG7BjY
         cGNCFO4UgsfEueOALXL+tlA7r3z5i5bJ+LRxDmeKql2VNWtbDrC1w1Itl5/Wp9Ye1Dk5
         NQy3cTMVZ4Q4G2btulOSvL5ro52JSBOjW6tAHM70XO9Sj5yUidh/V9VfEtihIYXuQFJQ
         VF23nJsM1j6Q6WH2ELTHZgdDNOD3sa4L+D/CDDqQZ+hVfNc+HeoVFqYwaJ8wB/qDcK+F
         HJ6x2rs1h+U2elj0ULb1tycJ1NxbkvgTm3QZwWYMr2Hwv1LisWwhbsUth/Oey555LaiZ
         OV0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519498; x=1789124298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/3KV6RuBnnb3kSlImB7scYqnTaYm6MjcG3VOHCy4kfM=;
        b=tEIeykuc9E+GmKRMi5nx/mJQCahjdD5Bv/x6UCHKUonBSp6lQc1rlNFiZhY6pqpEoB
         G2vgysvDhMMBlh/y06H9NHg1gcGJGoyYtL/rAmkCA8CV449ZroovQuG+NthSWvDBtvd6
         cxzFrOErtGREFjPpp0ubxcGy2O+CaOX/5qtErjQkCOC9mMlewmtFy4RHEbLDo44bvLxS
         vzl6oSMopjRF7gU6xdl1obY4vYzlcesJZ5GR1RG/cd/mCLQtMXqYClyyVWpjFuAvCWkY
         JITefU9u/SRxVo+XDnEf+8z0rgT+gyMEZeJQh7dCmbauUsOWNbF8LBOgBzoG/CFDoctQ
         dQ5w==
X-Forwarded-Encrypted: i=1; AKwUvBymKJ91uAv+8W0eIpllj8b6aDCYm+k0xDXhBAqDihAF4KvkZYG6zPa9xbgtPiMjGX2yIFfmD0+oo/eV@vger.kernel.org
X-Gm-Message-State: AFuF++mZFj+HhB2WyT4ZA4IA2Ds5DYKOhOjp/x3icKcBGZbsCn9mu59P
	jkhBYcCbN/iFCrz91HlqRLAcDHHHnllgkMsLVt5rRFPvkJv+uud04rEc
X-Gm-Gg: AYBFou3lshkjS+QVpIO9eht9PaK4W1wwYsDCvI4Oy4k9Pl3k5VIEaAH0g56Ufllv9PA
	kI3rvIovGMjOGASHctc1Ie6WlOVHNzxsUXa0TTH4yFo/K+S8wHo8Bb4P5qSfH3rzlbM7Lq/o8Es
	tdpv4ZuR6P30TmZMHlkMqcbEpduaJk19MHNnLDbauMdTclktgqbw89KJUgXggxJGdEwaYtoKDde
	HA3Ml3ElQGag8aDXPH3xTZ/S93ahCqKQ2fUyYeD5haU2/c9XyRykSX2PkXeGwRPVjPM4eUZ/oVt
	fUY7xlX7XxZO1Hahiz/OoCjKvc8CQRXLdF7J0THaix0yH4poUv8jjhu6WIzg1tTcetClPxYS6q6
	s0FynSJrYTnZKjYXtz6fF4S278+RUW7RGj5nNsvwzkFv5f8X9kggltlS+IK3lP+NB+XabtadIpy
	bqJ6DosrKDWPFxl6tAP7vd21Gufl/HHC6DfbIhOr7afXCf6vM8/+jLmrD0l+SduFHXbfiEzz1Ug
	GL7jaSbxCjwuB2gTJzaXoqlrQ==
X-Received: by 2002:a17:903:37c8:b0:2d9:50:a91b with SMTP id d9443c01a7336-2db12667eeemr81520455ad.16.1788519498125;
        Fri, 04 Sep 2026 03:58:18 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5523091eec.18.2026.09.04.03.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:58:17 -0700 (PDT)
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
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH 5/7] sparc: net: fix typo "evalute" in comment
Date: Fri,  4 Sep 2026 16:27:35 +0530
Message-ID: <20260904105743.39799-6-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260904105743.39799-1-hemanth.selam@gmail.com>
References: <20260904105743.39799-1-hemanth.selam@gmail.com>
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


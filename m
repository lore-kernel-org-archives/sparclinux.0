Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C3B48A8C2
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 12:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782518; cv=none; b=FQ6zwSDpe2ly8dhhVlOT68U6KHmhJSDEd326/bh9yrKUTBrXK1yMN+s25mHfdZkDscNKS0HXgsOTZH44lBxQydQgu3PxylgNrJ3Mm+iYduOMdPeyeCg0HiNZrGpGaB1trDSz9WPf3CPo+YHvjYPyezrwcMUr0QlUy088Fpt+9oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782518; c=relaxed/simple;
	bh=kuRqLYU/bVAolAtuT0lNsNPBb3H44v+1z9+WGNYvrCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kw4OCSJKxktmdnGkCSE9mDN9YUepq4Uc8wXs/6BuwyMFz6hzJjBypsws6qWtTvP9Dg98dr5j/Odb6O2PpuAf0H/uTTQ25Q9+MGWawUDqOVjELigjkW2HYgPjpEScdhJ/SoSDBXsqZweOxzS8IiX0veRLpt+qQCGTYHWKTt57xTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llQq4rCN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llQq4rCN"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2db59f54ccfso4921405ad.2
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 05:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782516; x=1789387316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=llQq4rCNDIie0aaplpZeITjsw35VfD5OpFuAUrvDpjn+9fQNpLR8BLGukiX0GUqtpX
         W5NgF6LTOVNHb2hcAwLOtRsN3/CDPjMxRlVPacxMFhyL24GquF4EHoE0BoL2dac164/y
         UCjnF7EJptkI1as7n2b4vE5tfvc7LM16CptR9FbRcfElRWMANipKFCod6kA6J/+X1X4O
         jxYp7syG4fxmIXhyyJpZoA52dQQxuQZ0Lsy8mIf2JgVf8Qmi1eKlwDif4XdixQ1GjjWs
         /H9vB6agHHoFHXfjQBeLccQtOLlirEta9/fD9zceKkatvAeMl3F7fI8Sy039AkqXUpcr
         wAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782516; x=1789387316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iSdhcylG8upaYgz/wmJd+JoSvai0ylGkPowyAHHfN0o=;
        b=sKAo9COpMUcxWAf1aEBKFhiipTZg5u62TCDv4VJtGahgpFMnQaJFaj3xCTp8s0qt8d
         o99aAeb7VpPcEuWRPvSmaqvWseu17A2FmnhRatl1sJwLgy97WWaQNLHiPwSUnaR8YEu0
         vrPBQJ+/56nRLVMk1uCPWXsMQ9ciyrLugPJcYdwa0MaBPS+I726bSz3nMiLMLAgNxIK8
         VGTSP5M3PbJxKF37Zr5fTE1Y1uvstrMvCTx36pfPCRpMKQJbcm+hW5Bo9Cn1Ek30A6Ka
         WCNGQyRj2N1enHQixqnTPTYn9K8n5VAYzUYmmw3xQ5vfg+5YAIPuJsgpojZP7YhQas3l
         urDQ==
X-Forwarded-Encrypted: i=1; AKwUvBx1Kb4KvqJUx10M0GFAUZal9JGQG8svpPtj5Y5cpZsW0Shd1FC17/Z8NLJovdfTVCeR2RU/4ranZ/LQ@vger.kernel.org
X-Gm-Message-State: AFuF++lQTwoWim3+nXSw8/8V6cFDovdirmclnKjbMCvq6r1Qm0B9PHON
	YJDZCXdB0HM/DXK7bNAwXhhnXS/QmAx5Zy546HcNFmWJ4Qk5ymerAoUs
X-Gm-Gg: AYBFou03kaM4vfYYs20Vsf30cELRoBT+NO7vmghC4l8OCPzqqigtTV4mdSpte3DuSnm
	OcrnLVwIoFPBwSV5sSbGzxpNkqgoGF1LDwJ8sBhDVDuauDs+d0ASIFRnNAH/DArBKW0nsfLv/Af
	19idxJkU9u60S7l5I3n/kjs6v5wMyg29DxO7M+DJZshyyKAEQW3VJsAoKPtJussTmhCzxCLNdoz
	NaysbMH4M4CMKnz1tvm+p82XK4ySORg0RyI4lmsLWuwD65gh2GU5K3NYw4W2/BKt9YT5n7pSAPS
	+bCoCxkcjVQHnxmkQfL+uu2RW/U0BlwekDuQbrXdRhq1nyd4glmNwjUoWnbtgY+VgZfNfiCjF3y
	HKFkuvbPJmY97TvjClUnYfJJu9z1IrjCEeBIx/YXiSKKWkBc+SXJ8WByckSLoMah3OJQnax/ZoI
	EnF+S1lpnDLhvMMwGV3+EhZgJ/7C/hm9G4ab4N6dNocW3UM5ovVNzE+r8pQJ4MY5XE+r9IFsupN
	HzKRbx1uj6vTw==
X-Received: by 2002:a17:903:3810:b0:2d6:3c22:99bf with SMTP id d9443c01a7336-2db124afcefmr348302995ad.9.1788782516134;
        Mon, 07 Sep 2026 05:01:56 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 7/7] selftests/bpf: fix repeated words in comments
Date: Mon,  7 Sep 2026 17:30:43 +0530
Message-ID: <20260907120043.36894-8-hemanth.selam@gmail.com>
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

Drop repeated words in comments, reported by scripts/checkpatch.pl.  Only
touches comments, no code changes.

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/libarena/src/asan.bpf.c | 2 +-
 tools/testing/selftests/bpf/progs/iters.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
index de656b69d13a..fb50ee4ad097 100644
--- a/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
+++ b/tools/testing/selftests/bpf/libarena/src/asan.bpf.c
@@ -204,7 +204,7 @@ static __always_inline bool check_asan_args(s8 __arena *addr, size_t size,
 		goto confirmed_valid;
 
 	/*
-	 * Wraparound is possible for values close to the the edge of the
+	 * Wraparound is possible for values close to the edge of the
 	 * 4GiB boundary of the arena (last valid address is 1UL << 32 - 1).
 	 *
 	 *
diff --git a/tools/testing/selftests/bpf/progs/iters.c b/tools/testing/selftests/bpf/progs/iters.c
index c6699159dacd..e44a979270ea 100644
--- a/tools/testing/selftests/bpf/progs/iters.c
+++ b/tools/testing/selftests/bpf/progs/iters.c
@@ -1511,7 +1511,7 @@ __naked int checkpoint_states_deletion(void)
 	 * would get equal to one of the explored states and thus loop
 	 * exploration would be finished (at-least for a specific path).
 	 * Verifier evicts explored states with high miss to hit ratio
-	 * to to avoid comparing current state with too many explored
+	 * to avoid comparing current state with too many explored
 	 * states per instruction.
 	 * This test is designed to "stress test" eviction policy defined using formula:
 	 *
-- 
2.48.1


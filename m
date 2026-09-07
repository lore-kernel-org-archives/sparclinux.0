Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D501DB92C
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756725; cv=none; b=Xy8Y7nk1ZBhIJFeEzHZbweYWvaFnDOi3VQsQLypP+R2g/Cx3BBOlRC32oseQWPBTA/PxYEFEC9SlN86DqkzFIiTlUhGHDLpRN68JM7Yb+7i+MVMpFdTB7QMUqXVYAPpko9m4tUndUcFFMny+7PWe4ssUajKBG4Xz3ePTDUW8uQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756725; c=relaxed/simple;
	bh=o+i201PWKQhnh0LFP97eF7E1wnhN9oEPKnfB2knTOSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIdiVY+Pmh+p96toi6Gw+WRsxoGLUZY/E7VRUH1hjD5Fde2xihGfftMFVo31WeMv+5c+6XL7C8OIpyUd2XKzQyLScR3kBuETNxPV1lofajG++266tiCOljpiscLYMBY+U7sR4MiUPW3FdFSKdk/fxg7bv09C8kmLZdw2vtlqOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjYGNuHp; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjYGNuHp"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso2317046a12.1
        for <sparclinux@vger.kernel.org>; Sun, 06 Sep 2026 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756723; x=1789361523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
        b=fjYGNuHpkPlvyaOD9PVD685AcyPxbS9VVUIIzwb303/cC5yqyTCQFtk2m3//X0GeeL
         dFmSg4HMYoYSUSAJqCpYU9ed3rACAcEyLmY/E0BFfpnY0Ztlm2W09wvqsNNhbOs2ulrU
         vKewDyPuQDr9XuDGbCqfqhU6xG9MdVoVSOW/VzrVWCps4EqO19XiUYouRvAaC1Iza3Zv
         CGnTD4T9Q/eu68huaywUBrSwIhTwZr4zsqIb+4QIQt0DTJZFTJBWLwB0lPPa8p/iruaV
         H9pzNGI4jVt0XHyRs2U9Hl5eT/fL6KO7f9snYpkz33uHZBXqXSzmXpg+RHQ+hTP0mnwA
         wutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756723; x=1789361523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
        b=DearbpwU0vtqo3ufwC9WMhbm54l3ptp4Ytfx+GmKrMwfIPXxVgwyuse+3paqnB6W5K
         UlCk+4tbHquR34UFxLWB3Hj74IrVRrlpPav9okKgu+n1wSv/gV8foRtMyIBsaX3o6nPe
         hqa1I6cdyIr+8toqoV0HkSSaNUQ0R+0neu7c8g6aUwl6nySfRHm2Vt1dH3Yi6b9OAoVG
         LoitZXkvsGSlMaLLjiwHyvP1akpJoUjS6B6QVlPhIRYozMQay2jtVxDu+JlVA6nap3ql
         6iWbTWJzjAu+WDteoUaT+hu2fpRUelRG6QFIjvNp3j13c7paGai+LazURlDFGrdeXrIn
         Lw2w==
X-Forwarded-Encrypted: i=1; AKwUvBxLT+QcoH74f0ZEGZEQI6lKiH/o/MCS/UF0SiW132Oo9h1lyQSVdG0MYZNIAsAqyljcxpPDtNl+JZ+Q@vger.kernel.org
X-Gm-Message-State: AFuF++miZ9w2Fp1Koxdh1N2pWJbSl6CnQlqsCmeC7Ke5t0VGQ5FuXSBn
	niYBCs/6i6VuMbqtgJQYydGLTHNhCmjV2EmLROr6d2X+QE0YJuMpg9dc
X-Gm-Gg: AYBFou0qLRhJUCnUzr5rdKLB+CaY3vd7EcMBzjlzAZVKj2z5Viq8cIFNbJSUcvmIpr1
	2ybENVKWYmXWWvYGse4gISJiO5HHqEsyB+Nq5sXtSZctWKiejAtjkIh9j468Ndepu8uU8QXS2Bk
	CaaIBlIHpVjGKCMC3uOntOfQk8kIlp/D1LT577Hjijb34qx280db9RGSexWH8S6tsmHrqwDZOum
	N8b8scEtkcld8DZbnBwttYiv7aUJ+Z6OGnJzBhDMedIhvk1q9m5oL1JbJuUTgrJBSt/icFxS92q
	OaL9UqPBCz0g45Rddbt7/pq3PyjUaak6pSyZqkwaSNHUUrWRlAUWCLDiHLAP03vy8rAETArXVI7
	FKTPj5clnEk3YJT4JQj8JrdeT16lJlC/sP2lm79ksZw0bwR+dszT7svq5SXuqmDLrKDVAxNhc6I
	vV4sjjhLxPYeHLGKaDnuQF2MtdrCARLT2HPK88AyxMSA/ezxPfpLdAMCpK2KvMfzKI5U3Iq3xu5
	4yMye21NotcWw==
X-Received: by 2002:a17:90b:33c9:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39b26122fbamr28838386a91.1.1788756723030;
        Sun, 06 Sep 2026 21:52:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:02 -0700 (PDT)
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
Subject: [PATCH v2 2/7] bpf: fix typos in comments
Date: Mon,  7 Sep 2026 10:21:30 +0530
Message-ID: <20260907045135.13317-3-hemanth.selam@gmail.com>
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

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/filter.h       | 4 ++--
 kernel/bpf/reuseport_array.c | 2 +-
 kernel/bpf/stream.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4a9bc6a848f2..0a067c2e923d 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -147,7 +147,7 @@ struct ctl_table_header;
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
 
-/* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
+/* Endianness conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
 	((struct bpf_insn) {					\
@@ -1029,7 +1029,7 @@ static inline u8 *bpf_skb_cb(const struct sk_buff *skb)
 	 *
 	 * In some socket filter cases, the cb unfortunately needs to be
 	 * saved/restored so that protocol specific skb->cb[] data won't
-	 * be lost. In any case, due to unpriviledged eBPF programs
+	 * be lost. In any case, due to unprivileged eBPF programs
 	 * attached to sockets, we need to clear the bpf_skb_cb() area
 	 * to not leak previous contents to user space.
 	 */
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 49b8e5a0c6b4..4de08abfd94e 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -207,7 +207,7 @@ reuseport_array_update_check(const struct reuseport_array *array,
 		return -ENOTSUPP;
 
 	/*
-	 * sk must be hashed (i.e. listening in the TCP case or binded
+	 * sk must be hashed (i.e. listening in the TCP case or bound
 	 * in the UDP case) and
 	 * it must also be a SO_REUSEPORT sk (i.e. reuse cannot be NULL).
 	 *
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9469..54f5be1289d2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -24,7 +24,7 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 	/*
 	 * Length denotes the amount of data to be written as part of stream element,
 	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
-	 * accomodate, therefore deny allocations that won't fit into them.
+	 * accommodate, therefore deny allocations that won't fit into them.
 	 */
 	if (len < 0 || len > max_len)
 		return NULL;

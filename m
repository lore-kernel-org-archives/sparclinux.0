Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F644756C4
	for <sparclinux@vger.kernel.org>; Mon,  7 Sep 2026 12:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782493; cv=none; b=EAW0/GWZATUjgG0gR1u/zPpXncRI9hLJYmokp/MIVkLbAwVbDaKYKlm2sccyf90mSMDYYPL5lBm3OpqOt/5/88wqrnNm9T0e+fAe26q3TaiONGIvHhTWXYglqERhj3jvkh+uU2mRGm8gqqcT5jCf5O9QDoo6gAGdPbclOB358Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782493; c=relaxed/simple;
	bh=7dtk/PimTN1tTIbaXYo8FFQym9q4FLwW3xCtKGUgfWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rKmPTs+Xo/duIg7skyLdngEFcdqXLc+N18RTXhF80LLYAlnHtCtwM4PrXIX++2tM6/SChh6wD++umbebVyi2/pCcQXaAGSdyxbCs+SMNjnNPRIK5oYnXqRaVEYVyasEHlKBkd75mSjhKDDUavrLuJ53gfS9hO4yUKuLoostOT0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/PhiJ0P; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/PhiJ0P"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6b128dd0cb1so2162092eaf.3
        for <sparclinux@vger.kernel.org>; Mon, 07 Sep 2026 05:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782491; x=1789387291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
        b=p/PhiJ0PBYt2wgMwniYO4MT996Zl45VIDXDn2PYDpLtIS0xe+eQ4HNYg61LkkTVClY
         fyuTnd2T7K/pQ4DjXFI81gBBycruasppeTkiDOaiUds+bYZP6SI8Fm+oCo5yjllJ6iWG
         ampiRSsc/LSJnDU9VFFw/kGDsCk3xJ4wU3JHaWhrkGeY2PvYht/jyTfZcOENcPasttlD
         bnoX3m1itnamMgSXck43tJpAoIGCSCZM1fnUz96QmQJjwKp6E1iy+QE7yQdEwngTo4Qu
         PS4XQLHxQ8Y9AXvT7VEtvfs1tk/74riQxAnKmljJByowNb84fB7iRktv4gGhfY3grnQi
         gQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782491; x=1789387291;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rfDPZXNcg+Nl7/Ylu6hp6siIi0FsvzwquJx1kpnnIKw=;
        b=I5FMeF3JQFFZO9k80Prdeh+HKaBWKUZmDA+5N7HBy0hYN6VXVULZ+5RlljrhEH36i7
         hM675pWlEG+LVQrm3olULAyiEfRwHOZUPST3OVNStByziZ5+/SPa1YtCG0QiVqjGVDAb
         IfKFd4bTH1Lw5PyHpBfAiUdQ8WVmrmpIagYwmhugc6LOJA2dMngGRwmdC+8fLItlDQl0
         SKM6Az8BeKk/Q+GBDRhjwT32OpUjrQEAPLD6NqEh2AzO8SGM1MYKHPlH/LUoLrx9WYFS
         30vDmPXOaPJ8nDAcXduE67JjmH4BSfeKFcauhS85e/I6orLwjyVXPzX1+4+NczaLBVIJ
         B2aw==
X-Forwarded-Encrypted: i=1; AKwUvBykDLCQhySGmYo3HINwVENOsPKyYQpR0hE1tAbCqk6arO6yUNyjjkUuWIxZFAaOaIy9uEt4na6b6uO0@vger.kernel.org
X-Gm-Message-State: AFuF++lW+3HGQjBcB2rmjZXvEP8H2PETiBrA621+4Ojy5rznznnYI+TT
	4agVaQ7Sayc69Sst5WC2Y6fwP6hAFiXr0It+7juHJxBAH/0Z5niI8uG6
X-Gm-Gg: AYBFou2FRCdlum/gkFDvrgB+U8IKw9BAlrWGtD1AUaEd+s2trpZhoXPgYKWOnNoAXRS
	vVUHDwND6a+U/YH9cdnp1X68QxodWwgY+/ddrEN4FWIFlh1UeH6sZThRKAXd2+U4U/Mp8ZdQNX6
	oX8ECk1hvf5CexPDrGY4Vl7NuMe9Kk6D2nHAoM+R2a8y+i32fZCH2lyCSqYaQDrB/jewW99/PiV
	FGN1KGEGtk4mlUUa71xI/cgw7arbNHUP/bFK4oNlmf5i/1vLFoOp5yLT4lyEp0uvE5WnBLY2GBX
	2TygehylbcTDDX/OY0Fh0TwuuE7F3z/zkx2dId3YPd8kklXSf16u12HcrNhiyhEM//FUBwH/JKT
	gMvOJu+SmthxODkEdfv2veDXa7t6y+vmy0ja4DSqHWYBXodUHZ7WP/jWIoE9wdVyRY84EkUx1NU
	uPg6L6PKwfMzYWSHTEpQYHx8x0FyUrAqdDsHro3g61JiBCyJ0LyC0CQm3UMOzh8l4r1DAzDxGwK
	FpKfWGSyOzA+g==
X-Received: by 2002:a05:6820:6ae7:b0:6aa:d13c:a709 with SMTP id 006d021491bc7-6b6fe2aeaf0mr12073907eaf.31.1788782490438;
        Mon, 07 Sep 2026 05:01:30 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:30 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 4/7] selftests/bpf: fix typos in comments
Date: Mon,  7 Sep 2026 17:30:40 +0530
Message-ID: <20260907120043.36894-5-hemanth.selam@gmail.com>
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

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

The subject prefix changed since v1, from "selftests: bpf:" to
"selftests/bpf:", to match the rest of the history in this directory.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c       | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h     | 2 +-
 tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c | 2 +-
 tools/testing/selftests/bpf/progs/verifier_var_off.c         | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
index 1b25d5c5f8fb..8b96fb861368 100644
--- a/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
+++ b/tools/testing/selftests/bpf/prog_tests/lwt_seg6local.c
@@ -13,7 +13,7 @@
  * IPv6 header with a Segment Routing Header, with segments :
  *	fd00::1 -> fd00::2 -> fd00::3 -> fd00::4
  *
- * 3 fd00::/16 IPv6 addresses are binded to seg6local End.BPF actions :
+ * 3 fd00::/16 IPv6 addresses are bound to seg6local End.BPF actions :
  * - fd00::1 : add a TLV, change the flags and apply a End.X action to fc42::1
  * - fd00::2 : remove the TLV, change the flags, add a tag
  * - fd00::3 : apply an End.T action to fd00::4, through routing table 117
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 8ae4fb2027f7..9f2971fc7cd5 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -243,7 +243,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		}
 
 		/*
-		 * TLD_DEFINE_KEY() is given memory upto a page while at most
+		 * TLD_DEFINE_KEY() is given memory up to a page while at most
 		 * TLD_DYN_DATA_SIZE is allocated for tld_create_key()
 		 */
 		if (dyn_data) {
diff --git a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
index 624078abf3de..d7e30ee576c9 100644
--- a/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
+++ b/tools/testing/selftests/bpf/progs/freplace_unreliable_prog.c
@@ -7,7 +7,7 @@
 
 SEC("freplace/btf_unreliable_kprobe")
 /* context type is what BPF verifier expects for kprobe context, but target
- * program has `stuct whatever *ctx` argument, so freplace operation will be
+ * program has `struct whatever *ctx` argument, so freplace operation will be
  * rejected with the following message:
  *
  * arg0 replace_btf_unreliable_kprobe(struct pt_regs *) doesn't match btf_unreliable_kprobe(struct whatever *)
diff --git a/tools/testing/selftests/bpf/progs/verifier_var_off.c b/tools/testing/selftests/bpf/progs/verifier_var_off.c
index a63e33675091..227dea0da3a0 100644
--- a/tools/testing/selftests/bpf/progs/verifier_var_off.c
+++ b/tools/testing/selftests/bpf/progs/verifier_var_off.c
@@ -225,7 +225,7 @@ __naked void stack_write_priv_vs_unpriv(void)
 }
 
 /* Similar to the previous test, but this time also perform a read from the
- * address written to with a variable offet. The read is allowed, showing that,
+ * address written to with a variable offset. The read is allowed, showing that,
  * after a variable-offset write, a privileged program can read the slots that
  * were in the range of that write (even if the verifier doesn't actually know if
  * the slot being read was really written to or not.
-- 
2.48.1


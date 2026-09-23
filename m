Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6948C53A3AC
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175272; cv=none; b=CLqkIQQuHFk6NmU2WQwOAEt8HwmEmDe20o7IpTFmVKtlBDvuJQz5GEu945FaoFaT6W6X2dDxs27jGTo7sGYonAxHc++qukFcRrhwIzS5yoK56kuvGVRswM7fvW1IXTt+ylfDMpjFukV6m+KXr/zbX27UCkwJQCUvyDUQroauy/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175272; c=relaxed/simple;
	bh=BQ3AIo9FaExG3aW1u0QXqsgAz+u3CyxtPn+zj7VYhc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gK0okOFrVMr2CmsHJrwGBouaHrrb2zHrVvE5vxfYOlrmmQi+tCPTd9sh7tutrQ27Aa7Zb6Rj2OCqBUSb1lNF2Ye1dgQc7s9bqgROlH6fBYsZItyYQDb47+HrIcWNUkF4KMmV8ySJgfy974bqXuX3uvFlZpQ0/qSv7u9p58hjzvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCFSrIC0; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCFSrIC0"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a2ffef2so540497b6e.3
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175268; x=1790780068; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8imZswOXgJq9Cx5JQERORsPUChw1RLSPP9EHDsUeryo=;
        b=YCFSrIC0lwqobzyWufIQdV+GBzHpF+Ee2UQ6PKXA4ZgCLCa7gB5Jz2XhCrot7XSWHz
         G2QmyzOtR8zr5vIXqYv1vEPXJP2+4+HNbP3nUdWcjpGD0JVWP+vUefUe1HjtNWT/drAK
         du5NHAcJ9ssvnENlG7L0+pdUJo6HpKdO7FLb5fpPBLDFxSLVI/T55x2ic2ssthOEIQLn
         7oTrle9afXPxeRPfcqoURZRVqPJhpUfjILLJ+qA+Nx3U5Y9hDImkoElfAK6b6Gdtyuom
         7y5jRKpmuL54MnNrysbt0YjJ62Wj0f3UvDhJyU+1RtnE2zkJ0C4lsUJT8zmC9+I9vGDy
         RQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175268; x=1790780068;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8imZswOXgJq9Cx5JQERORsPUChw1RLSPP9EHDsUeryo=;
        b=UKmFHHAKBUzgzxa/GfbthnEIU35EWmNWR1F0VvxycpgF8PJPHu6apaVRrajlIRbSL0
         z7agHlt4GgxgdTSfBD2hZOn6aB0cufoRXw+6GbwGh9LxCxRWCvICrrF5i6e43UqaUpCD
         vmzLzlzK4MbiahNFoINR8e5tEznvghAW6SMbuZuE5WnOg8worc/eduSGgAFj5EaFnK5d
         jJOtSksYJ8t3ypYG25UOIlQas2m1X9LQgatJhMIGvBC8cME6nZSe8QiosW7zOKnDE7XI
         TOVYnVuDA7S+pS5TdYA8pOvv/o54uSz+v9YAPedV3FWmLP7ROfWFlQzeFq3AJ8r8aK72
         3n6w==
X-Forwarded-Encrypted: i=1; AKwUvByDAAPiTgse/Pn++wGIkneOBthS8IYgaZSMqaKupXd2f/nditYASO+1lEqvbkVmo5O4dSkanc0pI0Q1@vger.kernel.org
X-Gm-Message-State: AFuF++knxyIiavDFyeg89Ra7VlQlUYfOkpf5EabukW7i6LRH02VCfni9
	LPg3+T30WQqio5vGbDZKvy+0sxG2IIoi0N2jKsdO4xTx3+3O47twLlBK
X-Gm-Gg: AYBFou1gl36Z+ivKhdHTVc1ZO1NFyVdjhIrqrXgioPnpLouBxDyWuZ1rqTfIdPsMVdR
	jjq35fwB0erTKcHDBAEMtn65iSPrkKQRPrf4xDvoWw9GTlxFsoiwrIU394MaehAH8jMb86zEJpG
	4tdj5RFfKeYDzKFMFb9fx8I+axIi6urZUtVWy6aOMtjJCFnikEkn6b93pqKRLVPnF2zh6xnoNzA
	lltXtJWdSLv5uN53ytwTHiNqzELammm0yhf+pHw9B+3ugFvjTETXRSanIZclIrMIsZxMN5jTumJ
	Iap5iib/oDJCL5/UPtSn2MWookVK62sfptVdxcp2OKt1ESZp2Q6L2nU3bZRMU0oFUGWn0BFLibJ
	L4yahZKlzM+s4VQINUakJyx+Zu7pyT3AvZYFmW41clAAuPqCc/rpP6tdpLefJdh8W/NHzgexYuO
	4P0cwjMYIH+K/dGXHIXN/7bnEmZ0TV1VtwsMEz/1iah4EnelVPkw8ZuyFqkFVGxjBUh8m2LA==
X-Received: by 2002:a05:6808:4f60:b0:4d6:9283:1bdd with SMTP id 5614622812f47-4d69283317bmr1082080b6e.58.1790175268279;
        Wed, 23 Sep 2026 07:54:28 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4d5c4bf8e14sm2290752b6e.14.2026.09.23.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:54:27 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Allen Pais <allen.lkml@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] sparc64: uprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
Date: Wed, 23 Sep 2026 09:54:26 -0500
Message-ID: <20260923145426.421639-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923144909.414968-1-danishkhateeb03@gmail.com>
References: <20260923144909.414968-1-danishkhateeb03@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uprobes single-step a copy of the probed instruction in an XOL slot.
When the copy is a taken PC-relative branch, its target is relative to
the slot, and relbranch_fixup() moves it back to the probed code. Like
its kprobes counterpart, it only recognizes call, BPcc and Bicc. After a
taken BPr (brz, brnz, ...), FBfcc or FBPfcc, the task continues at the
slot's address plus the branch displacement, inside the XOL page, and
dies with SIGILL.

GCC often emits a BPr as a function's first instruction, so a plain
function-entry uprobe can kill the probed program. In QEMU sun4u, with a
uprobe on a "brz,pn %o0, 1f", the first call with %o0 == 0 ends with

  init: potentially unexpected fatal signal 4.
  TSTATE: 0000000082000203 TPC: fffffffbffffe01c TNPC: fffffffbffffe020

where the task's [uprobes] mapping is fffffffbffffe000-fffffffc00000000.
FBfcc and FBPfcc behave the same.

Add the missing branch formats, as for kprobes.

Fixes: e8f4aa6087fa ("sparc64:Support User Probes for sparc")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index c8cac64e9988..c8ba033427ba 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -97,12 +97,15 @@ static unsigned long relbranch_fixup(u32 insn, struct uprobe_task *utask,
 	if (regs->tnpc == regs->tpc + 0x4UL)
 		return utask->autask.saved_tnpc + 0x4UL;
 
-	/* The three cases are call, branch w/prediction,
-	 * and traditional branch.
+	/* The cases are call and the branches with a PC-relative
+	 * displacement.
 	 */
-	if ((insn & 0xc0000000) == 0x40000000 ||
-	    (insn & 0xc1c00000) == 0x00400000 ||
-	    (insn & 0xc1c00000) == 0x00800000) {
+	if ((insn & 0xc0000000) == 0x40000000 ||	/* call */
+	    (insn & 0xc1c00000) == 0x00400000 ||	/* BPcc */
+	    (insn & 0xc1c00000) == 0x00800000 ||	/* Bicc */
+	    (insn & 0xd1c00000) == 0x00c00000 ||	/* BPr */
+	    (insn & 0xc1c00000) == 0x01400000 ||	/* FBPfcc */
+	    (insn & 0xc1c00000) == 0x01800000) {	/* FBfcc */
 		unsigned long real_pc = (unsigned long) utask->vaddr;
 		unsigned long ixol_addr = utask->xol_vaddr;
 
-- 
2.55.0


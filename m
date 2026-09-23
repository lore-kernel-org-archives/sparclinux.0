Received: from mail-oo2-f41.google.com (mail-oo2-f41.google.com [74.125.231.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E906535FD0
	for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174953; cv=none; b=NVZSGXfaVWB3XfFTC9aqQnCduOPNSy6ZQr4UIQZ/0P1CcLeauc6eLeIwGTkc7ZNRAPuw8NKv/UdIaXmvPJZAuyWZDd4/t90Ju6b6FJthowDI0l8V7GJ+z7k6b3gc1NFbcFpeAO112dPT0h/TzMxqBP3FxVUXrdVeR9OyXlaGnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174953; c=relaxed/simple;
	bh=wQCvOdr5DG6nGGHUmjf3dbvqPAsVzIgztOSMKuc72jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBWUABYQfaD5N5/3j4N4NuCCJbbVHVSUqt0/bnTnP0BN/jRe7GG3gydbt3oZ+GLYP1RQeLBNiE8cpjX8N2/Tid7Ce1krhOENbCvqipkoKMk5gXGCF9Yr+Cgnsoy3xQw9jU93FZA6KQEo6GCcerh2n7uZimb1RMBFfM6Ey8LjJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVMvzhby; arc=none smtp.client-ip=74.125.231.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVMvzhby"
Received: by mail-oo2-f41.google.com with SMTP id 006d021491bc7-6b1ae736c64so775634eaf.2
        for <sparclinux@vger.kernel.org>; Wed, 23 Sep 2026 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174951; x=1790779751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jb40C5wg5KlMegSVoKPaSGTLlViBBhllfQg4nnGSKA8=;
        b=DVMvzhby3hWepqkLYFp3NitIWxCyCs+BvmMzaoEUuuZvhu/zgJBntz4evdhwOrXecL
         nB2D16y2jhP2bcHSMCf0iiShrA2usUUbKlVk7oaqTWeLynqUhmEoXUieXWozIVng5kqb
         v6ULCkYQCAvYEC0TGFZeNsRosSSl/c4LIJDjb7dgvFoONLQQW4oPFhfQsm/w5VkrVzba
         eBIwzc8Akvg9FCvwwW2e7TN3UGLPR0YASFvT0qYoDyTo0H5tCzpg+3ppn32pWYAeaK00
         yUuKVivSKMQof3WikcMALRJ8MtDVEoAi6OkatxjeIhvOT1HigvWrDu6j4sM+KUbaFrrL
         +9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174951; x=1790779751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jb40C5wg5KlMegSVoKPaSGTLlViBBhllfQg4nnGSKA8=;
        b=RRUQCIKtQ6mNHGaYPVrhHu8XUrnPDmeuKA3tMYcurBfOUMktrwu1gTjFD2rngty+HW
         D40nrLv3tvoAVgEnOmAmsOq/WD8tcSS7lcq4d59HGxktNZvbo9n/rtZhH1gepWi0xUqW
         kDfKcjveXKGFRaYiwyvCMHNFHmVIsR23FWA5Cg3U4H1+Brrs3hRAyw9wsI+rDirS3+rB
         L23gZzSsc+7nofrpI3YwwwLBTSFNVGx6hG/ugcbmSmNmAZ2rGu4yQjhMgOfbAtVHXynj
         QRHVk5oEEn7/Z18jqYVnakevEc4ElQT49enUzG/bstjzJ7HzSV9OV9rI8xf2WCAiFo5D
         w+2g==
X-Forwarded-Encrypted: i=1; AKwUvBynnpHRbDZo0aPwYrm8eVcMXIjj2frl8J061kGv5uvN6C4007oga0N4wZVvJhNn0rVZqE+vka5aeBte@vger.kernel.org
X-Gm-Message-State: AFuF++nfa6sDhISMwvc6oJgFNhwRM4tWafOzuggIx4W+nGioM7sBSVJB
	V+w5GHYDzbETq0G8u114OF0DUmOmsT7KrkANEdhxvj00K0xuTJYm/5S8
X-Gm-Gg: AYBFou3IRmQQ4OASxHnTMssUWb7B1DgA/f5L2D/u77JYm1wJ0bVP7P0/YB32TSgIGeX
	cxyTFnAJM+gml2U6ygD+EYus6VPSRJm7PNqG4ARZiPSrTyzFuoi0BPsppsE/uqEif1cdCAKv77T
	S9H6NESQi3KX2KbHOHkAhb56yU4tV/lCqK4Bsjal63Cuaa3IZvMb0cH38sDtmW62ZjcP/zIOkxC
	45ZSDhtUdERTEBKulPJU4msQEhercXcDA7rE/Al2S5gruwZ61RKbmQfWazs9MPm/kP6YuWNVQ5T
	DsrLZIusMlaeTW4ZZhknqfzti33paFoZQLhv2UKqPkN2LCLuDhUtSQT1JAcBOQCp0rIod/4VDFy
	sUPK7lQz8KYj/vibOKos7UAximUXR/CRJ/utL6ZXBx16ws+iq2R1+uub9pwCzjx3r3g/ab2KTgH
	rSh9qXFfJXVzb9X/zP9N5s/k/W6+uupatP7BnbK1hHfpEF2NG3S58KF70gxGCHe6lD7TF486Xsm
	Mh+GQw9kFUyrGCEJec60hi+Cnh7RGOqkTwKynIe
X-Received: by 2002:a05:6820:190f:b0:6cd:3fec:de75 with SMTP id 006d021491bc7-6d2d3012efemr2156575eaf.75.1790174950870;
        Wed, 23 Sep 2026 07:49:10 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2c92c2619sm2788537eaf.0.2026.09.23.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:49:10 -0700 (PDT)
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
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH 0/2] sparc64: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
Date: Wed, 23 Sep 2026 09:49:06 -0500
Message-ID: <20260923144909.414968-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobes and uprobes on sparc64 single-step a copy of the probed
instruction, and each has a relbranch_fixup() that moves a taken
branch's target from the copy back to the probed code. Both only
recognize call, BPcc and Bicc. A taken BPr, FBfcc or FBPfcc therefore
continues next to the copy, which crashes the kernel for a kprobe and
kills the task with SIGILL for a uprobe. BPr is a common first
instruction (a brz,pn on an argument), so a probe on a function's entry
is enough to hit it.

Patch 1 fixes kprobes, where the check dates back to the start of git
history. Patch 2 fixes the uprobes copy of it. They are independent of
each other, and of my pending uprobes kmap_local_page() patch.

Testing, in QEMU sun4u with sparc64_defconfig plus PREEMPT,
DEBUG_PREEMPT, PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. A static init puts
uprobes on seven branches in its own code: brz,pn at a function's entry,
brgz,pt, fbe,pt %fcc0 (FBPfcc) and fbe (FBfcc), plus be (Bicc),
be,pt %xcc (BPcc) and call as controls. Each function runs 200 times in
a child, alternating taken and not taken, and the delay slot's effect
and the path taken are both checked. It then puts a kprobe on
__se_sys_getcpu(), which starts with "brz,pn %o0", and calls getcpu()
200 times, half of them with a NULL cpu pointer.

- fe2ec83746e5 (v7.3-rc4+): the four new uprobe cases die with SIGILL
  on their first taken branch, the controls pass, and the first taken
  getcpu() under the kprobe crashes the kernel.
- Patch 1 only: the kprobe case passes with 200 hits; uprobes as before.
- Both patches: everything passes, with no new kernel warnings. Boot
  has three DEBUG_PREEMPT "__this_cpu_read() in preemptible" reports
  from iommu_tbl_range_alloc(), with or without these patches.

W=1 and sparse are clean for both files.

Danish Khateeb (2):
  sparc64: kprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
  sparc64: uprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc

 arch/sparc/kernel/kprobes.c | 13 ++++++++-----
 arch/sparc/kernel/uprobes.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.55.0


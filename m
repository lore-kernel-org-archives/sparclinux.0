Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081117;
	b=vQ+PPwMV9Hy2vuhkV4uX5UIsMqlJxI7W9e9QZV5akIRBYOL8HfyfYp5KLSfm2BKdrYVj
	 bb5jj/55f9s6/eMAcrvFgKS+AnrjMYRVCFiRHeosV6bEmmRsDmI8bLzJ0UytOQ3jMFj2Q
	 AjpMhIGZgS/xYJNRVzczEs+HNNEPUkoS9tIAYW12KV0TfCzc67NyDg3wFgeNEckrRWaKa
	 w3X97w/I56DRzpylzMVgUyHKoP/Mpu0Lbu96HfDopf/puhMPqgxWo41Md4PycnjwI4jzY
	 RJ0QEBGTkiKQOYWtJRKbaBer8NaVqPgXLnmsg7TCiJKfaBQlbzLBgD/l73gZn+jDXjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FtLI03n5niPlmdsJ+E4XDcCPmRgq2Jm/sr5s8DtS9AM=;
	b=QahkZe7e3T6E3HsALFJZ0Bn3NEHlIo1V1Ua4IRHjmfaZxsmENHbI0KL9ozB7pp/5Kmfu
	 1zBoX4I2jwK53mGjPSecOccKh9e+jcj/0R+qWegLF/hELzdJQtx4CHp6EJAbCAodzJkB8
	 GN6T2PBsfwVbPKfR++cbU2P5FNyJkA/7ZTgIbUyw7cJ43auLn3TIlEImixNu+Btt9gKpa
	 hOymKiwaBbSkhzRIuU6pUZSyXC4kgGETB7TaJMOQCf0l/k6F1kOVkQtlCdD7Bo72YH4zz
	 sRcp9I7SGWNqQOMJ6xxFDq4IMD4VzqQ0YRGIb04sav4DjcxXKDl59t9vT5blsDRUPOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDbbq3bH;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BDFC606A32D
	for <sparclinux@vger.kernel.org>; Sat,  7 Nov 2026 19:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BDFC606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kDbbq3bH
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e1d0e5dafso420035f8f.1
        for <sparclinux@vger.kernel.org>; Sat, 07 Nov 2026 11:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794081116; x=1794685916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FtLI03n5niPlmdsJ+E4XDcCPmRgq2Jm/sr5s8DtS9AM=;
        b=kDbbq3bHTK2PIoZKpI+H9DdZkZGoZD/bpFLNuchanpHpnrfh56yqDuri2slv/Nl2HC
         kGQglgIYAivjhexIYTy6+FNtrHbILM8vX7JB1ZjS+4tqvOSEWF/5mdwRqav9L3jp/0S6
         n8RSgv5KD2HHMSxGKCP81clxmLVFKMYjQlFVnHyJ8gAh3Pvc3AKj/ND/rUqJYaQKqDbc
         Pm27tXU8kjnlZhdZnwJuXuaFfJlBG2YpS7ppkqIIo0PiqU8D75Bqs1qFtaCz6FRonLDM
         554RsdpzfWEzefLPjIVPyg88Idmww/+G7pyJ1t0Won2xabfXu3IE3a/HP/Nzkf6sGDxh
         hKDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794081116; x=1794685916;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FtLI03n5niPlmdsJ+E4XDcCPmRgq2Jm/sr5s8DtS9AM=;
        b=11krT+855P7QwHVJWQqhW/RG4eatmC97KhCE7hB8DXMJh/vRddZ/YijeJcmD2p2ze4
         i7rAEweIK4Xo68BgM1FX1OoggBlC0V/QqIdiyU9MZpEdD6mjlb5weWcUcxE/TwYcn9On
         2G3NM90OImKSZIF69nlsmOWcZ/r6hvbjG/96BRTbx/0BqQllfcc+i68XjHMLQZraC/HJ
         ltu/ccAFtaHXW4EZt3upULqIM7CiG6+lapxiKImsNKGwt7/H22u4tkodfM3HfLueOyxA
         +WqS9hB6YcdIMnWXstvm/+X/5da+okJgD33F3eqW5vwL+wTBZmDYIh4it9zl22eyhqFq
         So5w==
X-Forwarded-Encrypted: i=1; AKwUvBwbYHJC0+K6BesakGaeyPonNNqF/pGqVunBVFBvtqtt7Vh8ROkrT+IO5IxWM4vmqvJC/9/i16+SNNLG@vger.kernel.org
X-Gm-Message-State: APuU4Z9HQhggKfAQhXLp3Kl3PV2y6vXNIx0oR5zo7FHsdqfW1QSqLdLt
	VBncxqL4kWAJXZW/4WlUCxfN87OZbGkNpNXhrlrTrP64Hot3E2Tgs2p4
X-Gm-Gg: AYBFou1mCA54IFnQ2QpbNGekC5bhshsJ4azEUulUylzD7L7kOIX0i4btD3RfCj31f8l
	T0GFnUa3EHJTvf2ynMJM6JGL2HvgvSrU89bm0QdbcX5ZGZLOCDaJTGmZfLaiJg0iZZep1KEpRkV
	UHpUeB6XbnBuS+quc8F/NLt/iNVbDxPCoJCQGN1ujEfPSsaC7osrSDoTfDJjGAUzD9ltl75BHSm
	cOJck+oUaKJF7e8CjUrR16cnd7YS/CdlqNx1R1YdfpCFtylhcSqeJmxRYVdwxsbux5/cS2Z4RcS
	9pCWGv0gl1N+9KYm0ljf7GW9LAps51lX7+J5f5vdVxyliMUwMgtvjPP3nvAuz5SHxLWwdYve5tu
	78ddoV1TqabXVHqRoKwVCh9JSrorNW/LJtYEtUnSjgqgNXr7ctkLTMHlWoJv5DMV6JPD82B4pDI
	dvpAMvOZP415pfVFJzt10iyk4DZEULC1GGiUfuPhmGKWfAEiUom0/lG+B+R3yUjE4oead/1Ibhq
	xx0YXNAwRHrkn5NrSWmyPzp6OOXJI6yyCrb5T8vsUOsUMyyM7L4SDDdp2YujgYRNoF93wQ1Oxbd
	iNPqnvuA/Q/qsnAG1a4gDukZ8WhYPPYXUOukHtf4IlsA3wFnz5mUmwTaHleXhBHTMODlRRd+LDj
	Ww4iI43BHoqXcFLXKnfRVp00W3ZYWJ4qU/o/sP5wJZy58JzjFcBxz3SwHc/8FpwlA5iCCEGlKd0
	p81HlHMWXGTptiGHFrr957VQyjHDjr1M4=
X-Received: by 2002:a05:600c:64c8:b0:4a2:18c4:61a5 with SMTP id 5b1f17b1804b1-4b8190f42aemr51295615e9.6.1794081115573;
        Sat, 07 Nov 2026 11:51:55 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de. [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b76cb76697sm61139345e9.0.2026.11.07.11.51.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 11:51:55 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc/iommu: Use raw_cpu_read() for iommu_hash_common in iommu_tbl_range_alloc()
Date: Sat,  7 Nov 2026 20:51:47 +0100
Message-Id: <20261107195147.70084-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

iommu_tbl_range_alloc() reads the per-CPU starting pool cookie with
__this_cpu_read() before acquiring pool->lock. When called from
preemptible DMA allocation paths with PREEMPT and DEBUG_PREEMPT enabled,
check_preemption_disabled() reports a bug.

The per-CPU cookie only distributes allocations across pools, and each
pool is synchronized by pool->lock. Replace __this_cpu_read() with
raw_cpu_read().

Fixes: ff7d37a50202 ("Break up monolithic iommu table/lock into finer graularity pools and lock")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Assisted by an LLM.

Tested on v7.4-rc1 (d48723711bae) under QEMU sparc64 (sun4u, -smp 2)
with PREEMPT and DEBUG_PREEMPT. Without this patch, two consecutive
boots emit three "BUG: using __this_cpu_read() in preemptible
[00000000] code: swapper/0/1" diagnostics in iommu_tbl_range_alloc().
With this patch, two consecutive boots complete without the
__this_cpu_read() preemption diagnostic.

 arch/sparc/kernel/iommu-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/iommu-common.c b/arch/sparc/kernel/iommu-common.c
index 23ca75f092770..014d4e9283d55 100644
--- a/arch/sparc/kernel/iommu-common.c
+++ b/arch/sparc/kernel/iommu-common.c
@@ -101,7 +101,7 @@ unsigned long iommu_tbl_range_alloc(struct device *dev,
 				unsigned long mask,
 				unsigned int align_order)
 {
-	unsigned int pool_hash = __this_cpu_read(iommu_hash_common);
+	unsigned int pool_hash = raw_cpu_read(iommu_hash_common);
 	unsigned long n, end, start, limit, boundary_size;
 	struct iommu_pool *pool;
 	int pass = 0;
base-commit: d48723711bae9b8cdc56719c448ba42fef28cbee

-- 
2.39.5 (Apple Git-154)


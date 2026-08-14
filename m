Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FC45C6F7
	for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 11:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705488; cv=none; b=cn9bJCIOkB4QlrZxf3LxkTAeCxGQnhifcQFneb92S4usHrzTkeobUmRUOPAxDdwDJXJb+mQPghznbWwUG4kSSCLm2IaI4WFCKb4KJvonn+S80dVpuOFSxcFl/nzRIM5vA0rb5jWDkeO+pnHE5tlY712DtDBZ2x4YsevanAOep00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705488; c=relaxed/simple;
	bh=n0+oMFlCicrxC3zHuZmFe9MeT+CoF1ugOOoTEU4PhmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecfbvgg2VoWIvMbz8qAOpl0zQWI389opYAk8ZRfkEukJ0KA7GAJHMuKUrANp86chNns4B8KEgdFZyzD0QOaInhXbM/5vhu+sS/84ucvLZpVNUTK5CvrLgJXsUQExhQlKJX96S+yoe0XuXN8Myuj3z4pjaUZ2/tOq8p00uec/O1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bhl5goGk; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bhl5goGk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20363107f4so95511066b.2
        for <sparclinux@vger.kernel.org>; Fri, 14 Aug 2026 04:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786705482; x=1787310282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+C3yDrnyWElju51nv3m1vHWDYdz4gkHACkImbfPvTRU=;
        b=Bhl5goGkYgG8pNAiiGjnBJ7cRjPUV+in2o42jSbpc7VDool6JItgh7+4WKqTdoWeJt
         EZq/VbNEB92qzmEWtjL8LsBDTdbnVxGwcqAam+H8fD61rYRN+zRWQppWbQ5sWMj85yy5
         PlLJhkFaf4z7gjBPsl7LwK5v5sUjP5oa1leKs6J3E/OH5FQlhdXYX66Qs3p3oyznIwW9
         5A7VtfJT4G3zSZk21mpxkX9dlEpHCWmmQWoMIRC4ugsTqgC5QqD3N68HNFEE99MwKE/j
         LhJ8CyyMyjpOf70PwjfRQDOXrgVUUa4VlVhvyd/7mBDML+Z4NszxFWWc4QkgMqC785nY
         zpjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786705482; x=1787310282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+C3yDrnyWElju51nv3m1vHWDYdz4gkHACkImbfPvTRU=;
        b=sZCTM8kGHrx//Y6Ku7FHuRzK3ZtNg+bm0DWyV61F4OzzRj7HF588zjl+btCZk77wGd
         KKuFtGvE2oySgD9z3W9Gqgtr+GvzMWHoUYBy8HwOcMf7GEaUZuTHkYtd0pjsAtuTGrdq
         jMbBFZ9iKu1CBnUXzeT+X7+lTEWEroB26HgTPo+dfJ6XrYbq9EsteR2STG56Pj3+4I7g
         cjyC//+MJVALzzhMA3CffElAYeTi3pY1a4KYryXCYxWnoeavZO88dr6oz7FSgtZHF+d7
         9t3PNqZunx6RJNeWkBlpMHt3m+K164vU/ydoIaUpomP2Won6Ynen5yRRY/NGF61q/Khg
         kAWA==
X-Gm-Message-State: AOJu0YyBqL89KB0DsqZe2PUqn1oTvcYx6ZDRTF9let9/zd8gw5fyncV6
	QwXEBuC73ZdB6RHC1wn+rjxin/+D7QgrRZVdnBGCyczGey2BTsFKHnYUIelYfA==
X-Gm-Gg: AR+sD13TNp1vPqnfA4p4fyXPjo9CU8rZhi42onuiOGxWQOdDbaJDePhGqEg1GjxHe8Z
	gra7ec4LERPFjN4vFgzz3nzdLoy53l3yXqPe8p3OPpoBgYZi3oGbKs8tuv+Rz9pGVaHTTc2D8Ei
	DHnqlD5j4PR893RHbbyTzVptPT2hmRSIUwdzr8k1sS19J27Et1FdT9lJOXksTY52HQ/AisIswJq
	mmBiRlSvwd4bOl0GgO8xyW+GUGA9tbReRiUlas2tJQG4NTQ88KvuaheW+wveX7Ab2I/7czuGzUq
	CKwqPTRNZk24vj7usc1dfUE9ArFGMKiiC8rW1irTQLyM9FnKMXmC3gfwrAETIK3CzgouAWvaPEX
	Dfmwa+KYIBwONpePL8OM0nSpc83p0LcuZpLbDHfgVYXLOT3fBxWiwfFVsG62/mu+634neY7iSFr
	kStl4tlVTkOCuBZvGlhiUN4jiafuaTGKyeA+0JoDdN9rj+BYIsjg6rpvRgO/uet/aDn4EN7BMJR
	MiOyeiFpvzxupN1TWkgpveHT9yfoINYJG0mEnc2QQ==
X-Received: by 2002:a17:907:3f09:b0:c15:e118:9b99 with SMTP id a640c23a62f3a-c212aa4d8d5mr190069166b.23.1786705481429;
        Fri, 14 Aug 2026 04:04:41 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c21233a12e6sm92028366b.12.2026.08.14.04.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 04:04:40 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
Date: Fri, 14 Aug 2026 12:52:33 +0200
Message-ID: <20260814105723.3454511-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260814105723.3454511-1-linmag7@gmail.com>
References: <20260814105723.3454511-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

setup_arch() computes phys_base as the base of the lowest sp_banks[]
entry, that is, where RAM starts, and assumes the kernel image was loaded
there. That holds for the traditional boot path, where SILO places the
image at physical 0x4000 and PAGE_OFFSET is mapped to physical 0.

It stops holding once the image no longer fits there. SILO loads a kernel
between physical 0x4000 and its own text at 0x280000, a window of 2605056
bytes; a current sparc32 kernel is roughly twice that. The loader must
then place the image elsewhere in physical memory and map PAGE_OFFSET to
it, at which point phys_base describes where RAM begins rather than what
PAGE_OFFSET maps to, and the two disagree.

phys_base is the offset __pa() and __va() are defined in terms of, so once
it is wrong every early translation is wrong by the difference, including
the physical addresses written into page table descriptors. The
tablewalker then follows pointers into pages that hold nothing while the
same tables read back correctly through the nocache view. The failure
surfaces as a hang right after the context table pointer is installed and
the TLB flushed, with nothing on the console to explain it, since the PROM
mappings the early console depends on have become just as unreachable.

Ask the MMU what PAGE_OFFSET actually translates to and adopt that.
__get_phys() already implements this probe for sun4m and sun4d and returns
zero elsewhere, so no new low level MMU access is introduced and machines
without an SRMMU are unaffected.

Memory below the kernel cannot be reached through the linear map, which
runs upward from PAGE_OFFSET, so drop the banks that fall below it rather
than leave entries that __va() would translate to below PAGE_OFFSET.

With this a 6MB kernel loaded at physical 0x03000000 boots on sun4m: the
context table lands at its true physical address,
srmmu_inherit_prom_mappings() preserves the PROM console mappings, and
srmmu.c needs no change at all, since map_kernel() already handles a
non-zero phys_base via do_large_mapping().

The cost is the RAM below the load address the loader chose. SILO's
memory_find() picks 48MB on machines with 64MB or more.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 1b0db16cd37b..795714959da6 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -254,6 +254,30 @@ static __init void leon_patch(void)
 
 struct tt_entry *sparc_ttable;
 
+/* Drop RAM below the kernel; the linear map runs upward from phys_base
+ * and cannot reach it.
+ */
+static void __init trim_sp_banks_below(unsigned long base)
+{
+	int i, j = 0;
+
+	for (i = 0; sp_banks[i].num_bytes != 0; i++) {
+		unsigned long start = sp_banks[i].base_addr;
+		unsigned long end = start + sp_banks[i].num_bytes;
+
+		if (end <= base)
+			continue;		/* wholly below - drop it */
+		if (start < base)
+			start = base;		/* straddles - trim the front */
+
+		sp_banks[j].base_addr = start;
+		sp_banks[j].num_bytes = end - start;
+		j++;
+	}
+	sp_banks[j].base_addr = 0;
+	sp_banks[j].num_bytes = 0;
+}
+
 /* Called from head_32.S - before we have setup anything
  * in the kernel. Be very careful with what you do here.
  */
@@ -332,6 +356,22 @@ void __init setup_arch(char **cmdline_p)
 		if (highest_paddr < top)
 			highest_paddr = top;
 	}
+
+	/* phys_base must describe what PAGE_OFFSET maps to, not where RAM starts. */
+	{
+		unsigned long real_base = __get_phys(PAGE_OFFSET);
+
+		if (real_base && real_base != phys_base) {
+			prom_printf("phys_base: RAM starts 0x%x but kernel is at 0x%x\n",
+				    (unsigned int)phys_base,
+				    (unsigned int)real_base);
+			phys_base = real_base;
+			trim_sp_banks_below(phys_base);
+			prom_printf("phys_base: adopted 0x%x, RAM below it dropped\n",
+				    (unsigned int)phys_base);
+		}
+	}
+
 	pfn_base = phys_base >> PAGE_SHIFT;
 
 	if (!root_flags)
-- 
2.43.0


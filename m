Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15754F5E1F
	for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 20:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790626129; cv=none; b=J6lp2gJiAc+h4rSyCGDl5/wbBwEfNfdyrer16hAYFgmC1UGxbVlt6TpNA4OWVbGtPBl4MoVzl1cjvv5d9CvDxZaxt36ZtkbY2Z2CRCS7ycabBHNC/kWJZMp33pp1oc128jV8B6J+nNYDDr6Orv/G+wSvcOYm8CZJmd0+nFHKU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790626129; c=relaxed/simple;
	bh=d2MUplHsS8U4FJAMDoym0CNaIjbOWLHpN+BVoJXXMdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEHdZ/h4Kfbdpo0O0N6e25jOvS7I04FacwQ7LEr3x7Tly1OYCbUr/OnSk/ONlMd8PzAMoWHC0sSx0xvr7ObssjEMaXeFs3DqqjCaOadIMt82wiNaxSzVYcMFF1o8mtnOmgedksJaDU9skW5tBAi14uQgorJihohSDn3th4hzdLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgQgfz1C; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgQgfz1C"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2da4eea067so282748666b.3
        for <sparclinux@vger.kernel.org>; Mon, 28 Sep 2026 13:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790626126; x=1791230926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZmSflQBXftp4HXe4zrTMF1QW5LZc3st1xkIXknkEjYs=;
        b=pgQgfz1CGdfgc5nOYb0VXubQ35hGbzuEGpEbcKvrjScIOHRHpLn67jGjoHIkJl3pP7
         LHqzNqG+DGuNUvTMqrjYNrEeT79QOG17nz1uqRK/6rHtf51ihXWt06gXPjQ5V/f9uAE3
         bo6H7yJopSGCtA6as4mXuEghPR6mowA09xYCiJO0pEUVZQbKeptpSOVgwbC3r5sI+4gy
         7pQKdZW6mKeWvZPfMacJHwRLF/8qnYtpLCvCoKd1Lgq5dBSs3F9t9vkZgwUoNw14jE2K
         BfVc6tJQJFgsI31k4sVhFyzUAjTNHb0futW7TAWn4OlhPXn1t5ThWEL/5SEcciDj8JBC
         F5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790626126; x=1791230926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZmSflQBXftp4HXe4zrTMF1QW5LZc3st1xkIXknkEjYs=;
        b=vXDzd4S0auyiRRWh2MVNuPKLe/D3d3vW0NROzM9BxAc26I1O8t0xqz6nAzCMAM+enq
         epTTKz5YAVPN+vlvE6JyNC8VYsYwosVS7HTe9+9faIH2AwPTlRQXOyOVETAj1uJafnt/
         CFSK8R47QJq0/xQa0Km0KXlOU2ynsgxSm033jxMI6xgxQxPxEB4RE5eYFPOZvt3aH3XO
         6hVKzKGY8K6asGlELsN8j2d6qZiOktg6lh3iZtcjgHtIqsE/h9wgbRawAP1P4rFQ3k4D
         SvrvUmsKAm2TxjsjHAUmIWcXiGx6pqLu2GgrVbG0oQ17Zysh5JqAjo42vhix8BCYSwnz
         tqnw==
X-Forwarded-Encrypted: i=1; AKwUvBy4Mmu4xyYJRSRRr+84EkpV/Tv+cnsm1F8+peMqIHRTeVYhpdrKjNDpLnLARyKkxauKg16xVJtHc55I@vger.kernel.org
X-Gm-Message-State: AFq9FYKzrn+Xq1IHFSbgOzCEkuWNT1w7V9gvTZP1wYkewrU54Hr5M8aJ
	B93QSXqwbX0hQwl1kKg+2A+k0dwGhXDT18eX1SxoMdzHPM44al30IzGZ
X-Gm-Gg: AYBFou2aOBu1WN2brvbRlTV0sTWgQSEUBnIid/xlJeeHDpOlrxCt1sbxbqTHzRzrpQo
	8oPq8cyvdUNLXl8b2OENQm/EQP/fQj+6n0LsW21Nh/rbjvRQA1Blg7WWa0f+G3mONJnE7Fa5A6l
	FPCW+8TiikFeM+vQCX8mmdfhDxvMj/0Ttds/UuNtVXBmtYoVYla43xkfp5ndDwK2qVn4xBEL4Bx
	6hGRGypIPP/yZsqmFaXS2G88hGFeMblp4qTMzqWC6DoGfcMkPQKbPU3Hrgzr/LndGMVFJOpY9AI
	lizuGeOdL3AQTySrmyl9cl1nMS3DdQS8yWogjmNnZQkQHJRULruxWfGbEqYXm3d6VOk+TVDiRgw
	6JBC8iRxIb3W54ddOVbsFfzivpWIjmDvcNT+8grDXoPxCJwcKBbLsEBj6VrYn8RGbsT08UonRik
	NYOh112H3kqVRWbffJQMEbMSKTpMjxzlqXg7BM1MWM0XQkPg9qnJ1/8qMYSyeUnitss5KMkhdjs
	Dl3SLQ8ca4l79kASobp/qoutYlBPBq5XIOLjhFn
X-Received: by 2002:a17:907:9487:b0:c25:cb7a:12d6 with SMTP id a640c23a62f3a-c2ac528c69amr987383166b.14.1790626125962;
        Mon, 28 Sep 2026 13:08:45 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae76abc3asm509778166b.37.2026.09.28.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 13:08:45 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: linmag7@gmail.com,
	sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
Date: Mon, 28 Sep 2026 22:06:23 +0200
Message-ID: <9c8c84ffde99dbf747922ef93c1a73438c846e08.1790548064.git.linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1790548064.git.linmag7@gmail.com>
References: <cover.1790548064.git.linmag7@gmail.com>
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
zero elsewhere. Restrict the probe and diagnostic to these supported
platforms so that LEON does not report a bogus kernel address. No new
low level MMU access is introduced.

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

Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Message-ID: <20260928002035.1-3-linmag7@gmail.com>
---
 arch/sparc/kernel/setup_32.c | 40 ++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 1b0db16cd37b..6d7d6fb5c49d 100644
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
+	if (sparc_cpu_model == sun4m || sparc_cpu_model == sun4d) {
+		unsigned long real_base = __get_phys(PAGE_OFFSET);
+
+		prom_printf("phys_base: RAM starts at 0x%lx, kernel is at 0x%lx\n",
+			    phys_base, real_base);
+
+		if (real_base && real_base != phys_base) {
+			phys_base = real_base;
+			trim_sp_banks_below(phys_base);
+			prom_printf("phys_base: adopted 0x%lx, RAM below it dropped\n",
+				    phys_base);
+		}
+	}
+
 	pfn_base = phys_base >> PAGE_SHIFT;
 
 	if (!root_flags)
-- 
2.43.0


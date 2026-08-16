Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BA53D522C
	for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 07:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786866811; cv=none; b=D/hrLpsFD+/xnjlWs0HcTU/t83tfYtep8DWFGSFGD0pVAl9zSxWlIwH1ictK7KHWKbrHsVGl5OfF5Cqoq9qawVJdapQ8k3KiH35kDbJ0+ZQHR0eTQnFZDdiP7QDpRu0J5OvuwtWr9PpQ3HHvsXXcR/vgylE90qxGN8jZbgD2GzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786866811; c=relaxed/simple;
	bh=1/oOxcyYW0GuGrXLQoA79vT3BU2mfelT/BQaPar8lxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V8EVBmZcKbdU9kLx4jGdYKHLFSN/f34OnIns4mVyTIV5xaljkzdKf0jdaJcWOvD8qQk+bQJtzVSq0Cc192VoSMfoS1LunXRpyTXDtAw2/9g49OcpeL4EyMY307XplkxkCPRG4YkLMvtd5W2Oo+UpxirhoXlhEzF9Bni/Dj7g9B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTJH3Wr5; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTJH3Wr5"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aec201b582so2233938e87.1
        for <sparclinux@vger.kernel.org>; Sun, 16 Aug 2026 00:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786866807; x=1787471607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fTQFv3T7H3qQ3wtluPXd1EgweBdV/cuTg0pb3r4AAz4=;
        b=KTJH3Wr5Qd5LcjnACuLHlHFwqiyXKLuCAjHigB2g68u8k18lZDr/Gy20OGOOp8Uqa2
         M1WZlqLkX4aFImU3PrmE59ZQPaDR4xpRtqXHcX7EQXmyRKfymBznQZRv4DPvxF+xOh5/
         h+goHlhOfszqmW5IjH/3rCzehwtKybpeYhsewxStGgk01XxGhRh/EWX7e7Y7T21X1UyL
         OHx4YQPoSqZAnjF8wf3bUej/zVUhT9z98WDHyMvISyFayOJnuu5J4joH5bG7L7ajB/X1
         oikKlWB65jcjdZfOVvGm8X9R586C9vWgTO+A2ysoj0uCJUOQVNDPlLJXKGyKrJhk4Yar
         64Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786866807; x=1787471607;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fTQFv3T7H3qQ3wtluPXd1EgweBdV/cuTg0pb3r4AAz4=;
        b=PU6bPkE8MifbNU5AknfySWMX2gcOxgm8N6vsKGadFAswbD9NzWiMskncYNa0TD8CN1
         1nL47zvirdyLTqjPH/CZ7C2kgYPByEQPIk/+VXnc2qW9LoXOGqdAKSgwWYuLWAG1YDrk
         c4OK9KS/IxN50K0knRqqLvxOdtehjz9apzH9j0SVrE6RApvbeshwMuRSp+VZt+ozD7lU
         IE37gNY/sIN6Cdz5nTG/xxVS04jRsOtOok2qARlQza06IjIOosy+tfrcJOJSdJGFJgQi
         +btcqQJT1bPbgfi5M2PRwVXlyD4DMNs0RnEmsKVcEHVS7i8l5S1YTnC9A0pAbhicvZ9M
         WWAQ==
X-Gm-Message-State: AOJu0Yw7KuoigZZY3xdIiwIStYKTX7pc7vT72/R8i0ed78EJs4kunPkh
	L8EpqpJ3/wDIodGoDVgsF4Ie5bSO6yhMpRaRrEGogOGlNUW6GX/zv+x5
X-Gm-Gg: AR+sD13dmlpoCiH1jkMOLoMjJ0ytQsh464RSgaX9Vx1OHNPGv7I3/pxsWfodMJwvnyO
	LKzMbQGqOiUTPu/8X8Ayg8SZsmVoyW2Au6TJO6TE2yv8361aAJ6kqhSoBqrMnEWIOo0i9feCi1u
	Q+GhhrUkfFHJySkfkhJpsbZ+OhRcCa0XqK2cmKaW+NNHLECmV4h7wg8nzbHhIZsFkvMAwhYMipN
	Y4bV45aPLCHAVmtMPsPKa2RiPLzMwekJbCZdqcWonRpWKXncFi04LDuh4t5lQw7Wowlr6YAt1sy
	X4DM3HO/DFYtfmUb7dlrpmFvA2rCAUHnK/+qbECMfzPqhSwDjxRnSPG0YgwxISB77XvqtJcCjTr
	hyYRgDouIUUJ44AppvK2BHhdiaarNESl6fliTzXaXnPtYslaQ38JxmAW45HuvYBCZKyhmFoxCxo
	HUDXOrPCs3x1rhGiw/9krs6wLPH/rv8ZB0VFyCvA25wdruLiMFhYpBVIAcPPeoVPg3/ItC6gvv8
	cHSTa0rsVx+i0sBX60BzvFSG24VjgY=
X-Received: by 2002:a05:6512:3d25:b0:5ae:c563:f611 with SMTP id 2adb3069b0e04-5b459186181mr2802436e87.36.1786866807302;
        Sun, 16 Aug 2026 00:53:27 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b458b9a8d4sm1631136e87.15.2026.08.16.00.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:53:26 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v2 2/3] sparc32: derive phys_base from the PAGE_OFFSET mapping
Date: Sun, 16 Aug 2026 09:50:16 +0200
Message-ID: <20260816075141.3489194-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816075141.3489194-1-linmag7@gmail.com>
References: <20260816075141.3489194-1-linmag7@gmail.com>
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
index 1b0db16cd37b..34e8f7c87685 100644
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
+		prom_printf("phys_base: RAM starts 0x%lx, kernel is at 0x%lx\n",
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


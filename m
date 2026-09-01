Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E4144A3EE
	for <sparclinux@vger.kernel.org>; Tue,  1 Sep 2026 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788299203; cv=none; b=DVQAg64CDVyJo1ZogEN2Yveh9FtsbeE1d31NA87g9r8yfh4/YdOuBpR0PCDIou1Dea68ug6oZs3r8NEiAGa5m0DSaRCpW/JNSnkcP8Fh1AXAUpd3ghQHvEdzKMmmfv5nbdVuAZygfCGrsXaPcmxOUfwp93yb47Ui9h+lkOxJq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788299203; c=relaxed/simple;
	bh=VmbFlELFJ3Rn+I0JOfMdlDLEE3OEnrmuWAkyZTBARKw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATPVoCsfYQbNM1iZhVVUvDw1NqGq4UYLh4aLpjhSUG89pijmj/WAVdFNYldJJVSGJmiz/PC9IBIU4RZRwckMG7u5yESj49i4nZDomwkQnDsPHeNBzIn1Bw2tw6HLlVhuK01ufvuype0YvxOBpS5LyMe+7Q0eH8YtptJD5Lu6VLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1emJxKZ; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1emJxKZ"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2544ff970dso37532666b.2
        for <sparclinux@vger.kernel.org>; Tue, 01 Sep 2026 14:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788299200; x=1788904000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uJ7HB4Zmwe3amRULeH6fSoLAudldxAC6NdOXYXWuTOQ=;
        b=U1emJxKZL//hS/mmCC/CoUxxCJeKsV5aRjHLMPZcqIiLPM8Y0pDao3UOvbrJ20joq3
         8UTd1pCr9lVT6Zgk9C2jMgzKNQyM4a161yVOzAxEagafd5Igp6cyFbt63jhV0F/AMF7d
         WPYScR6OvmQWrMbVUDopRcf/1mNUf2j2Ny0n18fgp/n4DsNLPKas5iwQ9tuBR8Tk6zec
         0EXe0Y42xFGDVfud/gel3n+eKY+nLRT2ce/h1JnS+eeHBM93dXlTDNVKQj6vHSySoF+R
         wCm4GVb7zFPhw97hmpt0CGYJuYGiX1B/5iKd6hOzchlLzuuCCvNdjnfEK6sYhP0OWMfq
         F1jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788299200; x=1788904000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uJ7HB4Zmwe3amRULeH6fSoLAudldxAC6NdOXYXWuTOQ=;
        b=hZzwczLpbg//WoGFZImtNjldP9yQJHerC+76SFpF8WlvbeV7//OTFr9lj4FRzJoJu5
         R8C0FtKSmu0izKn/Yv3l8kNwHsK1iyrRj3WsUsPlxzjFlJcdjR5xZ22ujahcPJ+Y2el8
         v3h5TEtLEJFuuwOsQu00nZM3dijqL3j+kbpkXRUuIWNJUp6dqn4975YCn9IaxweBSJJV
         bEgAqvmWnJvXzVTrVHhaKrTesJplDFFixY5WeeViaXpshNGiVBtwVMV7sLAHdmw/heEp
         0NEsCbcPd00kXA+ePXzp5CMtP9EZORqkAsRkkMO1g1W4IVC8kG3Gkz9q3bMjJlH/jt1t
         XuxA==
X-Gm-Message-State: AFuF++nhrH9/D2P2v6EQMKKSZc3DCYRbggTA7wZL9qhkBF8CuAj1gW3Z
	4VaD9UmgE8FyuAo98fXSRThRUbq1xB8acAxsP+Re7TFtrlLxsXJFfmMcO+oGKw==
X-Gm-Gg: AR+sD100FNCoE5YRr7A0MAMB3O4hMjnm2HrnL4VL737FdYn3/rL2H9kH5SU1TiTX3kS
	9bes7nGQ9hYcCJlzJxyKbnYKVA6q2OJRC9vvaUhTfuZIDXK0IWRTJ9aYrKOEh5qI5UV2uE+bDyC
	9zwKJ16E+Ob2hfWHKDAUC8mfxv7aUV7eCVkF7z/+NOKkXPKXe2xZKdI2twg0Z5KsMF+kkFvrrRY
	UCCeOhAcIOgsrmMxAbORod0IOMwGFvNLSHYb620Zrl6YaCyIaZrhu1DmLrxHU8ms0gmknJdaxhk
	td8wdGa+wqov1JagmwrEEMholVoeQ8edXJ24m6TBnAgEOC0h53DXDKWe3xpHn+nLCeLmYnUkpl3
	pmPrPuzvp/DOixMdfjSfcLvitQl/Z3w9D8lbjBe8wWV71Y1aQ2djOQ65MlaDwv47VRxSs1ga+Q7
	wD9UNFYSJ+l81EJVEbwEEl/Q/+c41jrxCcMVzjroPcHQZaxUhQHzCvjxYBQhIw3LYGIbdt/wjzI
	GBgkZXdEzupvAfQy9yM3Kj5+C7Ddk0=
X-Received: by 2002:a17:907:80c:b0:c1c:5aa1:de57 with SMTP id a640c23a62f3a-c25d548f0ccmr12610166b.13.1788299199717;
        Tue, 01 Sep 2026 14:46:39 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25cffc70fdsm27500866b.4.2026.09.01.14.46.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 14:46:39 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	linux-kernel@vger.kernel.org,
	sam@ravnborg.org,
	glaubitz@physik.fu-berlin.de,
	Magnus Lindholm <linmag7@gmail.com>
Subject: [PATCH v3 3/6] sparc32: populate memblock from the PROM memory map
Date: Tue,  1 Sep 2026 23:45:47 +0200
Message-ID: <20260901214611.60560-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901214611.60560-1-linmag7@gmail.com>
References: <20260901214611.60560-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add each available PROM memory range to memblock as it is discovered.
Keep populating sp_banks temporarily so the remaining users continue to
work while they are converted in the following patches.

Since the complete PROM map is now present before bootmem_init(), enforce
the mem= limit after the legacy bank processing. Adding a smaller
overlapping range would otherwise leave memory beyond the requested limit
in memblock during this intermediate commit.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/mm/init_32.c  | 3 +++
 arch/sparc/prom/memory.c | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/sparc/mm/init_32.c b/arch/sparc/mm/init_32.c
index e0e66f91ceeb..75050dfbc2ea 100644
--- a/arch/sparc/mm/init_32.c
+++ b/arch/sparc/mm/init_32.c
@@ -165,6 +165,9 @@ unsigned long __init bootmem_init(unsigned long *pages_avail)
 		memblock_add(sp_banks[i].base_addr, sp_banks[i].num_bytes);
 	}
 
+	if (cmdline_memory_size)
+		memblock_enforce_memory_limit(cmdline_memory_size);
+
 	/* Start with page aligned address of last symbol in kernel
 	 * image.
 	 */
diff --git a/arch/sparc/prom/memory.c b/arch/sparc/prom/memory.c
index 269d6ab5ef5e..59962bc0bc82 100644
--- a/arch/sparc/prom/memory.c
+++ b/arch/sparc/prom/memory.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/memblock.h>
 #include <linux/sort.h>
 #include <linux/init.h>
 
@@ -23,6 +24,7 @@ static int __init prom_meminit_v0(void)
 	for (p = *(romvec->pv_v0mem.v0_available); p; p = p->theres_more) {
 		sp_banks[index].base_addr = (unsigned long) p->start_adr;
 		sp_banks[index].num_bytes = p->num_bytes;
+		memblock_add(p->start_adr, p->num_bytes & PAGE_MASK);
 		index++;
 	}
 
@@ -42,6 +44,7 @@ static int __init prom_meminit_v2(void)
 	for (i = 0; i < num_ents; i++) {
 		sp_banks[i].base_addr = reg[i].phys_addr;
 		sp_banks[i].num_bytes = reg[i].reg_size;
+		memblock_add(reg[i].phys_addr, reg[i].reg_size & PAGE_MASK);
 	}
 
 	return num_ents;
-- 
2.43.0


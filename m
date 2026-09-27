Received: from mail-ej2-f42.google.com (mail-ej2-f42.google.com [74.125.228.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EC3C5DA6
	for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 21:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790545431; cv=none; b=GRTy9EV5yozGmzI31L+4sVcnYGsH11+o1XsrrTsqIjmSIR7tvdKQ6PWm5naobRvfDcg4hh0UXcXxn7S9xi+ZOIycvhbftL2UMhItB/kzE9n38T/GSjN8PCaaAqbq+Ssl/Fi146x3qfor5NARODWC8phdOb7tx9Eag+iUOqF3JF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790545431; c=relaxed/simple;
	bh=W/J+iGtW2cqgl8E7D4V33DEgbjzhDkQun/Hg3T6koUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7r+NR6gbNwTyiC7ise70jZI5jBgM2W77S3vTJqtcyqz6RgN2cod8XmE+iiV/u+5gXFhW7/b/POGgisJL/rNvA8UKj69FZP3UGIKhgjYbH2x/dNk6c1Q29kqBuVHcB4XGgwhUYL2JfI6v0XGZYVqZ73WatVYYlopl8LPpxjWtiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSaruF45; arc=none smtp.client-ip=74.125.228.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSaruF45"
Received: by mail-ej2-f42.google.com with SMTP id a640c23a62f3a-c2c996fd607so80288866b.0
        for <sparclinux@vger.kernel.org>; Sun, 27 Sep 2026 14:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790545428; x=1791150228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hMvMI0qdiExZzcrJJ7xCboaNG2SDA0ACb0R/plvY+Ac=;
        b=HSaruF45GNcKGL+Gozr8wITY5cACgJq7E+VQV7TnCqiYu2Erie3RhnPqvIcHTBK8ml
         Ozq3hq71qrQpQfIKSPTwf78BvnMrhBRjw8+Dx0eyRfV3pb2yytKOSnVPMOklepkDhKFH
         pC7te2/IzCaSxoPppEBVDiaH7asWA11mYNJv9akCASZKdWeNMmVMGqk8BQ/9iQKhIqGy
         GWNoHd+KUaAD29873r6bfau24RfRbEOAv4txJOwaglc+sFMWDp89BM5tFwKjWvqSEB33
         s6w8mpBjRfxKHQalVEYi6K73++UCpFLmKKej8FJHn+3xdOBxmcYDanCDdCn0+eKEp03w
         zuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790545428; x=1791150228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hMvMI0qdiExZzcrJJ7xCboaNG2SDA0ACb0R/plvY+Ac=;
        b=MLqJxzxwvCstFeeoyfIt5aDiNA7zecCMHWrOKjanwY0Fc00B7+JbZmAZ+2pgJsZ6Hw
         6nwJxR0kRYGWWtosHc14aL4fGtuXRgp8y1rHtroJXx0jtFoeGHmwKS30fprgkfqqbBd6
         qmzvI/Xg4Q9YNvtAowr5f8/Bdd7+m5Q0VJArpqUYVB8GOqd7lfRtr9+DHJN8t0uGLqwq
         xM+4W9RyO5CULqoy8F59t5ai2W3F1dKwBdWPPL87jzdvLxfpUipDfHd7/eOUfFnT/oil
         tY8h6ejYbymcmJpqoWxTatwu3VifKl1A8+UEOl7UE+zYANI2Kx1RJDQ5on3lhEVuM0aj
         yPLA==
X-Forwarded-Encrypted: i=1; AKwUvBy2DseQoiJ6B7fWNyxBcoQaWeN3McPI5/rtpk7WY3XOX4xi3up9U2MqHEUFJOJiiRVjG0uD+Ts0nib6@vger.kernel.org
X-Gm-Message-State: AFuF++kO6qZeNJH87KbhXAppzOr4XP0wNhx6rLhQyEFXIaosHzqT2WLx
	li9Mtw4JIh7bFinnRVZ99o2MRac+bOg7wr1sJ6yr7tgz7Vdu3hK8YQKg
X-Gm-Gg: AYBFou2L4aK7SLxIkr0eEaARBukCZYZRYSUswLM4UYsf9mh7Pep7ycb1jdmTWIDnq4X
	wZePjPuD9ok0AoH7I4bOFs6iHFttSbZonc+TbriZkR+Xd+LCDYLjwLnulPCsr2qS1sFUWkRTYeu
	UZF4RNz4yxlxAk4KRyQ7g0tv5Yn8erGgzQ4jaoY3PKxco+sKGSypOB5JziFdkAnDCHTsfQYymKj
	JteY7vaQyduJkOUF1MG8GfxcJ3a9H48uyiCEk6zvIKXL7pic3CrkU0Xs/8Wk/vrBsaZBZknKliE
	gIYOCWpRO/XfWIgQKMdEL0Kc3d7RNzE9+LpmGpQQrv645q775yMK2ZngDowrlU2c4o+CKSlP++C
	nm9RX0VQenxU2uO+nCeIyYSO9IMZRbyJJl1eFUp32CpqP3uDMWXdohPDPhQhKXvoU/1DLkK6Pk/
	6WPM41ky5sJ5hXnrfJmY8xSt8us/bLQfO1PI9Kt1/BDqSMvYrce0/05JpnWxH1IRA7h/11UbfcK
	yQIvP9HI/C66UuyNaKcdavE4W/ocHqo9c0XLxD9
X-Received: by 2002:a17:907:7211:b0:c26:25e6:5c73 with SMTP id a640c23a62f3a-c2ac21f983bmr984152266b.2.1790545427944;
        Sun, 27 Sep 2026 14:43:47 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae757b9c1sm376091866b.33.2026.09.27.14.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 14:43:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH v4 3/6] sparc32: populate memblock from the PROM memory map
Date: Sun, 27 Sep 2026 23:43:14 +0200
Message-ID: <20260927214334.886582-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260927214334.886582-1-linmag7@gmail.com>
References: <20260927214334.886582-1-linmag7@gmail.com>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
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


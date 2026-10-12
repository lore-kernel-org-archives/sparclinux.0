Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65973389DF0
	for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 18:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830932; cv=none; b=PQ1Jw2QfC94VyoHRwRh+Q5hPUVqVBrAiPRgmB2i0zLjOK7QSTlZr1RF2NrDml8R1v8NSKr+z4VN2EdodjMbLX2z+iC+FvOScnQsWDKYZIP2tW4xZgnrOsKaNJ2UaFK3x3YA7+GgUe3ycHjm6UOvZEkcTbDAX4T4bkz428GAZRwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830932; c=relaxed/simple;
	bh=GJ+zpiKWWrr5gcwckmi0KaPm/Le64ewG91EClvJYRqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KTfbDLF9vtBWkmEBllHZWwccP42NdBsAGWLomC+pvcg2WnPht9nvcqUOpgwL4k/hk3cDihExbyow6N1d0ilEw9nL9McmCvACOOO5U7FWuwbWLq0EJrm/1xYWqChz69TD9wcZVxYMd16pfSexLYCZs9mwg6KAu20yUXo9YbtLAEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A2keFtow; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A2keFtow"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c2acc1e170cso357234766b.1
        for <sparclinux@vger.kernel.org>; Mon, 12 Oct 2026 11:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791830928; x=1792435728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
        b=A2keFtowjHZkmaH0KA66X7pQz8augvo2WwaY7+ykNZDak6Nd+x2AoSxpEYWQCqPOSe
         M7FFj6Jv2zq090o3J1Ah7fPJhP14voT1WYxVyfHv09DzpsTd7ElT1A+B2A44Pp18UnGP
         1StOmsL1xh83KHoEeaXQnC0DvXELJOsi/m8c9koc6+XL7IpNphhMpDCWn4m3wgAoFa9r
         zJOAcbVjJT839tpzO0pekGLzC0cy6Y3bLpgXn6uZX+JLQG1nT4asDtDQzTbdeAXAXF3I
         G9e1N21WQM0WH2NWRM+MulQtkvOU0y/HQDXqxrRE18xNHWKIS0LOXufssQ/9Ln4qYCMN
         bPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791830928; x=1792435728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=18ailoawq69tzoMJxp6THyIWAF8hC7cZD05rxXZegPs=;
        b=OotZIZMoCX3na0p8AaoYZcdzf23xJpgUn2ZbPxzyMu7teLY1xvwqqzzBeu2qkF0tyD
         wYjrqbi6xPr+pwrve4v5lawFIabJYk1xl2aTmMHk77d1YfRYKO/59+zjyxdKlND0f9cH
         tw43s+F8STF/g3KHt6jkNcorQFQ7GtpH+TbOTQu1PPTWcIH+AZ6P1UGLbW3XT0z1Z3re
         iv4x71pWsPFsm3YEg1w3l22h9e36VE72lzonCFw1Vp5KuEW5fJDaoDkApT3MJEI3bwNy
         DVQuN4U612iJjg9oJDR6ANPATmDY87SoiCBYWosysnF/KK8ssmfayDSJpOgXbGr+v29F
         2zyg==
X-Forwarded-Encrypted: i=1; AKwUvBy0Ypx5H76KJo4SlyMdxBkL34ps9z1pifVBfVtRY6Ct/OIDL4xuU3ZPSyjPkGszC/V4F162r/Z95GiK@vger.kernel.org
X-Gm-Message-State: AFq9FYKXMMjqibuzDkeMeu/9wyWlLj5jrb95OXsnqo5VURTCwsCazEmL
	Imqnua5zub+8IwgafHz4eacEaLAoyJiMmaUb4Ymyr2CgGgf09X2h6YjL
X-Gm-Gg: AYBFou2m20XURwx35RKJUSJSlE4BF5zU6pIEMpOmEOXGei4lQgmd6cgLKgwMTHV8z3f
	I4xVpUeZSAKJhPVOp+uG9sAv+wGWbamMSnUA3fHrWzCG8Jcf/ysmAFSuvJnyLhwAY/5conihhbM
	IW37wmv1DUU/T8wtQH9dFQPFtOfdEfnEyw6M5jruMyBkehXIQ2XBBn5xJt8+3rtoaYEBXeaO5xy
	3hSCYCq1WJstopeUe0+vxyBTXmZuio4EkGvd2LeSzGOZ3FmuscgsXecztSdWhDru2d9CO7NvHkp
	JD/svZ2bzHVQPZ/ujTjxOqliGzS2gEmGl7CaEMi07kyOKi2R/ophQYPlas6jJNG9oL50RT4wKuy
	3KChgpt7XLSH5/jn/Hi+iOW0JI95dSIZwhy0PbYtsIZCC7VKvCdzouz1EUTF9XYeaXDcjRGkFic
	u+/6bj/x71oFAiijUEGaB842OpPDmTzV08rubcYIsLVpeIKT7Bes9AlcmYGIY3H81wMEjadIigX
	uH9MmtZjXq4NDD9h0Iq6tCuqGZVfiwH++uJykes
X-Received: by 2002:a17:907:3e1d:b0:c31:70a5:4c3b with SMTP id a640c23a62f3a-c31a9a2fcccmr1093246466b.3.1791830927588;
        Mon, 12 Oct 2026 11:48:47 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9aa5aa7sm488517666b.55.2026.10.12.11.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 11:48:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/8] sparc64: honor queued spinlock layout in secondary startup
Date: Mon, 12 Oct 2026 20:48:03 +0200
Message-ID: <20261012184826.986050-3-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012184826.986050-1-linmag7@gmail.com>
References: <20261012184826.986050-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The trampoline's ldstub modifies the queue-tail byte of prom_entry_lock,
not its locked byte, because SPARC64 uses big-endian queued spinlocks.
Acquire the word with CASA, release byte three and poll while contended.
Retain the predicted-branch barriers for Spitfire erratum 51.

See qspinlock_types.h for the layout and JPS2 A.10/A.35 for CASA/MEMBAR.

Fixes: 145d97858597 ("arch/sparc: Enable queued spinlock support for SPARC")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/trampoline_64.S | 34 +++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index 51bf1eb92a36..62f404b3079a 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -106,9 +106,19 @@ startup_continue:
 	 * We lock 'num_kernel_image_mappings' consequetive entries.
 	 */
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* Get onto temporary stack which will be in the locked
 	 * kernel image.
@@ -212,7 +222,10 @@ startup_continue:
 	 nop
 
 	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ba,pt		%xcc, after_lock_tlb
 	 nop
@@ -326,9 +339,19 @@ after_lock_tlb:
 	wrpr		%g0, 0, %wstate
 
 	sethi		%hi(prom_entry_lock), %g2
-1:	ldstub		[%g2 + %lo(prom_entry_lock)], %g1
+	/* Big-endian qspinlock: acquire the whole 32-bit value, not byte 0. */
+	or		%g2, %lo(prom_entry_lock), %g2
+1:	lduw		[%g2], %g1
 	brnz,pn		%g1, 1b
 	 nop
+	mov		1, %g1
+	casa		[%g2] ASI_P, %g0, %g1
+	brnz,pn		%g1, 1b
+	 nop
+	/* Spitfire erratum 51: barrier in a predicted-taken delay slot. */
+	ba,pt		%xcc, 2f
+	 membar		#Sync
+2:
 
 	/* As a hack, put &init_thread_union into %g6.
 	 * prom_world() loads from here to restore the %asi
@@ -389,7 +412,10 @@ after_lock_tlb:
 	 add		%sp, (2047 + 128), %o0
 
 3:	sethi		%hi(prom_entry_lock), %g2
-	stb		%g0, [%g2 + %lo(prom_entry_lock)]
+	/* Match membar_safe() for Spitfire erratum 51. */
+	ba,pt		%xcc, 2f
+	 membar		#StoreStore | #LoadStore
+2:	stb		%g0, [%g2 + %lo(prom_entry_lock) + 3]
 
 	ldx		[%l0], %g6
 	ldx		[%g6 + TI_TASK], %g4

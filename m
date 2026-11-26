Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795685490;
	b=Enzpc3dcRBiAsy4Lrji00rG7nM7CxqIzJ7Zit7DnhF6iibkl07e5XkOljYKLqEVW7G4M
	 RHtc0nlP0rNgVvd8iiJToKUtkHRjFVnvTqZ70eOYVeNtWVqZ0m/dD8iTxbKqvOTWGVw72
	 /EiWaTAWJCWtVbEoJWc5sLvZYaF7449nGOVeqn9QZGE2pwSxV7sxarGRo1W58vD0Wfewm
	 XVIX96xUW9Ly5fJo0HeDphxoo9ZdVYZ/depLFHpM0qAOIhzojJhocbx6w/xWBQl4tBmXc
	 a3VtSsjvCtEr2jHkWB+PXcsjzxa+pAO71xb22x+Kh8PvPdFrfv7pgVHCZ8Wg9e0uFTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795685490;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tEF3lWf32TGtz7z26SuXZNu/KAyYjCI+GTjWC6/htvU=;
	b=seCNCOU48hg50f2A7x2FPOMTb03FbByUTW3J7hxHE1fbzJHAlmLloQgvwBvs7nFcaa1H
	 +VKc2pCXlRxVFNG5/Ex37tjQv83R7B0QLY7NIaoE8Av+E+OoZ/S0/wYw8Zv7KDOsKOKVO
	 KnLNk4EzlJs7Nf4zZ9AZ69pjBKiLNIMGi0/Ac9kazegjxsf1Hubd72IJc3UVn0PnFn+V1
	 acVl45K57DKKRG1DFkG78S8XMOud0sfcZI+VKcBvY8do7rifU5lKAXvIcYeTRAeGR/DP9
	 Qyp2oAsnb/TjEy1s47fWJ3qLy9mLejSOaIptXCujmEeDFiSrMcCncUweoo7LdQ0U9bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTfnxS3R;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2890F606A6AB
	for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 09:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2890F606A6AB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTfnxS3R
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c513a854320so231169366b.0
        for <sparclinux@vger.kernel.org>; Thu, 26 Nov 2026 01:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795685488; x=1796290288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tEF3lWf32TGtz7z26SuXZNu/KAyYjCI+GTjWC6/htvU=;
        b=ZTfnxS3RqcyljOoqGUuZmcJzKxU1W1M2D+TJ8SJngsUlVu9lJlpTV/dd1A16PNTHOI
         qw+WwZaAaVDOyNz7AcYUs1yP7pAH782bpynnEyeI+dRiPP9vn9wK0JZPVe1jL3VK5qNV
         bo4US9zxrX4JrGWRRohYuElqe4gra24m0NBMIw3S8lT1mf5UTvsdnDdOSNGHBjwPanyS
         X7k9d5u13F4hvMDN66HfiZQeCnj2KtQdvdo2+/eJgkEnueC9jzKYyMQZylRrie0lT7DC
         0FH9t7wM8Hxwf7HmjlBeVwKpk9U6tlghUmtsD4yc2EfsntQ+Kt1eQ639mX5HHc0bmm/Y
         0cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795685488; x=1796290288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tEF3lWf32TGtz7z26SuXZNu/KAyYjCI+GTjWC6/htvU=;
        b=P7N70uI/czlakzHqA3WtIL8XBYy7wsnycTDERCkzOGHHr93AvoKnIMyCYtEuJ41bwc
         JOIRpU2VaOgPzAreoavhDAdlOgRApVsh8tb70cHlddqyo+gBDPFsmvSqlS/3gt069dSJ
         5d3B0/ejzL2ZifDwlThz3UupAffyLFIyeGjISyVZSBI9ypXEhJe25kqLy6Qd4bahf8IO
         dBdxsNdu5/MXfC8F3jbe2GDG3xx8julhlJHYFKUtgTsElmNnf9GQcsBEr4YpuWMBDmk7
         uwl4ZcOXmdhfLz2eHDxkS8wJ1TWW+TIZYrwtBXu4/8vkQ3aLpZ2T8GaFYTq6+27RhX/1
         2Ung==
X-Forwarded-Encrypted: i=1; AL+hErHgZuO7ix6NrCCpGeP6urZVEFBJ1cJsYV0BwWb9VDbqJW+koDMO1CH8G17a/GqQajh/i6KexIxYf5lX@vger.kernel.org
X-Gm-Message-State: APuU4Z9KJav3DkO0Ym+51KTp8K/YUfzPEvUPvImx1lR96seXmPxw6e++
	DgMsd+bKjnYIE98clFNshVtPeU9fU3mxCY8/GKgG02C+kmSGJAZQ1NlL
X-Gm-Gg: AZFdTZesg829Xh07zOvk6XJcpfEPzdc4CNeFDQjpnYudwvXrxZw5l3UgHYo3vpGMXg5
	rxKwQ5WxtP877QAbr1OBKr2Q1Mm5eHJnAykISRKDM6rHii6eB6no4P+bmYHRM0aE/Mn6VdmIbFn
	14WZo9plpQNLa72NhlvZkb/VlWwEIJ7RL+wvOmUcDuXyChtpu0Trg/sB/gebri2xX43n+oICHqH
	1SBy6CQ3yZeloZM9VuaDkUjAA9FO8zMUxPQcJG6ue+u9g9Uewb+wkrwCIeriIEfmugA29cqJ79k
	IquvUXVDCpB/8xfU73nHKV8xjx4JzadbindtRuepsqk2GGziCzBW1fQXXHWIg6YtW6gdzGw96d6
	z3fCx3+wlxXZ1hC9UNj/wjsrUrpl9K242ubSdyqQQjWYnP0ZjJnuLmKD2p9Ln7m3xeS+NZ316Ib
	ZI8mS/EJ7/xS15YZEFJtrUdp9sk+Wxrn04CenVbEgdmevAEv6ZW0cbSHj7hDU9Er89kunA2Aa31
	jqp2aBw8T+EndjtOvZHFUCKYLsL8BH/Lfn6aj1A8Qy0FT2m9TLNo0OEFdz/IV0rnWeOsC616Qiv
	FYsKUj+Ds4I/hPuZ1nm8WozRGSCEwxRwuDAYg+3iAKB1iT2UJ2kauTYsmTsPEDhctWe2s6I=
X-Received: by 2002:a17:906:f8d2:b0:c50:bf14:8eb1 with SMTP id a640c23a62f3a-c513a84d84emr1305389866b.14.1795685488439;
        Thu, 26 Nov 2026 01:31:28 -0800 (PST)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afdee82sm597090066b.66.2026.11.26.01.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 01:31:28 -0800 (PST)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com
Cc: sam@ravnborg.org,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linmag7@gmail.com
Subject: [PATCH 09/18] sparc32,leon: preserve the Linux IRQ14 vector during startup
Date: Thu, 26 Nov 2026 10:30:14 +0100
Message-ID: <20261126093106.1345825-10-linmag7@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261126093106.1345825-1-linmag7@gmail.com>
References: <20261126093106.1345825-1-linmag7@gmail.com>
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

When LEON uses IRQ14 for IPIs, copying the firmware IRQ14 handler
overwrites Linux's IPI vector, including during secondary CPU startup.
Firmware supplies the IPI level through ipi_num. Legacy AMBA discovery
selects the highest free level below 15, IRQ14 on GR-LEON4-ITX.

Skip the firmware save/copy on every LEON CPU, preserving the linked
and patched Linux vector. Preserve the firmware-vector handling used
by other SPARC implementations.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/kernel/head_32.S | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 97000e9dffd6..6547717aac20 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -148,6 +148,15 @@ already_mapped:
 
 		/* Copy over the Prom's level 14 clock handler. */
 copy_prom_lvl14:
+#ifdef CONFIG_SPARC_LEON
+		/* LEON uses the Linux IRQ14 vector, potentially for IPIs.
+		 * Secondary CPUs also pass here and share the trap table,
+		 * so never replace its vector with the firmware's handler.
+		 */
+		leon_psr_compare %g3
+		be	copy_prom_done
+		 nop
+#endif
 #if 1
 		/* DJHR
 		 * preserve our linked/calculated instructions
-- 
2.43.0


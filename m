Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8756345FFB7
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748675; cv=none; b=WLFQQoiBI23JBLyY6VWFT/TcYNQoSEZvKgXmom8PRN4tpRbxyflQrUKDSvWhMFzbQuA3T1lcF1QSts90iTBlVbHlVhAQssXZORppoJRQUcabypw9cIBU4L4mDtl40fhScmPwWEA8Mq+kTWdwH4fg1OENs4PBrXxl+bz9WefvqV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748675; c=relaxed/simple;
	bh=9F9PqYLol8RYefMryvIE9X8WcFhHN+25KlDi07fHopY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsSAfAEwjbMcKyUvY0U9ZDbiNy5PZSpO2iuK4zUOrtW0w8xHG3nKGlN8POTToK0W5OSpnVhC+4FIpxZqk7x9Y5oAvwMiuzWs4FNjF0LqwG2aGK7A4KEJwZq7h0DvL9hH1lUP6ZOgggW5HND+CMC4muUldC5WPek3WrEa3taN23A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gu6MxJgG; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gu6MxJgG"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c2e7496f947so202071166b.1
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748672; x=1792353472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=gu6MxJgGhJ5fAuNey0baEcOvMpS/TXv1PMlzICuUjfuRcIWwg7oXnNfZbT2TBx+8oH
         zghvz02xttXd3lmZDw/J2j2tb2Tnx09itP7Hx8INrhakLgmg+MhFOXExPokaZo4pBaK/
         gvN+PlzsAbR/5z0JjcZRUb5rFA+UyZI4RbNUfVBHSm/oGlGtSFcJeJIHKjJXamzbj/Xn
         q9FLJMUiYdkWphP+YOUeamzsHFX7Cfd6dWZ2Jm66Ki51kGI5vWpdz/8rom54bV/j70CY
         r1Y674ahs10SCFMtmngXAhDdwDwwPga6G6N/x/8yduQA5bTv+XwAm3zPUPGpYJ2W1FLi
         ChCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748672; x=1792353472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ey4LJMK8RV+MV7vSZrPUmikamurNbFQxbI2le0bK+bM=;
        b=lsYdKRqL2W6Sl5z6utrJG96/GhpomjKR1ZIzJ3LfCiT0gkTZqe1iuYyXrnOnUbWuDT
         HpWIjtc7XM7KomzRSX+oWW+RnUihUY9oG7ZVhov2qE7ZbqQY26uvLDp6hkiMCQxnneqy
         9MZUDDbKDnOkJ3FZxAFoCjntRnVhb5JUFdTZJDx//gDuyYfa6fT8LbwnWdHzbzVKDQ4C
         xVHqk3xBE2d/sGk3CCra0ZW63enys+xkC3F5TWN7QKpxKaZYI0Br9nY1lCx4SR3Ghv+H
         g2qUF3+4N8Gxu4xwI2A3eX3ZH3ued2IEW5MdOUJErVkyeywS6F0fhj2CNX3DD6JZGD7t
         BcTw==
X-Forwarded-Encrypted: i=1; AKwUvBxlzHP0MIMBO0OuNkXoHso8vji5E9+8/FA6lM47HADDzbgHBtY4xqLwT2sUh3Y5ZCO6arRt92EH8TBV@vger.kernel.org
X-Gm-Message-State: AFq9FYKfO1jf5PQbK2/jyp1Cp4IrVYQPqMp7PySwXtpzv2Xujxh3I78l
	mkfu8ImCA/Y8Gc6VNG7bR2SqqO/clVGnmeUNNIjzHtL/e/w9DPpPxzib
X-Gm-Gg: AYBFou1gyADxt0GCIc3VUCbws8ZdvRilZv9f6jmu/VOOJ2rBXzXLEoDiwCCeypeDj2O
	lVoLB4YRlFUMPrKZdBXfJdcVeMKN/g6iiqvRBP9ERbQhuZ8ThnFcjN0wlotQTkQA9ZbbtGkDOSB
	9R+pBWQz7KtKO/M/z1dyKtqfeFIn7Qp5wv3tq/4HjoHfFAaQMysMBaTEEDTkPwi4zhej4yh3Eye
	B4vghfdIJxTef0yIPECMeFE+SC1d+/YnKjSvcYORndbM3/RTicTXSSrEy//rxIH9qCWAM9I+XqR
	rSQ6/XGiItTEQ4ZpYqHvJLUn+fPfmEgq5vbWvj4fHVwZrN8LreknC3qSGYvjJqw2ZwWbshqZCqx
	NpEDN6jsAnfCxXjsQ+qxmdW5Ug3Ivmhvbk16+ItCEdh7YL2UHffPbm6OJuX2sSZgzwXiRw2siHF
	CYtIBqS2TV2qKlu4LYTHc1Ph8SarrgrgjolYrKPLi0BUd8L1x+IIy/e1It9HcWvOnv+YlhXxu4A
	jZ979InH40BCuYNRyNoxkmBY735N95MZzbhpaoi
X-Received: by 2002:a17:907:7fab:b0:c26:1691:b368 with SMTP id a640c23a62f3a-c31a9f6b728mr805802966b.33.1791748671740;
        Sun, 11 Oct 2026 12:57:51 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:50 -0700 (PDT)
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
Subject: [PATCH v2 3/6] sparc64: avoid huge kernel PUD mappings on sun4u
Date: Sun, 11 Oct 2026 21:55:55 +0200
Message-ID: <20261011195729.981243-4-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel PUD refill path merges virtual address bits 32:28 into a
TTE, requiring a hardware page size of at least 256MB. On sun4u,
kern_linear_pte_xor[2] and [3] instead select the 4MB fallback TTE.
Consequently address bits 27:22 are lost when refilling a huge PUD.

Keep the kernel linear mapping at PMD granularity on sun4u. Its refill
path preserves bit 22, as required by the 4MB TTE. Leave the sun4v
mapping selection unchanged.

Fixes: 0dd5b7b09e13 ("sparc64: Fix physical memory management regressions with large max_phys_bits.")
Cc: stable@vger.kernel.org

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/sparc/mm/init_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 103db4683b16..0ae97e616435 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -1696,6 +1696,14 @@ static unsigned long __ref kernel_map_hugepud(unsigned long vstart,
 static bool kernel_can_map_hugepud(unsigned long vstart, unsigned long vend,
 				   bool guard)
 {
+	/*
+	 * The PUD miss path propagates VA bits 32:28, assuming at least
+	 * 256MB hardware pages. Sun4u uses 4MB pages here: retain PMD
+	 * mappings so bits 27:22 are not lost during TLB refill.
+	 */
+	if (tlb_type != hypervisor)
+		return false;
+
 	if (guard && !(vstart & ~PUD_MASK) && (vend - vstart) >= PUD_SIZE)
 		return true;
 
-- 
2.43.0


Received: from mx.itxnorge.no (itx-kvm-14.itxnorge.no [91.189.121.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2695237AE;
	Tue, 29 Sep 2026 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.121.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790689446; cv=none; b=BkqqTxVn98K7zLonEVlVKUOCwrqqLavyH720ckh6LKALYbEokT2KDEwqBKiQ62bD9L2q1IgBt3KqHI8RnBOWdDml0yH0XWAewEQIx/kwR1oEhpQFmYVafNNhB053RDtR0AYt0SeYhfZzSdm1DU19olyUmKL9Z6QAHfAfz4qe7os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790689446; c=relaxed/simple;
	bh=biTdxv5uh5RpdcHGsKu6LKXJxolTlezVqsYDj8JfbxA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pCZTckIU0/oo0McLuFKl5axubUjQsIxtlJagcjly5mxlGz00Iooqb3oN/W+6ihwrJk26RkESXg7dHOHgIIdpeb620EJe1x9bV14+2YJkkhWrJ2pO257oExHyyB+RHUOWQemXSNYQGcmzK/WdXMOOjQ/0sEGNz1SW+Gihl6nPk7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no; spf=pass smtp.mailfrom=itx.no; dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b=JwMwoNtc; arc=none smtp.client-ip=91.189.121.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=itx.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=itx.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=itx.no header.i=@itx.no header.b="JwMwoNtc"
From: Stian Halseth <stian@itx.no>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=itx.no; s=mx.itx.no;
	t=1790689442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CbHEMeGnBGEuY25BHoYPpmffIcMnF1AI43jCvvuHYJM=;
	b=JwMwoNtcmum6rlA8ooQRDZhQk5QpWIGRxs3SQI8QY2WbM7Wm6Hzk09rmq1NklqmjD46Vbr
	HXHo5aL4Q0ekhRXNz++K83cuVxfN6cIS1DjJ0tlXFRRBJPDtRsah7yaVfLFsgLgOWzhPc3
	SzUd9JWM4+ddIcbaGar6QxwzDWC2aO0=
To: "David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stian Halseth <stian@itx.no>
Subject: [PATCH 1/5] sparc64: Report unrecognised machine description hwcap-list entries
Date: Tue, 29 Sep 2026 15:43:49 +0200
Message-ID: <20260929134353.3879030-2-stian@itx.no>
In-Reply-To: <20260929134353.3879030-1-stian@itx.no>
References: <20260929134353.3879030-1-stian@itx.no>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mdesc_cpu_hwcap_list() matches each string in the cpu node's hwcap-list
against hwcaps[] and crypto_hwcaps[]. A string that matches neither is
skipped silently, so firmware can advertise a capability the kernel has
no name for and nothing reports it.

A SPARC T7-1 (M7) emits 28 entries, of which eight match nothing:

    vis3b pause-nsec mwait sparc5 cfr mont xmpmul xmont

Print the ones that are not recognised.

Signed-off-by: Stian Halseth <stian@itx.no>
---
 arch/sparc/kernel/setup_64.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b47..8ed65ad0e6081 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -488,20 +488,28 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 
 	while (len) {
 		int i, plen;
+		bool known = false;
 
 		for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 			unsigned long bit = 1UL << i;
 
 			if (hwcaps[i] && !strcmp(prop, hwcaps[i])) {
 				caps |= bit;
+				known = true;
 				break;
 			}
 		}
 		for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
-			if (!strcmp(prop, crypto_hwcaps[i]))
+			if (!strcmp(prop, crypto_hwcaps[i])) {
 				caps |= HWCAP_SPARC_CRYPTO;
+				known = true;
+			}
 		}
 
+		if (!known)
+			pr_info("CPU CAPS: unknown hwcap-list entry '%s'\n",
+				prop);
+
 		plen = strlen(prop) + 1;
 		prop += plen;
 		len -= plen;
-- 
2.43.0


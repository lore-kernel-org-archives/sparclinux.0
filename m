Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3571031B117
	for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 21:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575151; cv=none; b=RHKdREadtIRC/DRu0I4XcFiVIfyFbQVk2C/L9UYnHMdrSCuAHILmi2ESfUJ7whYNoJBPo5+XQqVGCHboW2WVkOEcv8bsM9F8/1XIFAZrSbbFqzMG3xknoJS3Ud02X8heN/ytTc4elFTdtCvvMlZa6/2hDrV9OMEF4/bBuqI/hdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575151; c=relaxed/simple;
	bh=howp07mlLn+qEQej3a/NiYGqhKW04VB++2fPRYcUvu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T9wwUDnBoWadUl8Pesj8DlqX3pS3fUqbFfO8r2WZqajsogsBcyJuc3w6qelZXdqj7EIm247pfnpoNOr4KeksWTzFiXmOZT3VNkaONF1S6pCgkx674LQ2iaGEU0kJuKrj2Ya34n+CtbFthNYlY/OPkZ76ulOjcL3pqrVixbINjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O9hc1/TA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O9hc1/TA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6RrF40MuIbGZRYz945fM3hN2TfePtR6BtCkXGa/wsqQ=;
	b=O9hc1/TAWbsWX/2tJAjigBQ0xRwZD9fNIzcKhwKnaLYa9HH0q1Th/pBigJaEyRJKZ/yWAn
	NM3xxLtxUuiDNKV5N1K+BpoJCETcr/rp+Wyh8VEyhp0ilP/ges9/7hX0oCbJIKl60XqPtD
	obZ9w7mZK6wY2ggpIOMXSI9bxi0nsyE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] sparc64: Replace deprecated strcpy with strscpy in build_path_component
Date: Mon, 22 Sep 2025 23:03:56 +0200
Message-ID: <20250922210408.1723452-7-thorsten.blum@linux.dev>
In-Reply-To: <20250922210408.1723452-1-thorsten.blum@linux.dev>
References: <20250922210408.1723452-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/prom_64.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/prom_64.c b/arch/sparc/kernel/prom_64.c
index ba82884cb92a..aa4799cbb9c1 100644
--- a/arch/sparc/kernel/prom_64.c
+++ b/arch/sparc/kernel/prom_64.c
@@ -361,14 +361,16 @@ char * __init build_path_component(struct device_node *dp)
 {
 	const char *name = of_get_property(dp, "name", NULL);
 	char tmp_buf[64], *n;
+	size_t n_sz;
 
 	tmp_buf[0] = '\0';
 	__build_path_component(dp, tmp_buf);
 	if (tmp_buf[0] == '\0')
-		strcpy(tmp_buf, name);
+		strscpy(tmp_buf, name);
 
-	n = prom_early_alloc(strlen(tmp_buf) + 1);
-	strcpy(n, tmp_buf);
+	n_sz = strlen(tmp_buf) + 1;
+	n = prom_early_alloc(n_sz);
+	strscpy(n, tmp_buf, n_sz);
 
 	return n;
 }
-- 
2.51.0


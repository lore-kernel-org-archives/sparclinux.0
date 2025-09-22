Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59727B343
	for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 21:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575140; cv=none; b=p9k+m2yFkUmzrOu2hdc4IJQJGScvda96VLM6HnQkFdALsGodBl/8apF9jy01c7R+7lTzv11Nt+Zqre9IMNDEe8Vv0s2pg0uQLr2sLbWudmSD2rVZWcbClvRrqTworI3rtbhxmblaNMnu+p7vK0PL7P92IeEkQrKkVZUxvqs8RA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575140; c=relaxed/simple;
	bh=rwLqPxmOBruycRjBQ9i1fCOtBWlJI0v0bWB3fUOU5/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mp+wnTu3ev7XceWkq1kQwyB20FDCOHemY2Yo1Tn4RYdtRl3R5Dr3JeC68vY+kQvXSyIiYPuVPYD2FArPhoMRAa8bu2S1TByiTkR0BneFthJ1DWWsm+KMhWAvvaCq6jO2kZvUt5OASKay/lvReb75W+FPV/d/Lptbd/ryVpw68ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F89G2gDk; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F89G2gDk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8XwWsws5dYIHiCnlZKvcgGQqxLqmlp0j+/eNhlPV+68=;
	b=F89G2gDkkFU+nV0Zb/z9LBP+wBy7w8chM8MC0DhNZWs7ejAoG5MV9VN4MOE9QYtYMBYYZN
	9rh8DcBomKbE69EGDnKISTIWDy/la1/IJQ4OtuoMwZx1IU0o5wLsxPLSfOad69XuT1mKXy
	8thCQADhukI0YK6S5lDwB8VP6S4iO3M=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] sparc: Replace deprecated strcpy with strscpy in prom_nextprop
Date: Mon, 22 Sep 2025 23:03:53 +0200
Message-ID: <20250922210408.1723452-4-thorsten.blum@linux.dev>
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
 arch/sparc/prom/tree_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 88793e5b0ab5..7388339bbd7e 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -272,7 +272,7 @@ char *prom_nextprop(phandle node, const char *oprop, char *buffer)
 		return buffer;
 	}
 	if (oprop == buffer) {
-		strcpy (buf, oprop);
+		strscpy(buf, oprop);
 		oprop = buf;
 	}
 
-- 
2.51.0


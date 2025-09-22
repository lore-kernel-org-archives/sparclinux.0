Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7590286413
	for <sparclinux@vger.kernel.org>; Mon, 22 Sep 2025 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758575143; cv=none; b=XGBMlMf5GDl0fwk7eDz2Xdg0uzgCm6mQs18jlVzFIqTBMr6avqJIkRXlLcMG1Jpgi9tPXDj5CgGEEXcwhxcUxNPRYDIxKGm2eMXWsCeMOccqhlRYpzcEmY7UHWHGp3ERsH5qUyvYrLYpLjGn5aw9HOVEMa+eop7tWLeAJVeU7fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758575143; c=relaxed/simple;
	bh=LtvaeOCXxLIS6jLl/VPm/pQI1+J5WDA6XMmRLUELPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VKcfX4vSOBkelmRHskpn5/Zu8NgUUqL4bUdJIP49k0biQyM3GpWA9cy0tbkJpcfSSyV7HLTUfItZz5Gn9oD4/206B2CMPAefUgxN4x/4aUQNQpqfObgKiz1AYWSPqWk5kRJmSPjqcn3sJb3sifjUfKKV81KDD4c0D8ErnM3mL/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Kgk1vISb; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Kgk1vISb"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758575138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CS1nVcM/7Pabq7qkTGNA56dWIxSoVNkOYZkqb/PSQyA=;
	b=Kgk1vISbxVCEiZigxUrtRwDozS2qxJgDw3l0HvZhq13iv0Ut+mHvWMDmF2jTYa0f1Rr+xz
	RuUvLSCWY4R+clVK5meQGSX38ayq9DDMyY8Jab4Vpj1l5izuJ/SZXtLOF+vXeFticTnfgF
	o4y4RWcV9fSE1EusqHQ/JDLRXpWiwDY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] sparc: Replace deprecated strcpy with strscpy
Date: Mon, 22 Sep 2025 23:03:54 +0200
Message-ID: <20250922210408.1723452-5-thorsten.blum@linux.dev>
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

In ldom_set_var(), use pr_err() instead of printk(KERN_ERR) to silence a
checkpatch warning.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/ds.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index ffdc15588ac2..f7fc6f2af2f2 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -781,14 +781,17 @@ void ldom_set_var(const char *var, const char *value)
 		} pkt;
 		char  *base, *p;
 		int msg_len, loops;
+		size_t var_len, value_len;
 
-		if (strlen(var) + strlen(value) + 2 >
-		    sizeof(pkt) - sizeof(pkt.header)) {
-			printk(KERN_ERR PFX
-				"contents length: %zu, which more than max: %lu,"
-				"so could not set (%s) variable to (%s).\n",
-				strlen(var) + strlen(value) + 2,
-				sizeof(pkt) - sizeof(pkt.header), var, value);
+		var_len = strlen(var) + 1;
+		value_len = strlen(value) + 1;
+
+		if (var_len + value_len > sizeof(pkt) - sizeof(pkt.header)) {
+			pr_err(PFX
+			       "contents length: %zu, which more than max: %lu,"
+			       "so could not set (%s) variable to (%s).\n",
+			       var_len + value_len,
+			       sizeof(pkt) - sizeof(pkt.header), var, value);
 			return;
 		}
 
@@ -797,10 +800,10 @@ void ldom_set_var(const char *var, const char *value)
 		pkt.header.data.handle = cp->handle;
 		pkt.header.msg.hdr.type = DS_VAR_SET_REQ;
 		base = p = &pkt.header.msg.name_and_value[0];
-		strcpy(p, var);
-		p += strlen(var) + 1;
-		strcpy(p, value);
-		p += strlen(value) + 1;
+		strscpy(p, var, var_len);
+		p += var_len;
+		strscpy(p, value, value_len);
+		p += value_len;
 
 		msg_len = (sizeof(struct ds_data) +
 			   sizeof(struct ds_var_set_msg) +
@@ -910,7 +913,7 @@ static int register_services(struct ds_info *dp)
 		pbuf.req.handle = cp->handle;
 		pbuf.req.major = 1;
 		pbuf.req.minor = 0;
-		strcpy(pbuf.id_buf, cp->service_id);
+		strscpy(pbuf.id_buf, cp->service_id);
 
 		err = __ds_send(lp, &pbuf, msg_len);
 		if (err > 0)
-- 
2.51.0


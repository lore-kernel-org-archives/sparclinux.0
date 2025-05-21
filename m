Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F4231A37
	for <sparclinux@vger.kernel.org>; Wed, 21 May 2025 12:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747830203; cv=none; b=fhjjS7YrdBg4LpjQjfP+ufZbZDyok9BmplSHR2fDQ4a/VvgY5zec9GJSQD7D3bElyuujfKgKogqqRITd+BMXZOz/gfacanDPOYneQ7yACatwgfA4ZjfDMLKseD+ojz12xgVigKBkT6lf3tpuTSNrE0M57xOMpKJy0PmgV+zV8e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747830203; c=relaxed/simple;
	bh=W1L0rO9dU5FFbVfVjwNW8A9US4mbKUKOKfUDHJkMAKI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NXrtJ5EpBFMTY/lUHFvc07oeH5N3WI5i68WS0XYKY60I4fUn8dsmqDUdwkotG/J3wZnCvDFqAr89wQc+/DEtN5A3LsCUpTasJQWOShhu0YDC7gO/6si/tblkOWWvCsub6WUgW+Tt2lNZi4b2F40yeTMArdqzTwYAtlRp2QEvpRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ooQn++bP; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ooQn++bP"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1747830198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=T2eXgg8AokEwULeJHXyxGHKldGhr0QHsHsoPutM/BV0=;
	b=ooQn++bPClfXm4wvAOlsc1JAliEGzwEn2Pw692y9OXRvlx/UUfv6/CXxROCxKmGr9PDvSh
	PUPfY3GJgOuUaHaVr4TA2y8P+XOT0dVh3pmSjSwNl9n2IIvCJGjxOyDWME2pt9MSl2KHX8
	UySi16bBehPgZJMDc+uaLks/BIlus5g=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND] sbus: envctrl: Fix typo in comment
Date: Wed, 21 May 2025 14:22:55 +0200
Message-ID: <20250521122258.6128-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

s/disinguish/distinguish/

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/sbus/char/envctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index 81918aa67109..69e49da93b8b 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -734,7 +734,7 @@ static void envctrl_set_mon(struct i2c_child_t *pchild,
 {
 	/* Firmware only has temperature type.  It does not distinguish
 	 * different kinds of temperatures.  We use channel description
-	 * to disinguish them.
+	 * to distinguish them.
 	 */
 	if (!(strcmp(chnl_desc,"temp,cpu")) ||
 	    !(strcmp(chnl_desc,"temp,cpu0")) ||
-- 
2.49.0


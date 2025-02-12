Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA8D1E500C
	for <sparclinux@vger.kernel.org>; Wed, 12 Feb 2025 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739356010; cv=none; b=qo8RwCKG19gT8CaLeUw8OXUgzJvUXcCQ/e5duzgF0+D0Trp11M2MleuPb1pmWKQWGy5u72WVDR2kyS/VLYt+HnJzKzQHwoa05F7qUyQImkYJ1tm7R65wJYV3kIYni6zoirS57L9sJ+kCWA2zKMKTNFi0pzMFd6DI8MUZkMb456M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739356010; c=relaxed/simple;
	bh=oi7lV/lrHT+EHF4OxEPCf+t4jtrbHvMpeUS9/w8MW9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lpkWePLmxyCmfgWA/6JzbtW+0tTJemlI14jO46/66i7biOVadkTqY7vSCIP7WdO6odgkhg7zEIpuq/OpfhAo3wsOkXTFV2FrCBbdfLwXBb4yipk5Wsu+NcBJIJJuBvuTGA56OMV8BKeG89ZIMqZgeLV9G75NxazcDGppB7m8s/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UlozL8XL; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UlozL8XL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739356005;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hR+XlzJzGTiqSgbWiAdN0TiNYvqq5BOnYBxudITTpnY=;
	b=UlozL8XL8bSRS0HEYxRsipM/hOx93t2pPf9FkFvd11a+LhwTy44t19ZnmimY8TQKY2SNo8
	Y54nSQJ+1FZfAcEIG9YQea8ac8mfRkSzhNYiyM9Rs6JZ0A/8uSTSbNl5rIcgvDvvSKeOWk
	A+bsl/1hXiYBpIKd1MBbwQb1jAiQ+Ek=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sbus: envctrl: Fix typo in comment
Date: Wed, 12 Feb 2025 11:26:17 +0100
Message-ID: <20250212102621.2741-1-thorsten.blum@linux.dev>
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
2.48.1


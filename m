Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086A518FA0F;
	Wed, 10 Jul 2024 09:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604526; cv=none; b=FDcF+KfYd/8GGI7+iaB2J8VkFjjxUSxgntah/1ONVb1FTEJxIHxlIcWtnj/31MU/oIMEzypmJivnyutQGyMnxbmlKhIEqc7AQm3xzlJ7SXWEqXOW3/0rt5VxHn6u8AcbU0XysY1fdrwVRXngv2mQQoGJh5xyRH2+IqjPHYS1phk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604526; c=relaxed/simple;
	bh=mFJu3AuQwBhYu6nvYHmXFe8W3vkUUK1zringR+EoIf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KsAsjNovXnI/wNeNilybaGnZsXIDDMu1UrpaHYBGo80Cs5TArtQkHVipn0XR10wOn+ztZfDvo5X6+uIVIGqvPy7TeJpeTZ5iSPpfkJZrMfbvkDKQBlM84d8z3mGvml4jX+sw0CYvZI7bEbyJzXleYec4CuGeaYbO+hq7nMp+TZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=S3Q35DX5; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="S3Q35DX5"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WJtDT3mTfz1DPkb;
	Wed, 10 Jul 2024 11:42:01 +0200 (CEST)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4WJtDT1gsPz1DPks;
	Wed, 10 Jul 2024 11:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720604521;
	bh=JmftKPWxL9NkSuMkpkySeuAYiQ7NRqf/1r5N/kj6mYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S3Q35DX5rS1BXnVgEVE4/WB5zVvohltKTwzz38IeMNQG6iyNmXExdfn7w9aiy+SCb
	 Ajd5dxrjFihYpo8tDpZHJ7YjmNQf/hAX0G4ZQ4BtEq/dGVbcI+eOp94piZ3KnXaFml
	 A5gFqSP6vbCJ7xc9qbrKX/Ug7DCDG6ySnEqqNNSk=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] sparc64: Fix prototype warning for prom_get_mmu_ihandle
Date: Wed, 10 Jul 2024 11:41:54 +0200
Message-Id: <20240710094155.458731-4-andreas@gaisler.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710094155.458731-1-andreas@gaisler.com>
References: <20240710094155.458731-1-andreas@gaisler.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for ‘prom_get_mmu_ihandle’

The function prom_get_mmu_ihandle has no users outside of misc_64.c so
declare it static.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/prom/misc_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index aed94cd4a1e73..3792736ff21fd 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -162,7 +162,7 @@ unsigned char prom_get_idprom(char *idbuf, int num_bytes)
 	return 0xff;
 }
 
-int prom_get_mmu_ihandle(void)
+static int prom_get_mmu_ihandle(void)
 {
 	phandle node;
 	int ret;
-- 
2.34.1


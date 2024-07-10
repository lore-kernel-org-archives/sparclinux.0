Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E8B18FA14;
	Wed, 10 Jul 2024 09:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720604525; cv=none; b=YAxGacjTziZGMcc4etngTWbwDWkdzpnzTQ7ZjsZ9mPgOzZFlsFv69U9cYdJ/tebIgwJcZBGp/bVu5q68gjS+3+UJI+Zuj0cUu6f3eN8MG2448GoP89DQMZJii5wYJdyiCPQZ+tqtF9QKBdDgxwlw6j6z+VRnhrBy7P2B2mxrIvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720604525; c=relaxed/simple;
	bh=F09pGXI36gTc54xO6rR55cxg708answbdVUpxYTieXM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kegXGpb5RVUmqtoFxEp6cBTf9MVgJcqXqdcbUHtKM0Yi+DittFvgVFNMlMoXu243NwkbM+xAuHIL1tsjEVqb+poyD457nyIpnFIAVlHi6Btjt6zySQELyxfd4CD0hnyCQ0Xc607Ic48OYYIYVuLfurKpLEaWlwdq2tYubV3Y0a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=UmnX5lmT; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="UmnX5lmT"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4WJtDT6944z1DPkh;
	Wed, 10 Jul 2024 11:42:01 +0200 (CEST)
Received: from andreas.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4WJtDT3bjgz1DPkC;
	Wed, 10 Jul 2024 11:42:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1720604521;
	bh=a+ls+m7uo39S1xs1SfdgV4y0qwjJ1vBlTRzPr3sdHZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UmnX5lmTyQpYLdiu6IU9+qTo5B2FuuF5f9P/dbGIKkGs0wmeXwAFWqjBuIrTQK5oJ
	 BGXowgm7FxiPoOtRAcr1IgqkHj+mwZzPD+CJUDvFQZpBbytK+2bDJv3Av7n+nfH8bj
	 LAB73dTZabjzHNgs1SUIWTWnEhHZUW0OBiTzS0/s=
From: Andreas Larsson <andreas@gaisler.com>
To: David Miller <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] sparc64: Fix prototype warnings in hibernate.c
Date: Wed, 10 Jul 2024 11:41:55 +0200
Message-Id: <20240710094155.458731-5-andreas@gaisler.com>
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

Fix the following warnings:
arch/sparc/power/hibernate.c:22:5: warning: no previous prototype for ‘pfn_is_nosave’
arch/sparc/power/hibernate.c:30:6: warning: no previous prototype for ‘save_processor_state’
arch/sparc/power/hibernate.c:35:6: warning: no previous prototype for ‘restore_processor_state’

The prototypes are available from linux/suspend.h so include that.

Signed-off-by: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/power/hibernate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/power/hibernate.c b/arch/sparc/power/hibernate.c
index 47b06f4af1f91..da8e2bc2e516a 100644
--- a/arch/sparc/power/hibernate.c
+++ b/arch/sparc/power/hibernate.c
@@ -5,6 +5,7 @@
  * Copyright (C) 2013 Kirill V Tkhai (tkhai@yandex.ru)
  */
 
+#include <linux/suspend.h>
 #include <linux/mm.h>
 
 #include <asm/hibernate.h>
-- 
2.34.1


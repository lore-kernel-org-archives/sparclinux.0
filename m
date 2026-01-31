Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99836AB79
	for <sparclinux@vger.kernel.org>; Sat, 31 Jan 2026 22:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769899506; cv=none; b=SONrZoJ0dZXXovvF2czWrh8ufnkGXCQxdEdChhiIH0YIwEk4oB/d28eM9uoqKN4hBJCTQN6RvQAqCE9rrjSTYihjO3iEt32OyAUHESqgZX/Du1fV+YHL7FwCIaJ2wE/FSIHHDZ0XhH0GgPICZAHXmILg2PrTEExHdZr998Az1G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769899506; c=relaxed/simple;
	bh=vj9KzDQ8pbEmM59VbkkSTwe/l9ZYsPVdEfuACv7077U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fARaRXVoCfPq+8PJlNgRC3vK3M697uX1uWXmtZOP7NgUfN8pMAhm2TEj/ltdJoDd1T/H084xBtw/h8+rscOOoX7V0kRq1nqM+YHIsGdGwWdvZpwuh/3Bh9gbvQL/SJ7ZKLnECRxL+0jR79D4xeQSY7RAWzrn/9MJSj5mYFyZHvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NALdNRVY; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NALdNRVY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769899492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SM87LpUC+3IR2vTANL07qz7fL7oEl904Az/N3IIT/eY=;
	b=NALdNRVYBvVli+daj7X6NNDMtk6QIuifFk43V7wboDdJvz4S6O+0Fxrovy6Uvg3ZIvgpSf
	7wWnFt3EY+Prlq8t6x2TiDkKB6l2crmjD+ZEz4zqfirO7paPmqxeQVdEd8YjJWJtEMg4f+
	Kg8nRt9qHwnchc/pLtmQGpOM7G0kUuY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sparc: vio: Replace snprintf with strscpy in vio_create_one
Date: Sat, 31 Jan 2026 23:44:11 +0100
Message-ID: <20260131224413.559324-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/sparc/kernel/vio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 1a1a9d6b8f2e..8c7dd72ef334 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -12,6 +12,7 @@
 
 #include <linux/kernel.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/irq.h>
 #include <linux/export.h>
 #include <linux/init.h>
@@ -378,8 +379,7 @@ static struct vio_dev *vio_create_one(struct mdesc_handle *hp, u64 mp,
 	 * the parent doesn't require the MD node info.
 	 */
 	if (node_name != NULL) {
-		(void) snprintf(vdev->node_name, VIO_MAX_NAME_LEN, "%s",
-				node_name);
+		strscpy(vdev->node_name, node_name);
 
 		err = mdesc_get_node_info(hp, mp, node_name,
 					  &vdev->md_node_info);
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7013C1F41;
	Fri, 31 Jul 2026 08:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485741; cv=none; b=Qsk7gdV7KHnkrxgpS+ddtNdMVC5j6f+TOwMcSPRBJjtBh3qoHKhK+hPf9m0yYEYdJ8Qcv1cdIokHu8Yxr8xgtwQG6YvkfVCDroSYwzL4dp0q+IP1JbU6VPq3BIpOuDsSbOMPF8wEB7tTWJUrUwEHrT3m9OlqlbQy1Ty/+2OPYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485741; c=relaxed/simple;
	bh=flpHljxSDlM6FiFUOGalQHThagM8liAXe0uLMZuHEJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5uA2qeo7BYHBXW/lRf5UFdkM3WOxsxSNvM7XefAI7cNXDO8bZ79NGpZxROJsEDKPLqmE6ZyJOBMId9OshmrF+0vzIooT2QqMkc4W7lgJkQ3/tvOsvV3aDZvXvtmleBMUrqIK+FT5lHgNJUzqGZBxTYM+L2vx9pAeticHbHdV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BE/MMlAR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BE/MMlAR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08B11F00A3A;
	Fri, 31 Jul 2026 08:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485735;
	bh=2ftHmK8g7nafyB0jkOSG6fQpcxsvFWE4K+g+CwBWgOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BE/MMlARCAMZGXjkXb4aSCXA2s7RVYzMIa33Z5TTio+BprsaPh5fAxpWbNm0hu1Ts
	 9nMN8fTMlTeBglG9IbGcx+QHNvQK1pnK6+SVgM9X255yWzBhjGhJA2xeJlL9XYB4U3
	 qIwRgXV3vbtrgud5juGunIYgD+/Xi6++/lIzBCsY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 10:15:17 +0200
Subject: [PATCH 1/2] tty: vcc: zero-initialize control packet in
 vcc_send_ctl()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-aisle-tty-vcc-v1-1-962e18beb8a8@linuxfoundation.org>
References: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
In-Reply-To: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Joshua Rogers <linux@joshua.hu>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=851;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=bq8fgDTT1FUjR57jXPgAKYoZ5dEnL8YK8TP0HoDJE/U=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5kdOmvl/77o7AjwgRv8Rtj9XLkuM2bRPRkVrIyvx53
 QOtpOllHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjARI36GBRfeHtbp8p9nNtNT
 eNIUR8EPfWbpOgxzONtXVt2/utfh6XfjtniGZYm3TS7IAwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

The stack-allocated struct vio_vcc pkt was partially initialized,
leaving the tag.stype_env field uninitialized before being sent via
ldc_write(), potentially leaking kernel stack data to the LDC peer.

Assisted-by: AISLE:Snapshot
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vcc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 27a55465bf5e..3947bd2b75ac 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -492,7 +492,7 @@ static ssize_t domain_show(struct device *dev,
 
 static int vcc_send_ctl(struct vcc_port *port, int ctl)
 {
-	struct vio_vcc pkt;
+	struct vio_vcc pkt = {};
 	int rv;
 
 	pkt.tag.type = VIO_TYPE_CTRL;

-- 
2.55.0


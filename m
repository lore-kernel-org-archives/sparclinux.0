Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F222DEA7B;
	Mon,  3 Aug 2026 14:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766280; cv=none; b=l4NLBX0ASpHCnpc/u2GVZpwu2+Qwq7wiQkQDd+0pzjDI32uC56kXpKVOtPethfywNXYdURSIbwAcaa+YMK8QD4RFmL87aJkYDfceqy3q6Y6UnFJmpi0LhgMyNbZxpW1F3hwQ6qagYJ36E+aPShh7rSBri1NMXTGR+K2H9Vqq3BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766280; c=relaxed/simple;
	bh=flpHljxSDlM6FiFUOGalQHThagM8liAXe0uLMZuHEJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LVdYp+0DGAU9CT0RGhy9OK/6PJjhrhxVV6Jxy8XXFQnmFJgyeute3DUR7TlzYhIh0rR7b+/8OOsgfWcMKa3vDqvWhMqIvB8KBNKHA3zh5NoWDA4AUnw/A/g0gLpWupx3iXLkB2jWal8p9tqb7s31r9sG2k2KCWLmwu1uKZvGX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XYffHzt4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XYffHzt4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C234E1F000E9;
	Mon,  3 Aug 2026 14:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785766279;
	bh=2ftHmK8g7nafyB0jkOSG6fQpcxsvFWE4K+g+CwBWgOU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XYffHzt4GGGT7fayKgw6SnzgXaxEk719NJ3Y767fqYNMvMxDZ+fHqfvmndSwU8yb3
	 Av7EYufZ5itqfaICvS+y8a/Ff6t9qIZXXKXH93sAtv3ZQ152AiNkIPu27VSZWeL+MG
	 CYip289SRkojM+yUvleOgLXFx/hXdeGGS8kTfS0Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 03 Aug 2026 16:10:54 +0200
Subject: [PATCH v2 1/2] tty: vcc: zero-initialize control packet in
 vcc_send_ctl()
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-aisle-tty-vcc-v2-1-a50bc9b15193@linuxfoundation.org>
References: <20260803-aisle-tty-vcc-v2-0-a50bc9b15193@linuxfoundation.org>
In-Reply-To: <20260803-aisle-tty-vcc-v2-0-a50bc9b15193@linuxfoundation.org>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Joshua Rogers <linux@joshua.hu>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=851;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=bq8fgDTT1FUjR57jXPgAKYoZ5dEnL8YK8TP0HoDJE/U=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFkFC0vc2vVOTzzqaMWTqvvtqm5dsHvyPTu5Wq2D39pFq
 5jq+9Z2xLIwCDIxyIopsnzZxnN0f8UhRS9D29Mwc1iZQIYwcHEKwET+SjDMz12Ro5g29ejyn8GM
 02+71dz1WSDRwzA/fnKsuNdBG8HV5i9YSiULhPb/3jkVAA==
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


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA5A212B1F;
	Thu, 20 Feb 2025 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050211; cv=none; b=BibDw9QCkduzOiVajUUhtcFSj3gIQKR0sIwxaDN23iZiCSXDeJCwRuImo1JTL2ALfGl7NFf/B+rLI8WMk6cvKayXhvOewQ+oLVcSskfJhhd8Ws401RYkqMJPkeTycN6kE92aWPq9qpMXwGPSJ8WgFSiDIFTvjX8AZWQU14TXsV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050211; c=relaxed/simple;
	bh=nZIkuJjMtnyrI9ew1aqrnJpKE9/wdKdxSn4kFieyw2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1UhE7kDcYQLTnm+7gbPU/qY6FsrfTdQOLgz8/FypPopHv6jMmOozkj5XaogzDqi2JTaaMJGK86/pT705BMWfd57PL1O7XQMTh/5GSHgimmv5pXICZm6k6YB4PTV/tb6DPCLe7PHwVsyO0XuhROMX1H6LSqlaRD9J+ZgmJNsVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgQ/lWkG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgQ/lWkG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 356C3C4CEE3;
	Thu, 20 Feb 2025 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740050211;
	bh=nZIkuJjMtnyrI9ew1aqrnJpKE9/wdKdxSn4kFieyw2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VgQ/lWkG9sGpiuSDUa3pXetNFATsu9YPLjw/2n3/XmGguMe6CLUr3L/fKDTvWvGMY
	 yO4ltLQy5OeltFDudR9z3wmQI+fPCEGqJyieyFm1YhjjGS9taegzyDoDe/4t3BJvYZ
	 qLN4GEuYAuqYFb937mMt7q/OopIQvZVYIXB+RJ30fKctMoFVt7xGY/QVihU/6OR4Qt
	 pvGS/LgNl2Cq6bPOYKtByz6n0Fpr9P8mwjnB7zbDIxHNYw+gq3w84f6y4sL8NAZw8P
	 921l+qaPrJNn7o95ABm09dSpOCU525WMx4IPd0icHMEkVbtT18JdngoEcC2ZoGzPUI
	 Ey4EnaV1VRkQQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [PATCH 23/29] tty: sunsu: remove unused serial_icr_read()
Date: Thu, 20 Feb 2025 12:16:00 +0100
Message-ID: <20250220111606.138045-24-jirislaby@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220111606.138045-1-jirislaby@kernel.org>
References: <20250220111606.138045-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is commented and never used.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/serial/sunsu.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 2dc68b3201a4..383141fe7ba0 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -159,20 +159,6 @@ static void serial_icr_write(struct uart_sunsu_port *up, int offset, int value)
 	serial_out(up, UART_ICR, value);
 }
 
-#if 0 /* Unused currently */
-static unsigned int serial_icr_read(struct uart_sunsu_port *up, int offset)
-{
-	unsigned int value;
-
-	serial_icr_write(up, UART_ACR, up->acr | UART_ACR_ICRRD);
-	serial_out(up, UART_SCR, offset);
-	value = serial_in(up, UART_ICR);
-	serial_icr_write(up, UART_ACR, up->acr);
-
-	return value;
-}
-#endif
-
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
-- 
2.48.1


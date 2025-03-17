Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37322D4F6;
	Mon, 17 Mar 2025 07:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742194890; cv=none; b=QvGU8X0oTqWM2sCeH3OKNancm2ASZYb61uFf5Zz/c16qHGiD0B9VwgLBvdIX9K/V5lQEL6LTAhvTwhDGUdwo6YYGAfly/HlY7iXiD7RJLtkoZai5rlWah8D9jB1pq8boBnCaZKysc3N/pC6vvaBXzaxqz7Vn2DHuILVf/8U68VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742194890; c=relaxed/simple;
	bh=HrxMMX96ZRTa4wo+i3IcrhvmJQTlSR2eUo1YODDfeN0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fn01DtvBatquCGcfwq1cRUmbZ4KJYYIy5VlFgWHdnIdvRUowhI62OXArxOs8d1hIWT/P6Z3z9OhgT1TaoxxOpiBrSJ/jsK40NNp3U1xIWc+9oHFicSV/VRxENqn9G4knTGyZ/26EcgnyeYtlipS+C/SVHHpVCoSw/xDBCMC7SK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOSDBXFZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOSDBXFZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952E6C4CEF2;
	Mon, 17 Mar 2025 07:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742194890;
	bh=HrxMMX96ZRTa4wo+i3IcrhvmJQTlSR2eUo1YODDfeN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LOSDBXFZ76MVEVMrv7QouOG/Y7ClG8+4SNTregw5s694lmt8JvJQcy48GL69UtKeH
	 DyGEImpxorygeTyKUpGdmLJLaA7ax4qqeXz0tlRuprTYX06v5+b7bnShnolbJIlL9g
	 bvFWOokoNLshk4bC2nRAj7gWGRS45RNTZ26/9qVhk5IiAOcuMNBHmzUXCeXzJRrdep
	 rii7qFz+RFMlOypYq+YkXN04VyzD+aOSUvRwH1IAstDflNKI87ZTjKYTvqjTrFuSWc
	 edX3I+UL6oGmxm4OgVLFve25yqkS4vLaXDLiV9hpq0q0rdRyG1MZluOPv5BWWTQmqM
	 37x2BRvnRH5ag==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 24/31] tty: sunsu: remove unused serial_icr_read()
Date: Mon, 17 Mar 2025 08:00:39 +0100
Message-ID: <20250317070046.24386-25-jirislaby@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317070046.24386-1-jirislaby@kernel.org>
References: <20250317070046.24386-1-jirislaby@kernel.org>
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
2.49.0


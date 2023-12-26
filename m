Received: from mailrelay4-1.pub.mailoutpod2-cph3.one.com (mailrelay4-1.pub.mailoutpod2-cph3.one.com [46.30.211.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3764E603
	for <sparclinux@vger.kernel.org>; Tue, 26 Dec 2023 12:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ravnborg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="zFMpPmf/";
	dkim=permerror (0-bit key) header.d=ravnborg.org header.i=@ravnborg.org header.b="I4yeLQQ5"
X-HalOne-ID: 8d306bbe-a3e8-11ee-bca2-2dc64a403fa2
Received: from mailrelay3.pub.mailoutpod3-cph3.one.com (unknown [104.37.34.40])
	by mailrelay4 (Halon) with ESMTPS
	id 8d306bbe-a3e8-11ee-bca2-2dc64a403fa2;
	Tue, 26 Dec 2023 12:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=rsa2;
	h=content-type:mime-version:message-id:subject:cc:to:from:date:from;
	bh=MbQcNc9JvXsQ+yjx2TrqKUQ/vQcx03BWjjGJcW0+TPo=;
	b=zFMpPmf/xLsNHMc4hKa88/rR0scLpkJiWt/MHdnLfsGJ7jdZvASjYs4KXMpHlfRuHy+FL0IGTHhiF
	 MV3Q0DPMQgEhTGkFmu6Wubs4GtPZCKlKtb5JfOzbtIKhYmaazM192jUtkpuz8oJRa/cKS/rNEUdCam
	 QW1onMwCH7/hLYH9stQgQDmkJgrGXLbrfARYmBe0eC4aKmxXFwPRoifpyAo9lKyzkTBxS+l7O4J3Ly
	 Gw8sH+kvY8hWPbSfNRYTh5BxeNTwV8s/6gOpzfCuky6viFzP4s6VkRsVkbMb/Cr+ed6K/ZlA1XbOyG
	 I4JzNmPXDBNP8aYYfv434VFXFMgabng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
	d=ravnborg.org; s=ed2;
	h=content-type:mime-version:message-id:subject:cc:to:from:date:from;
	bh=MbQcNc9JvXsQ+yjx2TrqKUQ/vQcx03BWjjGJcW0+TPo=;
	b=I4yeLQQ5znSs5S/RPuVmE2hxPDEE0D2nviuFY/Sk+c+Fq3syKu0WMkuaUar7UKlF9i6oF5OeKzS4V
	 VP2J9ByBw==
X-HalOne-ID: 8b56b3d1-a3e8-11ee-8834-85e425223685
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
	by mailrelay3 (Halon) with ESMTPSA
	id 8b56b3d1-a3e8-11ee-8834-85e425223685;
	Tue, 26 Dec 2023 12:16:08 +0000 (UTC)
Date: Tue, 26 Dec 2023 13:16:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org, sparclinux@vger.kernel.org
Subject: [PATCH] serial: apbuart: fix console prompt on qemu
Message-ID: <20231226121607.GA2622970@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When using a leon kernel with qemu there where no console prompt.
The root cause is the handling of the fifo size in the tx part of the
apbuart driver.

The qemu uart driver only have a very rudimentary status handling and do
not report the number of chars queued in the tx fifo in the status register.
So the driver ends up with a fifo size of 1.

In the tx path the fifo size is divided by 2 - resulting in a fifo
size of zero.

The original implementation would always try to send one char, but
after the introduction of uart_port_tx_limited() the fifo size is
respected even for the first char.

There seems to be no good reason to divide the fifo size with two - so
remove this. It looks like something copied from the original amba driver.

With qemu we now have a minimum fifo size of one char, so we show
the prompt.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Fixes: d11cc8c3c4b6 ("tty: serial: use uart_port_tx_limited()")
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Cc: sparclinux@vger.kernel.org
---
 drivers/tty/serial/apbuart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 716cb014c028..364599f256db 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -122,7 +122,7 @@ static void apbuart_tx_chars(struct uart_port *port)
 {
 	u8 ch;
 
-	uart_port_tx_limited(port, ch, port->fifosize >> 1,
+	uart_port_tx_limited(port, ch, port->fifosize,
 		true,
 		UART_PUT_CHAR(port, ch),
 		({}));
-- 
2.34.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAEE249E8;
	Thu,  4 Jan 2024 15:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNblqvl2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCC8CC433C8;
	Thu,  4 Jan 2024 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704381836;
	bh=ntsB/zO+V8LcScJNpkXqCsZ4Rc4wuSVE8XfPym0CPPg=;
	h=Subject:To:From:Date:From;
	b=oNblqvl2jVDn0iX9Y0/qYKriZRbdIBYdUTa+B4MyT/sv1BxAw+a8k0eR7GOg5VVgz
	 eSPdWs+rw4fnbiVSyGlLQD5Y+iNf/bS90oGyMkQaZJmqotsLOlCGEm4/uM7f5pQjyI
	 TuLa+X+41pZKVCpmzS1PcClDBYu5QLI+e5w5cNEk=
Subject: patch "serial: apbuart: fix console prompt on qemu" added to tty-testing
To: sam@ravnborg.org,andreas@gaisler.com,gregkh@linuxfoundation.org,jirislaby@kernel.org,linux-serial@vger.kernel.org,sparclinux@vger.kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jan 2024 16:23:39 +0100
Message-ID: <2024010439-elaborate-upstream-dd50@gregkh>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    serial: apbuart: fix console prompt on qemu

to my tty git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git
in the tty-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the tty-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From c6dcd8050fb7c2efec6946ae9c49bc186b0a7475 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 26 Dec 2023 13:16:07 +0100
Subject: serial: apbuart: fix console prompt on qemu

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
Cc:  <linux-serial@vger.kernel.org>
Cc:  <sparclinux@vger.kernel.org>
Link: https://lore.kernel.org/r/20231226121607.GA2622970@ravnborg.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
2.43.0



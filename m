Return-Path: <sparclinux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06753C433EF
	for <sparclinux@archiver.kernel.org>; Tue, 26 Oct 2021 08:04:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE85610A6
	for <sparclinux@archiver.kernel.org>; Tue, 26 Oct 2021 08:04:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbhJZIGy (ORCPT <rfc822;sparclinux@archiver.kernel.org>);
        Tue, 26 Oct 2021 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbhJZIGy (ORCPT
        <rfc822;sparclinux@vger.kernel.org>); Tue, 26 Oct 2021 04:06:54 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7861BC061767
        for <sparclinux@vger.kernel.org>; Tue, 26 Oct 2021 01:04:30 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:3ceb:3f52:2846:9a21])
        by baptiste.telenet-ops.be with bizsmtp
        id AY4U2600S4Ahxzd01Y4Uze; Tue, 26 Oct 2021 10:04:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfHRc-007yQq-6a; Tue, 26 Oct 2021 10:04:28 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mfHRb-00AG0J-NS; Tue, 26 Oct 2021 10:04:27 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, sparclinux@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] serial: sunzilog: Mark sunzilog_putchar() __maybe_unused
Date:   Tue, 26 Oct 2021 10:04:26 +0200
Message-Id: <20211026080426.2444756-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <sparclinux.vger.kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org

If CONSOLE_POLL=n, CONFIG_SERIAL_SUNZILOG_CONSOLE=n, and CONFIG_SERIO=m:

    drivers/tty/serial/sunzilog.c:1128:13: error: ‘sunzilog_putchar’ defined but not used [-Werror=unused-function]
     1128 | static void sunzilog_putchar(struct uart_port *port, int ch)
	  |             ^~~~~~~~~~~~~~~~

Fix this by marking sunzilog_putchar() __maybe_unused.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
One more casualty of CONFIG_WERROR=y.
---
 drivers/tty/serial/sunzilog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index 1a54e3e52ed630b6..b714b00d2dadd44f 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1125,7 +1125,7 @@ static void sunzilog_free_tables(void)
 
 #define ZS_PUT_CHAR_MAX_DELAY	2000	/* 10 ms */
 
-static void sunzilog_putchar(struct uart_port *port, int ch)
+static void __maybe_unused sunzilog_putchar(struct uart_port *port, int ch)
 {
 	struct zilog_channel __iomem *channel = ZILOG_CHANNEL_FROM_PORT(port);
 	int loops = ZS_PUT_CHAR_MAX_DELAY;
-- 
2.25.1


Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08E2370D56;
	Fri, 31 Jul 2026 08:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785485751; cv=none; b=Fc3rq+bj9R3kNCVBQ2hKV+3JJ1qYqj5Dgf7H8XIJ8o3Y2YAZr+F8igKHw3XSOtmRUjWAGu8F5Dea5Ii/zeXCOHPYwAbJCe7uPxdSGa5tWTfuTn693NaIhXBrwYALbCbC7rESKHxfL+IxO378Z5hDkzgQXU8u7fnmrc4ULMptiME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785485751; c=relaxed/simple;
	bh=W93Jxi2npIsPaB2SMYx5K62Y8ArMeQp5sW7O8LirgIs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uzMejWsBo9EkEZkGVU6uSn5I5QpRDWdkqC2kBse4m63JoAinpEuhXsHkdpfcTdi+JeE4k7DRbTZ1h+gSMBABs1hO2k7x8GCl6tmcNO63YopuJyOcQQiz28vwbO1eC+/DR1s8JrUo+KqWiRHv224wgxUl9ReDiuEB5ZOqpAX68W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eHXlSVcG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eHXlSVcG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB61F000E9;
	Fri, 31 Jul 2026 08:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785485738;
	bh=jAzYSFCqovf4RutYRoHW1v0lgQCoIUJ4nxHKfEG/SLA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=eHXlSVcGz2/Ac1pI9l8sG+V2kUFwN8lXQ1zw2KzME+N7MccT9LuL67xZztaaFDPhs
	 NL/O6TW+S1l/W1g2Ss6tzgWeF7G730lgLWbZtl0KEP0rs4WoYlDpZLyE4qNB2knWhg
	 C6y7Tv5+u4Z+2hDMcePTH3RcrhDOlk8Jwfdsyi38=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 31 Jul 2026 10:15:18 +0200
Subject: [PATCH 2/2] tty: vcc: hold port lock when clearing tty pointer in
 vcc_cleanup
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-aisle-tty-vcc-v1-2-962e18beb8a8@linuxfoundation.org>
References: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
In-Reply-To: <20260731-aisle-tty-vcc-v1-0-962e18beb8a8@linuxfoundation.org>
To: sparclinux@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Joshua Rogers <linux@joshua.hu>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable <stable@kernel.org>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=1125;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=TWfJgv1bTSXzNgfLa1MUieNdDzck10cgaKz6d60R1pI=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5kdPKvlxmnTJn6ZzKo7/jTvqbiJXHHF94UElm46Qk1
 iNhHhFVHbEsDIJMDLJiiixftvEc3V9xSNHL0PY0zBxWJpAhDFycAjCRNd4MC66F1Yde81rA336p
 JdnMOM0jZN6GnwzzDJMDTtrlpYdO3KRnXlZp/e+dbPpiAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

From: Joshua Rogers <linux@joshua.hu>

vcc_cleanup() sets port->tty to NULL without holding port->lock, racing
with vcc_event() LDC callbacks that read port->tty under port->lock and
then use tty->port. This can cause a use-after-free when the callback
dereferences tty->port after cleanup has already destroyed and freed it.

Assisted-by: AISLE:Snapshot
Cc: stable <stable@kernel.org>
Signed-off-by: Joshua Rogers <linux@joshua.hu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/vcc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index 3947bd2b75ac..03ed8c692acd 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -983,10 +983,13 @@ static int vcc_install(struct tty_driver *driver, struct tty_struct *tty)
 static void vcc_cleanup(struct tty_struct *tty)
 {
 	struct vcc_port *port;
+	unsigned long flags;
 
 	port = vcc_get(tty->index, true);
 	if (port) {
+		spin_lock_irqsave(&port->lock, flags);
 		port->tty = NULL;
+		spin_unlock_irqrestore(&port->lock, flags);
 
 		if (port->removed) {
 			vcc_table_remove(tty->index);

-- 
2.55.0


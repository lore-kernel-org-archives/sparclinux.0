Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3705F4C6F04
	for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792331394; cv=none; b=L1wgWmsMOufW9GFlvpzFW2qTWpLLjFC7ytoAKZddCSP7LrWncMA7YOqcf6TkH46Sh6Iqrtk5q79niSp9R8A5blg5l82NBtkelx1w82MOAFYZVYGaP7Cuu/nDSHoh/s9ZrQKhhibH8Chnly79GA7Z5wPZ48XODdgPpGB124Wi0Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792331394; c=relaxed/simple;
	bh=6bijUlXAbL/N3wCEuzy67Wc9+cqaf06lnVeWNhLXdQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zf/vxlUdz+KUTAQp3sH8/LpHH0z7CfVgl5sLzqDo+/W6lO7ohLd9hcM2f2sp+w/nZreXFq/So5ItVRZETw/LDli/1YfQORVrb9Sag2DlN4tqmRjg8ug0hOai19UeADR0eB8G2fQGSmHZYS7puzzR0Hdz4oI/WgsBL7mJwB35WiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqTMWcyH; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqTMWcyH"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c4086e892a4so151701266b.2
        for <sparclinux@vger.kernel.org>; Sun, 18 Oct 2026 06:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792331390; x=1792936190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lpRhgnnQ3c69BKtA52SSfn2OKHjIwq2qtwMcYorMrto=;
        b=iqTMWcyHWkDCeh3FocsbKTRCJWMW64g5M/SZwnro/CqvKjBIaBBh6tXfeRcM7JaL5R
         HUb52wqCHkzPDXvfwfiKseKOo0k3Mc3FeSWceSObZiao/aMgVD4sqR1G/ghXXCwMxyvG
         9XDsDc6cFg5bCu3UFETpF3wIoLCt/YdPgjmgeRUXxdevcQJ+RsklgMFNDquBh9Z0/jie
         qvqBhlRuXsK0RrTQCv4qxF2GuGovrLMXQcayaN4jQJCdv8fT2PSjtAuXqCbzl+d/slUe
         ZsnA9G4nBJ5SDSoA4+RO1xF5Q/RD8pZj7CRITUEBePdpHXDzYLWSSB4qVGD6b8NU9Mhz
         54zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792331390; x=1792936190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lpRhgnnQ3c69BKtA52SSfn2OKHjIwq2qtwMcYorMrto=;
        b=OUpNQG06INceVCRJCcv660CpaKlFrtSnvpR32BERytkoz9z3/H6j/NeL9Ik32Pt9C6
         03C84NiRTyFopNF9qcmenx9rApVFozvRF3AM2n01NSx9vFOixrLqhwglcpccg/CEJaxo
         IO9OsHjw6sJdeXKfDTy2HbCCC00A0QLd8nwUdnaLKgPWdLSW6MnL1w+TkTPuQQVGer7G
         42OqOyBZX2Q60x8ApUtt/1OwBFfSdaqJmRt9LvpcP3F9Z5CeoQOrS/fkZQ9yluLHFHdC
         IHPUp0O/rP5utIPL3UPhIU/dopL06+ah+TrJkCss9Ml2n8L4VKlFPEV6Lk2KZmB0kaZC
         zfvA==
X-Forwarded-Encrypted: i=1; AKwUvBxGL02IvT8hWTbiCGPzqBPOtgp2jVtEx6xN9tB+T0g7TWv0ERoZOmWCrtWIZ8neCFy0udYhMqotNWVv@vger.kernel.org
X-Gm-Message-State: AFq9FYLfYBJ7mTYQq4aDWTXQK0Y0Q6UyHfYQ8JSL1lnK8S9bsFRIm+w5
	0wjIMbTFCjWW9zoVjzWsdjBzCQvip5RvWWAQGErMlqAIffJK2H46xeL6
X-Gm-Gg: AYBFou1GDCFm5S046lOPBEEqJ9YsT1T9FiZL/TRBegaQAkp5S5O7P7rwp50f+6ZOe3o
	fQynDpGE1BZiv1UhqKcMLQpmk/lDP801msOEGjS62N7nFXXINIhU2ejb1FfaBYRJs8xC3m2teVO
	ZK0DWohylgzfxsqgfOFSHOLQeac+1qv1aTx75pAHPW1vmSp126ogoke5DgTJtfjLux0/ujeeRzN
	OINTeINklnT9VGysygep0ZnTxrHSCchYx9ENdFLtU1M4uoeM3XqIrlh49oOEGN7peNzJDNSGRQP
	Gvb+iJzrq1FTNoz0SbAEpC1gN8j5ZsUNHf5EfX48HbxYRKCIs/pO5WxRzQZjBT9C9ote+Gw+6pP
	kDIJA2NX14Kmh/gXlXHi07v8MuoSY0CNeiPP4hOmq6uYQJGB5ZCYr31mLBSc0E6tv4M9u9MTLoy
	9Jrsgff+zUVJC8zV/gjQjFpABu3L/+RbtIPdGRfs1aqW3jbb8mbjiZ3WDbTBLjakreWog8OfTAp
	6NLmeTlw/C8DsYsifQP6OEmSG3bfwsdKCCW8a2B
X-Received: by 2002:a17:907:1c8f:b0:c26:1649:47a5 with SMTP id a640c23a62f3a-c419f121280mr341217266b.27.1792331390333;
        Sun, 18 Oct 2026 06:49:50 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919c0402sm267678266b.61.2026.10.18.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 06:49:48 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linux-serial@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	krzk@kernel.org,
	oleg@redhat.com,
	linmag7@gmail.com
Subject: [PATCH v4 10/10] hvc: add an M3000 firmware console backend
Date: Sun, 18 Oct 2026 15:45:12 +0200
Message-ID: <20261018134738.1016106-11-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261018134738.1016106-1-linmag7@gmail.com>
References: <20261018134738.1016106-1-linmag7@gmail.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide hvc0 through the M3000 Open Firmware pseudo-console, validating
the firmware model and console endpoints before registering it. Keep
firmware buffers in locked kernel mappings and serialize their use in
atomic console contexts through the existing SPARC p1275 interface.

Poll input while the TTY is open and synchronize close with timer
rearming. Return zero on no progress so HVC retries buffered TTY output
but drops stalled console chunks instead of spinning indefinitely.
A firmware call that does not return remains unbounded.

Signed-off-by: Magnus Lindholm <linmag7@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS                 |   7 ++
 drivers/tty/hvc/Kconfig     |  11 ++
 drivers/tty/hvc/Makefile    |   1 +
 drivers/tty/hvc/hvc_m3000.c | 202 ++++++++++++++++++++++++++++++++++++
 4 files changed, 221 insertions(+)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..21e4f4e558bd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10728,6 +10728,13 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/fujitsu-laptop.c
 
+FUJITSU M3000 FIRMWARE CONSOLE
+M:	Magnus Lindholm <linmag7@gmail.com>
+L:	linux-serial@vger.kernel.org
+L:	sparclinux@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/hvc/hvc_m3000.c
+
 FUJITSU TABLET EXTRAS
 M:	Robert Gerlach <khnz@gmx.de>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 5866195de26a..d940fa0d68e0 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -134,3 +134,14 @@ config HVCS
 	  will depend on arch specific APIs exported from hvcserver.ko
 	  which will also be compiled when this driver is built as a
 	  module.
+
+config HVC_M3000
+	bool "M3000 firmware pseudo-console"
+	depends on SPARC64
+	select HVC_DRIVER
+	help
+	  Provide hvc0 using Open Firmware stdin/stdout on the Fujitsu M3000
+	  (IKKAKU platform).
+	  Input is polled; no native UART registers are accessed.
+	  Firmware calls are serialized and use a locked-image bounce buffer.
+	  Say Y to use the M3000 firmware pseudo-console as hvc0.
diff --git a/drivers/tty/hvc/Makefile b/drivers/tty/hvc/Makefile
index 98880e357941..38c8cf349053 100644
--- a/drivers/tty/hvc/Makefile
+++ b/drivers/tty/hvc/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_HVC_IUCV)		+= hvc_iucv.o
 obj-$(CONFIG_HVC_UDBG)		+= hvc_udbg.o
 obj-$(CONFIG_HVC_RISCV_SBI)	+= hvc_riscv_sbi.o
 obj-$(CONFIG_HVCS)		+= hvcs.o
+obj-$(CONFIG_HVC_M3000)		+= hvc_m3000.o
diff --git a/drivers/tty/hvc/hvc_m3000.c b/drivers/tty/hvc/hvc_m3000.c
new file mode 100644
index 000000000000..e2150d479308
--- /dev/null
+++ b/drivers/tty/hvc/hvc_m3000.c
@@ -0,0 +1,202 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * M3000 Open Firmware pseudo-console backend.
+ * Copyright (C) 2026 Magnus Lindholm
+ */
+#include <linux/cleanup.h>
+#include <linux/console.h>
+#include <linux/err.h>
+#include <linux/init.h>
+#include <linux/irqflags.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/spinlock.h>
+#include <linux/timer.h>
+#include <asm/oplib.h>
+#include <asm/spitfire.h>
+#include "hvc_console.h"
+
+#define M3000_PROM_IO_ARGS	3
+#define M3000_PROM_IO_RETURNS	1
+#define M3000_PROM_ERROR		(-1)
+#define M3000_PROM_NO_DATA	(-2)
+
+struct m3000_console {
+	struct timer_list poll_timer;
+	struct mutex poll_mutex; /* Serialize open against synchronous close. */
+	raw_spinlock_t buffer_lock;
+	spinlock_t poll_lock; /* Protect active state and timer rearming. */
+	int stdin;
+	u8 buffer[256];
+	bool ready;
+	bool poll_active;
+};
+
+/* Keep the firmware buffer within the locked kernel image mappings. */
+static struct m3000_console m3000_consoles[] = {
+	{
+		.buffer_lock = __RAW_SPIN_LOCK_UNLOCKED(m3000_consoles[0].buffer_lock),
+		.poll_mutex = __MUTEX_INITIALIZER(m3000_consoles[0].poll_mutex),
+		.poll_lock = __SPIN_LOCK_UNLOCKED(m3000_consoles[0].poll_lock),
+	},
+};
+
+static struct m3000_console *m3000_console(u32 termno)
+{
+	if (termno >= ARRAY_SIZE(m3000_consoles))
+		return NULL;
+	return &m3000_consoles[termno];
+}
+
+/*
+ * HVC's idle backoff can exceed the firmware input FIFO's capacity.
+ * Wake its worker each tick while open; keep PROM calls out of the timer.
+ */
+static void m3000_poll_tick(struct timer_list *timer)
+{
+	struct m3000_console *con = timer_container_of(con, timer, poll_timer);
+
+	guard(spinlock_irqsave)(&con->poll_lock);
+	if (con->poll_active) {
+		hvc_kick();
+		mod_timer(&con->poll_timer, jiffies + 1);
+	}
+}
+
+static int m3000_open(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+
+	if (!con)
+		return -ENODEV;
+	guard(mutex)(&con->poll_mutex);
+	guard(spinlock_irqsave)(&con->poll_lock);
+	con->poll_active = true;
+	mod_timer(&con->poll_timer, jiffies + 1);
+	return 0;
+}
+
+static void m3000_close(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+
+	if (!con)
+		return;
+	guard(mutex)(&con->poll_mutex);
+	scoped_guard(spinlock_irqsave, &con->poll_lock)
+		con->poll_active = false;
+	/* Block reopen until the callback has finished and cannot rearm. */
+	timer_delete_sync(&con->poll_timer);
+}
+
+static ssize_t m3000_io(struct m3000_console *con, u8 *in,
+			const u8 *out, size_t count)
+{
+	unsigned long args[3 + M3000_PROM_IO_ARGS + M3000_PROM_IO_RETURNS];
+	int ret;
+
+	if (!count)
+		return 0;
+	count = min(count, in ? 1 : sizeof(con->buffer));
+	/* Console writes can run with interrupts disabled; this lock cannot sleep. */
+	scoped_guard(raw_spinlock_irqsave, &con->buffer_lock) {
+		if (!in)
+			memcpy(con->buffer, out, count);
+		args[0] = (unsigned long)(in ? "read" : "write");
+		args[1] = M3000_PROM_IO_ARGS;
+		args[2] = M3000_PROM_IO_RETURNS;
+		args[3] = (unsigned int)(in ? con->stdin : prom_stdout);
+		args[4] = (unsigned long)con->buffer;
+		args[5] = count;
+		args[6] = (unsigned long)M3000_PROM_ERROR;
+		p1275_cmd_direct(args);
+		ret = (int)args[6];
+		if (ret > 0 && ret <= count && in)
+			memcpy(in, con->buffer, ret);
+	}
+	if (ret == M3000_PROM_NO_DATA || ret == 0)
+		return 0;
+	if (ret < 0 || ret > count)
+		return -EIO;
+	return ret;
+}
+
+static ssize_t m3000_get(u32 termno, u8 *buf, size_t count)
+{
+	struct m3000_console *con = m3000_console(termno);
+
+	return con ? m3000_io(con, buf, NULL, count) : -ENODEV;
+}
+
+static ssize_t m3000_put(u32 termno, const u8 *buf, size_t count)
+{
+	struct m3000_console *con = m3000_console(termno);
+
+	/* HVC retries zero for TTY writes but drops stalled console output. */
+	return con ? m3000_io(con, NULL, buf, count) : -ENODEV;
+}
+
+static const struct hv_ops m3000_ops = {
+	.get_chars = m3000_get,
+	.put_chars = m3000_put,
+	.notifier_add = m3000_open,
+	.notifier_del = m3000_close,
+	.notifier_hangup = m3000_close,
+};
+
+static bool __init m3000_property_matches(phandle node, const char *prop,
+					  const char *expected)
+{
+	char value[64];
+	int len;
+
+	len = prom_getproperty(node, prop, value, sizeof(value) - 1);
+	if (len <= 0)
+		return false;
+	value[len] = '\0';
+	return !strcmp(value, expected);
+}
+
+static int __init m3000_console_init(void)
+{
+	struct m3000_console *con = &m3000_consoles[0];
+	phandle node;
+	int ret;
+
+	if (tlb_type != sparc64_vii)
+		return -ENODEV;
+	if (!m3000_property_matches(prom_finddevice("/"), "model", "IKKAKU"))
+		return -ENODEV;
+	con->stdin = prom_getint(prom_chosen_node, "stdin");
+	if (!con->stdin || con->stdin == -1 || !prom_stdout || prom_stdout == -1)
+		return -ENODEV;
+	node = prom_inst2pkg(prom_stdout);
+	if (!m3000_property_matches(node, "name", "pseudo-console"))
+		return -ENODEV;
+	node = prom_inst2pkg(con->stdin);
+	if (!m3000_property_matches(node, "name", "pseudo-console"))
+		return -ENODEV;
+	ret = hvc_instantiate(0, 0, &m3000_ops);
+	if (ret < 0)
+		return ret;
+	con->ready = true;
+	return 0;
+}
+console_initcall(m3000_console_init);
+
+static int __init m3000_tty_init(void)
+{
+	struct m3000_console *con = &m3000_consoles[0];
+	struct hvc_struct *hp;
+
+	if (!con->ready)
+		return -ENODEV;
+	timer_setup(&con->poll_timer, m3000_poll_tick, 0);
+	hp = hvc_alloc(0, 0, &m3000_ops, sizeof(con->buffer));
+	if (IS_ERR(hp))
+		return PTR_ERR(hp);
+	hp->ws.ws_row = 24;
+	hp->ws.ws_col = 80;
+	return 0;
+}
+device_initcall(m3000_tty_init);
-- 
2.43.0


Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B6045D93D
	for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 19:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791748681; cv=none; b=PoP+C62b+FfY3+B5WZkA6j/qEoDdnYO9hpt9IEURTSHC/oZnIuCWFaXKfbyW2JZK1vy5F1MsdLQEwzZ59HGyF0U2E2s9z92yEgyUICrEbJI37sdGkmBGAVrvbz5bxk1KZFczyzxF/G2V/raV6WBfDm4CkJ9cH9QQzk6790YdkB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791748681; c=relaxed/simple;
	bh=QdB4IaBJBb0z7A0G/+ogZtW+U9p2I7V17gS4yPD647U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=txN3fCgnhMbp4wU7xUJtEH3MkX8K3iPcMq9RKN3LxoMK0d78EUZ4cj5oc8H8/iWYz5IZs+YBMb9GJzlq+mAnIPBzn5GyIzhOevpjIUjJdfZmUGg8y7Y5Gnvrx7tf4R4eQRiD0fEcX1aIWnaXKYVfMNM/jsKu3d2hcE75Mci5GAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QsgvZeTA; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QsgvZeTA"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2e3846d1caso220308366b.0
        for <sparclinux@vger.kernel.org>; Sun, 11 Oct 2026 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791748678; x=1792353478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=anERnWHtuXwEcIQ8AkUzNcW+B0MsW+CJ1YCPxhosgmo=;
        b=QsgvZeTAt9wfjx0f/5C51c5ox7EVF3o6Ij1IyxJW0Y3wB059vtHH6L09LFd46jJeK7
         KnfmYfthVbbNGOYKVdDJEbkvFlx30fU+CXLFMSqU31oq807QssohcjflW5CE2BZN7HA5
         vjQ1VklyEvKw8Tg4nmf+rb/ib3+E2YU0DNfIkl/7IAXH5xcmHytuaY1x4IKDLxdIylCI
         /ckReOhmOyPl0/NjnHqfqo6qX9rCKkRUti9sc5UscBHs0MIVsN6aDjdCXk03GdeCumv+
         IXPhwZG6/aJBH4WtL/4vf3mEi96aXWcetHX8RwupKKx/oSXH7fnlkZOl2xDAO/4PaAq4
         IZjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791748678; x=1792353478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=anERnWHtuXwEcIQ8AkUzNcW+B0MsW+CJ1YCPxhosgmo=;
        b=bWrfqnh1vHH2yNa+L0cbGGUGPwUWOfOlMcHGqu7EW/6yShT585psJ8CSowrm2tt4/U
         I9O+fQRiioXAFz/tNV1zmO+B9JOzNOAxjiS5cH2EAZz1btL/J2M+V3cZ03FbSkm3ColA
         L7EaPdESHa5y9yo78p9lCdsZnUCVNjIJqayy6FIvj6TfQ3sdZTSAwitodyFvgTIc1ds2
         1xYth9UzNobdBsR6lnFurFyEkxea80RcilCenXmUbQmkTfj2vFOX8gMsoXKTvrb3viVn
         kfgkCPs84ugFamdixXOS8raweXdV+bd6gykR96V1OHM2Rb7QAkbMMFuzdp+WsWC/62EG
         A4Ig==
X-Forwarded-Encrypted: i=1; AKwUvBzI+/4AbHojqT95efuD3h5nglLFqyd2C4LVTad9d6/qCwjDOLm6lAl6jbXj0cUMrrrVA6grl4J2k4f7@vger.kernel.org
X-Gm-Message-State: AFq9FYJqLRdnvuWxzxb+vC4ak81v+ZgsSkTpqnVeTE6AcFma/oN0XP2N
	VIuEk8vvnNJUKLSUEplOIi4OhGCLyAzIdR/5NbgdSV325w6n51gO8JDO
X-Gm-Gg: AYBFou3S85o7sFd1BybAMUURdS7O4Y81o0yU1PiE0Q4yp0QKHxpNFMgQH8Y37BbTSxm
	erJC6Ks88qIz2W/UYliwUdpZLtJWJMef6nb3uQHAa6OJfkj5IugP1UMRITduxZ6lRc9Duifw57O
	+AYoQKqgg/GpKzop73Aw8wwuy/9QcEOhv5a44AxaZX4q2dgKxSsUUvAMhLhbxAMRs4CMGJDq1a4
	Ujrefo78D4a70TBrO4GC2IRTt5PpKYkShQokGjlYUkzui5r8WmWI/fSbPXhIBxhqBiky2F6DgQr
	bE6RbRzn9YHTQlzCt2VUJcp/8cUEgaMkkMp5OGcdiBmqocixYXxWCuahXUCiJ8m5qhEDd2Ysz4a
	Pd4cMbZ2ewbNxkWS/UWUIW9qdGpN885mhfHL4L7e0NXBgFzHNjd5LEdy59MFY9YhU9FS6RnNudp
	jyzGyr1RGnDR9RCAVfAC9WgEHl2vFxl8+iehZflG9BsQjvqeI3WPYPo4/Y1JYkwbZw4Jo+leTjV
	bxiY2y5zNZrJ5V7wN2YstI0fFVry/kTWApB8UWk
X-Received: by 2002:a17:907:3e0d:b0:c2e:80b0:deb3 with SMTP id a640c23a62f3a-c31a9a10e74mr851073766b.7.1791748678067;
        Sun, 11 Oct 2026 12:57:58 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c31a9a3ae9fsm381315566b.26.2026.10.11.12.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 12:57:56 -0700 (PDT)
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
Subject: [PATCH v2 6/6] hvc: add an M3000 firmware console backend
Date: Sun, 11 Oct 2026 21:55:58 +0200
Message-ID: <20261011195729.981243-7-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261011195729.981243-1-linmag7@gmail.com>
References: <20261011195729.981243-1-linmag7@gmail.com>
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
---
 MAINTAINERS                 |   6 ++
 drivers/tty/hvc/Kconfig     |  10 ++
 drivers/tty/hvc/Makefile    |   1 +
 drivers/tty/hvc/hvc_m3000.c | 205 ++++++++++++++++++++++++++++++++++++
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/tty/hvc/hvc_m3000.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3a19da74d00c..5bc9b1cabd0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10728,6 +10728,12 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/fujitsu-laptop.c
 
+FUJITSU M3000 FIRMWARE CONSOLE
+M:	Magnus Lindholm <linmag7@gmail.com>
+L:	linux-serial@vger.kernel.org
+S:	Maintained
+F:	drivers/tty/hvc/hvc_m3000.c
+
 FUJITSU TABLET EXTRAS
 M:	Robert Gerlach <khnz@gmx.de>
 L:	platform-driver-x86@vger.kernel.org
diff --git a/drivers/tty/hvc/Kconfig b/drivers/tty/hvc/Kconfig
index 5866195de26a..0feb7ec98f4f 100644
--- a/drivers/tty/hvc/Kconfig
+++ b/drivers/tty/hvc/Kconfig
@@ -134,3 +134,13 @@ config HVCS
 	  will depend on arch specific APIs exported from hvcserver.ko
 	  which will also be compiled when this driver is built as a
 	  module.
+
+config HVC_M3000
+	bool "M3000 firmware pseudo-console"
+	depends on SPARC64_VII
+	select HVC_DRIVER
+	help
+	  Provide hvc0 using Open Firmware stdin/stdout on IKKAKU only.
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
index 000000000000..1285e2db2fab
--- /dev/null
+++ b/drivers/tty/hvc/hvc_m3000.c
@@ -0,0 +1,205 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * M3000 Open Firmware pseudo-console backend.
+ * Copyright (C) 2026 Magnus Lindholm
+ */
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
+struct m3000_console {
+	int stdin;
+	bool ready;
+	u8 buffer[256];
+	raw_spinlock_t buffer_lock;
+	struct timer_list poll_timer;
+	struct mutex poll_mutex; /* Serialize open against synchronous close. */
+	spinlock_t poll_lock; /* Protect active state and timer rearming. */
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
+	unsigned long flags;
+
+	spin_lock_irqsave(&con->poll_lock, flags);
+	if (con->poll_active) {
+		hvc_kick();
+		mod_timer(&con->poll_timer, jiffies + 1);
+	}
+	spin_unlock_irqrestore(&con->poll_lock, flags);
+}
+
+static int m3000_open(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+	unsigned long flags;
+
+	if (!con)
+		return -ENODEV;
+	mutex_lock(&con->poll_mutex);
+	spin_lock_irqsave(&con->poll_lock, flags);
+	con->poll_active = true;
+	mod_timer(&con->poll_timer, jiffies + 1);
+	spin_unlock_irqrestore(&con->poll_lock, flags);
+	mutex_unlock(&con->poll_mutex);
+	return 0;
+}
+
+static void m3000_close(struct hvc_struct *hp, int data)
+{
+	struct m3000_console *con = m3000_console(hp->vtermno);
+	unsigned long flags;
+
+	if (!con)
+		return;
+	mutex_lock(&con->poll_mutex);
+	spin_lock_irqsave(&con->poll_lock, flags);
+	con->poll_active = false;
+	spin_unlock_irqrestore(&con->poll_lock, flags);
+	/* Block reopen until the callback has finished and cannot rearm. */
+	timer_delete_sync(&con->poll_timer);
+	mutex_unlock(&con->poll_mutex);
+}
+
+static ssize_t m3000_io(struct m3000_console *con, u8 *in,
+			const u8 *out, size_t count)
+{
+	unsigned long args[7], flags;
+	bool input = in;
+	int ret;
+
+	if (!count)
+		return 0;
+	count = min(count, input ? 1 : sizeof(con->buffer));
+	/* Console writes can run with interrupts disabled; this lock cannot sleep. */
+	raw_spin_lock_irqsave(&con->buffer_lock, flags);
+	if (!input)
+		memcpy(con->buffer, out, count);
+	args[0] = (unsigned long)(input ? "read" : "write");
+	args[1] = 3;
+	args[2] = 1;
+	args[3] = (unsigned int)(input ? con->stdin : prom_stdout);
+	args[4] = (unsigned long)con->buffer;
+	args[5] = count;
+	args[6] = (unsigned long)-1;
+	p1275_cmd_direct(args);
+	ret = (int)args[6];
+	if (ret > 0 && ret <= count && input)
+		memcpy(in, con->buffer, ret);
+	raw_spin_unlock_irqrestore(&con->buffer_lock, flags);
+	if (ret == -2 || ret == 0)
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


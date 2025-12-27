Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163C4314D25
	for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 12:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837870; cv=none; b=Ky7mbEYpwfEY4/FcA+mzx1Ir8mi17NJFzpHXdMVNm4EfuG4wF+X8Ex6OsaxLKMpvUvlN5yEjU1YRhr7VfDx9AP5QuDw4uBfSf58QmIRM4XwXet8oRqO+BdiiG82wJqFfCoGmYCRgnZiljsUz4Er3BRCQe6TnCcw31famXv8GENk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837870; c=relaxed/simple;
	bh=yZ/nvvnmmkaNmxpD4iXjZtoziYkh4kvSpXf/WZXovX8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UpAjWtXxBso6mhT+tZB8zWVwc18A2TA2PASq0ovgSf+bQb+Ip+hLAOnGJrVrWBqwT2rAy5DRyvOm/HNkmEsxSLIrEE+LcQgeE+0iBc5Plrpm35+Rw6Y4xC1lYpKRb31dg+pSbaZ9DLFVLaRD2Teuy85qHR43uopmks0jNND/NiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FBrHxmDD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FBrHxmDD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477563e28a3so48212885e9.1
        for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 04:17:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837863; x=1767442663; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=;
        b=FBrHxmDDFdYfINgqhAiqXYPMrsW8mIbvLbhCfbQv4l5Sxl2hJQZHMkjCc7mhVHQ0de
         hWg+gYDPPRQX11AVLkMVF3VbhKVRunkr2P3ECneKx5lC45Jnc3x4LwBCwju8hi1PCNGd
         T3Lh13k94jDuOtjOOADU500Sr7XyAlcEjQ1n4Ruw1gPFdpNZ1tjPmnI3g0Mx27+9W4Uo
         IPNcbryhOqj1WUt9IGOZjBV04iL5Zg0P+orF1AOvz/lOk5tMhRwLbj6LJqCVz9jBW7n6
         FZ7x9a7Iw6UO9fy/IBn50ekomFNhj61VPhbhh+ELnIoNiK/qdKJFj/cjQdRfYdhBoC3Z
         2nBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837863; x=1767442663;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8qC0U4cjRdxCF4b/YJbgVpXPFvwbnk17NoVL2cOfc8A=;
        b=uLuo8JJXyt25yV1XY4i8jZK9hV388g2EbQunz0N5lnLoxjS5fLYfY4/AyCtIGL+e2f
         6KBMIw9fcW4bDLQDHKFuEAX0Ix35e7BJy1OHIyHJHn+cWiRDcDMpG8T0tGgd32p/R8Ds
         8ruCorHVnpRsjmijXbue9zk2VdTp8i/iYRQzxn4LMtAGBL22LkSHwYqDdKeeiTYT2OJd
         uB4JN5GY4rTb00TFGHIm9zZWZBDoJfXB30oVI+qV91HUEun7o9mw8XRpYMrPQREqNHwK
         aU4bIQnnTDmaIN1qoDuy0BO5AwYygRIwHLVDbBQeCegUnXax2Pn7jjkovEwo2O/upAnC
         +TeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKX6NSwzI6v5XpTz+SQgCdpIAQu/8siYU5LB+kOaDkvKfqGz5sT81U/6D6krWmo47FTdPvu9/rIszZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MYvOhCGNqNF7ruSDG/bGMvo2lUjj4lhPzcqHmc3TkcDkGpP4
	4ZT6dm1DJH8nm+DZvRP1xqCUw4jV+AFPPLc7o/F+WgJVhEPt1g31Y19Z4/3F8bh7+JI=
X-Gm-Gg: AY/fxX4k3eYANWviOwB6YAd9eKJdhGQLi/h8POvG6C22XbvBgfGS44BXxMuPuPJj7L4
	RaBdAYtCjA4DvUZgE+cuiDFu3gDSuNGoxYrQSMniljXPlmckNzEJISj7iFolMxvr9rEYsJJ2Erc
	U0CD6KgehXOLu79tVF20T7UDuK6Rr4VcncKQfjdpYvQbtO6ZYyrvDjEX0lDnk6yjAfKiyLiGXhy
	nsZlTH5SqINfViVjay855uMg8vc002RL5xmGY6whGmjUjs/JNLdD/ADvD52lL6jTbB/HirTHpb4
	r6IXp7TTJPbovEIIE8HFeF7iaz+Q3+2JdDHNWFNM3gqLQ8ftBBSPxGplOdn12AMRZ6ZlCIoKF+L
	ry+7ltm24hezhI/n7dRYqJCn+SApBitYrncAQGO8QRhM/9l7wK7Sd+LKn4hwwowZ2LTSPXRJs77
	4Kb/gvdzLr7TPNXRpZxyc=
X-Google-Smtp-Source: AGHT+IG9JI4KghQQLO4JoQ5Zx3PCxaurUWQYnoyI9pepg6l828D4iHu4xsQcwAkRrVG/7RHQ7XMpOg==
X-Received: by 2002:a05:600c:3397:b0:475:d91d:28fb with SMTP id 5b1f17b1804b1-47be2999657mr224830455e9.4.1766837862676;
        Sat, 27 Dec 2025 04:17:42 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:17:42 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:13 -0300
Subject: [PATCH 06/19] printk: Introduce register_console_force
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-6-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
In-Reply-To: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
To: Richard Weinberger <richard@nod.at>, 
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Andreas Larsson <andreas@gaisler.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jacky Huang <ychuang3@nuvoton.com>, Shan-Chun Hung <schung@nuvoton.com>, 
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, 
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org, 
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=5702;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=yZ/nvvnmmkaNmxpD4iXjZtoziYkh4kvSpXf/WZXovX8=;
 b=Bzarxjf3B7CuE6yunxTz81Z6xrtzP/oSyuvyRHrm78aAxtHdfrdz9xczyh+zQMNScnR1tQowx
 BZmWRp2B3qfBQ9NUKyPZEo6SC7UASze6iocMjN2ThffW7UbTy1hRyur
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function will register a console even if it
wasn't specified on boot. The new function will act like all consoles
being registered were using the CON_ENABLED flag.

The CON_ENABLED flag will be removed in the following patches and the
drivers that use it will migrate to register_console_force instead.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 include/linux/console.h |  1 +
 kernel/printk/printk.c  | 65 ++++++++++++++++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 23 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index caf9b0951129..7d374a29a625 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -792,6 +792,7 @@ enum con_flush_mode {
 extern int add_preferred_console(const char *name, const short idx, char *options);
 extern void console_force_preferred_locked(struct console *con);
 extern void register_console(struct console *);
+extern void register_console_force(struct console *c);
 extern int unregister_console(struct console *);
 extern void console_lock(void);
 extern int console_trylock(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 85a8b6521d9e..c5c05e4d0a67 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3858,7 +3858,7 @@ static int console_call_setup(struct console *newcon, char *options)
  * enabled such as netconsole
  */
 static int try_enable_preferred_console(struct console *newcon,
-					bool user_specified)
+					bool user_specified, bool force)
 {
 	struct console_cmdline *c;
 	int i, err;
@@ -3896,12 +3896,15 @@ static int try_enable_preferred_console(struct console *newcon,
 		return 0;
 	}
 
+	if (force)
+		newcon->flags |= CON_ENABLED;
+
 	/*
 	 * Some consoles, such as pstore and netconsole, can be enabled even
 	 * without matching. Accept the pre-enabled consoles only when match()
 	 * and setup() had a chance to be called.
 	 */
-	if (newcon->flags & CON_ENABLED && c->user_specified ==	user_specified)
+	if (newcon->flags & CON_ENABLED && c->user_specified == user_specified)
 		return 0;
 
 	return -ENOENT;
@@ -4001,26 +4004,11 @@ static u64 get_init_console_seq(struct console *newcon, bool bootcon_registered)
 
 static int unregister_console_locked(struct console *console);
 
-/*
- * The console driver calls this routine during kernel initialization
- * to register the console printing procedure with printk() and to
- * print any messages that were printed by the kernel before the
- * console driver was initialized.
- *
- * This can happen pretty early during the boot process (because of
- * early_printk) - sometimes before setup_arch() completes - be careful
- * of what kernel features are used - they may not be initialised yet.
- *
- * There are two types of consoles - bootconsoles (early_printk) and
- * "real" consoles (everything which is not a bootconsole) which are
- * handled differently.
- *  - Any number of bootconsoles can be registered at any time.
- *  - As soon as a "real" console is registered, all bootconsoles
- *    will be unregistered automatically.
- *  - Once a "real" console is registered, any attempt to register a
- *    bootconsoles will be rejected
+/**
+ * __register_console: Register a new console
+ * @force: Register the console even if not specified on boot
  */
-void register_console(struct console *newcon)
+static void __register_console(struct console *newcon, bool force)
 {
 	bool use_device_lock = (newcon->flags & CON_NBCON) && newcon->write_atomic;
 	bool bootcon_registered = false;
@@ -4080,11 +4068,11 @@ void register_console(struct console *newcon)
 	}
 
 	/* See if this console matches one we selected on the command line */
-	err = try_enable_preferred_console(newcon, true);
+	err = try_enable_preferred_console(newcon, true, force);
 
 	/* If not, try to match against the platform default(s) */
 	if (err == -ENOENT)
-		err = try_enable_preferred_console(newcon, false);
+		err = try_enable_preferred_console(newcon, false, force);
 
 	/* printk() messages are not printed to the Braille console. */
 	if (err || newcon->flags & CON_BRL) {
@@ -4185,8 +4173,39 @@ void register_console(struct console *newcon)
 unlock:
 	console_list_unlock();
 }
+
+/*
+ * The console driver calls this routine during kernel initialization
+ * to register the console printing procedure with printk() and to
+ * print any messages that were printed by the kernel before the
+ * console driver was initialized.
+ *
+ * This can happen pretty early during the boot process (because of
+ * early_printk) - sometimes before setup_arch() completes - be careful
+ * of what kernel features are used - they may not be initialised yet.
+ *
+ * There are two types of consoles - bootconsoles (early_printk) and
+ * "real" consoles (everything which is not a bootconsole) which are
+ * handled differently.
+ *  - Any number of bootconsoles can be registered at any time.
+ *  - As soon as a "real" console is registered, all bootconsoles
+ *    will be unregistered automatically.
+ *  - Once a "real" console is registered, any attempt to register a
+ *    bootconsoles will be rejected
+ */
+void register_console(struct console *newcon)
+{
+	__register_console(newcon, false);
+}
 EXPORT_SYMBOL(register_console);
 
+
+void register_console_force(struct console *newcon)
+{
+	__register_console(newcon, true);
+}
+EXPORT_SYMBOL(register_console_force);
+
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {

-- 
2.52.0


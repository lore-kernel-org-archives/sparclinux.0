Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBB8327212
	for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 12:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837968; cv=none; b=SEJajmCLMhhPOWwudVNcosZnvUkyRy1o9jpF4kceMb+pSykYoTxRrUeJtD3l5VL5okSvFe80Fmff5Ifd1EwzUFvsvnM8nA2nYJ0Xis5sC+d0ctfobWHA/mMO76d7a2bMn/M3RBKjy6bHkKvg34oYzEBhQZCSqtViQuTOXQhtEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837968; c=relaxed/simple;
	bh=ipo1oJr6oF51GaJ/ypmHdNm6pxSai2H+L3ksWdFz4YE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rmuCvc+VnNwJ4FE07mHFTrZmUCWG2c0FuQ9Mk7XnoJXYqyWXAPbjf/zjue6bRUAjRrIBq6crQz7gXfkC0/hURTy+ex5Qjr9LmLCsHw2KmnIi8MnKyE5Tb5bfxZGz9I83GDE/KGT7XwBpNT27pTxAh6Kjyoq1SQKoVBl2+N0q7vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Mm3mjxvQ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Mm3mjxvQ"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-477632b0621so49222305e9.2
        for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 04:19:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837965; x=1767442765; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=;
        b=Mm3mjxvQbYaOSTBPuMB21rwV2Ovuq4exCypSwKkvktgS8oVXqKqxc2gaY6VAjRCwt0
         o1tULQVGcNg//FqPUyCqHjQQJrFrjIkh4wKzSpZpOH0vCTpyWrIJCCSR6XAE6oLWiX8g
         d57XMFMDkexc8mI+87N4qAImcYwmLV2oy85aAEEQrW4+ac+G3sEVV5eOYz8YngBlVwf8
         FTrQTYQwdlJV9CLN2ZuLcXKOfGnaHQkwCqiq2CSKUzkuAMvezSWa4wbybRwYO5mp+3Dz
         uWIahmKU1flzE6vD3fS3tKyAMG5RXmrXWIwjEQfE4NOtfmvvfMf/XXjrQMmyrpbrSrNN
         SH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837965; x=1767442765;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PI64KbZN9t1PF6ymgBKKgUkODGeQdgLto8SJvKTSB0M=;
        b=LOdR3Bfh9azYXH8RgwpL4fljow1OrctTXitJQLJekhmSpemC7oeYM/MHowhfxbdp+m
         fwrtAiD3F8RUoeRDb0K1o2UobPifuzn89hyGWbKPcw304xok2RSuCoQPb13SFXt27+X9
         wzCeYb5o0lDCusHxuFlqValUcsIVna7tPFcLBH0WLkGeB7pDeksrNlD2OcvH86OWuwK0
         9tMw5Nr6hc91wDtS2cSRPuSHTzgkx0NCXIGJIQiEZYNXFTXfD8A0Lw/7h44bDwFrjh+w
         fY63523yVZy1SbqDrhUZ14DusGMISSH2CRKwDu/ayx+lXWcHxSQBoy+jjqyPigJMCGzB
         GDzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEJaGf7KbLkk7weU3Q9UFpA0OWnPwcmVLx2d6TWYlN2r8a1UAa5d8+dPtqf9ki3yn60wsl1aSbypCJ@vger.kernel.org
X-Gm-Message-State: AOJu0YzZmI+V+Q8uZ/RUk07C7GQxhgKSOXieDCbFTIODKFQCNZDNqeOl
	DcHXh+/JAP35/oTphT3OOV9lP5IBoRiKfcROf4gnFETDCDn99LZu4AzKRbo4XO1kUl4=
X-Gm-Gg: AY/fxX7zhwqbQOLKvJv/JVihI3TW57Efu0o9xjwD8hS+2PbL2y2H0ZMybzu+GOq15gR
	+NrlMlE/WPOM12PDSTADDTuFi4PU4D4jwJpSNJvxG72w6+SX9dZPaWdmDd/TYQ2sDoPaGSYfD0N
	A/0HpioXjhF1ghJFWnluq8OrXb3lo8nHd/+xVN+1iAF7FmZz/KgZM/vU3KMwsWwNM6U3siPQLdZ
	3THU+FC21o9OKA3efU3LHBOqN5Dd23sapdQKjmJQG5ozM4kHJEFE9E1/J6kzOEU/ZM0c5GuvvdT
	tn+0Wl28X7E0aTTbqLcmHzwtMNSKwVttXA8+paMYR/0JgCYh8v+YOJV0AjI99lrYLDhjdDj3E1g
	0YmCUQE7jUrrLqSHz7Q1LiD+g4lUF9i675HWm3kyp+gOwphfixz83Ts4VlIixntngyHe+UEDgon
	TPVlvc9UBa
X-Google-Smtp-Source: AGHT+IEqqHc/Rd2kLfHagj9YhzIrZRGfzwvOOoeUxY4FRXLnI0VACA/N9sgft7uDx22VCc1m3UDX7g==
X-Received: by 2002:a05:600c:190f:b0:475:dd89:acb with SMTP id 5b1f17b1804b1-47d195a72fbmr289900545e9.22.1766837964788;
        Sat, 27 Dec 2025 04:19:24 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:19:24 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:24 -0300
Subject: [PATCH 17/19] drivers: tty: ehv_bytechan: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-17-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1183;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=ipo1oJr6oF51GaJ/ypmHdNm6pxSai2H+L3ksWdFz4YE=;
 b=BCXQlMZHiSgf9aACQxFpdYHusJFHrRGAPtAecEP+JmKnj9nHT6kdi2m955mQdUkj992asxAcQ
 YxGwDMjxOJdD2wCUfBrHw1pcuZeGNuCZOOekwLuy8OjtGsDgBHGc3PP
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 drivers/tty/ehv_bytechan.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/ehv_bytechan.c b/drivers/tty/ehv_bytechan.c
index 69508d7a4135..a2aab48d11ae 100644
--- a/drivers/tty/ehv_bytechan.c
+++ b/drivers/tty/ehv_bytechan.c
@@ -299,7 +299,7 @@ static struct console ehv_bc_console = {
 	.name		= "ttyEHV",
 	.write		= ehv_bc_console_write,
 	.device		= ehv_bc_console_device,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 };
 
 /*
@@ -331,7 +331,7 @@ static int __init ehv_bc_console_init(void)
 	   byte channels here, either, since we only care about one. */
 
 	add_preferred_console(ehv_bc_console.name, ehv_bc_console.index, NULL);
-	register_console(&ehv_bc_console);
+	register_console_force(&ehv_bc_console);
 
 	pr_info("ehv-bc: registered console driver for byte channel %u\n",
 		stdout_bc);

-- 
2.52.0


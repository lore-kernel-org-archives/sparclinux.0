Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14698320CA7
	for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 12:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837913; cv=none; b=AhLHM6//qQWLIDyBw5/nGee+8uA7g9EsO05fJgqrJLlExyn7xVHoBuRNWrw9WhcXdjMRtRRe+d7aSwG8k3b2aXk1Ky0e4WoYBGpblBGyBtLrbOk7Csk8M4LphwPLMNNBbCHMhELRaN7CP3vGvFiNS6pgWRelk+3i+0uKCXTkJD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837913; c=relaxed/simple;
	bh=EzMaKsRNP/XrImaDzG6owj2ch5Rre3nG7qKvJVZXc3k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nT4wTSgaXo1Mjo5W9IaZOqCi12mUdoO/76YfhZ4HwJn0rKYN0Nx5wS1KfCjEAiOhHNLj0LRlD5yRQWUN9nQ2oqafHcnwj2u6KIyqH3M0RAy+IZAnzauQgZlS3ZkaTP0uv7aLCNeHIS7qwaeJHWT2Ik7tWrr5vhQA0Jw47P7uZFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=fail smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IOS0hqxG; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IOS0hqxG"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-47775fb6cb4so46307045e9.0
        for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 04:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837909; x=1767442709; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z9kNg59vMLuZUSj8msr6djkrRczOEtEux+Dq5BMshWM=;
        b=IOS0hqxGQGt53BaEgDieEO3PdDdYjQ4ZVmmVP8InQVGL9RYqG5YFkSvzR93nQBoqHX
         +/Gjyy7ZdiD/oOn4i2I1/oqRQejNV4hytUVjcaL4fk5QW2YCNDwq5wlXrN4GwwA0Kixw
         +4V9K3vrQO5OUUJ9aUJhyeF5WnTsMq+InZUsd6ShnYeRl9pE4xUIQsw4lYLgpj0cD2Km
         1UN/A2jyxSUP9vVYCQNt1ciemKQqRXJvvHNgVSdirNdwbxUFQgA0UaGCSHJtbh9wUcKf
         9UIVN+c5yVphJWOelyCGSztfuI+t4ibLXxpdnJC5Y+P3nVJ+lb2eU3oERD1DlRICCz4u
         L6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837909; x=1767442709;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=z9kNg59vMLuZUSj8msr6djkrRczOEtEux+Dq5BMshWM=;
        b=HG4/pO88XWqWN2M2Hgaa0RtCtrvyjgnPBY1s+LSSt7thX7bMtwwLeVXBK5PYmrwQQA
         ojEQ+aNtt5USDA9brjnWnHbDDyS6hl0XWp7b+Xwqa+aYbnZH65GRGujwdrxUlc7gS484
         /xylmsgxPS3s+/PSjRc/1RpntYyD4yBGUzqqT+8oneS0i8wKd/42TAopOocVL52NRS6L
         4UTXQUTd306M253ik7aC84HDnQRWWc7QqW1eDtQ3cDkoy4KL5CbbkK6gwlX1tRPEsbpq
         8BhuoOopvadDhAbIMz8QJe7NKe1lfK9l/CcscOIFRImAHEugcAipKbO3dW3/f5C+AdtE
         zB8w==
X-Forwarded-Encrypted: i=1; AJvYcCUR6kBkR6uWa9c0dAisUNnr6gDFoM6BuO4nrxdlS56hCQCwAKpX2VuJRQKL4/55BdtcPYVvrs6FEaD9@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3eYGuXPPRhbtDQbU0Y7PAoTJfqZrua+bQn09L1/FUlwtSl0Kp
	/aTUVZ24kakA3CMJ3LOzI8+21QWHXHbZsDP1KgXT8jtjPqELzjitwBhCMaLEfpd/B0g=
X-Gm-Gg: AY/fxX6oJ6f3IPCTx5Qpm9ol8xSEQtrq4l4UGsVLYCqRxwezsWTISQCarV6CqTKYuct
	xsdQ+ryvNYWqRvDHXVykJ6EcLAzoQakMSDrHx7sx4Sg5/rnxsiBVonHG2uAdu7SNtOXi2ncEUJ3
	cZ3MJ2HxRn8qhbThJazXoGspWwTO0GJMRqgWiLkIXejbzAsEscP5eWYVwdfO8XakOS6UAYQNJgi
	beFK4Xu5gyLwdC2KvlaTOMRcD+sMjoM7sGO5K5+8MtFJ13Py87fF019Xphln5XP3AS933hx5lVU
	sGJA5HUfjpq0KXXF69ITQo+oCiS639OcaKJUhCQI+Yq/I9asK270iIwmF3WUvZil4mf0pGsRXLd
	S1eBUL+bszOa16u/B16ER77nk3HpcHIDOzSz0vIPjrc9+fKjioPhdrVV1y4MTkXgsoN8KjSqLPz
	UNswC4HSKWpSDnJuGV4pM=
X-Google-Smtp-Source: AGHT+IHrtEPOGW5HpG0S0h+CrpgwJd8+zbJNmNN/crxl7Vk2Gjo34WfIR0WT0TkmrlMgn1CALEr/CA==
X-Received: by 2002:a05:600c:4f4c:b0:47a:7aa0:175a with SMTP id 5b1f17b1804b1-47d1958591bmr299387905e9.26.1766837909421;
        Sat, 27 Dec 2025 04:18:29 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:28 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:18 -0300
Subject: [PATCH 11/19] powerpc: kernel: udbg: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1180;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=EzMaKsRNP/XrImaDzG6owj2ch5Rre3nG7qKvJVZXc3k=;
 b=4hRgVgEFeE8Kfjdb4F4yho+pOLOr4/h5Rv8YKsyU7Hs44mjvTHW9sE+Wu4jBIqif6kS1nJWUa
 QXrCwGXn4DFCsUQcLd3WwFDkthhp5OOtTZ3i5F2rVUBtIHQVlS2lOkg
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/powerpc/kernel/udbg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/udbg.c b/arch/powerpc/kernel/udbg.c
index 862b22b2b616..0f88b7697755 100644
--- a/arch/powerpc/kernel/udbg.c
+++ b/arch/powerpc/kernel/udbg.c
@@ -142,7 +142,7 @@ static void udbg_console_write(struct console *con, const char *s,
 static struct console udbg_console = {
 	.name	= "udbg",
 	.write	= udbg_console_write,
-	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.flags	= CON_PRINTBUFFER | CON_BOOT | CON_ANYTIME,
 	.index	= 0,
 };
 
@@ -163,7 +163,7 @@ void __init register_early_udbg_console(void)
 		udbg_console.flags &= ~CON_BOOT;
 	}
 	early_console = &udbg_console;
-	register_console(&udbg_console);
+	register_console_force(&udbg_console);
 }
 
 #if 0   /* if you want to use this as a regular output console */

-- 
2.52.0


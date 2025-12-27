Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463ED3191B8
	for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 12:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837889; cv=none; b=TtICgE8dJYAMd05pjH41Q4tgBRHmO1J49Ua9lYbNcuCCMGr+oAGcITqSsNaL/wEu5wzBV+M3jAolgPOTt8wSodTc8T0XRWJ2qdg5uN5VQ78QaEj8hpJiwmYyikj7Ic9qVx4wRAdD31f6uVjqJ5XGvmAm536r0fhL8frDeRTpSys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837889; c=relaxed/simple;
	bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DIAKjFvlCDSi+jhcYVL25QF8iYUZHVRv52k9aWfnYV536NvWckId6iZUffCiPyja1AKaXtFm2ccREB9kPFD9gQrjLBIq43c83xnCi3OcUyGNDAfpOS/ulcN6ICniS7vZdxp2oQZbhf/NqEBiUXk2ALKMoEFCkTZ7T7/jB3SkFzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eBo2H9F7; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eBo2H9F7"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47775fb6c56so59043495e9.1
        for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 04:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837882; x=1767442682; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=eBo2H9F7jsvmaK92/XVdbdEGM9Tdcx4wgE+kCCLtUhDw4tiFGEFwrffvmJg3Cjflr4
         lLVjUhZChvFwikE0XJxcYjf0zBktHsHCPeQ1eRdVm52B1/xes6ShF/BI6rU3QvrL5sSM
         7jUR3QpNP5VGu1rAaHCctimiqxfroEiKYvmlv99XtG3FfaXc2C8SLHlvl87kAxKq3Jva
         ETdrsaBZZY0yjMUvbD+hJFiwLigqRz/RW3FlZQ8BcDTHnJ+LTxi77x5xGrYYwApC3/HC
         qy10hdktZ51gFdtI6Ure5hOa6dcgq/XZ2kbj+ggfexvJq8+uWpi7mf1SOoyl/T+MexXY
         2uVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837882; x=1767442682;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YPj481dav1h3nWeyVMYXYXTPRZgLS1US6KZdyNyRyzc=;
        b=NThpZRyY90qcF8D61zyNNpm1wc0NyTBjJ1bRlkGTruRrv2qcmPCMplizivXxw7HjdV
         gbhD2jDx2B9mWjCB53TJuD7d/4/vvVtnVOccmopZPUmNFFE3ohoDRbXlr/fqmM85pnh2
         4rZJcrCKjim777nsbD2a7teZpoQqT7+QNYWiOaQGpF9ETEfQNV1ik3zgo2jAJtg82tFH
         mTnSRSPinJaSqxtrdI/pMMKNHHEeffYQj2vTy2jDfwgX3XjwklrEbuNI0/abGHpgk7bM
         bZ7dj5aMYO+Qd8o/W+DmeXjO0u86hP4kBDT3hnq0wzOEE4+GrNrY1uwa6qQKW96XaDb9
         WQug==
X-Forwarded-Encrypted: i=1; AJvYcCWBapZ+27QALH4AxXX977BxeQeZBT6Z/70rBTJ296OtmToJtTTxcyqzPjoWC7LxRkaYYioVZIoqQea7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6th7yA281J+nITNTMzlE8Mxv3U2Qsg6S0DJhsQYOeco5Iasg2
	YDdOk32iT0jddXHn3XYYFxdJScGfDcJYol/JrHid483TBdVkgy9iB1vqosB0hXikeQk=
X-Gm-Gg: AY/fxX6rpph3jwZGly4nLjoE9WZg60T/lNLTg38HNLSd2DnKNlK/h+17qQZhU8AhGbn
	/26QukO+0rbdz6GKcSZJjA5qU8o+bYBz49xUuiCxE9VAHOhOB+PRfOMF0JTpYwoUbKDOAjsDrLR
	EE/RiO3dmypwAYuUEwAF1hBr/THrJBRS80u7Ji20DsEjSRfQyuVfdGYVpDgjy1clV01AgXpVit3
	2hjMFbNJDTYBeuy/h4HKiZbF0vFPR9SmcEyzBeuLdWI89xqYxYWBOocRZrf/rqfZ9sHCTbPEYiP
	BZ2ZgtMoIkFmR7/Ir+/tNv/3oeWyd6SaL8qHI0W98exWYZjeKsi6ng9j3gRi8KAzC/EL2hSlRwz
	fvV4zngvjOOQWOsqP0f0Zcsk3cK7R4K5aCuq0rcJYXwVa81IPAiVA/jRrQBAZdwWf/vaS0Ww4nR
	LXc3mSVMth
X-Google-Smtp-Source: AGHT+IG0mR7FQaw+l23lNeDI3HZ2oGPwNQnJRaTrq28MQwyhH5VRn+b1LrDgTvBXBb163N6NepB/tA==
X-Received: by 2002:a05:600c:198b:b0:477:9fcf:3fe3 with SMTP id 5b1f17b1804b1-47d1df12f84mr272520785e9.0.1766837881680;
        Sat, 27 Dec 2025 04:18:01 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:00 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:15 -0300
Subject: [PATCH 08/19] debug: debug_core: Migrate to register_console_force
 helper
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=1369;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=i+edMET6/ej5N2K5avM5O831EcMojt2VSHcuUrQdfTw=;
 b=frjUdDlkDnmz9ghHbQI85g3SWQC6r698VmLv/vY5BaR0ZhD0fZI/A4RKNedga5QpYNhkZRCmF
 1wOfSuqi/z5ASQwxAphrFcarhmThsZ8zA4jjeiyha2OJh22t8WzJ4PJ
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 kernel/debug/debug_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/debug/debug_core.c b/kernel/debug/debug_core.c
index 0b9495187fba..4bf736e5a059 100644
--- a/kernel/debug/debug_core.c
+++ b/kernel/debug/debug_core.c
@@ -941,7 +941,7 @@ static void kgdb_console_write(struct console *co, const char *s,
 static struct console kgdbcons = {
 	.name		= "kgdb",
 	.write		= kgdb_console_write,
-	.flags		= CON_PRINTBUFFER | CON_ENABLED,
+	.flags		= CON_PRINTBUFFER,
 	.index		= -1,
 };
 
@@ -950,7 +950,7 @@ static int __init opt_kgdb_con(char *str)
 	kgdb_use_con = 1;
 
 	if (kgdb_io_module_registered && !kgdb_con_registered) {
-		register_console(&kgdbcons);
+		register_console_force(&kgdbcons);
 		kgdb_con_registered = 1;
 	}
 
@@ -1071,7 +1071,7 @@ static void kgdb_register_callbacks(void)
 		register_sysrq_key('g', &sysrq_dbg_op);
 #endif
 		if (kgdb_use_con && !kgdb_con_registered) {
-			register_console(&kgdbcons);
+			register_console_force(&kgdbcons);
 			kgdb_con_registered = 1;
 		}
 	}

-- 
2.52.0


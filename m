Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D30231BC85
	for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 12:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837894; cv=none; b=rOj7wzQsYnF42zGmDPE6QxiwiZ6aoMwK6qLotE89+AZeD6IQsp+mfPyqQ2KYZM1wN1Uz5TjkbmmhBz5e+txooFBt8e2czdsWTlgQfy65QvnhF3zc2eR2TzM6zZ+J58e8M/fafNhK4UXgtmPzfLtNgYH1HmNP6aG3ruFbduxjZn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837894; c=relaxed/simple;
	bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DyLdRNUTdvqkb3YBHTkCwV7svwSLpb06zefCBpx1nuaj6kyhIZ6Myw0HOG3xSYABIHG9Cj+YbxKQwa/28SYiSFJXjGF3OjQkf+s+bywHBILVhivMLLXvESPoP80xKTUWlXGDSQQnnii6mTW8OHapQujom1BAmLBzlvTcdkZ7Xio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TG47dukP; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TG47dukP"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47774d3536dso61935745e9.0
        for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 04:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837891; x=1767442691; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=TG47dukP7w13KTUTZ2mrQEyHmZIw1b67Qnqn/1mmqNRDGCiAKHY++6IMzQte7KyLAr
         BP9kpfYHtqsTTOwTNS8gGBSRy3+UJwj3DoBlWZ/ctuAbw0wRSyH7nuXoD/sCE1QZBnLS
         5hq6zbtHXR5n00KdiMrm2Mv7tMj5gkUX3+E8UDHBrZfBONKAtCmjatG6MROGzUpun7a2
         hm2h/uhigfCGKby0EirnGsqgP9aqtpTzCPmIMy2aOwThblrC7dgAvEXTnu8wn/rjR9YV
         7hZB07PU27uGvQGMJEv3WO6Ln/VstRVEEoWlWKTfdbrnuxKmgAHNe7Esfqboi9c2sEgP
         ehTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837891; x=1767442691;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OB3+8VIsiv4yLcVB9h3kEd58M2RQJv95rPNYEtVMoiQ=;
        b=Z0koHvVfeuKKmMcxsKNPjcpTfm3g8ZxijRRsJ7js8NILUBdaU70ebPg/5H/nQzSEVb
         +QcWJjFJTe5xkgc50MD7JWPufV1163CnDSLBx/oVEKfXvGal/uQeXwRtbrguFOI8rm9U
         kIAgdaRq4lIwNo/CpW3uHaChrb/ZXmJBM9TO1LnnyLno3RFlkhkErk3p1UxiPQCJQWTN
         6rlrbH07F2maEXc4oEIRbKshzxyMaKZjQslMpWngFLkk2Rqxp805SOc0e8mCbTLDrF8b
         upgJBxi2s9LYONlcf3J4vlyZeunHXusCvw5CBGJ9W9jzmtbv3qS3gOS+4MxEOVfr2oQq
         j1TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKg/G84quGroarnwO50I6eYwHDnizRAVLmeUADRvPyc1tzUU1TnkaHWIicf8xGp+wIQOU9hrxra2eW@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmi+ZyYNq3Vd/CIfKVTo6BP9Q45coF4Ot5ahCWnFoiUPSlBsj+
	WrKoE0+jYQhLVAWYTCqRRoa0m+fK1faJ7Gf9W5zUfDdVcnRqWw+9emwSilh7hK0STyU=
X-Gm-Gg: AY/fxX4Tnjin8bNqbuAC3ZEvniZy312w5CzGKyAAEYmyBfmIRJ7awpu2whnbhTtZnc0
	iFKMlDRP643TgbzGrZroawJNTYH2mgyzxm+V37Ao+89NXDi60c5oXF5jT2HcxfJ2siIVWHHujIH
	j5Tdqwscnly9ylJ4tWw+2AuTvhzhZQe2I1ihxsptbhd9OJAmjtCBRzB0YLTaI5QM2Rhc/8UZkKo
	1g/tYKb/2LT+6zH3AJv7m4AS6DI+Xru0NRVLqD1B0WAVeNS53Nu6wOmfc/H157iBociwu4o2VEE
	pViSYy8sK7CsFMuqDSg1CWcd7n4YQFXCLLWN7TVsy5Cus0IYXVNSkNrkX6QmXkjFqvOa0fVuiPi
	XSE7Wg6khHMbbdcqfnVHbCHFOxdMeJzBMHTon1mRFv4OzIlWzbYNtpj4l7hAIZiirMU8vfA/gQ5
	P5VGLg5iSX
X-Google-Smtp-Source: AGHT+IFJeR5Bq3e314KIMXwkrZhqd3SM0Gtgef2ZKhyuTvMEsyAQgTg0idlkENoTE/A1RwLAaI6A4g==
X-Received: by 2002:a05:600c:a30f:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-47d52efc7bdmr6320155e9.1.1766837890917;
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:10 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:16 -0300
Subject: [PATCH 09/19] m68k: emu: nfcon.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-9-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=997;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=aTPPRUdelJJPNRSRbq/P3Dh/ezSRl1NcFqsysqipRcI=;
 b=bFiYD37gtcultSa+DtuWsZDZsqldtTEWNQGlnO3f8qpUTnHo9LyYg6/jnVTrFnBYz5Wno6rCP
 MIg9mT6KNXdApenqW2Pg83sbMRC0cE454dAXf3m0peqNYruoithEiNk
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/m68k/emu/nfcon.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index d41260672e24..3504bbb4aedc 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -110,10 +110,9 @@ static int __init nf_debug_setup(char *arg)
 		/*
 		 * The console will be enabled when debug=nfcon is specified
 		 * as a kernel parameter. Since this is a non-standard way
-		 * of enabling consoles, it must be explicitly enabled.
+		 * of enabling consoles, it must be explicitly forced.
 		 */
-		nf_console.flags |= CON_ENABLED;
-		register_console(&nf_console);
+		register_console_force(&nf_console);
 	}
 
 	return 0;

-- 
2.52.0


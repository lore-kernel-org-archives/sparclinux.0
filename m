Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FD93128B7
	for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 12:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766837931; cv=none; b=Q1M0kEJ5EPBw8jGTukVr7APaSRcHO2JEGZnRYO1XW8zDLrMuepZuP+Q/MsZuqP6xSK/tjEDsi3ovK1Q6of53hl0uTC23nybK2kmSX/aUh7p1/9yXcORZEWZe/6+DLEe9ZmIcfVRGH1KDitRZ0A67tAz9/jYiuq/sFYjO0l2hLiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766837931; c=relaxed/simple;
	bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8Mk3B7t7IN0lH22+z0g6B292yCVsBC6edYOOZgY6+XX87RK6eN2rV8KQT4Kj7DYxqRfCiXFhjW8A/yxhGUGTVu7lI0KEzaXJJlirzuA2CwKawm8I7XDFm0K507bkhaKONHs6+fwLvR/wDA7mW1bvPtTeJL3WCt6WZUb/U2+bew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=J0FA9L3E; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="J0FA9L3E"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4779ce2a624so59148935e9.2
        for <sparclinux@vger.kernel.org>; Sat, 27 Dec 2025 04:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766837928; x=1767442728; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=J0FA9L3EEmy+IH7mL6HrvsAU2J8mMSuJmz6c7amiBc6l2t5p3f62JdTCtKxVbVw5tv
         zuNS8vF1S+3BpGWqsjsvt4ONGTmjMi/I3YD222xJdfKU3h4VJfUslK/EeDgLn42ewU0j
         LmFaia6d73wWqXt/KgBZ5iFETl+z6Rh9R0DQN/rMwXBfnCoWzcyGp4OYHq2TLfwXr2YW
         QctsoL79xnhZYvgAc/ZHZCjw/UuAClU8c2kW/VmOPYGJFt21JADcG2l5JUTrhu5ga03I
         +AJKNR7KieNZIm41zxSYT3sOU92LGB7G83JtmI3WGHaz3MQWgZVnsoOHQGzODtYm02LZ
         d4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766837928; x=1767442728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NC/xlTHSkC5720zy/KPT378kGxggptiwCzT1YNGAqrI=;
        b=EKFx1JxcwaqjeF3FeExXzmvAN8p54HU34gtlp7cVzgsS/fthkEJFOn+pJVbNpMfFLx
         Qs+ypps68wFpHo9FIElZlGWMZn8k+AZGjAvTIwO2/Y/Avepa4euNfTKPmr2UUgQD6dY5
         Uo8Kg6rKvIG3LBpVbznGCu3CHBs5GIirWvwwvSK4c30660NOsZjXiGlSNecUTr9H1gFP
         OXuEmDVsZZlSx+TRwXNQvQ5Do09MjyLsOKmR6gn156iVk+3qq18mbPHspsjOvWK3xzgr
         hrs6V7or9EFjf1jIx/P8iB+1M7pRj999d0n12Q/zi0/TE+FRjdi9gk46d+mFoXdKWGBy
         xOHg==
X-Forwarded-Encrypted: i=1; AJvYcCXPRDX9LR1nm9JV+SsQC6xtqNdQN9ulEALMFCR3KKu5OR6a9aK/9rXouL6MCW6zb0RbF5uypCIjIWZ1@vger.kernel.org
X-Gm-Message-State: AOJu0YzP2il0tx5NrkhlVzz8kj4Zem9jmYCzO6QYg1RN3xzgFYRT6Xlc
	2tkXz7gHwJx0eWiR94d9EJz5XRqtNagEzCCOXgdq9TfVL9aA9IAeDGqLTAFyoyDMgOM=
X-Gm-Gg: AY/fxX5mQ6a2jhqwqrVppB5mhe2BvZdEFwtbFwXCr3FKq1U2hry/cD1QwowROfNY/WY
	7PmZN9Nr+V+mL05KqvnK+X8nEPihfniRzreeeXGj9fXK+FbOR4gX3Sefg57QX1vQzGokDdG8bPX
	MhqSrH32MBXxWlP+feCv08IMYcJOGU0wmenPp0ymuc0gs0066v4jvKVO+cdVTkifNfNK8Nj6Cyh
	DRN+VheaByORTlevUl9agKgHrxSw+v7d/zDcnsiVGuybtrY9Fcc2QpwRw0RH6oqjXBXic4uNobz
	Il1zyuqH5YSyjiHzQOayqt3TNOpO4YfjN1tujJ6AEA+E7oLL1pKQuZnBKE5O8WQ248FZEPuhglF
	WUKPtMTEAJhhtIMLLKPY/vE+a6rLUUAda+baM7RIiCqd4EucBr7ZhHf0uA20+YVIz9FEOaydahi
	PI3bfVnjfv
X-Google-Smtp-Source: AGHT+IFbCGvkCxGExFQLBl5yaU008gmiVvRdmeb7k0sjyaCh7Z1nYJocCXv7ZLYKC/Juko66305eyA==
X-Received: by 2002:a05:600c:8183:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-47d195a9834mr270395745e9.34.1766837927833;
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
Received: from [127.0.0.1] ([2804:5078:811:d400:58f2:fc97:371f:2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724cfdd0sm97940127c88.4.2025.12.27.04.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Dec 2025 04:18:47 -0800 (PST)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Date: Sat, 27 Dec 2025 09:16:20 -0300
Subject: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766837798; l=961;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=9A3Brx5a3gQ0NUhTGZ1ViMT9HfTuP00Tgzee1GwnjVM=;
 b=gNLF1CEZIFvupLFUy4kgNSgx2QLue8Fjf3sjVi+zSBhpSIWUfb0laNahgF6qahlq6x3pophwD
 dRykPPu3R/nALZM8P2pCpkq//4oDFgsmNLGc4Tixc+Z0JIXH+9rAGGe
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

The register_console_force function was introduced to register consoles
even on the presence of default consoles, replacing the CON_ENABLE flag
that was forcing the same behavior.

No functional changes.

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
 arch/um/drivers/mconsole_kern.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/drivers/mconsole_kern.c b/arch/um/drivers/mconsole_kern.c
index ff4bda95b9c7..ce4f4ceb7f27 100644
--- a/arch/um/drivers/mconsole_kern.c
+++ b/arch/um/drivers/mconsole_kern.c
@@ -582,12 +582,11 @@ static void console_write(struct console *console, const char *string,
 
 static struct console mc_console = { .name	= "mc",
 				     .write	= console_write,
-				     .flags	= CON_ENABLED,
 				     .index	= -1 };
 
 static int mc_add_console(void)
 {
-	register_console(&mc_console);
+	register_console_force(&mc_console);
 	return 0;
 }
 

-- 
2.52.0


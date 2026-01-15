Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 687472D7DF8
	for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 10:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472200; cv=none; b=GNVld6qkA10DREVgBRL5WWXJxhrK+YJCGz71/XtO0d8TvugkUQT3UkAmY6aRwkeXXMV+/KLaonto8T5bQZmfs6K7N/kX3D8odojQAOcipF/K2aaC9Yj2iTxzwGHYnpaTH8WL0IVMwqlzc1HTPa7mH5xqoH3acPVfoBNEUjhLli8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472200; c=relaxed/simple;
	bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G5WtWgKAEYHEydSGyRLzub0j6gYWMFWlY1ITN7mErGUjKnECbzLiraeXqTWVOuOJF1fQ+hliXjxFXobBbFq+cwhKFBvYAHiJYyVIAJSA5fbfpE59JnG+4cgiA5UE04eL35NyHjDbdaLYz2J0r2FxCfcwYwQjVw4kKB/DQfhullk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O1AfzI1f; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O1AfzI1f"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4801d24d91bso257995e9.2
        for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 02:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472195; x=1769076995; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=O1AfzI1fLMDVa3SD3LO45cvIiavE+LKVM93UrB7hJYcD0m6yOptHdhokkT8bTYka6C
         3sXJ7mv88zLWCKOA1K4tTNEUpgl5sRbxQkPkY/JxJ39NJl8UGOMFq8kcmDmf/klRNfzu
         nJ2y1cuRJKr4oZuTg+fls6YXgf7Cmk8scFvR14UdHkOvJCMLVgfHdOWaDArlFHS8i+in
         /rjDe30x+8k/vU2nriXmVzYvgsK75zbtsHQliWEWoqaCQIzSRCmZBSVIuTAHgBAk/qqa
         BhvMnVF7Ni7MX4Rr/TPuFFrwopkxq3IhJQiQJ1qEZjzsylkwRiXGFMLOKcT5/GAwd0bX
         FnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472195; x=1769076995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwLrvsF0GMvPSCBeAjAWQZcmbWMJVYh05GZu4CqMmyk=;
        b=l9Vdl4xApXvpLgJhX2mG0bjcR4BFOVnumr0OcdhRaKl8cWY66nnqlSCBAHMSlQPVtP
         RijnLXFl7XWQx6fHFtidXts7q25brV5KbMqtxV9fTIcjTPowNfdCYfQeOOdLbMvAyLy0
         XP/P9Io/RPX4mgvm+8KeVWn8I/ADHMbUZd25Elx8flm1+CTI0uBQDbkXY9klbtQWjTn8
         PTywYrHMDqVQK5KBZNCMx11CBGvq95UvHOB7TZV2iyMTIe+n5IxYIXc3ZQcSESW27llk
         8JObrR5/McbQ6EKq8FIBLi2JjN9mpqskanGquKB+ql0+fUudz/SxRIvAheQikgpwjLot
         gmng==
X-Forwarded-Encrypted: i=1; AJvYcCW+RSF+gezGnmLRRqh//F3oF/ia2QAniBaZksTBUTGEbuqkrwvzfcdYSemvz8IfUFO1NTAM+7/3/S6r@vger.kernel.org
X-Gm-Message-State: AOJu0YzphE93GcF1AfNhDyZwmq8XsaSjrZxdYLmHYvUHmnKLCHARc9cA
	FLd+jJBBsrHqVihkoWfeTEEIZfMvjrsWDXbojtRWK7LbxUDHZOLPQXxAaY1EpvQFTy8=
X-Gm-Gg: AY/fxX6lLCLg7PpRwve0uFLvVaQ5t6Y2CkQnWNVmg9zTecK0+rzN2S5fapYOaewuw3/
	1jdtg9cP54/LMLbk2OwreotnUJexb64L7mN+HMG09iBjPscx9AFF/v6YOdP5mwhVRRgxUvKXKja
	+DVdtEu+4KkVJ9K5RUsOrxxsUFiJsFI9dV9rr4suuDcR+SLt+YtPb2Vb77jIBdjBEzXZcDfm1q7
	7/Uglakj1A0/PED31z7JfX9SxwrQVp3S6+B8KUnP7juXegVL5HXbBPEj2q/U5IsUAVI9RDxs0uA
	MXS3262j2/bVkhpA8fR/BMgccsWWVEufs/4mRGTuk7Lt8q6O+myXe5fCBvrfCypLFpEWgVASr3w
	s0XQfWGq0JEZ9h/vSV3bFzRw/GkuXcVZT8yubtZb35xfEdUrPPC7tu/a7jgTTTTDxLIeP5DlAm+
	Im/pkEc6Ie5da+/YEmTYFqzust
X-Received: by 2002:a05:600c:608c:b0:477:a246:8398 with SMTP id 5b1f17b1804b1-47ee32e0829mr58296485e9.2.1768472195426;
        Thu, 15 Jan 2026 02:16:35 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47ee28144aasm39739585e9.11.2026.01.15.02.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:16:34 -0800 (PST)
Date: Thu, 15 Jan 2026 11:16:31 +0100
From: Petr Mladek <pmladek@suse.com>
To: Marcos Paulo de Souza <mpdesouza@suse.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jason Wessel <jason.wessel@windriver.com>,
	Daniel Thompson <danielt@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andreas Larsson <andreas@gaisler.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>, linux-um@lists.infradead.org,
	linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-hardening@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 07/19] drivers: netconsole: Migrate to
 register_console_force helper
Message-ID: <aWi-f9LBJtxGWgWs@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-7-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:14, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.

I would add "No functional changes." like you did in the other
similar patches ;-)

> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Nice clean up!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA07397AA1
	for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 12:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768480185; cv=none; b=qTiYcWrDXlsy8RUKRRwetCZtV1SWwfEInBZZNcauJHe1wXbAaxTx3bWefC63pURrCTzmwPqbNYETpu3Gqy/yfmAVwjg4s6tCRbq80erJQfG33b8KI6tPDC0APKolp747J5PguU3MpKqhxHtFs6yvz1x67cE3d+I6P6RPemVYquc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768480185; c=relaxed/simple;
	bh=vYsdvT7Esg+O4+yVXNphLK0YKxhLuEHhcRTW8Mb/9K8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rSJsIEKoG8fhNss0Bzuyrohq2Dg1X74hwzRFzZKCrIxvjPtYdmf+swm6KqK8UyTUl8irIr5NbgzmQYLd87XTvD3nsa+vMKoEUKGB+o9eXoEC+pBcSIthh4LDZEOzKxRO2wGsDyPWEUUxm5APF+cHmOBxDWx4LyHf0pGaWl1uBsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YWoqPUwR; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YWoqPUwR"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-431048c4068so468317f8f.1
        for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 04:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768480181; x=1769084981; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=YWoqPUwRhFjDNetwPJSdKBHF/sh7S1EgP7tlt+wR//RGEkO9N4XmFTkKsELsXCN+Wh
         tAaa3ENOSjTUpPILgZg/y++6goGL+uSgamekIXw8LmEugXqkm+977/byxDPFL1eoqlch
         cGOXGBs3zphBNNZNyLq/ZN0EehjhFZAUYOQqw+DHgPeteIljG+U4TPt1rzkLOeMvmZ27
         1O7Yw5joixwU3lRrqJFdpDK0eX4HermI+x+n3JLmTrJSvtJqL+AZ+HvmrKi9QhTt/+v6
         TP50tRwd+Z2mmYQDTI3Bo6Q51iA8Biw9ePX1ylXoopdCQ6oTxMlph+beE7QlfFLDppB4
         0k0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768480181; x=1769084981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ld+As4KXLNBvjLuNePKBkF4h3CZ3gGNkmAsVzP6KebE=;
        b=H+rq0nW7xWf+JId9F8rEZEH9Ch5c2zYIERa0ECfCm9c1XNtfZTQD3OSTkZWSqgqznL
         oHrFjDLsKPdd8yjTrYW7wuNAgWqSBI+IOVjoBoNXYMMnn9DcrRcz56W5suW+34xf2epk
         UJTosZHBCqrDVXT1m25zYLtH1uXRCqiQObDsVkMiNDUOPzS+/+Cflmlh/by3QGGy18nP
         RbOGwGKfARK/12D28fIaZVSBefepe2Bx2gZCWbtqpklLLEmavKgoZV7E2C7ily/vLAJD
         71/X0+cKNSc95F2vKgFdF9FicAbk5Kx7EUuhfPnyfhZNSzgI2+TmncctxzaVRJhBgYu2
         EHfw==
X-Forwarded-Encrypted: i=1; AJvYcCVeVq8C6i93mBniV4P+VLjooewbYldc5UbtmX3q63sLlFEXDQzRQ29hEJuE4II52bqUIeSJNKttDdGY@vger.kernel.org
X-Gm-Message-State: AOJu0YzcXoJm2OB6rRGewqKQxSiqlDS1jLXGhQdblYcugisoeui16r4Z
	zyUn6eHnb1aS0yx+Zh6ETsMS/DgjxAQFLDdbe28sHV5v7eg/I9nbWcK7kxu75JoB0S4=
X-Gm-Gg: AY/fxX6h7sXH8xrr1lofnMP+meBXvgvu6h5YuAI49R46zKLUPi/F7Q7pqfhE+t+bjbk
	EgJvNb1MoY6FFvySi2fgZvxVNzbamNw9lv9TXyawpHJK40R+bRq2B7PowsgAJtiNwahmjSw51ID
	l6dR1iFSfCVfk3UJqehYM3QvINxlgfRFCXuCb6ZPwy8WNMQwRHfz+3iBi9kZGot40LvT0cyQM+F
	p+uTZw6tcnc+nuo/VmwhZTvC7MdbfN6WY9jq87ZLcEUic/qSUwBY6VrXHGpZLBSvton/guvM677
	ulUPE+zI39xOXV5o9SYMGLsQnZao5SfPoRQ0/gILmoZlpboDBfyPXf4fIcc5JODolVLDVCxsoEt
	SXH2Mc/tiwG4MflkQ1Htl5uhdSe/mnWmHMobcW0Gbrfd4nojB7A3q1FQP3osQV0M5+mqXeTqDej
	gmCdgLLNxD9iYTRA==
X-Received: by 2002:a05:6000:420a:b0:42f:f627:3a88 with SMTP id ffacd0b85a97d-434ce7324b4mr3823468f8f.4.1768480180633;
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653576sm5965022f8f.17.2026.01.15.04.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:29:40 -0800 (PST)
Date: Thu, 15 Jan 2026 13:29:37 +0100
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
Subject: Re: [PATCH 14/19] drivers: hwtracing: stm: console.c: Migrate to
 register_console_force helper
Message-ID: <aWjdsbYev_5zfKEC@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-14-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:21, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

LGTM, nice cleanup!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

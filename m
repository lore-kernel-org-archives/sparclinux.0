Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41231337B9F
	for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768472406; cv=none; b=bWzyP4TZuNHXYwAFpRZ7dYW/UGURmqu4ytoTRROu5LNbz/LHllqGk8T200qTudYQDjUdPLAq75FmAic+H/X1SEejqVJPrIVOQMS9+d05xUA3gurX+GwQzQzwJBBcscutrHnDOZTJeMcGkUOIuaR6sx+9R9fWv4NZDwEp8zMMNTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768472406; c=relaxed/simple;
	bh=mwoYamMX+C4LOG3qk2bHenfle0rpDp5AHcC+7a69BvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Us+foOQJRlmo9bagGBNsNWWjJMPTeTx1Smj4Z6zlreqL+tV0DSn6tQl2s/4c2uqG8hgAEdQgIXEqRLWuw6wkwuafLRnSQ/z1fpJqFEPFW0Icf5ksWf/ZmrY5utCyXr0g+1zboP6h+XGDuVZ5J6QEPsRf2+IvX2Ydmrre260Z7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=POOTpyf2; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="POOTpyf2"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4327555464cso386649f8f.1
        for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 02:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768472404; x=1769077204; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=POOTpyf2E8LQhfgcWoVnmGcwTv9cjx7t9nOoTBipWSoduSQDl2DtDEX5jXOGnGpHug
         /vEr3bRycNEF9KDphpixHf8pjEFI6ZYVF8QXfo2/p/K4igsaUNuTuTAXBRonG0hkEw3y
         zjPwl0nXJwH8C//iA7KkpuUuefoo6u/aeL1FN/9mZaiJHPN2asi8Bnj10GOb/8yZxglx
         Mo+8uDhw7wpooLcni7m/NfXXLd+GFxPn8auytjzx3hOMHRSxcVVJJnn1AEDU7nQEhSnb
         pM9pvUeivyUXXZdwnM+CoENtMt4wf2UWt/Iei7G0hU36UOd88kWLwxHkhYgi5FI9j7DC
         cpzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768472404; x=1769077204;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Blw9ol92Adxv0ebGIyoRpKSiGhl8JOSAW1An3S4C+Hw=;
        b=mp2QT2lSdTNHqDgD4U2+mm6uia7UPLm4sbrmltziEXsWoLBzKLLlkKUUE5FgQcx1Hx
         28XAdXTSjG5MNHaq9SXPWHkZNAgtHtIEjk0kNiD3jPzXcxVlvpIMWB9eQq1SxYRYvlZN
         yShzj89jMGir1rRijWcEoO0SVuShkOSqmzHPJTQXjy0JEE3UX+KhxGC7KKe6XhsnQ8oU
         Dr5xAzc711mujIMcOsaWHDt83clirNFCqw7+yJr7lGg4f3ohIK9cqB0JG2rPbIKGS3ne
         xVNoLM9My9CLaCJ3r3wwi/an0HADuql9kVXTthphkWTbFi5Yy2L3B/rmT8I+6WszaAkN
         5pMA==
X-Forwarded-Encrypted: i=1; AJvYcCUfxXkI4aaddhSivSrTgyRYBxgiZdfm4buGyLXaCfoLI16738SOqxwsyQy4U2JaeIIeBbWe8hkduu6Y@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1x2CPqczjx8VgL2Gt9GfVubmSROH/+v2Z4sBxVJ0M7LZDgoFZ
	g64GlXxq/RdFRuBDcDaWY3jn0JGaXcxsddYN/WdTMGtrGZXtHL4GguAn9Mqgs2fbTzQ=
X-Gm-Gg: AY/fxX7vMKZqIgGfWYq/IyBBFkqnVyMwhth53YFqRPaQCFrqNrh2G0E4MSt4lihIs73
	lqn0nXXtYditT+h0+oqxdxVRPT94Ncwbma/AJSa9n8GoMrL2nSjE2WdzqbTfS3G+FsjCnpoED+w
	u05mXYV/HZxZxQtv1l0gVSoymIE6iFHC2mjg20xibazs2DAhh9f7wDyLCs1KbW4/Rxcxa9N5XA7
	LHShASylLK/77n5FD3ckQZJ3pQ+nHBqR2JhRukUOEAHq4sF0uaouKCredIqKh8dh2Hs1fyJ0+9c
	Y/4KtEC2h1J2KskRG1zFI9rhkpkeUpa0AEepTDtsHFYBJysxdXge/cYtM7/nTRNDWbT33Hz+E/K
	2tApWrcHxQIfZ2lwzqudHiJETEd5ePsHbfL4ThDaK3xn44NkfeRxCoRk6pGY3q/YJpJhA0gWTjm
	Uw5HJY6j0qkF4cEg==
X-Received: by 2002:a5d:6b41:0:b0:432:a9db:f99d with SMTP id ffacd0b85a97d-4342c535db3mr5505744f8f.36.1768472403629;
        Thu, 15 Jan 2026 02:20:03 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af653632sm5139931f8f.11.2026.01.15.02.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 02:20:02 -0800 (PST)
Date: Thu, 15 Jan 2026 11:20:00 +0100
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
	Shan-Chun Hung <schung@nuvoton.com>,
	Laurentiu Tudor <laurentiu.tudor@nxp.com>,
	linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
	kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
	netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
	linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	sparclinux@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 08/19] debug: debug_core: Migrate to
 register_console_force helper
Message-ID: <aWi_UJcrphO9Esxw@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-8-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:15, Marcos Paulo de Souza wrote:
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

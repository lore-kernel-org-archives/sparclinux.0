Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8E939B4A2
	for <sparclinux@vger.kernel.org>; Wed, 14 Jan 2026 13:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768396821; cv=none; b=RGQg8cZOC3H2HYp37K7+qOxYIns8DGXR3ZRL1JFUIPAO/k+ZPBVJ4Z9qDM4/7vNZiNS6LgLhJN5wcqkSGPBNFy4TQ3P3h8p+ivZwxa1Z83jWMVn93x1Z9+jex2aldlCuVUj7nev4oTmaf3LuyCXSz/vHnMJEcKPAHbX/cekceCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768396821; c=relaxed/simple;
	bh=tXOp5Q+91Ev71kEJDwNUHqTl/QTwmM0CMtRXuMN58II=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=es4PXDKi1uNty+1pc6M438JxMnvh1pWVZ1Ud4LvtJlEokgVqdapPrYaUcKtoa2NKZV2c1p7wV0RDqhbtd01ntIi2LxSOLfaaEualLIVgqoTNov+inUxSHkkAiuwFNV/SvTinfKiMk/B0U6JjweZdakLZNLZnWW8/gnB8Mp6gB2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GlebQonK; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GlebQonK"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fbc305882so4735613f8f.0
        for <sparclinux@vger.kernel.org>; Wed, 14 Jan 2026 05:20:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768396817; x=1769001617; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=GlebQonK1BdB5DbGUyi9LiHoN8EziU92CFCkVI0QFOq3zEhwH6N5lbaRdR+rY/gCBJ
         Fg2NFXOcXLM1sjMYh2EL+pPASArlb7dn5JYQ7xAsAHxn9ooNPyk8HFEWSqJ0AKiLb8Jy
         OQSWVcr/+nNTLUeQmGlmWpTFmRkrVv42YP0mJNxo52tq3Z9CmAHgnisMw8pXZTj3j6iw
         W9dqlfWz3lgvzZ7jhta9fOBYyatVRtFEe5eB3muxZaEykIAOGsy8r+eNHdfFZhS6yWUF
         ROqkPhLwPP8lxjeZu4RqCxL6fdAD5MnzbZZlLD2XpYbBoT63LePeeYvof/5bXqQB6xDM
         DGoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768396817; x=1769001617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sWiGwjTB0ZEpbDkwRFO+MVJzM9uZpDrSFPQIlzRZfsU=;
        b=je/U9VBbSd6OUe+3AFcdYCXAps3mqdNymBQoxnbrWCCfnBSQob9WmsxfaNN9eDNGt3
         3lngHWXd1HZSoNJqg02SMj+jo31j2gsDQqGVQMgi8YC/PrWVA9HVl6eFOwPl8TuKFKfW
         KYgPEegHQwgyP3F3XVQTE1sbrv1l4CMszCdq0bU7M/F71/V+DIvfdEpsIj26RugDya6b
         RfJOVCdhJNcWnp0ke8c8PohL/S1V6PgEOIwiXF4EA4HoIkOT/BVBU0lNXijjZsaYo9bd
         ZM+T/zGtFJsupDTjAi21qq6WnvR5pHvzehbavJlLdc/GuX5quQ9us4l6zDJYzo3pqSi1
         V2ow==
X-Forwarded-Encrypted: i=1; AJvYcCW2WgNEtai9/VfJeR71Z50H3ocsF4d1iqv67TDdINdzHtPbMJfY/4RpOmuGI0J/YPbnInO494YjxNuT@vger.kernel.org
X-Gm-Message-State: AOJu0YxLiO2/PRb5uYgnx937Yglot0Bup/bMPOi8I5+K0aAI22njnmMv
	8bffQpDzQFwppTqbtTFfvD0C7JzNeFLl72dy2ZuPsK/4feALqeFdkk3VNoxKtNGf59Y=
X-Gm-Gg: AY/fxX6d0CTGdeTbmEksIMQJO0/uh7eoAQYiiTtk0WkoaLNZGwZjQKPVAbeCCzQ94a7
	TiEVHZOF3Hq5rnsDmLkIFAA6JFmNOFpoL5ur5aWTByHsE+/fXa2ULmCX/GuvBtm58vvXgGDOspN
	jGUPJOAPyP88ouFe2gYVgSEHLWYnnGXr22LWHdAb6wCUD+xp9kH+QyEXpx05deQVOUALHNjseAa
	lnZQz0h6guK3lMBbik+MGlsnETZtEbvjXRGYdyNBmeyAJQysZgD4m17CpEoY2fVHHCqj43EnWPJ
	a2rzkpQ2m/edrVStb7cIsYCr8d7uN2MVdbncmyE2fgPMJicXdqNcZO/3RgdO66qb8958uVlWNWk
	EDDNLHA8DGVz9/mc0X7UCFzJjV38pTqEbBDecSBqQJYT2QrcbQc1D1nK75wyp75GsN86wGIKxTO
	dCXMoux3vQwtRq+A==
X-Received: by 2002:a05:6000:2511:b0:431:9b2:61c0 with SMTP id ffacd0b85a97d-4342d5b2ab9mr2581603f8f.24.1768396817421;
        Wed, 14 Jan 2026 05:20:17 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm49153435f8f.4.2026.01.14.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 05:20:16 -0800 (PST)
Date: Wed, 14 Jan 2026 14:20:14 +0100
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
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume
 functions
Message-ID: <aWeYDoMsdBNkJEqO@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:12, Marcos Paulo de Souza wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

The improved comments would have helped to understand the previous patch.
I would either merge it into the previous patch or switch the
ordering.

If this stays as a separate patch, feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75FB393DE2
	for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 12:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479190; cv=none; b=jvfapCiWq4AGaDhcRA37UaJeCi0w0WPq9HI/kicuyXhqhy2EGfwJwLE6c+E5ylGnffDT8G/+LbT505OkaOTAs08U2Nh2xpa4AdQg8ON0Zk2Ut+9SJwRb+PDGF+/V5r0tKWVi9UK5BMgRskLEA6fPaeX0A7q510YfCQj0jVoPTV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479190; c=relaxed/simple;
	bh=WgWNQzN1HCbfxhvYic4vy3EiJadotNmJsmSAKb79EIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=js8TOOiR5NzKXuXdoHBu4AhgIFjnCdp5U7yXUK9TUufgAMZii5e8B8fT1AtPjscXezIIP5seI+22Yuhz0Q+ZiE/w9E/OBer6HYqZ2tPSL/REdbSSm1lhryDw0X0WB3M4TeWsbNUiE3sSJnjSXFzqHtx7CKpvDrTfn+WTSF9BaZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BfTHUrZ3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BfTHUrZ3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47f5c2283b6so5175505e9.1
        for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 04:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479186; x=1769083986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=;
        b=BfTHUrZ3u5ApH8EMCkFS7NjojsplUSRc4DXcm4dai1QX+UpQAxW6Lfy8zd1RnxLsIZ
         W6M14mRS7L5U6AW17JqpChgweZ2bcLX45gBaMp2WfX0ratjmrgOz3cuZjOrvLPRigfVF
         AXb8vp4TdJpOEfHcwONsQKtadDQ1g+FQQI8vCbQKoRVywWEtW4uh2GNwSGWQVTbvYGLn
         7hrpzdn1bVFQsL1C8x5ZyoAu8bgCLO9wmlcaujAh+qLtYBvNDQVUvIPgTFL4vJgrLRzA
         OzvmDq8oiNhBno1p6gWZWEW5/gDsq2mQl7a+Q5ac6Y4uqg35suO36FhIdGnoZGK1v+L8
         BIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479186; x=1769083986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tARhp8b6WpUCQdTEvi4pG8l7ncFl190/VBWtO1OWxSE=;
        b=pnvve3nMxH05vMZjVnEK+wE5RQ7u3sxQbmyvt/iRncsGLWoPQQj9OqLUzWvHn/9TMN
         707HArunBtNt1u6rQZ3RA0RHhM3wgwQesLS1dapjgZh/SQhtzSBK4i243fGICQypkFcA
         qAleX522i9YuzQq3bBpGxfgciH4kHgaet+NMrGvK4HTATPDDQ5aZMgxZlp85dq7Qelcz
         I3N4k6qy+fzBtLnJxy7tKZileER11HJADlEKJtDWWVjuSnRFslxnhGenbglj83DdgeD1
         0wncXFGkAi3vOVDVA3Ku93DIqSa3EFv0n+KNky8AnnV/nCBcvU/txia17guUQ+qBZ2/5
         cANQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmKUHrGVnOa99Buz/CNbs5wSZf5MnjwHBw4ztfq3lcLjjkKPkWiJTBMJqmHHpVEtWu8KErlSAHh+wC@vger.kernel.org
X-Gm-Message-State: AOJu0YyERjv5R56yMXoYRHHR8uDk8rdoqMoxm33s66IQcR/rVtrjNFnb
	ErxgOTTgTcl3R48PptToK/ABXOwkrX5Bb5SwSFldVO5PX0epKv9+3opjXHzSx0k5vXs=
X-Gm-Gg: AY/fxX4vEnbKxmAQ41gkGudQvzK7G7H4M6HEcMy3aUVRPTlMrtQSSHwSC94Y4lZSkZi
	xO8Mr4qvFMdhic3870tkn12/21Zvdg3UUhNyiLVAy8GTQKcfR5vA2w1HLHYEnUfHU2HmB2YGQEk
	kgWuUhq5D20JrbUc74LCskW7XYEPOKq8izB5qGNm2r3frbVaV6UAo77/XFOS9sYTjS8e3lvlMq8
	7v1L9bPSg1KXHdd5lQ/Uux5C3957CK0CdUteqx5Hb2OmU/VR+VffVL2sm1JbBRttpyUw4P9b+CG
	No5U8w8xO1hX4lrc2KWOGEBZRXLG0/rEveIk6sOzIJiRGYCy6twEYWImQOB30oNm3MY/SqZq0RM
	X/AZYztoKrpbWmIX4vojSAPUOcC4iL0tZd65ykKzkmR+fmuotQ/zv+fsYPHdk6qbzH4ExF+JBD+
	yZmmRUN7ScmUW/5Q==
X-Received: by 2002:a05:600c:1c20:b0:47e:e712:aa88 with SMTP id 5b1f17b1804b1-47ee712ac96mr42613125e9.31.1768479186231;
        Thu, 15 Jan 2026 04:13:06 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4801bc3e57fsm22590935e9.5.2026.01.15.04.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:13:05 -0800 (PST)
Date: Thu, 15 Jan 2026 13:13:02 +0100
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
Subject: Re: [PATCH 11/19] powerpc: kernel: udbg: Migrate to
 register_console_force helper
Message-ID: <aWjZzuY31bg95jiy@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-11-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:18, Marcos Paulo de Souza wrote:
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

Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6604B37417F
	for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 11:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475160; cv=none; b=b2T8wxxm26fgLZkIpuhro0fdBqEurlsGTs6KasfHVzKCysB25sVqrw9IS7UqAYUX6TKaRBASGvmhb7VlL8uoKMvYXmaiCjSNOL2gu9C6pktw0Dp5RW64m1DRMMJrdXyC4/H24kZPRGEA0pNzF3hU4ie2eqKLHzGkTclWhg3hbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475160; c=relaxed/simple;
	bh=5pJaxN7hZxh6H+l9RH7y9R9O3ys4FH/dz9mNWCjHNb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HQ1k2Zwrs3o8S9EfHTSYkYszfgTQVLz2iYsxcLi71ZrfIspvhWBUt8sdlExAuSZpglBcN3NBxYpazga5GmizhxLUBWUWq/6/Zr0Jv+oUK/EdU9ynlwVouaphYUwz2sLPUWEXrmkhQnOqWiZS6wCdF/r/md+qc/HUqleMPj3QiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fjVUrmSC; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fjVUrmSC"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fbad1fa90so717993f8f.0
        for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768475155; x=1769079955; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=;
        b=fjVUrmSC9MSMqvxswqINqxfP7kInAvh2yUZz80Lx3Oz+J0nN4bpCMKnlR2Zs8PT2QI
         bru01CF9kzRl9QNE0aKptzLlWYeW6ezbhmt50gw0LnNCmoUv69ek4KUzsAEcc35qfbPM
         lWwa/dQor4rpZjr+5VsOA/fiA1EK0/Jy8iu+Vs60ZCcGmBsET27cADZ4cxK5Bc5+M4wF
         8Rfsv+bacl3Jjoo4oi5xtuZsFEhOPKiQKnDx/rO2nHosgTuggeMHXRbt+HfiFHfLlG5s
         yQFtE0iNZlDQATflRbguDlFwutYJ15Xb41/PsBGo5/A8ZgOOOV3bF0JXKgayZCUHaGMb
         NP7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768475155; x=1769079955;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuZzUvIQYamq4W1YoLrzX7y0En5/TpcBTyFE7gx3A0A=;
        b=WYabouZzCOuaD8UcTputb76TsepP7qFdx6ZDq7m3WRid9Vum12u3/Bnzdh7Py0qHaj
         iiRC+eru1a3Qw//ymFcCrLxCSCUGZG1WUeplkIXl/tsv4WzyvBAGaK0feheK3wGyCcvo
         +ezDeEtVSL0wHDrss/S6SUnLOiXEIW05XTM/qAp6MPtffNpGLIDgjidWHDidjiudenL3
         GMOqM+CAxsX6S4nFgHkgAG1wQPXugu+GJBP3/GqT5Ngla3bQI0ZZDl8Kpd120icBMEUW
         dxxf1zfebO7/7u9t4bJNAlbDAY0B0Ahn4Z+5zw+touzOx6QJdnt35Qnw3Coj42WGsbx+
         4iBg==
X-Forwarded-Encrypted: i=1; AJvYcCVTrT7EBSK+xgZdiDPjE/5VL8lxXXd17PbXkTnGPlPZzXnOoUxS4mVM1nmsa/0wngwdJZ2fa7SDwDHv@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2h26VCAfYMnrocanIqzlc6iCcJeMX8OXBeuJSO4L/7LdsNw2n
	+fZPeAWhqWzhMsrab4ZXh7Ew7BAsnt25xsmGdBi/9gKYHwNbUqgTEIB7ySQo/cyNeqE=
X-Gm-Gg: AY/fxX7RjRMkHfb0ThqBfN0w2/VAwSBTFCtpJuXWf8BcU/KKUx/YH+NEm5e0762gTql
	H/Sni9av/+HEklNJ+jH+kX15gIExF+hqwUmQkzPRjfilAUy606ZrwFo3Xx5VesKluzhUtByU2A7
	wqJUMwHFJwpIH4DJv62YmE0vqtVCIVGyLYw2c0RMLq8aSyooENcGQteuGuf+9j/jSoV4RED65co
	29CIofwZEaI9aGdaSmqzIsZpIIFffNsWe1g8auDLdHFFVwQEuDPuB4IUUjg4ug48xccdcIgkFqa
	43fN0XFQ8IM3ZM3+JiJr8/8GLZx4OU8QMD5zl7WHXLC4Da2/JUUbIFstkUSwBbDq8on61pP2G6U
	+nD1A/1H3ON/pO74OFKhQFecA3ovsHgUpE7IDFq9TvUhaJCixqFGyBFUaACPLd76A2oCITHVGgp
	/kc6uWNjK9Z0V2TA==
X-Received: by 2002:a05:6000:2f84:b0:430:fa9a:74d with SMTP id ffacd0b85a97d-4342d3912bcmr7103110f8f.24.1768475154515;
        Thu, 15 Jan 2026 03:05:54 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af6d909fsm5297949f8f.31.2026.01.15.03.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:05:53 -0800 (PST)
Date: Thu, 15 Jan 2026 12:05:51 +0100
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
Subject: Re: [PATCH 10/19] fs: pstore: platform: Migrate to
 register_console_force helper
Message-ID: <aWjKD4jv8CySV0Rj@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-10-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:17, Marcos Paulo de Souza wrote:
> The register_console_force function was introduced to register consoles
> even on the presence of default consoles, replacing the CON_ENABLE flag
> that was forcing the same behavior.
> 
> No functional changes.

> --- a/fs/pstore/platform.c
> +++ b/fs/pstore/platform.c
> @@ -418,10 +418,10 @@ static void pstore_register_console(void)
>  		sizeof(pstore_console.name));
>  	/*
>  	 * Always initialize flags here since prior unregister_console()
> -	 * calls may have changed settings (specifically CON_ENABLED).
> +	 * calls may have changed settings.
>  	 */
> -	pstore_console.flags = CON_PRINTBUFFER | CON_ENABLED | CON_ANYTIME;
> -	register_console(&pstore_console);
> +	pstore_console.flags = CON_PRINTBUFFER | CON_ANYTIME;

As the original comment suggests, this was done primary because
of CON_ENABLED flag. Otherwise, the console was not registered again.

register_console() might remove CON_PRINTBUFFER when there was
a boot console and the newly registered console will get associated
with /dev/console. But I consider this a corner case. Other console
drivers ignore this scenario.

I suggest to define the two flags statically in
struct console pstore_console definition as it is done by
other console drivers. Remove this explicit dynamic assigment.
And add the following into the commit message:

<proposal>
Define the remaining console flags statically in the structure definition
as it is done by other console drivers.

The flags were re-defined primary because of the CON_ENABLED flag.
Otherwise, the re-registration failed.

The CON_PRINTBUFFER might get cleared when a boot console was registered
and the pstrore console got associated with /dev/console. In this
case, the pstore console would not re-play the entire ring buffer
on re-registration. But it is a corner case. And it actually might
be a desired behavior.
</proposal>

Otherwise, the next generations of kernel developers might think that
the re-assigment was there because of CON_PRINTBUFFER flag.
And it might cause non-necessary headaches ;-)


> +	register_console_force(&pstore_console);
>  }
>  
>  static void pstore_unregister_console(void)

Best Regards,
Petr

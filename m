Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AD637F728
	for <sparclinux@vger.kernel.org>; Wed, 14 Jan 2026 08:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768380264; cv=none; b=srNi5k1vAKx1pWtIu2rFko2Vmc3JYBDRDp6yJOl6mEhoCMI6tYnpSWAUO6mDI0sK/jEXmz3GdPBXGg5f1bcbCLsv5WCuRJDSl5fx8Nsj/tCJDgvuP606dyJnLJqaDrePSdvHER93Wab9iOw3jXVg6zXCnaEl4crE4pftS8OuJiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768380264; c=relaxed/simple;
	bh=ysd4WYTvCh9+HsQ1AtbOfW5FzL4/iKQHwd6lm5bPF7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oeLHKfxyS473Wuy9Hf6RPy3wOPjgDWdWU9em4KB/4X2Wr9OaRanOzXV4TGrARvc9CKUmmoifUt2RgC03NeHSEoVxMWu6XTdeYBYH7X+aJclDql1SPX6xk1AJ5JDC3kIOAMYensPajYifX0Mp/pI0WPdS18A5OKUfNVtXQvJyKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UJDpRkoJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UJDpRkoJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-432d2c7dd52so4502160f8f.2
        for <sparclinux@vger.kernel.org>; Wed, 14 Jan 2026 00:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768380255; x=1768985055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=UJDpRkoJ07RgspaR1NhfCpR626ZyVYHDm/91x63cM8gsy5+B8MAqHavRm979cqv826
         adfCBmE4P0x6kfOJf6QVKQ+F73K8lwHrXn3rzPWHcqFa3N4E1nvvheWr+fvWlsfjnG3d
         q5I4aa3r8n+1bnVHkuJKjH4VnxEE0Ax/OlO+0AlsTNmjx9JmMpIQmGfXyFrUV7bjE4AG
         b+aIpJVdS5yOciq4wFCdKoOH2ygYDkIIMtINtTrq5bEwn2hZxdIsOnH1Mevl7p3aXRkT
         mmHrpfvAEIKMqwJsI6Dxxcv5mSGvyKeQIfwtfaMbksOr61rqb70D/17uospsX2LrpTOB
         fjgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768380255; x=1768985055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Nn9M/VPDoeuifL+P7no8o5FApQZk7zNKYvSR+p2CRU=;
        b=KCbRiQ3FuHnbpVZ6C+PT/87vcwhvRQtngvC4Fuyf2eeldmj1YpQ6dzRUGPEqnjCQ1Z
         WnlxZOfUtA/Q4KsvsPHwVSGNptwYUxNxaHvkQRAmtznhgJMOWJZ1WEdjmgsST4/2UJ97
         CeEP1C45s+pB1cZAJwghxhBR9ctIV7ogUSd0bKoVbCozY3a1/lwyrS51xH1541s/38oR
         WUbJlutljzBpPd0nccS81uIwdiclG87NMATIvCV5pBpuMp6NKuoGVE0qe9/StFwhqeO6
         q+RX/iVbmxFQj4G9XK4czfTS23tpaNWSu4JzrCt/lWia9BXR7+ud3M25y1Ms71BGtN/T
         u95Q==
X-Forwarded-Encrypted: i=1; AJvYcCW9tiC7a0sIeq7YZX7xwE/RjGCNl8HZYFXsaH9KwBDbhcHS0KyTuAiEPauoXMCNSCrovbmD8WQkmmax@vger.kernel.org
X-Gm-Message-State: AOJu0YxWRChX57KrqkS4XSudiWrsHxsZV61c+53fz4xhgaAXOmXbJA8b
	Uo8Uxpqz5x7uh912/5kd1BlXrJHv3xs9ZSsYdu/6vbyvBpkrowA3wFEdex1TRAGmOPw=
X-Gm-Gg: AY/fxX6ZkSjw0NJRLMVZ/CrP92HJx0Z7kfxwKB9jdHbYnf9PGcU3PA0LXwNE4Fn1iSP
	fqEBI2/67mgzDO6rj8P2eepouJRd9hdZbO5ITGJ/VBszsHt1Uo4ahL6lOiBB7YsxGCgOrvrMBVc
	JnZXzDvPy1pPg1YEj56cfpIe7bTut5yteiXxJ1PG7bsYHkWBJuXGt9E3PHtBahAd1vOuwCs0rQe
	0LIbn2nW/v4VvrVIjLmCN/6wFyAX6TvqpufqOfgADUMajUPSv54LMB1j1EoKwTgM2vvqHRjScd/
	pc2ImEJMb0SrdVJlLdPvpKqcLVNKHx12rHJqDpQklrysjHAXzFbBnAa0dUhtNu1hve2WPMeW0yg
	zQLbgQKkuKzwffQWbQRomlZd4q69ZEdoTFAoqN9/+6fhwmgLEqpzg50oY4pUzVeLjlGxse/gfm/
	4TsB0EetXN0weprA==
X-Received: by 2002:a05:6000:61e:b0:431:a38:c2f7 with SMTP id ffacd0b85a97d-4342c574bedmr1500621f8f.59.1768380254886;
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd5ee5e3sm48685590f8f.35.2026.01.14.00.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 00:44:14 -0800 (PST)
Date: Wed, 14 Jan 2026 09:44:11 +0100
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
Subject: Re: [PATCH 03/19] printk: Drop flags argument from console_is_usable
Message-ID: <aWdXW6ohfQ7_z2B_@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-3-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:10, Marcos Paulo de Souza wrote:
> The flags argument was also used to check if CON_NBCON was set, but their
> usage was fixed in the last commit. All current users are reading the
> variable just to call console_is_usable.
> 
> By calling console_srcu_read_flags inside console_is_usable makes the
> code cleaner and removes one argument from the function.
> 
> Along with it, create a variant called __console_is_usable that can be
> used under console_list_lock(), like unregister_console_locked.
> 
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -656,13 +656,8 @@ extern bool nbcon_kdb_try_acquire(struct console *con,
>  				  struct nbcon_write_context *wctxt);
>  extern void nbcon_kdb_release(struct nbcon_write_context *wctxt);
>  
> -/*
> - * Check if the given console is currently capable and allowed to print
> - * records. Note that this function does not consider the current context,
> - * which can also play a role in deciding if @con can be used to print
> - * records.
> - */
> -static inline bool console_is_usable(struct console *con, short flags,
> +/* Variant of console_is_usable() when the console_list_lock is held. */

Nit: The comment is a bit misleading because this function is called
     also from console_is_usable() under console_srcu_read_lock().

     I would say something like:

/*
 * The caller must ensure that @con can't disappear either by taking
 * console_list_lock() or console_srcu_read_lock(). See also
 * console_is_usable().
 */
> +static inline bool __console_is_usable(struct console *con, short flags,
>  				     enum nbcon_write_cb nwc)
>  {
>  	if (!(flags & CON_ENABLED))
> @@ -707,6 +702,18 @@ static inline bool console_is_usable(struct console *con, short flags,
>  	return true;
>  }
>  
> +/*
> + * Check if the given console is currently capable and allowed to print
> + * records. Note that this function does not consider the current context,
> + * which can also play a role in deciding if @con can be used to print
> + * records.

And I would add here something like:

 *
 * Context: Must be called under console_srcu_read_lock().

> + */
> +static inline bool console_is_usable(struct console *con,
> +				     enum nbcon_write_cb nwc)
> +{
> +	return __console_is_usable(con, console_srcu_read_flags(con), nwc);
> +}
> +
>  #else
>  static inline void nbcon_cpu_emergency_enter(void) { }
>  static inline void nbcon_cpu_emergency_exit(void) { }

Otherwise, it looks good. It is a nice clean up.

Best Regards,
Petr

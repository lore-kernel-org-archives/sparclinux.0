Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5256A364024;
	Fri, 30 Jan 2026 17:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769794051; cv=none; b=JX0ZdVqwWBpvbt/Yd9xh20CpEznH90ket8328KKx2r9suj6lMrKowIgR2zNGnSYngHtWXYA/Qlc30/Om1JUSEBNr2AuL3qgXRotGs2tPfZU4xYsMygVwiDV5pxuUDZXXPaH+yRUV56K5AbpfdkN0JHhDvu6zhr7tI8foRGD1+sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769794051; c=relaxed/simple;
	bh=2+OMGUQcuKS2tJWaxFiW0o1E0ku3RG+1C/hjNsN6rPI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u3gwN9Z0FlK4ZcRip2xnSiFJhvWnwHb6LEvvFZEoKYkAz2+YXPIETKyWwJ+th5tr9MYxG05JPOFHjs/0Vb9wjDc/5iZkMkuNihWyohlRqoABM2YxTrHeqpruJoCz7BLpHjbbB7TTjJI0nwTIk2r353W16h9r9fjs3t3A/IUzqdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4vjFnCId; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=520kqiAp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4vjFnCId";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="520kqiAp"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769794048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3M3i7fOsBJJ8QZ7iZoiOC82WHRYdzsj5QwfB37tvhM=;
	b=4vjFnCIdprQ4bapgrR0W30E28e5XqGnWTzlLJRIchP5KT0mQiU7C2HocIuX1Kdz8pUDo0Y
	qc+5Orpl1l1vZoFNRQKL24RKcgRr4rbqO02DrPCVc+5aUzHom7b8+oniEw+b53sZSdrxJg
	+9kDxpq15AQ1xIFUPYwfQgdiBumRwsh+faRgD4dNJMyLkXr/A+P3jXB+CHRA0Hld9eIR+Y
	7xvqnLxeTCF6EQZwTVn1wPEr2oy9Q/+88+eiC8F7PD8kB/n3dpKOZdgpjEsqUgdQZXqqI6
	yQRXOGphajl9ppYkFrEud4nWZdOCa3/Ob9kGErESIR3cRVjE/LChlCPSJd3YTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769794048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o3M3i7fOsBJJ8QZ7iZoiOC82WHRYdzsj5QwfB37tvhM=;
	b=520kqiApVkDPFPboRTL5PTkP4fVPei7/H7ecnPwf1SVFxrBJQEXzDTADXeZGZGuaQ0gr4c
	ZZ61wAzhpOPpFsDw==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Richard Weinberger
 <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes
 Berg <johannes@sipsolutions.net>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, Jiri
 Slaby <jirislaby@kernel.org>, Breno Leitao <leitao@debian.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Kees Cook <kees@kernel.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <christophe.leroy@csgroup.eu>, Andreas Larsson
 <andreas@gaisler.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jacky Huang <ychuang3@nuvoton.com>,
 Shan-Chun Hung <schung@nuvoton.com>, Laurentiu Tudor
 <laurentiu.tudor@nxp.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org,
 netdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-hardening@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH 05/19] printk: Add more context to suspend/resume functions
In-Reply-To: <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-5-21a291bcf197@suse.com>
Date: Fri, 30 Jan 2026 18:33:27 +0106
Message-ID: <87343n3ta8.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-12-27, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> The new comments clarifies from where the functions are supposed to be
> called.
>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
>  kernel/printk/printk.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 173c14e08afe..85a8b6521d9e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2734,7 +2734,8 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
>  /**
>   * console_suspend_all - suspend the console subsystem
>   *
> - * This disables printk() while we go into suspend states
> + * This disables printk() while we go into suspend states. Called by the power
> + * management subsystem.

Since you are touching this comment, I would prefer to make it
technically accurate. It is not printk() that is disabled, it is console
printing that is disabled. Perhaps something like:

 * Block all console printing while the system goes into suspend state.
 * Called by the power management subsystem.
   
>   */
>  void console_suspend_all(void)
>  {
> @@ -2766,6 +2767,12 @@ void console_suspend_all(void)
>  	synchronize_srcu(&console_srcu);
>  }
>  
> +/**
> + * console_resume_all - resume the console subsystem
> + *
> + * This resumes printk() when the system is being restored. Called by the power
> + * management subsystem.

And something similar here:

 * Allow all console printing when the system resumes from suspend. Called by
 * the power management system.
 
> + */
>  void console_resume_all(void)
>  {
>  	struct console_flush_type ft;

John Ogness

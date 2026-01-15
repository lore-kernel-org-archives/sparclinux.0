Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D46A378D6E
	for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768479886; cv=none; b=kB5dASlv/3hxUxLN3uvQg7AkSWnP6Sr21Zm/xhkqcVpPxcYk/Yc1LV61MY5TE+XJ3lJIJtU7YW8LBiETuZVxVYNWTeF5P/DvqCppeIl8w9cfa9pFCeRpeAgXXLs1ejKApeVLQ3J9MEHspi9RwBHprNpFbvzPW5K8hE1/pmTzkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768479886; c=relaxed/simple;
	bh=L1TTyH0HQfm7i7n+eqeYhrSGiuwmELmvtw7QQ3GNH2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJTgVFWp6XqWBZHm5yK2Uxo3C0olNZlzwK68XSYkkI7tShmM5rhkD+PfU3yEL99mAn/6MAbzfW76ThUK2tMsqYaYv+YKWNbAOsXU+Bl4jJieDZ1B0oQBn8axQ4WX5jNs/d4JDKk/RM2RrMuK23r70gw9NVuCX2P35S6RRoRDJUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AavSW8zD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AavSW8zD"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42fb5810d39so634089f8f.2
        for <sparclinux@vger.kernel.org>; Thu, 15 Jan 2026 04:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768479883; x=1769084683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=AavSW8zDa7wyUQOrKCsE5mEiLhCbCgtNLUJDLiygsCIz5MtcNfL5qg5hmiFSH/hnLF
         dY1NM5kxU9pSW9DgohxUfSzAVt+iLYuHkRY/WkdFE1XVmgvI8pljiAwerID8UL6g7PU/
         eolJwYFX6Yj0B7yZch1EvVk8qqbK6y7rtIhghbakTGjeNT0IeZm0hOjwyUU0ncWi7Ohd
         fORx/nYcwlXu0aeT6z2nysNJs2vxMwjVnQi03RkyIvPvmebQbr0uJa/GOMbQXodXURQ6
         +ZErOfCH6CKBneuJM1DXIQJeb7qxioDN+X5ZyEYo1486PL/QTstgRmV32S5n4c6fMV9G
         3dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768479883; x=1769084683;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jS491F7pY/6VV44vwrzsFaAyA9RjAqjEAkamZCNInAE=;
        b=gyE9czdellhO2NQF1tk4vd1q/wYwdKEIlDdusv2wjl83JWRoz5dCopFr5KMi16xMig
         Cy1ZOJ6c4j+fZx4ieE50D9JwFqpnWcZph+ljIYbtkfKdLPmTuRDHa/tAK+ORfAYKT0JE
         TGYvIOBwHqv3JVwDpXO/6Z0dPgiWBx1TDj9fN5Hqt8DFLjDsjNw/0nCJVZ0csLETXyUC
         W8a6G0Ym3N2H7h2YNEjOeCgL26EuoS+urzR9/NrLJUZr3tFBfa7sNonLUkt++KDzj96x
         eOChq9hYWSagi8CQG9/5XCXQ3tLSahp8eXzK0ydy/WfqJTRLZNM9AM6oggmEdYSjAEpc
         4QEw==
X-Forwarded-Encrypted: i=1; AJvYcCXLZ8QNJltgy8up9d8GjTcigZX/9P4EaYGJVU6N8dmTqzJgYtjfL8bN42dlOsjcB9+fxIPNI9MOqfHl@vger.kernel.org
X-Gm-Message-State: AOJu0YyQed6vwgiZXOfg3S7H2Y9it3cHwfabFZwsp73sXwRH6I9/pvD5
	rCirbJeJABUq338IjlHiqRJG+VeRNDQQgHWCOr5nV/kLN/iOUXhibLWeFuHbhy4Wfhg=
X-Gm-Gg: AY/fxX7JR+pdSJ/ZzLtMMeMc0AH/8pIGuqYrc2tW63LYeFSyspZhK6Xj06YGd2nc9Ti
	WMlqKzbvCuEgDWd2PvHRCQybDHlmKHgHyvt4qj60b0p3Ote/9Jm4QCv73/TW2HG/ewKBYQiAkw0
	E8xyWAcW32bGz+E21cOk7vyQxTjVdpn5Ht0CXT7G4Ol4TYQFvBwKkIpG2zOmm1ZmNoTk6O4yP4Z
	1lOrCdhSw+KHjgmz1GZdKcZHOtk76l95DRSZgLx3KO/22+G649d+lNLHYO+2chwLehPbnYTtwvP
	QY3u5rr4oUNkz12XiYkFG0+3MjMLTYpyJhqGBVSHSqo12gjMuPZgpIoVHbsiDvd3xw+pVZQMQqH
	9WPiMOf4qy6B7lgw6F7MiFYwPfZVX8hue7zIJdmDgqtCjqEfdBybJL9larVlvG/EpXZ4Y5QhF7p
	z7DxMKEXaRS3mktA==
X-Received: by 2002:a05:6000:1789:b0:432:5c43:64 with SMTP id ffacd0b85a97d-4342c547aa9mr7495008f8f.41.1768479882771;
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-434af64a650sm5653238f8f.4.2026.01.15.04.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 04:24:42 -0800 (PST)
Date: Thu, 15 Jan 2026 13:24:39 +0100
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
Subject: Re: [PATCH 13/19] um: drivers: mconsole_kern.c: Migrate to
 register_console_force helper
Message-ID: <aWjch-EcYm7tkF0t@pathway.suse.cz>
References: <20251227-printk-cleanup-part3-v1-0-21a291bcf197@suse.com>
 <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251227-printk-cleanup-part3-v1-13-21a291bcf197@suse.com>

On Sat 2025-12-27 09:16:20, Marcos Paulo de Souza wrote:
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

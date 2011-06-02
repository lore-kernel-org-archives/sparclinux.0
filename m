From: David Miller <davem@davemloft.net>
Date: Thu, 02 Jun 2011 21:42:05 +0000
Subject: Re: [PATCH] sparc: Do not select GENERIC_HARDIRQS_NO_DEPRECATED
Message-Id: <20110602.144205.1691129951056490754.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1306568396-10438-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306568396-10438-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: geert@linux-m68k.org
Cc: sam@ravnborg.org, daniel@gaisler.com, tglx@linutronix.de, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 28 May 2011 09:39:56 +0200

> Config option GENERIC_HARDIRQS_NO_DEPRECATED was removed in commit
> 78c89825649a9a5ed526c507603196f467d781a5 ("genirq: Remove the now obsolete
> config options and select statements"), but the select was accidentally
> reintroduced in commit 6baa9b20a68a88c2fd751cbe8d7652009379351b
> ("sparc32: genirq support")
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

I'll apply this, thanks Geert.

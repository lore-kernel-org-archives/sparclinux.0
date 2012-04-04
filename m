From: David Miller <davem@davemloft.net>
Date: Wed, 04 Apr 2012 07:52:22 +0000
Subject: Re: [PATCH] irq: remove obsolete definitions in interrupt.h
Message-Id: <20120404.035222.1873553360219906110.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120404074553.GA14959@merkur.ravnborg.org>
In-Reply-To: <20120404074553.GA14959@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, geert@linux-m68k.org, linux-m68k@vger.kernel.org, gerg@uclinux.org, sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 09:45:54 +0200

> interrupt.h contained a small fixlet for the days when
> m68k and sparc32 did not use genirq.
> As they have both entered the modern world this
> fixlet can be dropped.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Acked-by: David S. Miller <davem@davemloft.net>

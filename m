From: David Miller <davem@davemloft.net>
Date: Mon, 08 Dec 2008 09:01:50 +0000
Subject: Re: sparc: fix a few sparse warnings
Message-Id: <20081208.010150.19740563.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081207203330.GA27505@uranus.ravnborg.org>
In-Reply-To: <20081207203330.GA27505@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 7 Dec 2008 21:33:30 +0100

> The best solution would be to move the interrupt
> handler to floppy_32.h (as we do with sparc64) so
> we keep the dependencies local.
> And if we do this maybe we should just rewrite it to C
> anyway. But that requires some sparc assembler knowledge,
> and the real gain is minimal so I dropped it.

Unfortunately it's in assembler on sparc32 for a reason.

You'll drop data bytes and overflow the floppy controller FIFO on very
old sparc32 systems, particular sun4c ones, if we try to do this in C
code.

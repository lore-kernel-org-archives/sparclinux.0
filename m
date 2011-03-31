From: David Miller <davem@davemloft.net>
Date: Thu, 31 Mar 2011 23:57:59 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ
Message-Id: <20110331.165759.112599932.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Thu, 31 Mar 2011 17:13:35 +0200

> This is sad, as we have designed all LEON architecture to be Plug&Play
> as far as possible, and it will be software that limits it in the
> end.

Never is this the case.

For any future device you can provide properly formed firmware
device tree nodes, with all IRQ entries included.

Stop fighting this, you made a mistake in the past, and the set of
broken device nodes that need fixing will not expand if you start
creating them properly starting now.

You made a mistake, add handlers to cope with that mistake, and
take this opportunity to fix things so that future LEON device
nodes found in firmware are properly formed and contain multiple
IRQ entries when necessary.

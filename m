From: David Miller <davem@davemloft.net>
Date: Tue, 20 Nov 2007 02:15:47 +0000
Subject: Re: [RFC] Minor cleanups of the sparc serial drivers
Message-Id: <20071119.181547.45982194.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071120021014.GA15879@palantir8>
In-Reply-To: <20071120021014.GA15879@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Tue, 20 Nov 2007 02:10:15 +0000

> This patch against 2.6.23 sparc-2.6.git contains a number of minor cleanups
> of the sparc serial drivers.
> Initially I fixed this build warning:
> 
> WARNING: vmlinux.o(.text+0x107a2c): Section mismatch: reference to .init.text:add_preferred_console (between 'sunserial_console_match' and 'sunserial_console_termios')
> 
> which is done by declaring sunserial_console_match() as __init.

I haven't touched this known problem because I think it's legitimate
to register serial consoles from a module, yet the current console
layer doesn't allow it.

I can't think of a clean way to make add_preferred_console() non-init
so I'll likely apply your patch.

Thanks!

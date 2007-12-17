From: David Miller <davem@davemloft.net>
Date: Mon, 17 Dec 2007 09:57:55 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071217.015755.10498733.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 17 Dec 2007 10:40:05 +0100

> The machine was stuck with a white blank screen on the monitor, and a
> dysfunctional keyboard (USB). It's a standard keyboard that came with the
> same machine, and otherwise works fine. It's completely dead - not only
> normal key combinations (including Alt+SysRq), but pressing Caps Lock
> doesn't turn on its LED, and Stop+A doesn't work either.
> 
> The machine doesn't have any ports for the old-style Sun keyboards, so I'm
> out of options...

You're more likely to get a good crash dump on the serial
console, if that is something you can use.

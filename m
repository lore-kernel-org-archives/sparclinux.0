From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 23 Sep 2004 19:43:44 +0000
Subject: Re: boot failure for 2.6.9-rc2 and 2.6.9-rc2-bk6
Message-Id: <20040923124344.7b5dd575.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20040923150722.GF31137@azrael.luon.net>
In-Reply-To: <20040923150722.GF31137@azrael.luon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 23 Sep 2004 17:07:22 +0200
Admar Schoonen <admar@luon.net> wrote:

> Remapping the kernel... done.
> Booting Linux...
> 
> and then nothing happens. With 2.6.8.1 and before, the screen used to
> blank almost immidiately after that, and then showing some messages in
> black on a white background, followed by a flash and messages in grey on
> a black background + quite penguin.

It's a early OOPS that happens before the console is set up,
if you had booted with the "-p" option you would have seen
the OOPS too.

I'm working on a fix, it's a bug in the timer implementation
on IIe chips.

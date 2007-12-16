From: David Miller <davem@davemloft.net>
Date: Sun, 16 Dec 2007 23:30:43 +0000
Subject: Re: Fix for sparc64 cpu hangs.
Message-Id: <20071216.153043.118573976.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20071106.203433.144763156.davem@davemloft.net>
In-Reply-To: <20071106.203433.144763156.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 16 Dec 2007 23:41:19 +0100

> One problem I was pointed to was the build failure of erlang. Here the
> created erlc binary segfaults with a bus error.

Find out where the bus error is occuring.

The futex() line from the strace isn't very interesting,
it just shows that one thread is stuck because the other
one died with a lock held.

I really don't have time ot do all the monkey work to track down this
critical debugging information and you have the setup to trigger it
already, so if you could please do this I'd really appreciate it.

I've already dumped a ton of time into fixing every single
problem you've reported, it's frustrating to be dumped on
with even more work given that :-(

I hope you understand.

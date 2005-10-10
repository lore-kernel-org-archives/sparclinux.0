From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Oct 2005 18:11:26 +0000
Subject: Re: Fix for sparc64 irq.c compile error
Message-Id: <20051010.111126.46931482.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051009.202412.110750797.davem@davemloft.net>
In-Reply-To: <20051009.202412.110750797.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 08:20:37 +0200 (CEST)

> The Debian variant of 2.6.12 works fine and does shutdown correct. I have 
> yet to check, if they include any patch to solve this issue or if only 
> 2.6.13 and higher are affected.

I believe they have a hack workaround that checks for a NULL tty in
the wakeup routine, it's the wrong fix.

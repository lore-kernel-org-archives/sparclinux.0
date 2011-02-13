From: David Miller <davem@davemloft.net>
Date: Sun, 13 Feb 2011 21:19:50 +0000
Subject: Re: [PATCH 4/4] sparc32: genirq conversion (buggy)
Message-Id: <20110213.131950.42788782.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110213192952.GD25069@merkur.ravnborg.org>
In-Reply-To: <20110213192952.GD25069@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 13 Feb 2011 22:06:51 +0100

> So I fixed this - but result is the same - we hang in calibrate_dealy().

Well, the next problem I noticed is that you only enable the timer IRQ
on the cpu on which request_irq() executes, what about all of the
other cpus in the system?

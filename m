From: "David S. Miller" <davem@davemloft.net>
Date: Tue, 30 Aug 2005 18:01:04 +0000
Subject: Re: [gentoo-sparc] 2.6 kernel and docs
Message-Id: <20050830.110104.42258333.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050829.130957.02952920.davem@davemloft.net>
In-Reply-To: <20050829.130957.02952920.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josh Grebe <josh@brokedown.net>
Date: Tue, 30 Aug 2005 10:04:10 -0500

> Well, its a little different now! I crashed very quickly the first
> run, before I commented out that MEMORY_READ_BARRIER().

We really can't be testing the same kernels then.
Mine ran for hours and hours on end, even spamming my
xterms with tar output over the network to my workstation
in parallel.

Linus's current 2.6.14 GIT tree has all of my fixes in
it, maybe you can test that.

And if you get a wedge again, please turn on spinlock
debugging, CONFIG_DEBUG_SPINLOCK, because that is how I
got my traces.

And please do it with a head and keyboard attached so we
can eliminate the sketchy serial console layer as a variable.

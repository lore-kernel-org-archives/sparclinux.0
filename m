From: David Miller <davem@davemloft.net>
Date: Tue, 03 Feb 2009 23:19:18 +0000
Subject: Re: Sunfire V880 and 480R 2.6.27.x startup hangs
Message-Id: <20090203.151918.254599330.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20081219085622.GA20721@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 3 Feb 2009 22:26:32 +0100

> Maybe it's important that this is a two cpu machine (as a similar 6
> cpu machine seems to work, see other report on the list) ?

I don't think it matters, to be honest.  Memory size and layout
may have more to do with it.

I'll look at your logs and post some new debugging patches later,
thanks.

From: David Miller <davem@davemloft.net>
Date: Wed, 27 Apr 2016 19:36:38 +0000
Subject: Re: Bisected: RED State Exception in 4.5 on E420R
Message-Id: <20160427.153638.939805633559600222.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1604061729350.16827@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 27 Apr 2016 15:33:55 -0400 (EDT)

> Therefore some other aspect of the change is causing problems and I
> think that aspect is the size of the new code.

Actually, there is a way to prove that this is indeed the bug, Meelis
what does the entry for "swapper_tsb" say in your System.map file for
a failing kernel?

If it is not "0000000000408000", then that shows the bug.

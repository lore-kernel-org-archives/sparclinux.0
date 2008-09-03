From: David Miller <davem@davemloft.net>
Date: Wed, 03 Sep 2008 00:21:51 +0000
Subject: Re: tty compile warnings
Message-Id: <20080902.172151.184140434.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <48BBEDB2.3080207@earthlink.net>
In-Reply-To: <48BBEDB2.3080207@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 1 Sep 2008 14:57:29 +0100

> You could try removing _x_cc[2] and changing [NCCS] to [NCCS+2] which
> might work depending upon the alignment you get.

We can't do that kind of change for the "struct termios" case as
changing the array size would change the size of the structure in
userspace.  Here, the _x_cc[] thing is only present when __KERNEL__.

I've looked at this issue before, and so far my conclusion is that
ignoring the warnings and teaching other people to do so as well is so
much easier than trying to make this palatable to the compiler and
checking tools.

From: "David S. Miller" <davem@davemloft.net>
Date: Sun, 12 Mar 2006 21:52:37 +0000
Subject: Re: ESP busted
Message-Id: <20060312.135237.16031494.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20060309.131637.114886710.davem@davemloft.net>
In-Reply-To: <20060309.131637.114886710.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Sun, 12 Mar 2006 14:09:43 -0700

> OK, just got time to test this.  Using gcc-3.3.5 and your patch
> against 2.6.16-rc6, everything is booting fine on an Ultra 1.
> Anything you'd like to see from the compiled output?

And 2.6.16-rc6 without the patch is definitely broken
right?  Can you verify this?  I want to make sure I'm
fixing something.

Note that this kind of explains why the IRQ stacks stuff,
which I hope to get back to, helps various folks to one
degress or another.


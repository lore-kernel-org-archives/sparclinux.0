From: David Miller <davem@davemloft.net>
Date: Thu, 13 Jul 2006 20:23:38 +0000
Subject: Re: 2.6.18-rc1 fails to boot on Ultra 5
Message-Id: <20060713.132338.48528902.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200607131218.k6DCIX3Y025756@harpo.it.uu.se>
	<Pine.LNX.4.64.0607130836140.13948@beer.tclug.org>
In-Reply-To: <Pine.LNX.4.64.0607130836140.13948@beer.tclug.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jima@beer.tclug.org
Cc: mikpe@it.uu.se, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: Jima <jima@beer.tclug.org>
Date: Thu, 13 Jul 2006 08:38:28 -0500 (CDT)

>   I don't know about you, but my Ultra 5 has two: the DB25 female
> connector on the board ("A"), and the DB9 male connector on a ribbon
> cable ("B").  This is going off memory, but I'm fairly confident of
> this.

The 'se' device has two ports.  It seems one of them is not
getting registered properly or something like that.  I'll
take a look.

The DB9 one is in fact labelled "B" on the back of my ultra5.

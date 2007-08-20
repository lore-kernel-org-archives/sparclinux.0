From: David Miller <davem@davemloft.net>
Date: Mon, 20 Aug 2007 08:06:22 +0000
Subject: Re: possible endless loop in PROM initialization
Message-Id: <20070820.010622.41634915.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070820075949.GA5927@vimes.madsworld.lan>
In-Reply-To: <20070820075949.GA5927@vimes.madsworld.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mad@automagically.de
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Markus Dahms <mad@automagically.de>
Date: Mon, 20 Aug 2007 09:59:49 +0200

> I could track down the issue to the function __prom_nextprop() in
> arch/sparc/prom/tree.c, but I am now looking for the definition of
> prom_nodeops->no_nextprop() without success.

When we boot the firmware provides a vector of function
pointers, and this is prom_nodeops.  So prom_nodeops->no_nextprop()
is a routine inside the PROM.


From: David Miller <davem@davemloft.net>
Date: Sat, 08 Jan 2011 19:26:35 +0000
Subject: Re: [PATCH] atyfb: Fix bootup hangs on sparc64.
Message-Id: <20110108.112635.112593098.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110105.130959.260100853.davem@davemloft.net>
In-Reply-To: <20110105.130959.260100853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Fabio M. Di NItto" <fabbione@fabbione.net>
Date: Sat, 08 Jan 2011 10:01:43 +0100

> Oh ok.. so you do use the card output (that would have been useful info
> earlier ;)). All my tests were around fixing serial console (as it's
> really the only one I have). I'll try to hook up a monitor to the SB100
> and see if I can reproduce here.

Sam figured out the bug the other day, see the thread starting at:

http://marc.info/?l=linux-sparc&m9443149014127&w=2

From: David Miller <davem@davemloft.net>
Date: Wed, 24 Sep 2008 08:45:53 +0000
Subject: Re: qlogicpti driver hangs the machine
Message-Id: <20080924.014553.221132445.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080923.212513.184633012.davem@davemloft.net>
	<20080924044211.GL27204@parisc-linux.org>
	<20080923.215302.152506074.davem@davemloft.net>
In-Reply-To: <20080923.215302.152506074.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: matthew@wil.cx
Cc: mroos@linux.ee, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 23 Sep 2008 21:53:02 -0700 (PDT)

> I'm about to stick a qlogicpti card into my ultra2 and try to reproduce
> this.

Unfortunately, the driver works just fine for me, in fact it's
checking the root filesystem right now :-)

Meelis, if Matthew isn't able to give you some debugging patches or
other stuff to try, I'll try to get this fixed when I get back from
the netfilter workshop in Paris in 2 weeks.

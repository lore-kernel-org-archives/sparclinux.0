From: David Miller <davem@davemloft.net>
Date: Tue, 15 Jul 2008 01:31:16 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080714.183116.121978835.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807141000340.24718@devserv.devel.redhat.com>
	<20080714.143751.266098047.davem@davemloft.net>
	<Pine.LNX.4.64.0807141903001.2825@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807141903001.2825@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 14 Jul 2008 19:16:17 -0400 (EDT)

> So the question is: to reduce number of requests by 12% on an outdated 
> SCSI card, it is sensible to maintain complicated merge accounting logic 
> in the core block layer? To me, it doesn't seem sensible.

Rip out the code if you like, then.  I really don't have time to
work on this myself.  So if you do, by all means do whatever
you think is appropriate.


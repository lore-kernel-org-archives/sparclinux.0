From: David Miller <davem@davemloft.net>
Date: Mon, 14 Jul 2008 00:48:55 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080713.174855.234796356.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080713.124610.193703496.davem@davemloft.net>
	<487A61DD.6090304@firstfloor.org>
	<Pine.LNX.4.64.0807131947090.7803@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807131947090.7803@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 13 Jul 2008 19:53:01 -0400 (EDT)

> There is no need to turn BIO merge off --- the problem is caused by 
> accounting of BIO merging in block layer, not by BIO merging itself.
> 
> Just do #define BIO_VMERGE_BOUNDARY 0, and that disables the accounting, 
> but leaves merging as it is.

For the thousanth time, the BIO_VMERGE_BOUNDARY code is useful
and worked perfectly fine before segment boundary handling was
added to the block layer.

It's a regression, and as such should be fixed or the guilty
code reverted.

Since when do we say "sorry that got broken, turn it off, thanks"
?

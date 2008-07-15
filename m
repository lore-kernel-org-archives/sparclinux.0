From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 15 Jul 2008 02:40:45 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080715113238U.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807140805380.10106@devserv.devel.redhat.com>
	<20080714.052859.88212003.davem@davemloft.net>
	<Pine.LNX.4.64.0807141000340.24718@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807141000340.24718@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: davem@davemloft.net, andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Mon, 14 Jul 2008 10:03:29 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Mon, 14 Jul 2008, David Miller wrote:
> 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Date: Mon, 14 Jul 2008 08:16:13 -0400 (EDT)
> >
> >> As you mentioned ESP driver, it declares .sg_tablesize = SG_ALL, so
> >> BIO_VMERGE_BOUNDARY has no effect on the operation of this driver. Any
> >> other driver where BIO_VMERGE_BOUNDARY does matter?
> >
> > When BIO_VMERGE_BOUNDARY is turned on, requests that would not
> > otherwise fit into the device's limits, can.
> 
> Why would someone want to overshoot SG_ALL? ... and, shouldn't the 
> constant be increased then --- instead of making buggy BIO_VMERGE_BOUNDARY 
> expectations?

'buggy' is a wrong word. VMERGE works for some IOMMUs (though I think
that we need to fix it about max_segment_size).

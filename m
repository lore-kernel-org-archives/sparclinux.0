From: David Miller <davem@davemloft.net>
Date: Wed, 20 Jan 2010 11:30:48 +0000
Subject: Re: [PATCH]: sparc64: Add perf callchain support.
Message-Id: <20100120.033048.94906579.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100119.002645.70252139.davem@davemloft.net>
In-Reply-To: <20100119.002645.70252139.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jens Axboe <jens.axboe@oracle.com>
Date: Wed, 20 Jan 2010 12:26:59 +0100

> On Tue, Jan 19 2010, David Miller wrote:
>> 
>> Pretty straightforward, and it should be easy to add accurate
>> walk through of signal stack frames in userspace.
> 
> I tested it, works for me. Thanks Dave! You can add my Tested-by, if you
> wish.

Great, thanks for testing.

I just posted a patch to sparclinux and lkml adding support for both
sparc64 performance counters as well, so you might want to check that
out too. :-)


From: Christoph Hellwig <hch@infradead.org>
Date: Wed, 15 Oct 2014 13:35:51 +0000
Subject: Re: Sparc ESP problem with blk-mq
Message-Id: <20141015133551.GA15539@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.11.1410140102230.18488@adalberg.ut.ee>
 <543D355A.3030605@kernel.dk>
In-Reply-To: <543D355A.3030605@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>
Cc: Meelis Roos <mroos@linux.ee>, linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org, Christoph Hellwig <hch@infradead.org>

On Tue, Oct 14, 2014 at 08:38:18AM -0600, Jens Axboe wrote:
> Christoph, any idea on this? The command just times out, for some reason.
> Only thing I could think of was related to perhaps missing bouncing or
> similar, but I don't think that's the case. But the hba must not like the
> request somehow. Or perhaps it sets up the wrong number of segments.

Seems like this is the first command we send.  I don't really have an
idea at the moment, but it would be good to increase the scsi_logging
level to the maximum and/or add some traces to the esp driver to figure
out where the command gets lost.


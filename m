From: Jens Axboe <axboe@kernel.dk>
Date: Fri, 11 May 2018 21:08:26 +0000
Subject: Re: make a few block drivers highmem safe
Message-Id: <e5f3ffef-4fa3-50d3-4fbe-d67ba2a85bd8@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180509135948.20329-1-hch@lst.de>
In-Reply-To: <20180509135948.20329-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>, Geoff Levand <geoff@infradead.org>, Maxim Levitsky <maximlevitsky@gmail.com>, linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mtd@lists.infradead.org, sparclinux@vger.kernel.org

On 5/9/18 7:59 AM, Christoph Hellwig wrote:
> Hi all,
> 
> this series converts a few random block drivers to be highmem safe,
> in preparation of eventually getting rid of the block layer bounce
> buffering support.

Applied, thanks.

-- 
Jens Axboe


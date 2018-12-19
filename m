From: Christoph Hellwig <hch@lst.de>
Date: Wed, 19 Dec 2018 16:57:56 +0000
Subject: Re: fix sparc32 ->map_sg regression
Message-Id: <20181219165756.GA26038@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181216095755.10503-1-hch@lst.de>
In-Reply-To: <20181216095755.10503-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Dec 18, 2018 at 11:22:59PM -0800, David Miller wrote:
> From: Christoph Hellwig <hch@lst.de>
> Date: Wed, 19 Dec 2018 08:07:10 +0100
> 
> > Any chance to get a review on these?  I'd like to merge them before
> > preparing the dma-mapping pull request for Linus.
> 
> I have no objection to your work Christoph.

Thanks.  Aplied to the dma-mapping for-next tree with the j to i
rename pointed out by Sam.

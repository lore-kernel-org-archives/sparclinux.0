From: Christoph Hellwig <hch@lst.de>
Date: Wed, 19 Dec 2018 16:30:12 +0000
Subject: Re: [PATCH 2/2] sparc/iommu: fix ->map_sg return value
Message-Id: <20181219163012.GA25383@lst.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20181216095755.10503-3-hch@lst.de>
In-Reply-To: <20181216095755.10503-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Dec 19, 2018 at 05:28:25PM +0100, Sam Ravnborg wrote:
> > +	struct scatterlist *sg;
> > +	int j, n;
> Nit - in the other use of for_each_sg() you used "i" as the variable named.
> It confused me a little to see "j".

I think this was a copy and paste from the one function where i was
already taken.  I can remove it here.

> sg-lenght and sg->offsett are both unsigned int.
> So n should looking at this piece of code be unsigned int.
> But then iommu_get_one() takes an int as argument.
> So the real issue seems to be that iommu_get_one() should
> have npages be an unsigned int. And your code is fine.
> 
> If you had named n for npages it would have been a little more readable.

Well, n isn't really new here but from the existing code.  I see
plenty of potential for the usual cleanups in that code..

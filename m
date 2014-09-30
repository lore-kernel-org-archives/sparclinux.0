From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 21:38:27 +0000
Subject: Re: [PATCH] sunvdc: limit each sg segment to a page
Message-Id: <20140930.173827.787679686956736736.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1411134173-26665-1-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1411134173-26665-1-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Fri, 19 Sep 2014 09:42:53 -0400

> ldc_map_sg() could fail its check that the number of pages referred to
> by the sg scatterlist was <= the number of cookies.
> 
> This fixes the issue by doing a similar thing to the xen-blkfront driver,
> ensuring that the scatterlist will only ever contain a segment count <> port->ring_cookies, and each segment will be page aligned, and <= page
> size. This ensures that the scatterlist is always mappable.
> 
> Orabug: 19347817
> OraBZ: 15945
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Applied.

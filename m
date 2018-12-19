From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 19 Dec 2018 16:06:53 +0000
Subject: Re: [PATCH 1/2] sparc/io-unit: fix ->map_sg return value
Message-Id: <20181219160653.GA15867@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20181216095755.10503-2-hch@lst.de>
In-Reply-To: <20181216095755.10503-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Dec 16, 2018 at 10:57:54AM +0100, Christoph Hellwig wrote:
> Just decrementing the sz value will lead to an incorrect return value.
> Instead of just introducing a local variable switch to the standard
> for_each_sg helper and standard naming of the arguments.
> 
> Fixes: ce65d36f3e ("sparc: remove the sparc32_dma_ops indirection")
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

I did not look too much into the code that uses this.
Your changes looks fine but I miss part of the picture
so not really a review - sorry.

	Sam

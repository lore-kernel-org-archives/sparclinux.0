From: Jens Axboe <axboe@kernel.dk>
Date: Tue, 15 May 2018 18:51:20 +0000
Subject: Re: [PATCH] jsflash: fix compilation
Message-Id: <0d9ca090-5277-6c1c-9bff-477054f97746@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <20180515183258.4440-1-hch@lst.de>
In-Reply-To: <20180515183258.4440-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, sparclinux@vger.kernel.org

On 5/15/18 12:32 PM, Christoph Hellwig wrote:
> No bio in this whole function, use req->bio instead.

Applied.

> Looks like no one except for Guenters build bot cared.  I wonder if we
> should just get rid of the driver given that it doesn't look in a good
> shape at all based on his build logs even with the fix..

Needs input from the folks that actually might use it. The driver looks
abandoned, it's only getting updates through API changes etc.

-- 
Jens Axboe


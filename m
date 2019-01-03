From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jan 2019 01:49:11 +0000
Subject: Re: [PATCH] block: sunvdc: don't run hw queue synchronously from irq context
Message-Id: <20190102.174911.1224897930304340408.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190103011948.25706-1-ming.lei@redhat.com>
In-Reply-To: <20190103011948.25706-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ming.lei@redhat.com
Cc: axboe@kernel.dk, linux-block@vger.kernel.org, matorola@gmail.com, sparclinux@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>
Date: Thu,  3 Jan 2019 09:19:48 +0800

> vdc_blk_queue_start() may be called from irq context, so we can't run
> queue via blk_mq_start_hw_queues() since we never allow to run queue
> from irq context. Use blk_mq_start_stopped_hw_queues(q, true) to fix
> this issue.
> 
> Fixes: fa182a1fa97dff56cd ("sunvdc: convert to blk-mq")
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Tested-by: Anatoly Pugachev <matorola@gmail.com>
> Cc: Anatoly Pugachev <matorola@gmail.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Acked-by: David S. Miller <davem@davemloft.net>

From: Jens Axboe <axboe@kernel.dk>
Date: Thu, 03 Jan 2019 15:22:03 +0000
Subject: Re: [PATCH] block: sunvdc: don't run hw queue synchronously from irq context
Message-Id: <fbaa1e6f-71d5-0696-a873-20bc1b6a5a7d@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <20190103011948.25706-1-ming.lei@redhat.com>
In-Reply-To: <20190103011948.25706-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Anatoly Pugachev <matorola@gmail.com>, David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org

On 1/2/19 6:19 PM, Ming Lei wrote:
> vdc_blk_queue_start() may be called from irq context, so we can't run
> queue via blk_mq_start_hw_queues() since we never allow to run queue
> from irq context. Use blk_mq_start_stopped_hw_queues(q, true) to fix
> this issue.

Thanks Ming, applied.

-- 
Jens Axboe

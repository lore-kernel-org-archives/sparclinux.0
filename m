From: Jens Axboe <axboe@kernel.dk>
Date: Wed, 02 Jan 2019 15:44:26 +0000
Subject: Re: [sparc64] unable to boot git kernel / deadlock / cpu stall
Message-Id: <16e68c7a-c09b-7b98-a608-e20502ca74b7@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwwE5wu6KSvydtEggpdb+5XjNpk+uCeE8vJYp72TCJY=w@mail.gmail.com>
In-Reply-To: <CADxRZqwwE5wu6KSvydtEggpdb+5XjNpk+uCeE8vJYp72TCJY=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 1/2/19 5:11 AM, Ming Lei wrote:
>> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
>> index 9c0553dd13e7..6eddd17a864a 100644
>> --- a/drivers/block/sunvdc.c
>> +++ b/drivers/block/sunvdc.c
>> @@ -181,7 +181,7 @@ static void vdc_blk_queue_start(struct vdc_port *port)
>>  	 * allocated a disk.
>>  	 */
>>  	if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
>> -		blk_mq_start_hw_queues(port->disk->queue);
>> +		blk_mq_start_stopped_hw_queue(port->disk->queue, true);
>>  }
>>  
>>  static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)
> 
> oops, we should have called blk_mq_start_stopped_hw_queues(): 
> 
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index 9c0553dd13e7..ab7f7ab4c472 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -181,7 +181,7 @@ static void vdc_blk_queue_start(struct vdc_port *port)
>  	 * allocated a disk.
>  	 */
>  	if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
> -		blk_mq_start_hw_queues(port->disk->queue);
> +		blk_mq_start_stopped_hw_queues(port->disk->queue, true);
>  }
>  
>  static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)

Indeed, that was a silly oversight on my part. Ming, will you send a
"proper" patch so I can queue it up?

-- 
Jens Axboe

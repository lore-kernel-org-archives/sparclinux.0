From: chris hyser <chris.hyser@oracle.com>
Date: Mon, 30 Mar 2015 17:05:46 +0000
Subject: Re: [PATCH v3] sunvdc: Complete I/O request if vdisk server error
Message-Id: <5519826A.8080708@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <55197CB6.2020903@oracle.com>
In-Reply-To: <55197CB6.2020903@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

If the underlying VDS driver error is not intermittent and callers ignore the error and keep issuing requests or the 
queue is filled, I suppose there could be a flood of messages.

On 3/30/2015 12:56 PM, David Ahern wrote:
> On 3/30/15 10:41 AM, chris hyser wrote:
>> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
>> index 4b911ed..dad85fe 100644
>> --- a/drivers/block/sunvdc.c
>> +++ b/drivers/block/sunvdc.c
>> @@ -308,7 +308,11 @@ static void vdc_end_one(struct vdc_port *port,
>> struct vio_dring_state *dr,
>>
>>       rqe->req = NULL;
>>
>> -    __blk_end_request(req, (desc->status ? -EIO : 0), desc->size);
>> +    if (desc->status) {
>> +        pr_err(PFX "VIO I/O Error %d\n", desc->status);
>
> printk_ratelimit()? i.e., any chance these can come out in a flood?
>
>
>> +        __blk_end_request_all(req, -EIO);
>> +    } else
>> +        __blk_end_request(req, 0, desc->size);
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

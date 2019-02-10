From: Jens Axboe <axboe@kernel.dk>
Date: Sun, 10 Feb 2019 16:05:34 +0000
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5 minute delay during boot on Su
Message-Id: <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
List-Id: <sparclinux.vger.kernel.org>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
 <1549736341.2971.7.camel@HansenPartnership.com>
 <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
 <1549813472.4142.3.camel@HansenPartnership.com>
In-Reply-To: <1549813472.4142.3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Mikael Pettersson <mikpelinux@gmail.com>
Cc: Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On 2/10/19 8:44 AM, James Bottomley wrote:
> On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
>> On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
>> <James.Bottomley@hansenpartnership.com> wrote:
> [...]
>>> I think the reason for this is that the block mq path doesn't feed
>>> the kernel entropy pool correctly, hence the need to install an
>>> entropy gatherer for systems that don't have other good random
>>> number sources.
>>
>> That does sound plausible, I admit I didn't even consider the
>> possibility that the old block I/O path also was an entropy source.
> 
> In theory, the new one should be as well since the rotational entropy
> collector is on the SCSI completion path.   I'd seen the same problem
> but had assumed it was something someone had done to our internal
> entropy pool and thus hadn't bisected it.

The difference is that the old stack included ADD_RANDOM by default,
so this check:

	if (blk_queue_add_random(q))
		add_disk_randomness(req->rq_disk);

in scsi_end_request() would be true, and we'd add the randomness. For
sd, it seems to set it just fine for non-rotational drives. Could this
be because other devices don't? Maybe the below makes a difference.


diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 6d65ac584eba..60e029911755 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1881,6 +1881,7 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 	sdev->request_queue->queuedata = sdev;
 	__scsi_init_queue(sdev->host, sdev->request_queue);
 	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, sdev->request_queue);
+	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, sdev->request_queue);
 	return sdev->request_queue;
 }
 

-- 
Jens Axboe

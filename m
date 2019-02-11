From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Mon, 11 Feb 2019 15:42:53 +0000
Subject: Re: [5.0-rc5 regression] "scsi: kill off the legacy IO path" causes 5 minute delay during boot on Su
Message-Id: <1549899773.2831.12.camel@HansenPartnership.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAM43=SO6bdDAEULEPArfgdbjLAYDo9OiPBa8gL4fsSg7Dky=gA@mail.gmail.com>
         <1549736341.2971.7.camel@HansenPartnership.com>
         <CAM43=SPUMzOLRmkoT+DQSpzu2DYRTyOhU6o8KRUU_Q902o2e1Q@mail.gmail.com>
         <1549813472.4142.3.camel@HansenPartnership.com>
         <3380ed8e-ae02-96f2-142b-7cce09459df8@kernel.dk>
         <1549815924.4142.8.camel@HansenPartnership.com>
         <0e6e5d67-d305-dd00-2e42-e2299166c8b2@kernel.dk>
         <1549898730.2831.6.camel@HansenPartnership.com>
         <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
In-Reply-To: <44bb4374-0b7c-733b-a53e-92d2f03f2f49@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jens Axboe <axboe@kernel.dk>, Mikael Pettersson <mikpelinux@gmail.com>
Cc: Linux SPARC Kernel Mailing List <sparclinux@vger.kernel.org>, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, 2019-02-11 at 08:28 -0700, Jens Axboe wrote:
> On 2/11/19 8:25 AM, James Bottomley wrote:
> > On Sun, 2019-02-10 at 09:35 -0700, Jens Axboe wrote:
> > > On 2/10/19 9:25 AM, James Bottomley wrote:
> > > > On Sun, 2019-02-10 at 09:05 -0700, Jens Axboe wrote:
> > > > > On 2/10/19 8:44 AM, James Bottomley wrote:
> > > > > > On Sun, 2019-02-10 at 10:17 +0100, Mikael Pettersson wrote:
> > > > > > > On Sat, Feb 9, 2019 at 7:19 PM James Bottomley
> > > > > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > > > 
> > > > > > [...]
> > > > > > > > I think the reason for this is that the block mq path
> > > > > > > > doesn't feed the kernel entropy pool correctly, hence
> > > > > > > > the need to install an entropy gatherer for systems
> > > > > > > > that don't have other good random number sources.
> > > > > > > 
> > > > > > > That does sound plausible, I admit I didn't even consider
> > > > > > > the possibility that the old block I/O path also was an
> > > > > > > entropy source.
> > > > > > 
> > > > > > In theory, the new one should be as well since the
> > > > > > rotational entropy collector is on the SCSI completion
> > > > > > path.   I'd seen the same problem but had assumed it was
> > > > > > something someone had done to our internal entropy pool and
> > > > > > thus hadn't bisected it.
> > > > > 
> > > > > The difference is that the old stack included ADD_RANDOM by
> > > > > default, so this check:
> > > > > 
> > > > > 	if (blk_queue_add_random(q))
> > > > > 		add_disk_randomness(req->rq_disk);
> > > > > 
> > > > > in scsi_end_request() would be true, and we'd add the
> > > > > randomness. For sd, it seems to set it just fine for non-
> > > > > rotational drives. Could this be because other devices don't?
> > > > > Maybe the below makes a difference.
> > > > 
> > > > No, in both we set it per the rotational parameters of the disk
> > > > in 
> > > > 
> > > > sd.c:sd_read_block_characteristics()
> > > > 
> > > > 	rot = get_unaligned_be16(&buffer[4]);
> > > > 
> > > > 	if (rot = 1) {
> > > > 	
> > > > 	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
> > > > 	
> > > > 	blk_queue_flag_clear(QUEUE_FLAG_ADD_RANDOM, q);
> > > > 	} else {
> > > > 	
> > > > 	blk_queue_flag_clear(QUEUE_FLAG_NONROT, q);
> > > > 	
> > > > 	blk_queue_flag_set(QUEUE_FLAG_ADD_RANDOM, q);
> > > > 	}
> > > > 
> > > > 
> > > > That check wasn't changed by the code removal.
> > > 
> > > As I said above, for sd. This isn't true for non-disks.
> > 
> > Yes, but the behaviour above doesn't change across a switch to MQ,
> > so I don't quite understand how it bisects back to that change.  If
> > we're not gathering entropy for the device now, we wouldn't have
> > been before the switch, so the entropy characteristics shouldn't
> > have changed.
> 
> But it does, as I also wrote in that first email. The legacy queue
> flags had QUEUE_FLAG_ADD_RANDOM set by default, the MQ ones do not.
> Hence any non-sd device would previously ALWAYS have ADD_RANDOM
> set, now none of them do. Also see the patch I sent.

So your theory is that the disk in question never gets to the
rotational check?  because the check will clear the flag if it's non-
rotational and set it if it's not, so the default state of the flag
shouldn't matter.

James

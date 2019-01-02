From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 02 Jan 2019 14:34:37 +0000
Subject: Re: [sparc64] unable to boot git kernel / deadlock / cpu stall
Message-Id: <CADxRZqx6wCkO8nTuudHPc+fb6LUiuRMWY=V55+xAixi2UiUGYw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CADxRZqwwE5wu6KSvydtEggpdb+5XjNpk+uCeE8vJYp72TCJY=w@mail.gmail.com>
In-Reply-To: <CADxRZqwwE5wu6KSvydtEggpdb+5XjNpk+uCeE8vJYp72TCJY=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 2, 2019 at 3:11 PM Ming Lei <ming.lei@redhat.com> wrote:
>
> On Wed, Jan 02, 2019 at 08:08:43PM +0800, Ming Lei wrote:
> > On Wed, Jan 02, 2019 at 01:58:17PM +0300, Anatoly Pugachev wrote:
> > > Hello!
> > >
> > > Latest git kernels does not boot for me. Bisect log is the end of this email.
> > >
> > > v4.20.0-rc1-00088-gea2c18e1044e boots ok.
> > > v4.20.0-rc1-00089-gfa182a1fa97d does not boot.
> > >
> > > Can someone look please? Thanks.
> > >
> > > Boot log:
...
> > > bisected kernel to the following commit:
> > >
> > >
> > > mator@ttip:~$ cd linux-2.6
> > > mator@ttip:~/linux-2.6$ git desc
> > > v4.20-rc1-88-gea2c18e1044e
> > >
> > > mator@ttip:~/linux-2.6$ git bisect good
> > > fa182a1fa97dff56cda742f22d17d666420cd27f is the first bad commit
> > > commit fa182a1fa97dff56cda742f22d17d666420cd27f
> > > Author: Jens Axboe <axboe@kernel.dk>
> > > Date:   Mon Oct 15 08:54:23 2018 -0600
> > >
> > >     sunvdc: convert to blk-mq
> > >
> > >     Convert from the old request_fn style driver to blk-mq.
> > >
> > >     Cc: David Miller <davem@davemloft.net>
> > >     Reviewed-by: Hannes Reinecke <hare@suse.com>
> > >     Tested-by: Ming Lei <ming.lei@redhat.com>
> > >     Reviewed-by: Omar Sandoval <osandov@fb.com>
> > >     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >
> > > :040000 040000 2860baedf9e55349500dbc7ae738562f1e2ee05b
> > > dfe5d1704ab9598a654aa4e4700487c33bd43039 M      drivers
> > >
> > > mator@ttip:~/linux-2.6$ git bisect log
> > > git bisect start
> > > # good: [00c569b567c7f1f0da6162868fd02a9f29411805] Merge tag
> > > 'locks-v4.21-1' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/jlayton/linux
> > > git bisect good 00c569b567c7f1f0da6162868fd02a9f29411805
> > > # bad: [903b77c631673eeec9e9114e9524171cdf9a2646] Merge tag
> > > 'linux-kselftest-4.21-rc1' of
> > > git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest
> > > git bisect bad 903b77c631673eeec9e9114e9524171cdf9a2646
> > > # bad: [1984f65c2fbc0d2b557d6e89ece9b39267e215c6] Merge tag
> > > 'vfio-v4.21-rc1' of git://github.com/awilliam/linux-vfio
> > > git bisect bad 1984f65c2fbc0d2b557d6e89ece9b39267e215c6
> > > # bad: [938edb8a31b976c9a92eb0cd4ff481e93f76c1f1] Merge tag
> > > 'scsi-misc' of git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi
> > > git bisect bad 938edb8a31b976c9a92eb0cd4ff481e93f76c1f1
> > > # bad: [00203ba40d40d7f33857416adfb18adaf0e40123] kyber: use sbitmap
> > > add_wait_queue/list_del wait helpers
> > > git bisect bad 00203ba40d40d7f33857416adfb18adaf0e40123
> > > # bad: [c6d962aebaf8ec5d867aac09ee33e3f528c2539d] nvme-pci: only allow
> > > polling with separate poll queues
> > > git bisect bad c6d962aebaf8ec5d867aac09ee33e3f528c2539d
> > > # bad: [511c49fe1804671800947b69281e07719fad25e2] fnic: fix
> > > fnic_scsi_host_{start,end}_tag
> > > git bisect bad 511c49fe1804671800947b69281e07719fad25e2
> > > # bad: [3110fc79606fb6003949246c6fb325dd43445273] blk-mq: improve plug
> > > list sorting
> > > git bisect bad 3110fc79606fb6003949246c6fb325dd43445273
> > > # bad: [a1ce35fa49852db60fc6e268038530be533c5b15] block: remove dead
> > > elevator code
> > > git bisect bad a1ce35fa49852db60fc6e268038530be533c5b15
> > > # bad: [c6f2882691e8fd128083abdcc3c5aa5b410c2367] block: remove q->lld_busy_fn()
> > > git bisect bad c6f2882691e8fd128083abdcc3c5aa5b410c2367
> > > # bad: [600335205b8d162891b5ef2e32343f5b8020efd8] ide: convert to blk-mq
> > > git bisect bad 600335205b8d162891b5ef2e32343f5b8020efd8
> > > # bad: [fa182a1fa97dff56cda742f22d17d666420cd27f] sunvdc: convert to blk-mq
> > > git bisect bad fa182a1fa97dff56cda742f22d17d666420cd27f
> > > # good: [ea2c18e1044e9ed8f780c965c50432060ab0e355] null_blk: Add
> > > conventional zone configuration for zoned support
> > > git bisect good ea2c18e1044e9ed8f780c965c50432060ab0e355
> > > # first bad commit: [fa182a1fa97dff56cda742f22d17d666420cd27f] sunvdc:
> > > convert to blk-mq
> > > mator@ttip:~/linux-2.6$
> >
> > Could you try the following patch and see if it makes a difference?
>
> diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
> index 9c0553dd13e7..ab7f7ab4c472 100644
> --- a/drivers/block/sunvdc.c
> +++ b/drivers/block/sunvdc.c
> @@ -181,7 +181,7 @@ static void vdc_blk_queue_start(struct vdc_port *port)
>          * allocated a disk.
>          */
>         if (port->disk && vdc_tx_dring_avail(dr) * 100 / VDC_TX_RING_SIZE >= 50)
> -               blk_mq_start_hw_queues(port->disk->queue);
> +               blk_mq_start_stopped_hw_queues(port->disk->queue, true);
>  }
>
>  static void vdc_finish(struct vio_driver_state *vio, int err, int waiting_for)

Ming,

fixes boot for me on the latest git kernel, tested with
4.20.0-10595-g8e143b90e4d4

Thanks a lot!

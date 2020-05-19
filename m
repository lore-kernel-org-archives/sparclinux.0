From: Al Viro <viro@zeniv.linux.org.uk>
Date: Tue, 19 May 2020 00:24:38 +0000
Subject: Re: [PATCH 0/3] sparc: port to copy_thread_tls() and struct kernel_clone_args
Message-Id: <20200519002438.GA2726018@ZenIV.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200512171527.570109-1-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

On Tue, May 19, 2020 at 12:08:40AM +0100, Al Viro wrote:

> That's
>                 unsigned int pool_nr = entry / tbl->poolsize;
> 
>                 BUG_ON(pool_nr >= tbl->nr_pools);
>                 p = &tbl->pools[pool_nr];
> 
> in get_pool(), so it looks like 'entry' is too large here.  The call chain is
> get_pool() <- iommu_tbl_range_free() <- dma_4u_unmap_page() (get_pool() itself got
> inlined), so we have
>         iommu_tbl_range_free(&iommu->tbl, bus_addr, npages, IOMMU_ERROR_CODE);
> in the end of dma_4u_unmap_page(), with
>         unsigned long shift = iommu->table_shift;
>         if (entry = IOMMU_ERROR_CODE) /* use default addr->entry mapping */
>                 entry = (dma_addr - iommu->table_map_base) >> shift;
>         pool = get_pool(iommu, entry);
> 
> in iommu_tlb_range_free().  Hmm...  Anyway, that looks like more like fallout from
> buggered attempt of recovery in sunhme.  We are definitely losing IRQs here.
> 
> > If you able to reproduce the issue consistently and can help figure out what's going
> > on then that would be a great help. Perhaps it might make sense to split this into a
> > separate thread and drop the non-sparc lists?
> 
> Sure, no problem.As for "able to reproduce"
  -generally takes under half an hour.
> Less in this case, as you can see from printk timestamps...

FWIW, right after boot
root@sparc64:/tmp# wget http://ftp.us.debian.org/debian/pool/main/l/linux/linux_5.7~rc5.orig.tar.xz
--2020-05-18 19:23:31--  http://ftp.us.debian.org/debian/pool/main/l/linux/linux_5.7~rc5.orig.tar.xz
Resolving ftp.us.debian.org (ftp.us.debian.org)... 208.80.154.15, 64.50.233.100, 64.50.236.52, ...
Connecting to ftp.us.debian.org (ftp.us.debian.org)|208.80.154.15|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 117279780 (112M) [application/octet-stream]
Saving to: ‘linux_5.7~rc5.orig.tar.xz’

          linux_5.7   0%[                    ]       0  --.-KB/s               [  216.454929] enp2s1: Happy Meal out of receive descriptors, packet dropped.
.tar.xz              63%[======>        ]  71.36M  5.32MB/s    eta 9s     [  261.490162] ata1: lost interrupt (Status 0x50)
[  261.491467] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  261.492164] ata1.00: failed command: FLUSH CACHE
[  261.492773] ata1.00: cmd e7/00:00:00:00:00/00:00:00:00:00/a0 tag 0
[  261.492773]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[  261.493920] ata1.00: status: { DRDY }
[  261.494587] ata1: soft resetting link
[  261.495030] ata2: lost interrupt (Status 0x58)
[  261.658539] ata1.00: configured for UDMA/33
[  261.658987] ata1.00: retrying FLUSH 0xe7 Emask 0x4
[  266.854943] ata2.00: qc timeout (cmd 0xa0)
[  266.855567] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  272.229617] ata2.00: qc timeout (cmd 0xa0)
[  272.230028] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  272.230851] ata2.00: limiting speed to UDMA/33:PIO3
<similar to earlier, this time with fs errors - different ATA command failing>

When writing *not* to disk:
root@sparc64:~# mount -t ramfs none /tmp
root@sparc64:~# cd /tmp/
root@sparc64:/tmp# wget http://ftp.us.debian.org/debian/pool/main/l/linux/linux_5.7~rc5.orig.tar.xz
--2020-05-18 19:39:58--  http://ftp.us.debian.org/debian/pool/main/l/linux/linux_5.7~rc5.orig.tar.xz
Resolving ftp.us.debian.org (ftp.us.debian.org)... 208.80.154.15, 64.50.236.52, 64.50.233.100, ...
Connecting to ftp.us.debian.org (ftp.us.debian.org)|208.80.154.15|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 117279780 (112M) [application/octet-stream]
Saving to: ‘linux_5.7~rc5.orig.tar.xz’

         linux_5.7~   0%[                    ] 918.40K  4.38MB/s               [   82.810156] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[   82.830163] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[   82.832862] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[   82.853928] enp2s1: Happy Meal out of receive descriptors, packet dropped.
inux_5.7~rc5.orig.t   3%[                    ]   3.72M  1.63MB/s               [   84.860985] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[   84.878113] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[   84.886409] enp2s1: Happy Meal out of receive descriptors, packet dropped.
7~rc5.orig.tar.xz     6%[>                   ]   7.09M  1.54MB/s    eta 46s    [  118.099900] ata2: lost interrupt (Status 0x58)
[  122.195865] ata1: lost interrupt (Status 0x50)
[  122.197426] ata1.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x6 frozen
[  122.199156] ata1.00: failed command: WRITE DMA
[  122.200488] ata1.00: cmd ca/00:08:ac:fb:46/00:00:00:00:00/e0 tag 0 dma 4096 out
[  122.200488]          res 40/00:01:00:00:00/00:00:00:00:00/a0 Emask 0x4 (timeout)
[  122.203720] ata1.00: status: { DRDY }
[  122.204870] ata1: soft resetting link
[  122.365836] ata1.00: configured for UDMA/33
[  122.367282] ata1: EH complete
[  123.463696] ata2.00: qc timeout (cmd 0xa0)
[  123.464129] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  128.839650] ata2.00: qc timeout (cmd 0xa0)
[  128.840747] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  128.842261] ata2.00: limiting speed to UDMA/33:PIO3
[  134.215584] ata2.00: qc timeout (cmd 0xa0)
[  134.215995] ata2.00: TEST_UNIT_READY failed (err_mask=0x5)
[  134.216499] ata2.00: disabled
<usual series of bus resets, with complaints about jbd2 locked for too long, etc.; IO on
/var/log/exim4/mainlog, of all things>

Very interesting...  The same with exim4 and sshd stopped passes with
lots of "out of receive descriptors", but without a hang.  The same with
ssh started: ditto.  Start exim4, repeat - still no hang.  Try to do
the same wget with md5sum /usr/bin/* at the same time from ssh session -
lost interrupt and a hang.  Actually, it wasn't even md5sum - tab
completion in bash has done it.

Next experiment: boot, then
root@sparc64:~# service exim4 stop
Stopping MTA: exim4_listener.
root@sparc64:~# service ssh stop
Stopping OpenBSD Secure Shell server: sshd.
root@sparc64:~# mount -t ramfs none /tmp
root@sparc64:~# cd /tmp/
root@sparc64:/tmp# (sleep 2; md5sum /usr/bin/* >/dev/null) &
[1] 1126
root@sparc64:/tmp# wget http://ftp.us.debian.org/debian/pool/main/l/linux/linux_5.7~rc5.orig.tar.xz
--2020-05-18 20:17:18--  http://ftp.us.debian.org/debian/pool/main/l/linux/linux_5.7~rc5.orig.tar.xz
Resolving ftp.us.debian.org (ftp.us.debian.org)... 64.50.236.52, 64.50.233.100, 208.80.154.15, ...
Connecting to ftp.us.debian.org (ftp.us.debian.org)|64.50.236.52|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 117279780 (112M) [application/x-xz]
Saving to: ‘linux_5.7~rc5.orig.tar.xz’

         linux_5.7~   0%[                    ] 535.49K  2.58MB/s               [  142.491757] enp2s1: Happy Meal out of receive descriptors, packet dropped.
       linux_5.7~rc   2%[                    ]   2.92M  4.85MB/s               [  142.815354] enp2s1: Happy Meal out of receive descriptors, packet dropped.
[  142.843435] enp2s1: Happy Meal out of receive descriptors, packet dropped.
ux_5.7~rc5.orig.tar   6%[>                   ]   7.18M  2.72MB/s               [  175.465117] ata1: lost interrupt (Status 0x50)
<hang>

So it does look like hme alone is not enough, but it makes cmd64x lost interrupt happen
much faster.  Note that this time no tab completion, etc. had been involved - straight
reads (well, and atime touches) done by md5sum in background.

No repeats of that iommu.c BUG_ON() so far...  Ideas?

From: David Miller <davem@davemloft.net>
Date: Thu, 19 Apr 2007 07:41:39 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070419.004139.58454642.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Pasi Pirhonen <upi@centos.fi>
Date: Sun, 15 Apr 2007 12:45:27 +0300

> >From dmesg the difference seems to be that when i did fail, i did have
> two same type disk that both did claim to be
> 
> sda: Mode Sense: cf 00 10 08
> SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
> SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
> sda: Write Protect is off
> sda: Mode Sense: cf 00 10 08
> SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
> 
> and now, when i do have different disk as /dev/sdb that gets detected as
> 
> sdb: Mode Sense: fb 00 00 08
> SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
> sdb: Write Protect is off
> sdb: Mode Sense: fb 00 00 08
> SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
> 
> 
> ... if that is clue for reason at all.

The two disks are identical except for MODE_SENSE settings printed
here and those are just some timeout parameters and such.

The current driver should not hit the problems you saw.  I plan
to post in-full the current driver as a patch in a few moments,
if you could retest this case with it, I'd really appreciate it.

Thanks!

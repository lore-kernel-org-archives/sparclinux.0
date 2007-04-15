From: Pasi Pirhonen <upi@centos.fi>
Date: Sun, 15 Apr 2007 09:45:27 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070415094526.GC6300@centos.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Sat, Apr 14, 2007 at 05:12:11PM -0700, David Miller wrote:
> From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
> Date: Sat, 14 Apr 2007 17:58:57 -0500
> 
> > ESP: tgt[3] lun[0] scsi_cmd [ 12 00 00 00 24 c2 ]
> > ESP: intr sreg[93] seqreg[00] sreg2[00] ireg[18]
> > ESP: intr sreg[97] seqreg[04] sreg2[00] ireg[08]
> > ESP: intr sreg[90] seqreg[04] sreg2[00] ireg[20]
> > ESP: Command done status[2] message[0]
> 
> Target 3 (presumably your disk) gave a CHECK_CONDITION
> for the INQUIRY, that's fine, so that scsi layer gives
> a REQUEST_SENSE.
> 

This seems to be as good insertion point as any for this thread. When i
see this problem with esp for another machines, i do remember that i
did have weird beahaviour with first boot when i was rearranging my
gear to be able to test the new ESP. I did have same kind of situation
when and first disk (which i am using even now as root) was detected,
but second disk got the esp in the loop where it just did walk thru
scsiID by scsiID and claimed those be 'offlined due ....'.

I thought it would be failing disk and swapped one from D1000 to
replace it, booted and all was fine.

Now that i do have glogicpti up and running again, i see that disk
there and if i can provide some inquiry date with something from that
disk and it would help, let me know. 

Host: scsi0 Channel: 00 Id: 02 Lun: 00
  Vendor: SEAGATE  Model: ST336704LSUN36G  Rev: 032C
  Type:   Direct-Access                    ANSI  SCSI revision: 03

This is the disk that has been /dev/sda all the time with new esp, but

Host: scsi2 Channel: 00 Id: 03 Lun: 00
  Vendor: SEAGATE  Model: ST336704LSUN36G  Rev: 032C
  Type:   Direct-Access                    ANSI  SCSI revision: 03

is the disk that was supposed to be /dev/sdb when it did NOT boot.

From dmesg the difference seems to be that when i did fail, i did have
two same type disk that both did claim to be

sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA

and now, when i do have different disk as /dev/sdb that gets detected as

sdb: Mode Sense: fb 00 00 08
SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
sdb: Write Protect is off
sdb: Mode Sense: fb 00 00 08
SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA


... if that is clue for reason at all.



-- 
Pasi Pirhonen - upi@iki.fi - http://pasi.pirhonen.eu/
Top-postings silently ignored

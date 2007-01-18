From: "Andrew Walrond (Heresy)" <andrew@h-e-r-e-s-y.com>
Date: Thu, 18 Jan 2007 22:14:08 +0000
Subject: Re:
Message-Id: <45AFF130.1000404@h-e-r-e-s-y.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

vatch23@riseup.net wrote:
> Hi,I`m quite new to this, so my appologies for a for what I suppose is a
> too simple question to answer.
> I have bought two Sun E450,both with 20 18gig disks ,and I have for about
> 1 week tried to get Debian testing up and running.After going through all
> kind of troubles converting them from servers run from other sun
> terminals,Ive got so far that testing IS installed on sda: sda1 for /boot
> sda2 for swap, and sda3 for /.Here it comes :I understand that I`m
> supposed to boot from the `whole` partition, meaning sda3, but what is it
> called in openboot?
> Not: boot /pci@f1,4000/scsi@3/disk@0:0
> Not boot disk0:c
> Not boot disk0:3
> And not hundred other sequences I`ve tried!
>   

Try probe-scsi-all. sda will be the first disk on one of the scsi interfaces

For me:

{0} ok probe-scsi-all
/sbus@3,0/QLGC,isp@0,10000
Target 0
  Unit 0   Disk     COMPAQ  HD0093172C      3208LJ815478
                    Copyright (c) 1998 Seagate
                    All rights reserved

[...snip...]

Target d
  Unit 0   Disk     COMPAQ  HD0093172C      3208LJ811269
                    Copyright (c) 1998 Seagate
                    All rights reserved
Target e
  Unit 0   Processor     SYMBIOS D1000           2   N.d     SAF-TE1.00
Target f
  Unit 0   Processor     SYMBIOS D1000           2   N.d     SAF-TE1.00

{0} ok boot /sbus@3,0/QLGC,isp@0,10000/sd@0,0

Hope that's useful

Andrew Walrond

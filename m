From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Thu, 08 Sep 2005 03:05:24 +0000
Subject: SCSI device info reported twice
Message-Id: <20050908030524.GA26941@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just noticed today that some SCSI info gets reported twice in my
dmesg output. This happens on 2.6.13 and 2.6.10, but not on 2.6.8.
Is this a known issue? Any patch avaiable?

Below is a part of my 2.6.13 dmesg output.

Thanks,
Martin
---------------------------------------------------------------------------
scsi0 : Sparc ESP100A-FAST
  Vendor: SEAGATE   Model: ST39173W SUN9.0G  Rev: 7063
  Type:   Direct-Access                      ANSI SCSI revision: 02
  Vendor: SEAGATE   Model: ST32550W SUN2.1G  Rev: 0416
  Type:   Direct-Access                      ANSI SCSI revision: 02
scsi1 : Sparc ESP236-FAST
esp0: target 1 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
SCSI device sda: drive cache: write through
SCSI device sda: 17689267 512-byte hdwr sectors (9057 MB)
SCSI device sda: drive cache: write through
 sda: sda1 sda2 sda3 sda4 sda5 sda6 sda7 sda8
Attached scsi disk sda at scsi0, channel 0, id 1, lun 0
esp0: target 3 [period 100ns offset 15 10.00MHz FAST SCSI-II]
SCSI device sdb: 4194995 512-byte hdwr sectors (2148 MB)
SCSI device sdb: drive cache: write through
SCSI device sdb: 4194995 512-byte hdwr sectors (2148 MB)
SCSI device sdb: drive cache: write through
 sdb: sdb1 sdb2 sdb3 sdb4 sdb5
Attached scsi disk sdb at scsi0, channel 0, id 3, lun 0

From: Pasi Pirhonen <upi@centos.fi>
Date: Fri, 13 Apr 2007 15:59:23 +0000
Subject: Re: [TESTERS NEEDED]: Rewritten ESP driver
Message-Id: <20070413155923.GA11898@centos.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20070412.233350.41640545.davem@davemloft.net>
In-Reply-To: <20070412.233350.41640545.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,


On Thu, Apr 12, 2007 at 11:33:50PM -0700, David Miller wrote:
> 
> I've been putting off posting this, since people seem to get a little
> upset when they lose their filesystems, but it passes all of my tests
> on an Ultra2 so what the heck. :-)
> 

Don't know what kind of information is 'preferred', but here goes for
nothing .... no toying with "init=/bin/sh". Those are for ....

Took the IOMMU + new ESP patches and ..

[root@sparky /]# uptime
 19:04:15 up  1:48,  5 users,  load average: 4.15, 5.23, 5.87

[root@sparky /]# uname -a
Linux sparky 2.6.21-rc6 #1 SMP Fri Apr 13 15:36:25 EEST 2007 sparc64 sparc64 sparc64 GNU/Linux


[root@sparky /]# gcc -v
Using built-in specs.
Target: sparc64-redhat-linux
Configured with: ../configure --prefix=/usr --mandir=/usr/share/man
--infodir=/usr/share/info --enable-shared --enable-threads=posix
--enable-checking=release --with-system-zlib --enable-__cxa_atexit
--disable-libunwind-exceptions --enable-libgcj-multifile
--enable-languages=c,c++,objc,obj-c++,java,fortran
--enable-java-awt=gtk --disable-dssi --enable-plugin
--with-java-home=/usr/lib/jvm/java-1.4.2-gcj-1.4.2.0/jre
--with-long-double-128 --host=sparc64-redhat-linux
--build=sparc64-redhat-linux --target=sparc64-redhat-linux
--with-cpu=v7
Thread model: posix
gcc version 4.1.1 20070105 (Red Hat 4.1.1-52)

Hardware is 8-way E3500 w/ 7GB (ATM) memory installed. There are two
36GB disk behing ESP and two behind Qlogic (= my backup plan :)
There is also CD-ROM and DDS-3 plugged to ESP-bus and at least the
DDS-3 is working fine (didn't even test the CD-ROM still).

Past about two hours the machine has pushed the OS part of disks once
to DDS-3 with tar and no problem. Now it's doing same with dump while
compiling RPMS - no problems what so ever.

The ESP part of the kernel messages comes up as following.

SCSI subsystem initialized
scsi0 : esp
esp: esp0 found at /sbus@3,0/SUNW,fas@3,8800000,
regs[1c738810000:1c738800000] irq[20]
esp: esp0 is a FASHME, 40 MHz (ccf=0), SCSI ID 7
scsi 0:0:0:0: Sequential-Access HP       C1537A           L007 PQ: 0 ANSI: 2
 target0:0:0: Beginning Domain Validation
 target0:0:0: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:0: Domain Validation skipping write tests
 target0:0:0: Ending Domain Validation
scsi 0:0:2:0: Direct-Access     SEAGATE  ST336704LSUN36G  032C PQ: 0 ANSI: 3
 target0:0:2: Beginning Domain Validation
 target0:0:2: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
 target0:0:2: Domain Validation skipping write tests
 target0:0:2: Ending Domain Validation
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
SCSI device sda: 71132959 512-byte hdwr sectors (36420 MB)
sda: Write Protect is off
sda: Mode Sense: cf 00 10 08
SCSI device sda: write cache: disabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4
sd 0:0:2:0: Attached scsi disk sda
scsi 0:0:3:0: Direct-Access     IBM      DDYST3695SUN36G  S96H PQ: 0 ANSI: 3
 target0:0:3: Beginning Domain Validation
 target0:0:3: FAST-10 WIDE SCSI 20.0 MB/s ST (100 ns, offset 15)
 target0:0:3: Domain Validation skipping write tests
 target0:0:3: Ending Domain Validation
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
sdb: Write Protect is off
sdb: Mode Sense: fb 00 00 08
SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
SCSI device sdb: 71132959 512-byte hdwr sectors (36420 MB)
sdb: Write Protect is off
sdb: Mode Sense: fb 00 00 08
SCSI device sdb: write cache: disabled, read cache: enabled, doesn't support DPO or FUA
 sdb: sdb1 sdb2 sdb3
sd 0:0:3:0: Attached scsi disk sdb
scsi 0:0:6:0: CD-ROM            TOSHIBA  XM6201TASUN32XCD 1103 PQ: 0 ANSI: 2
 target0:0:6: Beginning Domain Validation
 target0:0:6: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:6: Domain Validation skipping write tests
 target0:0:6: Ending Domain Validation


Something else? Long term stability and some _real_ I/O load is still
something to be tested ......


-- 
Pasi Pirhonen - upi@iki.fi - http://pasi.pirhonen.eu/
Top-postings silently ignored

From: Jim Gifford <maillist@jg555.com>
Date: Thu, 30 Mar 2006 05:44:04 +0000
Subject: Re: SCSI Hard Drive Issues Netra
Message-Id: <442B7024.9060904@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <442B3557.6090300@jg555.com>
In-Reply-To: <442B3557.6090300@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jim Gifford wrote:
> Jim Gifford wrote:
>> Since I tried working with 2.6.16 and 2.6.16.1, when I attempt to 
>> mount my scsi disks, I get invalid disk label. Switch back to 
>> 2.6.15.x, and the problem goes away. Any ideas suggestions, I'm stuck 
>> at this point to figure out what's wrong. Any help will be appreciated.
>>
> OK, here's what I've been able to find out about the issue 
> investigating it a lot further. Some reason it's saying my drives have 
> an improper checksum(See error message below).
>
> I'm doing a build on my X1 to see if the issue also exists.
>
> root:~# fdisk /dev/sda
> Detected sun disklabel with wrong checksum.
> Probably you'll have to set all the values,
> e.g. heads, sectors, cylinders and partitions
> or force a fresh label (s command in main menu)
>
>
I took my troubleshooting a little more. Issues the following commands, 
then rebooted.
I cleared out the old header and bootloader with
dd if=/dev/zero of=/dev/sda count=1 bsQ2

Then I ran fdisk, which gave me

"Device contains neither a valid DOS partition table, nor Sun, SGI or 
OSF disklabel
Building a new sun disklabel. Changes will remain in memory only,
until you decide to write them. After that, of course, the previous
content won't be recoverable."

Then I configured the label and saved, then I got the following error 
message.

Command (m for help): w
The partition table has been altered!

Calling ioctl() to re-read partition table.
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
 sda:Dev sda Sun disklabel: Csum bad, label corrupted
 unknown partition table
SCSI device sda: 35378533 512-byte hdwr sectors (18114 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write through w/ FUA
 sda:Dev sda Sun disklabel: Csum bad, label corrupted
 unknown partition table
Syncing disks.


-- 
----
Jim Gifford
maillist@jg555.com


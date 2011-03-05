From: Kjetil Oftedal <oftedal@gmail.com>
Date: Sat, 05 Mar 2011 14:55:11 +0000
Subject: Sun4d scsi<->fs issues [Was: Status update on sparc32 genirq support]
Message-Id: <Pine.LNX.4.64.1103051535390.27582@oizys.tordivel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

>On Sat, 5 Mar 2011, Kjetil Oftedal wrote:
>> 
>> Hi,
>> 
>> With regards to testing on sun4d, I have run into problems with the
>> existing kernel, during the process of getting a test system up and
>> running. The system is unable to mount partitions correctly,
>> (both ext2 on a hdd, and iso8859 on a cdrom), however dd, running from an
>> initrd filesystem is able to read the ext2 blocks correctly. So I have
>> started investigating this instead.
>> 
>> Is there anyone aware of any alignment requirements in the sun4d on DMA
>> transfers and such ? Or have the datasheet for the FAS2x6 (236) scsi
>> controllers ?
>
> First check that you can see the drive correctly from the OBP
> ok> probe-scsi-all
>
> If that is OK try booting with no SMP, I forget the correct incantation
> but something like "max-cpus=1" sounds familiar.
>
> You could also try booting with a 2.2.x kernel, if that does not work
> something is SERIOUSLY wrong. 2.2.x does not support SMP and has
> always booted OK for me.
>
> Do you have Solaris, it should boot and run 2.6, 7, or 8 (last supported).
> If this fails you certainly have hardware issues.
>
> Sorry to be vague, there has been no properly working Sun4d kernel
> since 2.2.x so expect to find bitrot in all sorts of obscure places.

Hi again,

probe-scsi-all reports no duplicate devices or anything else that might 
indicate problems. 

I have now tested with debian hamm, which uses some flavour of linux-2.2, 
and that was able to mount the filesystem and read files successfully. 

The linux-2.6 kernels I build are non-SMP ones, as SMP disables the 
ability to jump back to openboot, so SMP is problably not the source of 
the scsi problems.

The exact problem manifest with a successful mount of the filesystem. 
But it is not possible to read or list any files on the ext2 parition.

# mount /dev/sda2 /mnt
EXT2-fs (sda2): warning: mounting ext3 filesystem as ext2
# cd /mnt
# ls
EXT2-fs (sda2): error: ext2_check_page: bad entry in directory #2: : 
rec_len is smaller than minimal - offset=0, inode=0, rec_len=0, name_len=0
#

I have dumped out the memory area ext2_check_page is reading and it 
contains only zero-data. Hence, the error message. 

As mentioned if I use dd to access the same block on sda2 directly I get 
the correct data. (Address verified by enabling scsi command debugging 
messages in the esp driver)

Kjetil Oftedal


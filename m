From: "Kevin Wang" <kevin34@areca.com.tw>
Date: Thu, 19 Apr 2007 13:52:08 +0000
Subject: Re: Bug with ext3 journaling using Sparc hardware.
Message-Id: <00d901c78289$ed630b10$0132a8c0@arecakevin>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.62.0704182325170.28953@keuhkot.vipu.org>
In-Reply-To: <Pine.LNX.4.62.0704182325170.28953@keuhkot.vipu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Dear Sir,

after the problem happen, have you reboot system before ?
if not, please check the raidset member drives status in controller
management console.
there have some SMART value and two error counts.
does any drive reports error ?

if your system reboot after problem happen, these two error counts will be
reset.
you may needed to reproduce the problem then check the status.

you can also do a volume check without fix to check the data inside.
and YS drive have firmware updated for array applications, have you updated
the firmware already ?


Best Regards,


Kevin Wang

Areca Technology Tech-support Division
Tel : 886-2-87974060 Ext. 223
Fax : 886-2-87975970
Http://www.areca.com.tw
Ftp://ftp.areca.com.tw

----- Original Message ----- 
From: "Johannes Kullberg" <triak@vipu.org>
To: <sparclinux@vger.kernel.org>; <ext3-users@vger.kernel.org>;
<eki@sci.fi>; <kevin34@areca.com.tw>; <tuomas.leikola@appelsiini.fi>
Sent: Thursday, April 19, 2007 4:52 AM
Subject: Bug with ext3 journaling using Sparc hardware.


> Hi guys,
> My fileserver project is giving me a headache.
> I have been struggling with this one for a long time now, and help is
needed.
> My goal is to have a stable Sparc-based fileserver with hardware RAID and
> possibility to use SATA disk's.
> I'm experiencing severe filesystem breakage in certain situations.
>
> Setup:
> Sun Microsystems E450 2x300 Mhz / 512MB / OpenBoot 3.30
> Areca ARC-1160 fw. V1.42
> 8x Western Digital WD2500YS ( RAID6 1506 GB)
> Seagate SX336704LC root disk
> Intel Pro1000T
> Debian etch 2.6.20.1 smp
>
> Filesystems are created with theese commands:
>
> mkfs.ext3 -m 0 -L home /dev/sdb1
> mkfs.ext3 -m 0 -L srv /dev/sdb2
> mkfs.ext3 -m 0 -L store /dev/sdb3
> root filesystem formatted with Debian defaults
>
> Filesystem           1K-blocks      Used Available Use% Mounted on
> /dev/sda4             34416328  11627128  21040928  36% /
> tmpfs                   256552         0    256552   0% /lib/init/rw
> tmpfs                   256552         0    256552   0% /dev/shm
> /dev/sda1                90329     21922     63588  26% /boot
> /dev/sdb1             96122620    192312  95930308   1% /home
> /dev/sdb2             96122636    192312  95930324   1% /srv
> /dev/sdb3            1255375040 102169936 1153205104   9% /store
>
> I have been using the following script to test the filesystem:
>
> #!/bin/sh
> dir=/store
>
> iter=0
> while :; do
>    test -d $dir/iter-$iter && rm -rf $dir/iter-$iter
>    mkdir $dir/iter-$iter
>    cd $dir/iter-$iter
>     for i in 0 1 2 3 4 5 6 7 8 9; do
>       (mkdir d$i && cd d$i && tar xf /root/root.tar) &
>    done
>    wait
>    du -s $dir/iter-$iter
>    if [ $iter = 7 ]; then
>      echo "pass $iter, disk almost full, removing test data.."
>      rm -rf /$dir/iter-*
>      iter=0
>    else
>      echo "pass $iter, untarring the next round.."
>    fi
>    iter=$(expr $iter + 1)
> done
>
> root.tar is the whole Redhat root directory tarred in to ~9GB package.
> The test runs without problems for weeks, processing many terabytes.
> But then...!!
> Copying files from another partition or running fsfuzzer (after a short
> period) breaks the filesystem beyond repair.
> The following errors appear right after the copy process is done:
>
> EXT3-fs error (device sdb1): htree_dirblock_to_tree: bad entry in
directory #2: rec_len is smaller than minimal - offset=0, inode=0,
rec_len=0, name_len=0
> EXT3-fs error (device sdb2): htree_dirblock_to_tree: bad entry in
directory #2: rec_len is smaller than minimal - offset=0, inode=0,
rec_len=0, name_len=0
> EXT3-fs error (device sdb3): htree_dirblock_to_tree: bad entry in
directory #2: rec_len is smaller than minimal - offset=0, inode=0,
rec_len=0, name_len=0
> journal_bmap: journal block not found at offset 5883 on sdb2
> Aborting journal on device sdb2.
>
> How is this possible? The stress-script does not break anything and it
> handels billions of bytes.
>
> I run fsck.ext3 on sdb1..2..3 with lots of errors (output included as
> attatchment). I can mount the partition as ext2, trying to mount ext3
> gives an error:
>
> ext3: No journal on filesystem on sdb
>
> Any suggestions?
>
> TIA: Johannes


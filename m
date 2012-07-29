From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Sun, 29 Jul 2012 11:35:54 +0000
Subject: SILO fails to read silo.conf from EXT4 FS
Message-Id: <5015201A.8060309@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

With the rewrite of the e2fs part of SILO, its unable to read 
/etc/silo.conf from an EXT4 FS. It can read from EXT2 and EXT3, though.

Dumpe2fs from the partition where silo.conf is located:

dumpe2fs 1.42 (29-Nov-2011)
Filesystem volume name:   <none>
Last mounted on:          /
Filesystem UUID:          6027fece-1dd0-4d2e-8f03-c182f8101ed8
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index 
filetype needs_recovery extent flex_bg sparse_super large_file huge_file 
uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    user_xattr acl
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              2084880
Block count:              8334336
Reserved block count:     416716
Free blocks:              7654482
Free inodes:              1844855
First block:              0
Block size:               4096
Fragment size:            4096
Reserved GDT blocks:      1022
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         8176
Inode blocks per group:   511
Flex block group size:    16
Filesystem created:       Sun Jul 29 12:49:50 2012
Last mount time:          Sun Jul 29 13:28:47 2012
Last write time:          Sun Jul 29 13:27:35 2012
Mount count:              2
Maximum mount count:      -1
Last checked:             Sun Jul 29 12:49:50 2012
Check interval:           0 (<none>)
Lifetime writes:          132 MB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:	          256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      5e059fc0-418d-4c25-b1ce-afbf97717450
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Journal size:             128M
Journal length:           32768
Journal sequence:         0x000000a3
Journal start:            1



Log from boot:


Rebooting with command: boot 

Boot device: disk1  File and args: 

SILO Version 1.4.14_git2012226_p1 

 

Cannot find /etc/silo.conf (error: 4294967295) 

 

Couldn't load /etc/silo.conf 

No config file loaded, you can boot just from this command line 

Type [prompath;]part/path_to_image [parameters] on the prompt 

E.g. /iommu/sbus/espdma/esp/sd@3,0;4/vmlinux root=/dev/sda4 

or 2/vmlinux.live (to load vmlinux.live from 2nd partition of boot disk) 

boot:

Obviously the version where it used the e2fsprogs libs works fine.

Thanks

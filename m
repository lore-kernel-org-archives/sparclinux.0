From: Meelis Roos <mroos@linux.ee>
Date: Wed, 22 Feb 2012 07:22:51 +0000
Subject: Re: silo trouble with ext3
Message-Id: <alpine.SOC.1.00.1202220920500.21339@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Ok, let's try to fix this.  Can you run "dumpe2fs -h $DEV" where $DEV
> is the block device the filesystem resides on, and report the output?

I see you already have a patch for testing but here is the output from 
mounted filesystem:

Filesystem volume name:   mandariin-root
Last mounted on:          <not available>
Filesystem UUID:          1ff8d6d7-6d17-4bfa-9758-27a879320627
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr dir_index filetype 
sparse_super
Filesystem flags:         signed_directory_hash 
Default mount options:    (none)
Filesystem state:         not clean
Errors behavior:          Remount read-only
Filesystem OS type:       Linux
Inode count:              14446080
Block count:              28835840
Reserved block count:     1441792
Free blocks:              7187096
Free inodes:              14323802
First block:              0
Block size:               4096
Fragment size:            4096
Blocks per group:         32768
Fragments per group:      32768
Inodes per group:         16416
Inode blocks per group:   513
Filesystem created:       Thu Sep 23 17:14:35 2004
Last mount time:          Tue Feb 21 12:24:06 2012
Last write time:          Wed Feb 22 09:20:16 2012
Mount count:              1
Maximum mount count:      27
Last checked:             Tue Feb 21 13:32:08 2012
Check interval:           15552000 (6 months)
Next check after:         Sun Aug 19 14:32:08 2012
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:               128
Journal inode:            8
Default directory hash:   tea
Directory Hash Seed:      4605a528-34b9-4b7c-8455-fdcaf274e145
Journal backup:           inode blocks
Journal features:         journal_incompat_revoke
Journal size:             32M
Journal length:           8192
Journal sequence:         0x00917abb
Journal start:            0


-- 
Meelis Roos (mroos@linux.ee)

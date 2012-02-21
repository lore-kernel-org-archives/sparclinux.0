From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 23:10:07 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221.181007.225442485550765553.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jurij Smakov <jurij@wooyd.org>
Date: Tue, 21 Feb 2012 22:51:08 +0000

> If needed, the version can be rolled back pretty easily in 
> testing/unstable (will take just a couple of days), but that will 
> minimize the chances of the new version getting any mileage. Given 
> that the next Debian release is something like 6 months to a year away 
> and the fixes will be forthcoming sooner than that :-), I don't really 
> see a reason to do such a rollback, especially considering that vast 
> majority of the Debian sparc users, who followed the default 
> installation procedure, will not be affected by it. Default install 
> still creates a small ext2 partition at the beginning of the disk for 
> kernels and initrds (legacy of the sparc32 days, when kernel would 
> refuse to boot if it was further than 1GB away from the beginning of 
> the disk, or something like that). That was the reason why I did not 
> get any problem reports and have not seen any problems on my machine. 

The assumption here is that it has something to do with ext3 or some
ext3 specific feature, but it might not.

For example, I just found a bug with symlink handling in path
traversal fixed by the following patch.  So if there are symlinks
involved in Meelis's setup that would be the cause rather than not
specifically using ext2 for the boot partition.

--------------------
ext2: Fix symlink being overwritten.

When the symlink length is small, it's contained in the block list
part of the inode.  But we still need to copy the symlink into the
caller's buffer in that case because this string is used for path
traversal which will read an inode and thus overwrite the inode the
symlink string is inside of.

Also, forcefully NULL terminate the symlink string.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 second/fs/ext2.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/second/fs/ext2.c b/second/fs/ext2.c
index 710695a..53f2b5e 100644
--- a/second/fs/ext2.c
+++ b/second/fs/ext2.c
@@ -450,9 +450,11 @@ static char *read_symlink(struct silo_ext2_state *s, struct ext2_inode *ip, char
 	__u32 isize = ext2_to_cpu_32(ip->i_size);
 
 	if (isize <= 60)
-		return (char *) &ip->i_block[0];
+		strncpy(namebuf, (char *) &ip->i_block[0], isize);
+	else
+		read_data(s, ext2_to_cpu_32(ip->i_block[0]), 0, isize, namebuf);
 
-	read_data(s, ext2_to_cpu_32(ip->i_block[0]), 0, isize, namebuf);
+	namebuf[isize] = '\0';
 
 	return namebuf;
 }
-- 
1.7.7.6


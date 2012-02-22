From: David Miller <davem@davemloft.net>
Date: Wed, 22 Feb 2012 01:27:33 +0000
Subject: Re: silo trouble with ext3
Message-Id: <20120221.202733.1840554502153600636.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1202211523260.24120@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 21 Feb 2012 18:33:10 -0500 (EST)

> From: David Miller <davem@davemloft.net>
> Date: Tue, 21 Feb 2012 18:10:07 -0500 (EST)
> 
>> For example, I just found a bug with symlink handling in path
>> traversal fixed by the following patch.  So if there are symlinks
>> involved in Meelis's setup that would be the cause rather than not
>> specifically using ext2 for the boot partition.
>> 
>> --------------------
>> ext2: Fix symlink being overwritten.
> 
> Ignore me, there is no bug.  All callers specifically use a special
> on-stack inode buffer to avoid this problem.

Ok, while waiting for the debug dump from Meelis I think I found the
problem.

With my test harness I reproduced a case similar to what Meelis saw
but it has nothing to do with ext3'ness or anything like that.

The block group descriptors were having their location miscalculated.
It only worked for the first block of group descriptors.

So if an inode is outside of the first several block groups, things
don't work.  I guess for most /boot partitions, which are relatively
small, most if not all of the files fit into the working range.

Jurij, can you possibly build a test package for Meelis to see if this
fixes the reported bug?

It's pushed out to the silo GIT repo as well if that helps any.

--------------------
ext2: Calculate group descriptor location properly.

Calculate the block and offset correctly for group descriptors.

The existing code would work properly only for the first block
of descriptors.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 second/fs/ext2.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/second/fs/ext2.c b/second/fs/ext2.c
index 710695a..7eb665f 100644
--- a/second/fs/ext2.c
+++ b/second/fs/ext2.c
@@ -57,6 +57,8 @@ struct silo_ext2_state {
 	__u32			block_size;
 	__u32			addr_per_block;
 	__u32			addr_per_block_bits;
+	__u32			desc_per_block;
+	__u32			desc_per_block_bits;
 };
 static struct silo_ext2_state *sstate;
 
@@ -285,8 +287,8 @@ static void read_group(struct silo_ext2_state *s, __u32 grp_no,
 	__u32 first = ext2_to_cpu_32(s->super->s_first_data_block);
 	__u32 blk, offset;
 
-	blk = first + 1;
-	offset = grp_no * sizeof(*grp);
+	blk = first + 1 + (grp_no >> s->desc_per_block_bits);
+	offset = (grp_no & (s->desc_per_block - 1)) * sizeof(*grp);
 
 	read_data(s, blk, offset, sizeof(*grp), grp);
 }
@@ -371,6 +373,8 @@ static int open_ext2(char *device)
 
 	s->addr_per_block = s->block_size / sizeof(__u32);
 	s->addr_per_block_bits = calc_ilog2(s->addr_per_block);
+	s->desc_per_block = s->block_size / sizeof(struct ext2_group_desc);
+	s->desc_per_block_bits = calc_ilog2(s->desc_per_block);
 
 	s->scratch_block[0] = malloc(s->block_size * 4);
 	if (!s->scratch_block[0]) {
-- 
1.7.7.6


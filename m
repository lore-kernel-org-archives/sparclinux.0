From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 10 Apr 2006 23:03:23 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <20060410.160323.81822134.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Jim Gifford <maillist@jg555.com>
Date: Mon, 10 Apr 2006 15:48:26 -0700

> If we compile a Kernel(2.6.12-2.6.15) or util-linux(2.12r, 2.13-pre7) with GCC 4.1 we get
> this message during boot-up.
> sda:Dev sda Sun disklabel: Csum bad, label corrupted
> unknown partition table

It might be laying out the Sun partition table data structure
differently or something like that.  Or miscompiling the checksum
calculation loop.

Try compiling and running the following test program both
with a working compiler and with a non-working one, compare
the results.  It should be a small enough test case for a
gcc expert to look at it:

#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef unsigned short __be16;
typedef unsigned int __be32;

struct sun_disklabel {
	unsigned char info[128];   /* Informative text string */
	unsigned char spare0[14];
	struct sun_info {
		unsigned char spare1;
		unsigned char id;
		unsigned char spare2;
		unsigned char flags;
	} infos[8];
	unsigned char spare[246];  /* Boot information etc. */
	__be16 rspeed;     /* Disk rotational speed */
	__be16 pcylcount;  /* Physical cylinder count */
	__be16 sparecyl;   /* extra sects per cylinder */
	unsigned char spare2[4];   /* More magic... */
	__be16 ilfact;     /* Interleave factor */
	__be16 ncyl;       /* Data cylinder count */
	__be16 nacyl;      /* Alt. cylinder count */
	__be16 ntrks;      /* Tracks per cylinder */
	__be16 nsect;      /* Sectors per track */
	unsigned char spare3[4];   /* Even more magic... */
	struct sun_partition {
		__be32 start_cylinder;
		__be32 num_sectors;
	} partitions[8];
	__be16 magic;      /* Magic number */
	__be16 csum;       /* Label xor'd checksum */
};

#define dump_one_offset(name) \
printf("offsetof: " #name " %Zd\n", offsetof(struct sun_disklabel, name))

static void dump_offsets(void)
{
	printf("sizeof: %Zd\n", sizeof(struct sun_disklabel));
	dump_one_offset(info);
	dump_one_offset(spare0);
	dump_one_offset(infos);
	dump_one_offset(spare);
	dump_one_offset(rspeed);
	dump_one_offset(pcylcount);
	dump_one_offset(sparecyl);
	dump_one_offset(spare2);
	dump_one_offset(ilfact);
	dump_one_offset(ncyl);
	dump_one_offset(nacyl);
	dump_one_offset(ntrks);
	dump_one_offset(nsect);
	dump_one_offset(spare3);
	dump_one_offset(partitions);
	dump_one_offset(magic);
	dump_one_offset(csum);
}

int main(void)
{
	struct sun_disklabel label;
	__be16 csum, *ush;

	dump_offsets();

	memset(&label, 0xff, sizeof(label));

	ush = ((__be16 *) (&label + 1)) - 1;
	for (csum = 0; ush >= ((__be16 *) &label); )
		csum ^= *ush--;

	printf("Test checksum is %x\n", csum);

	exit(0);
}


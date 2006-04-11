From: Jim Gifford <maillist@jg555.com>
Date: Tue, 11 Apr 2006 03:24:40 +0000
Subject: Re: More on the Sun Disk Label Issue
Message-Id: <443B2178.1080000@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
References: <443AE0BA.8070706@jg555.com>
In-Reply-To: <443AE0BA.8070706@jg555.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

 Dave,
       They both give the same output exactly.

sizeof: 512
offsetof: info 0
offsetof: spare0 128
offsetof: infos 142
offsetof: spare 174
offsetof: rspeed 420
offsetof: pcylcount 422
offsetof: sparecyl 424
offsetof: spare2 426
offsetof: ilfact 430
offsetof: ncyl 432
offsetof: nacyl 434
offsetof: ntrks 436
offsetof: nsect 438
offsetof: spare3 440
offsetof: partitions 444
offsetof: magic 508
offsetof: csum 510
Test checksum is 0

    I think the problem may be with the way fdisk is creating the 
labels. Here is how they are doing it.

typedef struct {
        unsigned char info[128];   /* Informative text string */
        unsigned char spare0[14];
        struct sun_info {
                unsigned char spare1;
                unsigned char id;
                unsigned char spare2;
                unsigned char flags;
        } infos[8];
        unsigned char spare1[246]; /* Boot information etc. */
        unsigned short rspeed;     /* Disk rotational speed */
        unsigned short pcylcount;  /* Physical cylinder count */
        unsigned short sparecyl;   /* extra sects per cylinder */
        unsigned char spare2[4];   /* More magic... */
        unsigned short ilfact;     /* Interleave factor */
        unsigned short ncyl;       /* Data cylinder count */
        unsigned short nacyl;      /* Alt. cylinder count */
        unsigned short ntrks;      /* Tracks per cylinder */
        unsigned short nsect;      /* Sectors per track */
        unsigned char spare3[4];   /* Even more magic... */
        struct sun_partition {
                __u32 start_cylinder;
                __u32 num_sectors;
        } partitions[8];
        unsigned short magic;      /* Magic number */
        unsigned short csum;       /* Label xor'd checksum */
} sun_partition;

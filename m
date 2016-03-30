From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2016 01:23:09 +0000
Subject: Re: Minor tweak to silo regarding GPT labeled drives
Message-Id: <20160329.212309.169756802992982018.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <569D2C3E.5060608@oracle.com>
In-Reply-To: <569D2C3E.5060608@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Bryce <philip.copeland@oracle.com>
Date: Mon, 18 Jan 2016 18:17:34 +0000

> diff --git a/include/silo.h b/include/silo.h
> index 94d6e31..135b79e 100644
> --- a/include/silo.h
> +++ b/include/silo.h
> @@ -46,6 +46,7 @@ typedef struct {
>  } sun_partition;
>  
>  #define SUN_LABEL_MAGIC          0xDABE
> +#define GPT_LABEL_MAGIC          0x0000
>  
>  struct silo_inode {
>      unsigned int inolen;
> diff --git a/second/fs/iom.c b/second/fs/iom.c
> index 28dd4b2..8629d36 100644
> --- a/second/fs/iom.c
> +++ b/second/fs/iom.c
> @@ -37,8 +37,8 @@ static int read_sun_partition (int partno)
>          silo_fatal("Cannot read partition");
>          return 0;
>      }
> -    if (sdl.magic != SUN_LABEL_MAGIC)
> -        silo_fatal("Wrong disklabel magic");
> +    if ((sdl.magic != SUN_LABEL_MAGIC) && (sdl.magic != GPT_LABEL_MAGIC))
> +        printf("Wrong disklabel magic [0x%X]\n", (unsigned int) sdl.magic);
>      for (csum = 0, ush = ((unsigned short *) ((&sdl) + 1)) - 1; ush >= (unsigned short *) &sdl;)
>          csum ^= *ush--;
>      if (csum)

This can't be right.

If it's a GPT label then we have to add all of the necessary GPT
datastructures and code necessary to interpret and verify the
partition label properly.

You can't just fudge it by making the label magic check pass, the code
right afterwards verifies the checksum and then we calculate the disk
offset from the partition entry 'partno' to determine where to start
reading things.


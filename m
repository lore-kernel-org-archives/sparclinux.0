From: Oliver Hartkopp <socketcan@hartkopp.net>
Date: Sat, 02 Feb 2019 17:15:41 +0000
Subject: Re: [PATCH net-next v5 12/12] sock: Add SO_RCVTIMEO_NEW and SO_SNDTIMEO_NEW
Message-Id: <0fad3f4d-4c0e-d9f2-1af0-7890d40c19c0@hartkopp.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20190202153454.7121-1-deepa.kernel@gmail.com>
 <20190202153454.7121-13-deepa.kernel@gmail.com>
In-Reply-To: <20190202153454.7121-13-deepa.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Deepa Dinamani <deepa.kernel@gmail.com>, davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, linux-parisc@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, netdev@vger.kernel.org, deller@gmx.de, linux-mips@vger.kernel.org, ralf@linux-mips.org, cluster-devel@redhat.com, ccaulfie@redhat.com, paulus@samba.org, linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, rth@twiddle.net

Hi all,

On 02.02.19 16:34, Deepa Dinamani wrote:
> Add new socket timeout options that are y2038 safe.
(..)
> 
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/uapi/asm/socket.h
> index 9826d1db71d0..0d0fddb7e738 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -119,19 +119,25 @@
>   #define SO_TIMESTAMPNS_NEW      64
>   #define SO_TIMESTAMPING_NEW     65
>   
> -#if !defined(__KERNEL__)
> +#define SO_RCVTIMEO_NEW         66
> +#define SO_SNDTIMEO_NEW         67
>   
> -#define	SO_RCVTIMEO SO_RCVTIMEO_OLD
> -#define	SO_SNDTIMEO SO_SNDTIMEO_OLD
> +#if !defined(__KERNEL__)
>   
>   #if __BITS_PER_LONG = 64
>   #define SO_TIMESTAMP		SO_TIMESTAMP_OLD
>   #define SO_TIMESTAMPNS		SO_TIMESTAMPNS_OLD
>   #define SO_TIMESTAMPING         SO_TIMESTAMPING_OLD
> +
> +#define SO_RCVTIMEO		SO_RCVTIMEO_OLD
> +#define SO_SNDTIMEO		SO_SNDTIMEO_OLD

Maybe I'm a bit late in this discussion as you are already in v5 ...

I can see patches making the transition in different steps where it 
might be helpful to name them *_OLD and *_NEW to understand the patches.

But in the end the naming stays in the kernel for a very long time and I 
remember myself (in early years) to name things 'new', 'new2', 'new3'.

In fact SO_TIMESTAMP_OLD should be named SO_TIMESTAMP32 and 
SO_TIMESTAMP_NEW should be named SO_TIMESTAMP64.

Especially as it tells you what is 'inside', the naming of these new 
introduced constants should be replaced with *32 and *64 names.

The documentation and the other comments still fit perfectly then.

Regards,
Oliver

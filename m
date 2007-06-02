From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
Date: Sat, 02 Jun 2007 18:46:21 +0000
Subject: Re: Alignment question, sparc-centric
Message-Id: <Pine.LNX.4.61.0706021939290.421@mtfhpc.demon.co.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0706022001330.5076@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Jan,

Definatly not on sun4c (sparc32) and probably not on other sparc.

16bit values have to be 16bit aligned.
32bit values have to be 32bit aligned.
64bit values have to be 64bit aligned (e.g. double x).

Some versions of GCC may be capable of sorting out the correct code but my 
experience is avoid the situation to start with by using code similar to 
memcpy (&x, &un_aligned_x, sizeof x).

Regards
 	Mark Fortescue.

On Sat, 2 Jun 2007, Jan Engelhardt wrote:

> Hi,
>
>
> I was just wondering, since sparc is one of these alignment-sensitive
> architectures, is it actually valid to dereference at odd positions,
> e.g...?
>
>  *(uint16_t *)uint8_ptr[something_not_divisible_by_2];
>  *(uint32_t *)uint8_ptr[something_not_divisible_by_4];
>  etc.
>
>
> 	Jan
> -- 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

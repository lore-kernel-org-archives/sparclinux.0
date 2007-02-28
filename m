From: "Richard Mortimer" <richm@oldelvet.org.uk>
Date: Wed, 28 Feb 2007 12:30:54 +0000
Subject: RE: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <00c201c75b34$4dffb860$0202fea9@Jive>
List-Id: <sparclinux.vger.kernel.org>
References: <20070225200702.GA4451@droopy.oc.cox.net>
In-Reply-To: <20070225200702.GA4451@droopy.oc.cox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Excellent. I haven't had chance to compile a new kernel yet but
I tried changing rx_copybreak at modprobe time and can confirm
that the issue goes away.

rmmod tulip
modprobe tulip rx_copybreak18

Thanks

Richard 

> -----Original Message-----
> From: sparclinux-owner@vger.kernel.org 
> [mailto:sparclinux-owner@vger.kernel.org] On Behalf Of Doug Nazar
> Sent: 27 February 2007 18:52
> To: 'Jurij Smakov'
> Cc: sparclinux@vger.kernel.org
> Subject: RE: Unaligned accesses in ip_rcv and ip_fast_csum
> 
> > We have a report (Debian bug #409313 [0]) of the following unaligned
> > accesses, occuring every 5-6 seconds on Netra X1 and 
> SunFire v100 with
> > kernel 2.6.18 and newer:
> 
> This took me a little longer to track down than it should 
> have. I started
> looking at the wrong end of the issue but on the plus side I 
> now have a
> better understanding sparcv9 asm and the networking stack.
> 
> 
> diff --git a/drivers/net/tulip/tulip_core.c 
> b/drivers/net/tulip/tulip_core.c
> index 5a35354..e3774a5 100644
> --- a/drivers/net/tulip/tulip_core.c
> +++ b/drivers/net/tulip/tulip_core.c
> @@ -67,7 +67,7 @@ const char * const medianame[32] = {
>  
>  /* Set the copy breakpoint for the copy-only-tiny-buffer Rx 
> structure. */
>  #if defined(__alpha__) || defined(__arm__) || defined(__hppa__) \
> -	|| defined(__sparc_) || defined(__ia64__) \
> +	|| defined(__sparc__) || defined(__ia64__) \
>  	|| defined(__sh__) || defined(__mips__)
>  static int rx_copybreak = 1518;
>  #else
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


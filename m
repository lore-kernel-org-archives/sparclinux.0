From: "C.Newport" <crn@netunix.com>
Date: Thu, 09 Sep 2004 19:57:19 +0000
Subject: Re: Sun4D SMP now works OK, serial console broken - was Re: More Sun4d tests
Message-Id: <200409092057.19210.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <200409091646.21205.crn@netunix.com>
In-Reply-To: <200409091646.21205.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Thanks, this seems to help, but the real problem is still there.

To make testing easier I am now using the kbd/screen as console
and ttyS0 as a login terminal. 

Symptoms on the serial terminal: 
I can log in OK, and do a few simple things like ls, but as soon as I 
do something reasonably output intensive such as run top the 
output continues to be displayed but input is messed up. 
q or ^C does not work, so I kill the top process from the console.
now typing from serial (minicom session) gives garbage.

Another clue: 
stty < /dev/ttyS0  from the console should give me some clues, but this
hangs until I kill it with ^C.

 

On Thursday 09 September 2004 6:38 pm, David S. Miller wrote:
> On Thu, 9 Sep 2004 10:19:35 -0700
>
> William Lee Irwin III <wli@holomorphy.com> wrote:
> > On Thu, 9 Sep 2004, C.Newport wrote:
> > >> My SS1000E seems to be stable with 2.4.27 after fitting a frame
> > >> buffer and keyboard. It rebuilds a kernel OK in SMP mode.
> > >> Serial console is still broken, there seems to be a problem
> > >> with the sunzilog driver.
> > >> What other Sun machines use sunzilog.c as the serial console ?.
> > >> Is this problem really a sun4d issue or is it generic to sunzilog ?
> >
> > On Thu, Sep 09, 2004 at 12:55:19PM -0400, Chris Ricker wrote:
> > > I think early Ultras (Ultra2, for example) are Sun Zilog as well. I've
> > > not tried serial console on mine in a while though....
> >
> > Yes, SunZilog appears to be stable on all my UltraSPARC machines. The
> > bug is likely something specific to older revisions typically used in
> > sun4d boxen or some such.
>
> Like the UltraSPARC Enterprise bigger systems using the
> SunZILOG's for serial, the XBUS/XDBUS on sun4d can
> defer the completion of writes to I/O registers.
>
> Thus you should play around with enabling the
> __sparc_v9__ version of the ZS_WSYNC() macro
> in drivers/sbus/char/zs.c for all Sparc builds.
>
> Something like this:
>
> === drivers/sbus/char/zs.c 1.11 vs edited ==> --- 1.11/drivers/sbus/char/zs.c	2002-03-30 07:45:50 -08:00
> +++ edited/drivers/sbus/char/zs.c	2004-09-09 10:20:18 -07:00
> @@ -71,13 +71,13 @@
>  #ifndef __sparc_v9__
>  #define ZSDELAY()		udelay(5)
>  #define ZSDELAY_LONG()		udelay(20)
> -#define ZS_WSYNC(channel)	do { } while(0)
>  #else
>  #define ZSDELAY()
>  #define ZSDELAY_LONG()
> +#endif
> +
>  #define ZS_WSYNC(__channel) \
>  	sbus_readb(&((__channel)->control))
> -#endif
>
>  struct sun_zslayout **zs_chips;
>  struct sun_zschannel **zs_channels;
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


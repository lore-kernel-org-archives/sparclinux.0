From: "C.Newport" <crn@netunix.com>
Date: Tue, 13 Jul 2004 20:00:07 +0000
Subject: Re: sparc32 status
Message-Id: <200407132100.07918.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040713160257.GA8148@foobazco.org>
In-Reply-To: <20040713160257.GA8148@foobazco.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tuesday 13 July 2004 5:02 pm, Keith M Wesolowski wrote:
> Due to a conflict of interest, I'll no longer be maintaining the
> sparc32 tree.  Although I hope there will soon be an announcement of a
> new maintainer, in the interim please direct all patches and bug
> reports to the list.

> -- spot's sun4 patch  
(see below)

> -- sun4d ranges fixup is hosed, see sbus.c:sbus_bus_ranges_init:
>
> /*
>  * XXX This functions appears to be a distorted version of
>  * prom_sbus_ranges_init(), with all sun4d stuff cut away.
>  * Ask DaveM what is going on here, how is sun4d supposed to work... XXX
>  */

I tracked down a man in Sun who designed this stuff and gave his contact info 
to Keith. Sun4D should now be fixable.


> ... blow away all of the a.out build support cruft.
> There is zero use for any of this ancient crap anymore.
>
> This means C_SYMBOL() et al. may die as well.
>
> I had been meaning to do this for years.
>
> ** DONE

ISTM that this effectively blows Sun4 support out of the water.
Sun4 has not worked in a long while - Decision time ?.
Do we need Sun4 support ? - I have a 4/110 here tested with SunOS4.1.4
if someone would like to make the effort.

Add to list :- fc.c, fcal.c, pluto.c  Needs updating to new SCSI API.
	Most sun4d machines came with fc and pluto storage so they are
       rather cramped  for disk space without this. 

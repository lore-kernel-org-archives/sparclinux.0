From: Eric Brower <ebrower@gmail.com>
Date: Mon, 14 Feb 2005 20:45:27 +0000
Subject: Re: TUNSETIFF: data not copied back to userspace
Message-Id: <ec7cefb0502141245151c1cec@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Take a look at the dev_ifsioc() function in ioctl32.c-- it does not
copy the data back to userspace except for SIOCSIFMAP, and judging
from the strict definition of TUNSETIFF it should not be required to
do so.

I think if this is functionality that is required (I see no TUNGETIFF,
but I don't play with this stuff enough to know) the directionality of
the ioctl definition should be _IOWR rather than _IOR; in any case,
the "argument" field should  not be "int" but rather "struct ifreq*"
in if_tun.h.  Likely, neither will change for historical reasons....

E


On Mon, 14 Feb 2005 20:41:33 +0100 (CET), Michael Tautschnig
<michael.tautschnig@zt-consulting.com> wrote:
> Hello!
> 
> Thanks for the information regarding userland/kernelspace - I think I
> understood ...
> 
> The reason of my question were problems using the tun/tap interface - I've
> got an application (namely l2tpns) demanding the ifreq-structure being
> copied back to userspace - which AFAIK doesn't happen in case of the
> TUNSETIFF-ioctl. Is this a bug or are there any reasons why this shouldn't
> happen in dev_ifsioc ?
> 
> Thanks,
> Michael
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
E

From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 14 Feb 2005 23:02:33 +0000
Subject: Re: TUNSETIFF: data not copied back to userspace
Message-Id: <20050214150233.2ec4a292.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 14 Feb 2005 23:59:32 +0100 (CET)
Michael Tautschnig <michael.tautschnig@zt-consulting.com> wrote:

>     switch (cmd) {
>      case SIOCGIFFLAGS:
>      case SIOCGIFMETRIC:
>      case SIOCGIFMTU:
>      case SIOCGIFMEM:
>      case SIOCGIFHWADDR:
>      case SIOCGIFINDEX:
>      case SIOCGIFADDR:
>      case SIOCGIFBRDADDR:
>      case SIOCGIFDSTADDR:
>      case SIOCGIFNETMASK:
>      case SIOCGIFTXQLEN:
>        if (copy_to_user(uifr32, &ifr, sizeof(*uifr32)))
>          return -EFAULT;
>        break;
>      case SIOCGIFMAP:
> 
> - the (modified) struct is copied in all cases listed above. But what do 
> you mean by "the strict definition of TUNSETIFF"?

So add "case TUNSETIFF" to the switch statement above.
You discovered the fix for your own bug, so why not implement
it and submit the resulting patch here? :-)

> Why should be be _IOWR there?

ioctl's are mostly defined in with a set of macros that describe
whether data goes in or out (or both) from/to userspace.  The
_IORW macros set the direction to indicate that data goes both
in and out.

These macros are defined in include/asm/ioctl.h

include/linux/if_tun.h defines TUNSETIFF using the _IOW() macro.
Which indicates that data only comes in from userspace.  This definition
is incorrect, it should use _IORW() as Eric stated, but it can't be changed
because  this ioctl value is hardcoded into many existing applications which
would break if we "fixed" this.

From: Michael Tautschnig <michael.tautschnig@zt-consulting.com>
Date: Mon, 14 Feb 2005 22:59:32 +0000
Subject: Re: TUNSETIFF: data not copied back to userspace
Message-Id: <Pine.LNX.4.61.0502142341430.12680@l01.thnet>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Take a look at the dev_ifsioc() function in ioctl32.c-- it does not
> copy the data back to userspace except for SIOCSIFMAP, and judging
> from the strict definition of TUNSETIFF it should not be required to
> do so.
IMHO this isn't true -

    switch (cmd) {
     case SIOCGIFFLAGS:
     case SIOCGIFMETRIC:
     case SIOCGIFMTU:
     case SIOCGIFMEM:
     case SIOCGIFHWADDR:
     case SIOCGIFINDEX:
     case SIOCGIFADDR:
     case SIOCGIFBRDADDR:
     case SIOCGIFDSTADDR:
     case SIOCGIFNETMASK:
     case SIOCGIFTXQLEN:
       if (copy_to_user(uifr32, &ifr, sizeof(*uifr32)))
         return -EFAULT;
       break;
     case SIOCGIFMAP:

- the (modified) struct is copied in all cases listed above. But what do 
you mean by "the strict definition of TUNSETIFF"?


>
> I think if this is functionality that is required (I see no TUNGETIFF,
> but I don't play with this stuff enough to know) the directionality of
> the ioctl definition should be _IOWR rather than _IOR; in any case,
> the "argument" field should  not be "int" but rather "struct ifreq*"
> in if_tun.h.  Likely, neither will change for historical reasons....
>

The idea behind all that is, that the application needs (?) to know the 
name of the device (tunX) to do further ioctls on that device! Of course, 
it could be hardcoded, but that doesn't seem as nice ...

Why should be be _IOWR there?

Thanks,
Michael

From: Michael Tautschnig <michael.tautschnig@zt-consulting.com>
Date: Mon, 14 Feb 2005 23:18:08 +0000
Subject: Re: TUNSETIFF: data not copied back to userspace
Message-Id: <Pine.LNX.4.61.0502150013310.12680@l01.thnet>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
In-Reply-To: <Pine.LNX.4.61.0502141928510.11663@l01.thnet>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

[...]
>
> So add "case TUNSETIFF" to the switch statement above.
> You discovered the fix for your own bug, so why not implement
> it and submit the resulting patch here? :-)
It might have been intentionally left out - but here we go:


--- linux-2.6.10/fs/compat_ioctl.c      2005-02-15 00:09:53.969591354 +0100
+++ linux-2.6.10.patched/fs/compat_ioctl.c      2005-02-15 00:08:26.078059666 +0100
@@ -696,6 +696,7 @@
                 case SIOCGIFDSTADDR:
                 case SIOCGIFNETMASK:
                 case SIOCGIFTXQLEN:
+    		case TUNSETIFF:
                         if (copy_to_user(uifr32, &ifr, sizeof(*uifr32)))
                                 return -EFAULT;
                         break;

:-))

Actually, it did the trick - l2tpns works fine now.

[...]

>
> include/linux/if_tun.h defines TUNSETIFF using the _IOW() macro.
> Which indicates that data only comes in from userspace.  This definition
> is incorrect, it should use _IORW() as Eric stated, but it can't be changed
> because  this ioctl value is hardcoded into many existing applications which
> would break if we "fixed" this.
>

So the preferred behaviour would be: Add an interface-specification to 
l2tpns' config - or will the above "patch" ever be included in the 
official kernel?

Thanks for your help,
Michael

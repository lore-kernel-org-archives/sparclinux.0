From: till varoquaux <tvaroqua@ie2.u-psud.fr>
Date: Fri, 02 Jul 2004 12:58:50 +0000
Subject: Re: initrd problems??
Message-Id: <20040702145850.2dc5999c.tvaroqua@ie2.u-psud.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
In-Reply-To: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Thanks.
I didn't knew how to pass parameters to the kernel. interesting...
It does seem however like there is a weird bug:
I recompiled busybox with init support
(>init utilities
	>init
	>Support reading an initab file
	>Support running init from within an initrd
	>Should init be _extra_ quiet ion boot) 
and moved my /linurxc to /etc/init.d/rcS
and everything works fine now.....
I'm using kernel 2.4.26. Should I fill a bug report?
Regards,
Till
P.S.:I've build initrd on x86 before and definitly did not encounter
this behavior.

On Fri, 2 Jul 2004 08:21:39 -0400
Ben Collins <bcollins@debian.org> wrote:

> > I'm confused: isn't the standard init for an initrd /linuxrc?
> > How do I pass options to the kernel with tilo?
> > How come busybox is called when there isn't even an init link??
> > My kernel is the one from the Debian boot cd (I don't have the time
to> > compile a new one until I get this problem solved).
> 
> Read Documentation/initrd.txt in the kernel sources. It gives a lot of
> details about how initrd (and especially use of /linuxrc) is supposed
to> work, and what the kernel expects.
> 
> You could just try doing init=/bin/bash and see if that works. (boot
net> linux init=/bin/bash)
> 
> -- 
> Debian     - http://www.debian.org/
> Linux 1394 - http://www.linux1394.org/
> Subversion - http://subversion.tigris.org/
> WatchGuard - http://www.watchguard.com/
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux"
in> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
"pardon my french"

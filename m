From: Ben Collins <bcollins@debian.org>
Date: Fri, 02 Jul 2004 12:21:39 +0000
Subject: Re: initrd problems??
Message-Id: <20040702122139.GB3320@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
In-Reply-To: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> I'm confused: isn't the standard init for an initrd /linuxrc?
> How do I pass options to the kernel with tilo?
> How come busybox is called when there isn't even an init link??
> My kernel is the one from the Debian boot cd (I don't have the time to
> compile a new one until I get this problem solved).

Read Documentation/initrd.txt in the kernel sources. It gives a lot of
details about how initrd (and especially use of /linuxrc) is supposed to
work, and what the kernel expects.

You could just try doing init=/bin/bash and see if that works. (boot net
linux init=/bin/bash)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

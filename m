From: Ben Collins <bcollins@debian.org>
Date: Tue, 03 Feb 2004 21:21:39 +0000
Subject: Re: Was:  Problems with bridging on Sparc64
Message-Id: <20040203212139.GQ735@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200402031553.44155.crn@netunix.com>
In-Reply-To: <200402031553.44155.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> We should take pity on the developer of some nice 64 bit application 
> who tries to get his install scripts to work on all common Linux 
> distributions. Portability between distributions is a major headache
> for application developers.


With Debian, I think the goal is to make dpkg recognize the ABI aswell
as the arch.  The binaries will go in standard places (/bin, etc..).
Packages that support this will have ABI independent files go in a
seperate package (config files, headers, gifs, etc...) if needed, and
supply binary packages that are built for each ABI (sparc32, v9,
sparc64, etc..same goes for x86, x86-64 and hppa/hppa64).

So you would not be able to install, say bridge-utils for the 32-bit ABI
and bridge-utils for the 64-bit ABI together. They would conflict with
each other. You will however be able to install libc6 for 32-bit and
64-bit ABI's simultaneously.

This hasn't been done yet, but as more and more architectures hit this
problem, more and more folks are working on it.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

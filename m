From: Ben Collins <bcollins@debian.org>
Date: Fri, 02 Jul 2004 12:44:29 +0000
Subject: Re: initrd problems??
Message-Id: <20040702124429.GC3320@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
In-Reply-To: <20040701194809.3e060eb0.tvaroqua@ie2.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jul 02, 2004 at 02:58:50PM +0200, till varoquaux wrote:
> Thanks.
> I didn't knew how to pass parameters to the kernel. interesting...
> It does seem however like there is a weird bug:
> I recompiled busybox with init support
> (>init utilities
> 	>init
> 	>Support reading an initab file
> 	>Support running init from within an initrd
> 	>Should init be _extra_ quiet ion boot) 
> and moved my /linurxc to /etc/init.d/rcS
> and everything works fine now.....
> I'm using kernel 2.4.26. Should I fill a bug report?
> Regards,
> Till
> P.S.:I've build initrd on x86 before and definitly did not encounter
> this behavior.

I'm not quite sure why, but there is some weird difference in how
sparc64 boots up with initrd. I went down this road a long time ago with
the Debian boot images. I don't consider it a bug with the kernel, just
that x86 seems to be less critical of the initrd environment than other
architectures do. Hell, I can't even remember what it was that caused
this.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

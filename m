From: Ben Collins <bcollins@debian.org>
Date: Wed, 07 Jan 2004 19:58:06 +0000
Subject: Re: [BKPATCH]: Add option to define default command line to kernel.
Message-Id: <20040107195806.GR17280@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040107182529.GK17280@phunnypharm.org>
In-Reply-To: <20040107182529.GK17280@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 07, 2004 at 12:22:22PM -0800, David S. Miller wrote:
> On Wed, 7 Jan 2004 14:24:05 -0500
> Ben Collins <bcollins@debian.org> wrote:
> 
> > What if you have different kernels that require different boot args? If
> > you want to switch between them without messing with bootargs, this is
> > the easiest way.
> 
> Ok, I guess it can't hurt to add this change.

Thanks.

> But I have to admit it does still sound like someone being incredibly lazy :)

For someone that switches kernels once a week, or even once a day, it's
probably lazy. But I'm rebooting different kernels doing different
things in 1 minute cycles, so that should count for something :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

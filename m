From: Ben Collins <bcollins@debian.org>
Date: Wed, 04 Feb 2004 13:46:31 +0000
Subject: Re: Was:  Problems with bridging on Sparc64
Message-Id: <20040204134631.GB562@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200402031553.44155.crn@netunix.com>
In-Reply-To: <200402031553.44155.crn@netunix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Feb 04, 2004 at 10:01:28AM +0200, Baurjan Ismagulov wrote:
> Hello,
> 
> On Tue, Feb 03, 2004 at 04:21:39PM -0500, Ben Collins wrote:
> > So you would not be able to install, say bridge-utils for the 32-bit ABI
> > and bridge-utils for the 64-bit ABI together. They would conflict with
> > each other.
> 
> So, there are no plans to support such kind of installation for NFS
> clients (e.g., like proposed /bin64)? We plan to package both versions
> where binaries are /usr/bin/prg32 and /usr/bin/prg64 and provide a
> script /usr/bin/prg, which would check the architecture and run the best
> version. However, it would be interesting to know how the others solve
> this issue.

I'm not really interested in that kind of setup, but you could do it
without too much problems.

It'd be more of a headache to do that in a distribution.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

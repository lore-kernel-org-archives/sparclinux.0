From: Ben Collins <bcollins@debian.org>
Date: Wed, 07 Jan 2004 19:43:21 +0000
Subject: Re: [BKPATCH]: Add option to define default command line to kernel.
Message-Id: <20040107194321.GQ17280@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040107182529.GK17280@phunnypharm.org>
In-Reply-To: <20040107182529.GK17280@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 07, 2004 at 12:07:53PM -0800, David S. Miller wrote:
> On Wed, 7 Jan 2004 12:03:31 -0800
> Keith M Wesolowski <wesolows@foobazco.org> wrote:
> 
> > I don't really understand the need for this.  Why not just use the
> > PROM boot arguments if you're booting from TFTP?
> 
> I agree.  You can even tweak the prom environment vars to force
> the command line you want.

In my case, I'm booting back and forth between different kernels, and
each requires different command lines. It's a pain in the ass to type
that out on the command line, or change the bootargs env, when I can put
it in the kernel and type "boot net" no matter what it is, and without
having to remember which kernel I am booting from.

FYI, I ripped this out of ppc, so it's nothing new :)

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

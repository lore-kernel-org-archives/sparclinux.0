From: Ben Collins <bcollins@debian.org>
Date: Mon, 23 Feb 2004 12:04:55 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040223120455.GA2992@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 22, 2004 at 04:34:50PM -0800, William Lee Irwin III wrote:
> At some point in the past, davem wrote:
> >> Ben Collins and I may have messed up net booting when we added SILO+kernel
> >> support for larger images, but it could also be this STACK phdr thing too.
> 
> On Sun, Feb 22, 2004 at 06:57:12PM -0500, Ben Collins wrote:
> > My big kernel testing worked with net booting, but I didn't use
> > elftoaout, I booted the elf image directly.
> 
> OpenBoot 3.2.30 doesn't seem to netboot ELF directly; how did you do it?

I didn't say I did it on an e3000 :) Just noting that netboot should
still work.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

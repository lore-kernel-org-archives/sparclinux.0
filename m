From: Ben Collins <bcollins@debian.org>
Date: Mon, 23 Feb 2004 12:11:31 +0000
Subject: Re: oops in sched_init() on E3000
Message-Id: <20040223121131.GC4346@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040222043448.GG703@holomorphy.com>
In-Reply-To: <20040222043448.GG703@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Feb 23, 2004 at 04:27:31AM -0800, William Lee Irwin III wrote:
> On Sun, Feb 22, 2004 at 04:34:50PM -0800, William Lee Irwin III wrote:
> >> OpenBoot 3.2.30 doesn't seem to netboot ELF directly; how did you do it?
> 
> On Mon, Feb 23, 2004 at 07:04:55AM -0500, Ben Collins wrote:
> > I didn't say I did it on an e3000 :) Just noting that netboot should
> > still work.
> 
> Yeah, it turned out to be a config problem (CONFIG_NR_CPUS = 6 is bad
> with sparse MID's). I'm chasing down a sunhme.c issue how it appears.
> Bootlog (with some instrumentation) attached.

Nope, now you're chasing the same problem I am on e3000. Somehow the
IRQ's aren't getting setup properly. For me, esp scsi gets initialized
first, and the machine locks up waiting for the esp to get it's first
interrupt.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

From: Rob Radez <rob@osinvestor.com>
Date: Mon, 03 May 2004 15:31:27 +0000
Subject: Re: __builtin_trap() broken?
Message-Id: <20040503153126.GA17245@osinvestor.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040430151028.GA10534@osinvestor.com>
In-Reply-To: <20040430151028.GA10534@osinvestor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 03, 2004 at 07:48:21AM -0700, Keith M Wesolowski wrote:
> On Fri, Apr 30, 2004 at 11:10:28AM -0400, Rob Radez wrote:
> 
> > Trying to compile fs/reiserfs/journal.c in 2.6.6-rc1 (UP, sparc32, gcc
> > 3.3.3) ICE'd with an 'unrecognizable insn'.  It looks like there's a bad
> > interaction with __builtin_trap() again, for at least gcc 3.3.3 from
> 
> I can't reproduce this.  Bogus Debian patches?  gcc build options?
> Your test case looks good; please try with stock gcc 3.3.3 built with
> those same options that Debian uses (ie --with-kitchen-sink).  If it
> still fails then I guess we'll have to change this again.
[snip some stuff]

In IRC, I heard reports from other people that fs/reiserfs/journal.c
ICE'd for them too with gcc 3.3.3 from gentoo (config for kernel
available on request privately) but alas, I don't have it who or the
exact version of gcc logged (please feel free to chime in if it was you)
so it's unclear whether I just messed up in minimizing the test cast.
I'll spend some more time and see if I can pin it down.

Rob

From: David Dillow <dave@thedillows.org>
Date: Fri, 08 Oct 2004 16:51:07 +0000
Subject: Re: RED State Exception on Ultra 1, 2.6.9-rc2
Message-Id: <1097254267.4711.18.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1095742791.3421.3.camel@ori.thedillows.org>
In-Reply-To: <1095742791.3421.3.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 2004-09-21 at 23:35, David S. Miller wrote:
> On 21 Sep 2004 23:25:48 -0400
> David Dillow <dave@thedillows.org> wrote:
> 
> > > Anyways, in free_streaming_cluster() we took a vectored interrupt (trap
> > > type 0x60).  In tl0_ivec we took an illegal instruction trap, which is
> > > very odd because the instruction at 0x408c00:tl0_ivec is a branch.
[snip]
> Something is writing garbage to that instruction, that is my current
> guess.

Ok, I've reproduced one more RED exception, and several silent lockups.

I got a RED exception with arch/sparck64/kernel/sbus.c v1.17, but
without loading my lpvi driver. It's been a while, but I believe I've
seen a silent lockup on this kernel as well.

I backed that patch out, and using sbus.c 1.16 I've gotten 3 or 4 silent
lockups.

So, I think there is a problem somewhere, and its probably not the sbus
changes.

I'm using 2.4.9-rc2 built by gcc version 3.2.3 (Debian). 

Any suggestions on things I can do to rule out flaky hardware, or other
useful steps before I start a binary search on where it broke? It can
take from 15 minutes to 5 or more hours to reproduce using a network
load and back-to-back "dbench 24" runs.

Thanks,
Dave


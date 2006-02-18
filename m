From: Christopher Zimmermann <madroach@zakweb.de>
Date: Sat, 18 Feb 2006 15:48:00 +0000
Subject: Re: kernel-2.6.15-r4 (in)stability on U2-SMP, etc.
Message-Id: <20060218154759.GA1453@sparc>
List-Id: <sparclinux.vger.kernel.org>
References: <1140008955.4844.42.camel@polylepis.inforead.com>
In-Reply-To: <1140008955.4844.42.camel@polylepis.inforead.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'd like to try reproducing this on my U2-SMP(2x300). Could you give me
some instructions? I use Debian, so I just tried

find / -exec dd if='{}' of=/dev/null bs00 count 0 \;

This should generate some heavy disk load, shouldn't it?
I also tried starting two such processes in parallel, but I did not
experience any crashes so far.
Maybe this is of some importance: I use the deadline scheduler.

Christopher

On Wed, Feb 15, 2006 at 01:09:15PM +0000, Ferris McCormick wrote:
> A few days ago, I indicated that I was testing subject kernel on various
> systems (U2-SMP, U60-SMP, SB1000-MP) for stability.  U60/SB1000 appear
> to be stable.
> 
> However, U2-SMP(2x450) is not.  As is the case with ALL 2.6.xx kernels,
> 2.6.15-r4 cannot handle the sort of disk activity which portage requires
> of it on a daily basis (although the daily slocate cron task no linger
> kills it).  Symptom is as with all kernels in the 2.6.xx series ---
> silent death with system completely non-responsive to anything.
> 
> Regards,
> Ferris 
> -- 
> Ferris McCormick (P44646, MI) <fmccor@gentoo.org>
> Developer, Gentoo Linux (Sparc, Devrel)



From: David Dillow <dave@thedillows.org>
Date: Fri, 29 Oct 2004 06:14:19 +0000
Subject: Re: RED State Exception on Ultra 1, 2.6.9-rc2
Message-Id: <1099030459.8952.33.camel@ori.thedillows.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1095742791.3421.3.camel@ori.thedillows.org>
In-Reply-To: <1095742791.3421.3.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2004-10-10 at 21:09 -0700, David S. Miller wrote:
> On 08 Oct 2004 12:51:07 -0400
> David Dillow <dave@thedillows.org> wrote:
> 
> > Any suggestions on things I can do to rule out flaky hardware, or other
> > useful steps before I start a binary search on where it broke? It can
> > take from 15 minutes to 5 or more hours to reproduce using a network
> > load and back-to-back "dbench 24" runs.
> 
> David, I'll try to give you a hand with this when I get back
> from Japan on the 18th.

While you were gone, and while the latest addition to my family has kept
me up nights, I've run some more testing...

A simple "while true; do dbench 48; done" will crash the system.
Repeatably. With the exact same RED exception dump -- well, it was
different one time.

I tried from 2.6.1 to 2.6.8.1, all compiled by the same compiler I'd
been using with 2.6.9-rc2, and they all produced RED exceptions, or
silent hangs.

I also tried the Debian "testing" kernel package of 2.6.8.1 (gcc 3.3.2,
I think -- would have to reboot to check). Same result.

I'm open to suggestions on what to try next.

Thanks!
-- 
David Dillow <dave@thedillows.org>

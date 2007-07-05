From: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 05 Jul 2007 18:46:11 +0000
Subject: Re: [1/2] 2.6.22-rc7: known regressions
Message-Id: <1183661171.2756.13.camel@shinybook.infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <468A7D14.1050505@googlemail.com>
	 <1183599771.2740.19.camel@shinybook.infradead.org>
	 <alpine.LFD.0.98.0707050921000.9434@woody.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.98.0707050921000.9434@woody.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>, marcel@holtmann.org, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, reiserfs-devel@vger.kernel.org, "Vladimir V. Saveliev" <vs@namesys.com>, Randy Dunlap <randy.dunlap@oracle.com>, linux-ide@vger.kernel.org, David Chinner <dgc@sgi.com>, sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>, Mikael Pettersson <mikpe@it.uu.se>, Mark Fortescue <mark@mtfhpc.demon.co.uk>, William Lee Irwin III <wli@holomorphy.com>

On Thu, 2007-07-05 at 09:28 -0700, Linus Torvalds wrote:
> 
> On Wed, 4 Jul 2007, David Woodhouse wrote:
> > 
> > Oh, and here's another one for you. My Bluetooth mouse just stopped
> > working and hidd is deadlocked...
> 
> Looks like it is stuck on hidp_session_sem.

Oh, I suck. I failed to noticed that it had oopsed earlier, in slab
debugging. I shall look at my 'obviously correct' slab patch a little
harder, now that I'm not distracted by the fireworks.

-- 
dwmw2


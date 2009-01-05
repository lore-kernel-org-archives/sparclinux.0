From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 05 Jan 2009 22:14:22 +0000
Subject: Re: ftrace breaks sparc64 build
Message-Id: <alpine.DEB.1.10.0901051710450.25066@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105181922.GA25622@uranus.ravnborg.org> <alpine.DEB.1.10.0901051428370.27085@gandalf.stny.rr.com> <20090105195415.GA6204@uranus.ravnborg.org> <alpine.DEB.1.10.0901051458460.25066@gandalf.stny.rr.com> <20090105213107.GA27293@uranus.ravnborg.org>
 <alpine.DEB.1.10.0901051649240.25066@gandalf.stny.rr.com> <20090105220156.GC8592@uranus.ravnborg.org>
In-Reply-To: <20090105220156.GC8592@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sam Ravnborg <sam@ravnborg.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <srostedt@redhat.com>, Ingo Molnar <mingo@elte.hu>, "David S. Miller" <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>


On Mon, 5 Jan 2009, Sam Ravnborg wrote:

> > Is this all sparc cross compiler?  I'm trying to reproduce it on x86 with 
> > no avail :-(
> > 
> > I would like to test other ways to change the macro, but to do so, I need 
> > to get a compiler that will produce the warnings that you see. What 
> > version of gcc are you using?
> 
> I used crosstool to build a 3.4.5 gcc:

Hmm, that's a pretty old compiler. I wonder if it wouldn't just help
if we just make the branch tracer dependent on the compiler used. That is.

#if defined(CONFIG_PROFILE_ALL_BRANCHES) && (__GNUC__ >= 4)
#define if(cond) ...

Or something :-/

-- Steve

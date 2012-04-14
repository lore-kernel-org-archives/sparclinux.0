From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 14 Apr 2012 10:23:00 +0000
Subject: Re: [GIT] Sparc
Message-Id: <20120414102300.GA32120@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120413.152455.900761231064979707.davem@davemloft.net> <CA+55aFwYWRv6+ix+UjT52UAn1rQeDpUKmbWq5SdHjZ0qHR2Cbg@mail.gmail.com> <20120413215012.GA31739@merkur.ravnborg.org> <20120414091352.GA15373@gmail.com>
In-Reply-To: <20120414091352.GA15373@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>, akpm@linux-foundation.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Sat, Apr 14, 2012 at 11:13:52AM +0200, Ingo Molnar wrote:
> 
> * Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Fri, Apr 13, 2012 at 12:46:34PM -0700, Linus Torvalds wrote:
> > > On Fri, Apr 13, 2012 at 12:24 PM, David Miller <davem@davemloft.net> wrote:
> > > >
> > > > With special guest sparc64 assembler hacker, Paul E. McKenney.
> > > 
> > > Oh christ.  You're teaching *more* people about sparc64?
> > You do not get it...
> > 
> > How many people are pondering around tweaking every bit of x86
> > specific code? A lot! Let them have fun competing :-)
> 
> I wish it was so! In reality there's really just a handful of 
> people looking at actual x86 assembly code. I don't know whether 
> I've ever seen a conflict between substantial x86 assembly 
> patches, in the last 4 years since I co-maintain the x86 
> architecture ...

Hmm...

      lines of c files  lines of S files
x86   183609            27130
sparc 66823             25852

There is more than just assembly when dealign with an architecture.
And honestly I do not "speak" neither sparc nor x86 assembly.

	Sam

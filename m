From: Steven Rostedt <rostedt@goodmis.org>
Date: Mon, 15 Aug 2011 19:55:00 +0000
Subject: Re: About ARCH=sparc and what to pass to recordmcount.pl
Message-Id: <1313438100.15704.20.camel@gandalf.stny.rr.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20110815152102.GK11398@pengutronix.de>
In-Reply-To: <20110815152102.GK11398@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2011-08-15 at 12:44 -0700, David Miller wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> Date: Mon, 15 Aug 2011 11:40:23 -0400
> 
> > Actually, I think option d) is the best.
> > 
> > d) have sparc support recordmcount.c
> 
> Maybe you misunderstand what these guys are doing.
> 
> The recordmcount.pl script wants to look at the output of the
> architecture of the built kernel.  It's intimitately tied to
> the architecture the kernel was built as, it must therefore
> be invoked with exactly what the kernel was bult with.
> 
> These guys are building a 64-bit sparc kernel then trying to use
> recordmcount.pl with the 32-bit sparc ARCH set.
> 
> That can't work.
> 
> Next, recordmcount.pl doesn't have 32-bit sparc support because we
> don't support building the kernel with profiling options enabled for
> that architecture.

But if they use recordmcount.c instead, then nothing needs to be done
with recordmcount.pl.

recordmcount.c looks at the elf file itself to determine what arch it is
for. If this is supported, then everything should work, and you get a
faster build of the kernel as an extra bonus.

But sure, if we test recordmcount.pl on all archs, and using the SRCARCH
doesn't break anything, then I'm fine with that change too.

-- Steve



From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 06 Jun 2008 11:27:21 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080606112721.GA31482@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jun 06, 2008 at 02:12:09PM +0300, Adrian Bunk wrote:
> On Thu, Jun 05, 2008 at 10:25:18PM +0200, Sam Ravnborg wrote:
> >...
> > Half of this is trivial differences but anyway more work than
> > I initially anticipated :-(
> 
> Is there anything where I could/should help?

The ones I have not yet finished is:

posix_types.h
ptrace.h
sigcontext.h
siginfo.h
signal.h
stat.h
termbits.h
termios.h
types.h
unistd.h

Except for termios.h (or was is termbits.h) then they all
looks like they will require two different sections in the .h file.

Any help with these are appreciated.
I will look at it tonight again and will concentrate on
the patches I already have.

	Sam

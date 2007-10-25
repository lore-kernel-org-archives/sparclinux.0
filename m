From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 25 Oct 2007 15:07:36 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071025150736.GA2824@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Oct 24, 2007 at 04:36:03PM -0700, David Miller wrote:
> > > 2) compiler used to build kernel and is it SMP?
> > 
> > gcc (GCC) 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)
> > 
> > I've no idea if that compiler is SMP, if you want I'll ask someone else.
> 
> I was asking if the running kernel were SMP or not, I'll assume it is
> :-)

Oh, sorry, that sentence structure confused me (not a native speaker).

> > There doesn't appear to be a pattern, on this machine at least - I just let
> > the buildd run, building whatever comes up, and after a few hours it
> > inevitably runs into a wall.
> 
> If you try, within that troublesome build-root, a few times to try to
> fork off a couple hundred:
> 
> 	dpkg-query --something python-2.5
> 
> or whatever, can you get some of processes to wedge under that
> build root?

I did this in a chrooted bash:

for i in $(seq 0 100); do (dpkg-query -s python2.5-minimal > /dev/null &); done

And now the machine went catatonic. :(

Thankfully the console is still vaguely operational - I can enter my
username to log in, but I can't get the Password prompt to appear.
Magic SysRq still works - if you need any output from it, tell me.

-- 
     2. That which causes joy or happiness.

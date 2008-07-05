From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 05 Jul 2008 23:03:48 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080705230348.GA18213@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Jul 05, 2008 at 10:55:10PM +0200, Sam Ravnborg wrote:
> > 
> > So this looks correct except that we include the wrong header file.
> > So the test:
> > #if defined(__sparc__) && defined(__arch64__)
> > 
> > is the bad one.
> ....
> > 
> > We can fix the -Usparc64 for the vmlinux.lds file if the right check is:
> > #if defined(__sparc__) && defined(sparc64)
> 
> I think this is the right way to go so I have locally
> committed the following patch.
Hmm, I was fooled by something else. My sparc64 gcc does NOT
define the sparc64 symbol.
I defines:
__sparc_v9__
and
__arch64__

to say this is sparc64.

So I really need the output of:
touch foo.c; cpp -dM foo.c

to select the right combination of options before I can
proceed.

	Sam

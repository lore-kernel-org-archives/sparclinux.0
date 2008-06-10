From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 10 Jun 2008 21:03:48 +0000
Subject: Re: [PATCH 01/21] sparc: copy exported sparc64 specific header files to asm-sparc
Message-Id: <20080610210348.GB16756@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1212786033-4227-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 10, 2008 at 11:00:03PM +0200, Sam Ravnborg wrote:
> On Tue, Jun 10, 2008 at 01:48:39PM -0700, David Miller wrote:
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Tue, 10 Jun 2008 22:45:33 +0200
> > 
> > > Notice that I screwed up the changelog/diff in the last two patches
> > > in the series. I can do a repost when you push your current sparc tree.
> > 
> > After test building I hit another problem.  If I apply your
> > first patch, the header checks fail with things like:
> > 
> > /home/davem/src/GIT/sparc-next-2.6/usr/include/asm-sparc64/display7seg.h requires asm-sparc/display7seg.h, which does not exist in exported headers
> > 
> > Is there any way to avoid this so that the tree is bisectable
> > during your changes?
> Yes - I will then have to add all the moved headers to
> include/asm-sparc/Kbuild.
I was trying to say that all the files copied to asm-sparc had to be
listed in asm-sparc/Kbuild to get exported.
And we need to keep them in asm-sparc64 to be exported there.

	Sam

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Apr 2012 20:21:27 +0000
Subject: Re: sparc32 - keyboard is dead with v3.4-rc1
Message-Id: <20120404202127.GA17013@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120403204455.GA29433@merkur.ravnborg.org>
In-Reply-To: <20120403204455.GA29433@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 04, 2012 at 08:55:48AM +1000, Julian Calaby wrote:
> Hi Sam,
> 
> On Wed, Apr 4, 2012 at 06:44, Sam Ravnborg <sam@ravnborg.org> wrote:
> > Hi all.
> >
> > bisect will take some time as my build-machine is not exactly
> > quick - so I expect no result until sometime tomorrow.
> > But the good thing is that it is easy to test :-)
> 
> I'm investigating distcc as a solution for this as part of my latest
> attempt to get Gentoo Linux onto my SS10. I've read some success
> stories, however they're on my other computer, if you're interested,
> I'll send you a link to the "official" Gentoo sparc/distcc guide.

distcc require spare computers - for now I do most of my
linux stuff on one Intel dual-core Atom based box.
I have a quad-core box - but it is seldom powered on.

The Atom based box is always ready - which matches my
typical working pattern well (less than an hour typically
and only few days a week).

The quad-core would be fine for bisect etc. but then
I have to install a lot....
In practice I am much slower than the computer,
so it actualy hurts less than one may think.

	Sam

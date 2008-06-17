From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 17 Jun 2008 18:22:39 +0000
Subject: Re: unify sparc and sparc64 headers
Message-Id: <20080617182239.GB11453@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080613195449.GA9141@uranus.ravnborg.org>
In-Reply-To: <20080613195449.GA9141@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 17, 2008 at 08:46:13AM -0700, Eric Brower wrote:
> On Tue, Jun 17, 2008 at 12:02 AM, Sam Ravnborg <sam@ravnborg.org> wrote:
> > On Mon, Jun 16, 2008 at 04:33:03PM -0700, David Miller wrote:
> >> From: Sam Ravnborg <sam@ravnborg.org>
> >> Date: Fri, 13 Jun 2008 21:54:49 +0200
> >>
> >> > The full set can be pulled from:
> >> >
> >> >    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git
> >> >
> >> > And will follow as mails too.
> >>
> >> This looks OK.
> >>
> >> About asm/openprom.h, I am very sure we can kill that export to
> >> userspace.  The only real user is the SILO boot loader and nowadays
> >> SILO includes it's own copy of the kernel headers it needs so we can
> >> safely remove the export on the kernel side.
> >
> > The purpose of exporting kernel headers to
> > user space is to get rid of all the local copies so this
> > seems as a wrong argument to remove the export. We should
> > instead ask SILO to use the kernel exported version.
> >
> > Looking at the SILO sources I would say that the kernel should
> > use a copy from the SILO source as that version are far better
> > documented than the kernel version. And then export that version.
> >
> >        Sam
> 
> The current methodology of copying kernel header files into user-space
> application sources has always perplexed me.  Does this indicate there
> is talk or activity around changing this methodology, or are you
> pushing towards such an agenda, Sam?  Not subscribing to LKML, perhaps
> I'm a bit out of the loop.

David Woodhouse startet a task to create a proper set of exported
kernel headers. And they are today used by gcc and glibc (to my best knowledge).
There is nolonger separate kernel-headers install jobs - the exported
headers are created by "make headers_install" from the kernel source.

So the possibility is new.
If this is feasible for small packages like SILO is another matter. IMHO
SILO and alikes should use the exported headers like gcc/glibc does
it. But I think I share this opinion with the other kernel folks
but I have never asked direct.

So this is from my side not seen as a private agenda but as the general
kernel movement in this respect.

	Sam

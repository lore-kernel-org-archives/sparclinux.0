From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 21 Feb 2016 20:13:24 +0000
Subject: Re: Kernels 4.+ are breaking rsync?
Message-Id: <20160221201324.GA24601@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <56C11585.3060503@triadic.us>
In-Reply-To: <56C11585.3060503@triadic.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Feb 21, 2016 at 01:52:55PM -0500, Alex McWhirter wrote:
> On 02/14/2016 07:02 PM, Alex McWhirter wrote:
> > I having a strange issue where using any 4.X kernel causes rsync to
> > appear to die on a select syscall. Not sure why, maybe it's getting a
> > wrong file descriptor or something. Unfortunately this starts pushing
> > outside of my knowledge level of linux so bear with me. This is on a Sun
> > V215 but i have also tested it on a Sun Blade 150 and a Sun Ultra 45
> > with the same results. These are all sun4u boxes of course, i haven't
> > tried any sun4v boxes. I''l try to spin up a T5120 this week and find
> > out if it's also an issue on sun4v.
> >  
> > Here's what I've tested.
> >
> > 3.14.58 "gentoo" - Works
> > 3.18.26 "vanilla"  - Works
> > 4.1.15   "gentoo" - Dead
> > 4.1.17   "vanilla"  - Dead
> > 4.4.1     "vanilla"  - Dead
> >
> > I don't mind hacking away at kernel sources if anyone can point me in
> > the right direction. It's also worth noting that this only happens when
> > the folder i am attempting to rsync is significantly large in regards to
> > the amount of sub-folders and files. The Gentoo portage tree in particular.
> >
> > Attached is the strace output of a failing rsync job.
> >
> >
> 
> I've traced this down a bit further.
> 
> Kernel 3.18.26 is working but 3.19.0 is not. Git bisect traced it down
> to this commit.
> 
> e5a4b0bb803b39a36478451eae53a880d2663d5b is the first bad commit
> commit e5a4b0bb803b39a36478451eae53a880d2663d5b
Well done!

Did you try to revert the offending commit on top of a faulty
kernel, just to double check this is the guilty commit?

	Sam

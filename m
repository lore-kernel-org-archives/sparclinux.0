From: "Alex Deucher" <alexdeucher@gmail.com>
Date: Tue, 07 Mar 2006 22:57:36 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <a728f9f90603071457g47802436h964686e7293a5530@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/7/06, Josh Grebe <josh@brokedown.net> wrote:
> Hi Alex,
>
> Current 2.6 kernels are doing pretty well for me. There are issues, though. You
> will want to move all your memory to the bank of cpu0 if you can. Linux won't
> see all of it no matter where you put it, but you get more if it is all on one
> cpu. Make sure you have a current OBP, I'm running 4.17.1.

Thanks Josh.  What's the limit on ram?  These boxes have 2 GB at the
moment.  I'm not sure which slots they are in.

Alex

>
> I can't even get 2.4 to userland.
>
> Linux v240 2.6.15-gentoo-r7 #1 SMP Fri Mar 3 12:40:28 CST 2006 sparc64 sun4u TI
> UltraSparc IIIi (Jalapeno) GNU/Linux
>
> Josh
>
>
>
> Alex Deucher wrote:
> > I have a couple questions about Linux support for the sunfire V240.
> > I've only been able to find limited information about the status of
> > the V240s.  I have several that I'd like to install linux on.  My
> > other question is, what is the status of SMP on 2.6 kernels?  The last
> > few times I tried it locked the boxes hard, however I seem to recall
> > hearing that the problem had been fixed.  I'm currently running debian
> > w/ 2.4 kernels on our SMP SPARC boxes and debian with 2.6 kernels on
> > our UP SPARC boxes (E4500, 420R, 220R, etc.) and both have been rock
> > solid.  What's my best bet for SMP V240 servers?  2.4? 2.6?
> >
> > Thanks,
> >
> > Alex

From: "Michael Marineau" <mike@marineau.org>
Date: Tue, 06 Mar 2007 19:48:50 +0000
Subject: Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <c0526ddf0703061148x27229bfbv49e126b0a0f9e1ab@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
In-Reply-To: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/5/07, David Miller <davem@davemloft.net> wrote:
> From: "Michael Marineau" <mike@marineau.org>
> Date: Mon, 5 Mar 2007 22:41:31 -0800
>
> > On 3/5/07, David Miller <davem@davemloft.net> wrote:
> > > I'd be even more interested if you could reproduce it under
> > > Debian or Ubuntu, any release :-)
> >
> > I'd rather not have to rebuild the box, but I suppose that can be done
> > if necessary.
>
> Another way we could do this is someone builds you a test kernel using
> your kernel .config on a Debian/Ubuntu box, tar up the modules and
> kernel image for you, and you test that.
>
> I'm very suspicious of this bug because there are no reports of it
> on Debian or Ubuntu systems, and that's also the environment
> under which I've been beating the crap out of Niagara with 2.6.x
> kernels.

I twiddled with my kernel configuration a bit to remove the need for
any modules to make building elsewhere and copying it over easier.
With this new config I am no longer able to trigger the bug (ran the
test over night).  I have no idea what change did this, I'll fiddle
more with it as soon as I have time in the next day or two.

-- 
Michael Marineau
Oregon State University
mike@marineau.org

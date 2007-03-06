From: "Michael Marineau" <mike@marineau.org>
Date: Tue, 06 Mar 2007 06:41:31 +0000
Subject: Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <c0526ddf0703052241tf5fa8aale0efbf14539e7bb1@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
In-Reply-To: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/5/07, David Miller <davem@davemloft.net> wrote:
> From: "Michael Marineau" <mike@marineau.org>
> Date: Mon, 5 Mar 2007 21:22:22 -0800
>
> > I'm not sure where you saw Fedora,
>
> Sorry, that wasn't you, that was from Dennis Gilmore in
> the original T1000 crash thread. :-)
>
> this is running Gentoo, but yes the
> > compiler is 3.4.6. Newer versions haven't been marked stable in Gentoo
> > on sparc yet for some reason. I'll give gcc 4.1.2 a try and see if I
> > can still reproduce it.

Built the kernel with gcc 4.1.1 and I got the oops in just a few
minutes, trying a second time now and it is lasting longer this time
around.

>
> I'd be even more interested if you could reproduce it under
> Debian or Ubuntu, any release :-)

I'd rather not have to rebuild the box, but I suppose that can be done
if necessary.

-- 
Michael Marineau
Oregon State University
mike@marineau.org

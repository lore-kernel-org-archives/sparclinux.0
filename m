From: David Miller <davem@davemloft.net>
Date: Tue, 06 Mar 2007 20:02:20 +0000
Subject: Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <20070306.120220.63126953.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
In-Reply-To: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Michael Marineau" <mike@marineau.org>
Date: Tue, 6 Mar 2007 11:48:50 -0800

> I twiddled with my kernel configuration a bit to remove the need for
> any modules to make building elsewhere and copying it over easier.
> With this new config I am no longer able to trigger the bug (ran the
> test over night).  I have no idea what change did this, I'll fiddle
> more with it as soon as I have time in the next day or two.

Thanks for continuing to help track this down.

Probably it's some module that has some "use after free" memory
allocation bug.

From: David Miller <davem@davemloft.net>
Date: Tue, 06 Mar 2007 05:04:26 +0000
Subject: Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <20070305.210426.95058803.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
In-Reply-To: <c0526ddf0702282313i4c815b1ta31cdb159ae84ba4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Michael Marineau" <mike@marineau.org>
Date: Wed, 28 Feb 2007 23:13:20 -0800

> This bug was originally reported for a T1000 a while back:
> http://thread.gmane.org/gmane.linux.ports.sparc/6361/focusd13
> 
> On a T2000 I am able to trigger the Oops in 5 to 50 minutes by pushing
> a ton of traffic over lo with netcat:
> nc -l -p 9000 >/dev/null
> nc localhost </dev/zero

I've run the same and similar tests for quite some time and
I can't get a trigger on both my T1000 and T2000.  I let them
keep running for a while just in case.

Your ability to trigger this in 5 minutes or so is too easy, and
therefore I looked again at your original report and I see that you
are using some fedora3 based distribution and the gcc-3.4.x that comes
with it to build your kernel.

I really suspect the compiler or build tools at this point.

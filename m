From: David Miller <davem@davemloft.net>
Date: Thu, 01 Mar 2007 18:08:37 +0000
Subject: Re: Oops in tcp_sendmsg on T[12]000
Message-Id: <20070301.100837.41635392.davem@davemloft.net>
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
> 
> This works on 2.6.19, 2.6.20, and 2.6.21-rc2.  I have added the
> debugging statement suggested in the original thread, and it's result
> along with the Oops is posted below.  I've dug through the code a bit,
> but so far the issue is far beyond me. Thanks for any help!

Thanks for the debugging information, I'll certainly try to track
this down.

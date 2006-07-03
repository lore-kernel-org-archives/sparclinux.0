From: Ben Collins <bcollins@ubuntu.com>
Date: Mon, 03 Jul 2006 16:16:15 +0000
Subject: Re: Oops in tcp_sendmsg on T1000
Message-Id: <1151943375.4864.36.camel@grayson>
List-Id: <sparclinux.vger.kernel.org>
References: <200607011421.56811.rene@exactcode.de>
In-Reply-To: <200607011421.56811.rene@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, 2006-07-02 at 12:13 -0700, Jurij Smakov wrote:
> On Sun, 2 Jul 2006, David Miller wrote:
> 
> > 2.6.17.x should be extremely stable and there is nothing
> > in the current tree that ought to fix this.
> >
> > Please retry with gcc-4.0.x, I really want to eliminate
> > gcc-4.1.x because that compiler has caused problems for
> > other folks.  In fact I'm almost hoping it's a gcc-4.1.x
> > problem so we can investigate it using this test case and
> > fix it :)
> 
> FWIW, I have experienced exactly the opposite while preparing the 2.6.17 
> for Debian: the SMP kernel built with gcc-4.0 was hanging randomly 
> during boot, but works fine when built with gcc-4.1.

Was this an SMP machine/kernel? If so, it sounds like the scheduler
tuning bug, fixed in the latest kernel (maybe dave knows git sha).

-- 
Ubuntu     - http://www.ubuntu.com/
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
SwissDisk  - http://www.swissdisk.com/


From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2009 09:11:24 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090915.021124.38790429.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Mon, 14 Sep 2009 14:40:22 +0200

> On Mon, Sep 14, 2009 at 02:36:48PM +0200, Josip Rodin wrote:
>> > > 2) Try a UP kernel build, does it work even with all of the NMI
>> > >    bits enabled on this machine?
>> > 
>> > Will try and report shortly.
>> 
>> It seems to work just fine without SMP.
> 
> Just in case it might matter:

I was able to reproduce the hang with your originally posted config.

It only triggers when CONFIG_PROM_CONSOLE is enabled, I keep telling
people to turn it off.  Nobody should be using it, it either breaks
things or it slows the console down considerably.

That's it, I'm completely removing that driver from the tree this
merge window, so you guys can't mess it up any more even if you want
to :-)

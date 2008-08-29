From: David Miller <davem@davemloft.net>
Date: Fri, 29 Aug 2008 20:26:49 +0000
Subject: Re: [PATCH 0/12]: Convert sparc64 to use generic RTC layer.
Message-Id: <20080829.132649.25643019.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080828.230918.47426996.davem@davemloft.net>
In-Reply-To: <20080828.230918.47426996.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: krzysztof.h1@poczta.fm
Date: 29 Aug 2008 15:17:32 +0200

> > David Miller wrote:
> > > Here are 12 patches that build upon Krzysztof's initial work to
> > > convert all RTC support in the sparc64 port over to the generic
> > > RTC layer.
> > >   
> > Are there any plans to do the same thing for sparc32?
> > 
> > I have plenty of sun4c and sun4m hardware to test it on.
> > 
> > 
> 
> I will try. There seems to be only 2 rtc types handled: idl and
> m48t59/08/02. The former type is already supported by the rtc
> layer. I will prepare patch for it next week.

You can ignore all of the CONFIG_SUN4 protected code, including
the intersil RTC stuff, as I'm adding a patch from Adrian Bunk
that removes everything to do with CONFIG_SUN4.

From: David Miller <davem@davemloft.net>
Date: Thu, 19 Oct 2006 03:35:06 +0000
Subject: Re: sparc32 modpost warnings from init()
Message-Id: <20061018.203506.69218892.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20061015200547.GA4729@palantir8>
In-Reply-To: <20061015200547.GA4729@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Sun, 15 Oct 2006 21:05:47 +0100

> I am left with the warnings below in the sparc build of 2.6.19-rc2. They
> all originate from init() (init/main.c). This function should definitely
> remain in .text and it is fine it calls to .init.text functions.
> 
> The patch below against modpost makes it ignore this function, but I am
> not sure:
> - if this is the correct solution
> - if this code should be sparc-specific
> Any input on how to get rid of these warnings is welcome.

I don't know what to make of this :-)

On the one hand we do indeed need to keep init() in .text because
init memory is released before the init thread exec()'s, but on
the other hand filtering init() specially in modpost is a little
bit hackish.

But if Sam has no problem with this change, I'm not going to
object either.  Sam?

From: David Miller <davem@davemloft.net>
Date: Tue, 22 Jan 2008 01:25:58 +0000
Subject: Re: [PATCH] sparc64: fix section error in sparcspkr
Message-Id: <20080121.172558.172627322.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080121215036.GA1286@uranus.ravnborg.org>
In-Reply-To: <20080121215036.GA1286@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Jan 2008 22:50:36 +0100

> With a sparc64 defconfig modified to set CONFIG_HOTPLUG=n
> the following error happened during link of vmlinux:
> 
> local symbol 0: discarded in section `.devexit.text' from drivers/built-in.o
> local symbol 1: discarded in section `.devexit.text' from drivers/built-in.o
> 
> (The error message above is from kbuild.git but it happens in mainline too)
> 
> The error happens becase there is a reference from .text/.data to
> a function marked __devexit. With CONFIG_HOTPLUG=n all code marked
> __devexit are discarded and the linker complains.
> 
> It was tracked down to sparcspkr.c which were missing __devexit_p()
> around the function pointers.
> 
> Unfortunately modpost did not catch this since modpost do not warn about
> references from .data to .devexit from variables named *_driver.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied, thanks Sam.

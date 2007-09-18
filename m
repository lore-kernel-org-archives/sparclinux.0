From: David Miller <davem@davemloft.net>
Date: Tue, 18 Sep 2007 02:03:20 +0000
Subject: Re: [PATCH] sparc: beautify vmlinux.lds
Message-Id: <20070917.190320.124551826.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070915200224.GB14858@uranus.ravnborg.org>
In-Reply-To: <20070915200224.GB14858@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Sep 2007 22:02:24 +0200

> Make vmlinux.lds almost readable.
> When going through the file fixed the following:
> - Use PAGE_SIZE as replacement for hardcoded 4096
> - Moves label definitions inside {} to avoid ld alignment
>   that may be added between label and section
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> ---
> Build tested only.
> Will do this for all archs over time.
> 
> PS. I expect that Davem will apply this and a similar
> one for sparc64 I already sent.

I've queued up both patches for 2.6.24, thanks Sam.


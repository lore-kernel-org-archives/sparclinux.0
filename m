From: David Miller <davem@davemloft.net>
Date: Sat, 03 Jan 2009 03:21:35 +0000
Subject: Re: [PATCH 08/11] sparc: unify signal.h
Message-Id: <20090102.192135.61994334.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 30 Dec 2008 00:58:07 +0100

> They were almost identical and with the preapration
> patch nothing was needed to be added.
> 
> The unified version contains a few sparc64 only definitions
> but they are kept as is and not protected by ifdef/endif.
> The unified version exports a bit more to userspace then the
> 32 bit version did.
> This is not considered fatal.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Also applied, thanks Sam.

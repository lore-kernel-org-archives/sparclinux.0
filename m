From: David Miller <davem@davemloft.net>
Date: Tue, 17 Jun 2008 23:49:10 +0000
Subject: Re: [PATCH] sparc: correct module name in Kconfig help for
Message-Id: <20080617.164910.137451741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200806171353.49127.elendil@planet.nl>
In-Reply-To: <200806171353.49127.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Tue, 17 Jun 2008 13:53:48 +0200

> The module name was changed from esp to sun_esp some time ago.
>     
> Signed-off-by: Frans Pop <elendil@planet.nl>

Applied, thank Frans.

> ---
> 
> Should the help text maybe also mention that it supports SUNW,fas devices?
> It's still SBUS of course, but it may not be immediately obvious that esp 
> also covers fas.

That might make the help text better, sure.

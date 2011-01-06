From: David Miller <davem@davemloft.net>
Date: Thu, 06 Jan 2011 22:26:51 +0000
Subject: Re: [PATCH 2/4] sunhme: cleanup conditional on CONFIG_SBUS
Message-Id: <20110106.142651.193712710.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1294261427-26104-2-git-send-email-sam@ravnborg.org>
In-Reply-To: <1294261427-26104-2-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed,  5 Jan 2011 22:03:45 +0100

> sparc has always SBUS defined.
> So there is no need to have #ifdef CONFIG_SBUS within
> code that is SPARC only.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

This breaks the build on x86, sbus_can_burst64() is only defined on
sparc currently.

So if you want to make this patch you'll need to add a dummy
implementation somewhere that gets defined on non-sparc.

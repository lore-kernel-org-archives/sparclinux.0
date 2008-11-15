From: David Miller <davem@davemloft.net>
Date: Sat, 15 Nov 2008 21:46:33 +0000
Subject: Re: [PATCH 8/8] sparc,sparc64: unify Kconfig
Message-Id: <20081115.134633.129073818.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1226784875-8829-8-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226784875-8829-8-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 15 Nov 2008 22:34:35 +0100

> Merge all definitions from sparc64 Kconfig in to sparc Kconfig.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Sparc64's CONFIG_SUN_LDOMS et al. got lost by this change.

Not applied.

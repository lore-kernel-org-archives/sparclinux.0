From: David Miller <davem@davemloft.net>
Date: Sat, 25 Sep 2010 21:34:03 +0000
Subject: Re: [2.6.36-rc regression] occasional complete system hangs on
Message-Id: <20100925.143403.226762219.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <19611.34846.813757.309183@pilspetsen.it.uu.se>
	<20100923.120935.173861259.davem@davemloft.net>
	<19614.12985.649827.886053@pilspetsen.it.uu.se>
In-Reply-To: <19614.12985.649827.886053@pilspetsen.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Sat, 25 Sep 2010 19:34:49 +0200

> Update: I got another hang with 2.6.36-rc5, then went back to
> 2.6.36-rc1 which hung twice.  SYSRQ would print help text and
> the name of the command but not print anything useful on the
> console.  Now trying some of the 2.6.35-git snapshots before -rc1.

If you can somehow coerce a SysRQ-y combo to work, that's
the most likely way to get the information necessary to
debug this.

From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 07 Dec 2005 20:34:58 +0000
Subject: Re: Sparc: Kernel 2.6.13 to 2.6.15-rc2 bug when running X11
Message-Id: <20051207.123458.26771065.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0512061658190.14952@lai.local.lan>
	<20051206.152316.82233251.davem@davemloft.net>
	<Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.64.0512071203460.8861@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: trizt@iname.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: "J.O. Aho" <trizt@iname.com>
Date: Wed, 7 Dec 2005 12:05:43 +0100 (CET)

> When running in plain console (without trying to run X) everything works 
> fine (just telling that so I won't get people to ask if ps segfaults in 
> other cases or claims that my init is broke and so on).

Is the Xorg.conf setup to use the "ati" driver?  You can't use
"fbdev" or similar, that will in fact hang the machine in a
manner similar to how you describe.

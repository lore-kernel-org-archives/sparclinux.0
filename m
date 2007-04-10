From: David Miller <davem@davemloft.net>
Date: Tue, 10 Apr 2007 21:04:58 +0000
Subject: Re: [Repost] Ultra2 SMP freezes with heavy disk I/O
Message-Id: <20070410.140458.26533670.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070320180102.GA27466@rayleigh.systella.fr>
In-Reply-To: <20070320180102.GA27466@rayleigh.systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 20 Mar 2007 21:53:26 +0100

> 	I have tried the last 2.6.21-rc4. Same bug.

The good news is that I can reproduce this problem now on my
Ultra2, I'll try to figure out what's wrong.

Running "dbench 32" a few time is enough to trigger it.

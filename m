From: David Miller <davem@davemloft.net>
Date: Thu, 12 Jul 2007 09:46:22 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070712.024622.39158581.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Thu, 12 Jul 2007 11:11:32 +0200

> 	I'm lucky ;-) First mail in clamd and clamd sleeps... You can find in=20
> attachement complete strace log (strace -ff ...).

It is looping at the end servicing SIGINT over and over, are
you pressing Ctrl-C at the terminal where clamav is running
or sending it signals with "kill"?


From: David Miller <davem@davemloft.net>
Date: Tue, 10 Jul 2007 17:49:13 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070710.104913.41635731.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 10 Jul 2007 09:53:12 +0200

> 	When clamav-daemon (or all other daemons) remain in sleep mode, I=20
> cannot quickly restart this daemon by /etc/init.d/$(daemon) restart, I=20
> have to wait for a timeout.

Use the kernel sysrq keystrokes to get a task dump to see where
clamav-daemon is sleeping, my suspicion is that it is stuck
in the kernel futex code somewhere.

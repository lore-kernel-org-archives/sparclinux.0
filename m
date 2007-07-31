From: David Miller <davem@davemloft.net>
Date: Tue, 31 Jul 2007 09:54:31 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070731.025431.18308575.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Tue, 31 Jul 2007 11:52:59 +0200

> 	I cannot reboot this workstation now. Is it possible to only
> stop netfilter ?

It would be an interesting test to just stop netfilter, but not
conclusive because if netfilter has corrupted something already only a
reboot would ensure it did not occur.

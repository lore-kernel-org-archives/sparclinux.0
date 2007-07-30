From: David Miller <davem@davemloft.net>
Date: Mon, 30 Jul 2007 08:17:01 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070730.011701.71091893.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Mon, 30 Jul 2007 09:48:30 +0200

> I know. How can I help you ? This bug is very problematic. I can
> patch kernel of my U60 to debug futex if that can help you.

I really need to confirm that the 450Mhz cpus are the type
that uniquely trigger this problem.

We need to find someone who can test alternate cpu types to
see if that makes the bug go away.

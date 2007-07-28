From: David Miller <davem@davemloft.net>
Date: Sat, 28 Jul 2007 08:07:01 +0000
Subject: Re: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and
Message-Id: <20070728.010701.59470059.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46933AE8.1080509@systella.fr>
In-Reply-To: <46933AE8.1080509@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND_Jo=EBl <joel.bertrand@systella.fr>
Date: Sat, 28 Jul 2007 09:59:44 +0200

> 	I have tested your patch for two days. Now, I can affirm that
> it does not fix futex trouble. I have seen exactly same bug report
> on sparc-debian mailing list.

Thanks for your continual feedback.

I want to reproduce this here, that will get this fixed most
quickly.

What version of debian do you have installed on the machine that shows
this, and what exact kind of system and cpu configuration does it
have?

I think I can reproduce this most easily using firefox, or whatever
they have renamed it to under debian, do you just startup the web
browser and it hangs soon?

Under debian gutsy I ran the same test, saw the same futex calls under
strace, and it worked fine even after hours of browsing many sites.

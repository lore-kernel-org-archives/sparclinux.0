From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 06:20:37 +0000
Subject: Re: Fix for sparc64 irq.c compile error
Message-Id: <did15f2mm0@ds9.argh.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20051009.202412.110750797.davem@davemloft.net>
In-Reply-To: <20051009.202412.110750797.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Um 20:24 Uhr am 09.10.05 schrieb David S. Miller:

>> init(495): Oops [#1]
>> TSTATE: 0000000011009600 TPC: 0000000000534ce4 TNPC: 0000000000534ce8 Y:=
 00000000    Not tainted
>> TPC: <tty_wakeup+0x4/0x80>
=20
> Known problem with serial console, I mean to get to fixing it
> at some point.

The Debian variant of 2.6.12 works fine and does shutdown correct. I have=20
yet to check, if they include any patch to solve this issue or if only=20
2.6.13 and higher are affected.

Gr=FC=DFe,
Sven.

--=20
Sven Hartge -- professioneller Unix-Geek
Meine Gedanken im Netz: http://sven.formvision.de/blog/

From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 20:26:17 +0000
Subject: Re: Oops while shutdown on serial console
Message-Id: <dieihm2mm0@ds9.argh.org>
List-Id: <sparclinux.vger.kernel.org>
References: <diech22mm0@ds9.argh.org>
In-Reply-To: <diech22mm0@ds9.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Um 13:11 Uhr am 10.10.05 schrieb David S. Miller:

>> The same question applies to the bug I sent the patch earlier,=20
> Specific to sparc64 systems using iptables and having discontiguous
> physical cpu numbers.

Huh? I think you mixed this one up. I meant the one-line fix which=20
included asm/io.h into irq.c for readb()/writeb().=20
=20
>> I am asking, because I have some E150 and E250, which I would like to=20
>> convert from SunOS 2.6 to Linux, but I am dependant on proper serial=20
>> console support.
=20
> I'll try to fix the serial problem this week.

Thank you. Without proper serial console support I'd have a hard time=20
defending myself against those NetBSD guys in my department ;)

Gr=FC=DFe,
Sven.

--=20
Sven Hartge -- professioneller Unix-Geek
Meine Gedanken im Netz: http://sven.formvision.de/blog/

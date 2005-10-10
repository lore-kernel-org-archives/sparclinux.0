From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 20:48:00 +0000
Subject: Re: Oops while shutdown on serial console
Message-Id: <diejro2mm0@ds9.argh.org>
List-Id: <sparclinux.vger.kernel.org>
References: <diech22mm0@ds9.argh.org>
In-Reply-To: <diech22mm0@ds9.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Um 13:38 Uhr am 10.10.05 schrieb David S. Miller:
> Sven Hartge wrote:
>> Um 13:11 Uhr am 10.10.05 schrieb David S. Miller:

>>>> The same question applies to the bug I sent the patch earlier,=20
>>> Specific to sparc64 systems using iptables and having discontiguous
>>> physical cpu numbers.

>> Huh? I think you mixed this one up. I meant the one-line fix which=20
>> included asm/io.h into irq.c for readb()/writeb().=20

> Most configurations usually get the asm/io.h file indirectly
> by other includes, which is probably why others have not hit
> it before.

Most systems today are ones with PCI, so they all pull in pci_impl.h,=20
which includes asm/io.h. As I am using a SBUS-Sparc, I hit the bug. Like I =

wrote, just me and my bizarre old computers again ;)

Thanks again for your quick answer.

Gr=FC=DFe,
Sven.

--=20
Sven Hartge -- professioneller Unix-Geek
Meine Gedanken im Netz: http://sven.formvision.de/blog/

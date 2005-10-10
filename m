From: Sven Hartge <hartge@ds9.argh.org>
Date: Mon, 10 Oct 2005 18:44:42 +0000
Subject: Re: Oops while shutdown on serial console
Message-Id: <diech22mm0@ds9.argh.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Um 11:11 Uhr am 10.10.05 schrieb David S. Miller:

>> The Debian variant of 2.6.12 works fine and does shutdown correct. I hav=
e=20
>> yet to check, if they include any patch to solve this issue or if only=20
>> 2.6.13 and higher are affected.
=20
> I believe they have a hack workaround that checks for a NULL tty in the=20
> wakeup routine, it's the wrong fix.

Is this Oops specific to all sparc64 systems or does it just happen on=20
sbus ones? The same question applies to the bug I sent the patch earlier,=20
because I wonder why nobody has noticed before and 2.6.13 even got=20
released while uncompilable on sparc64.

I am asking, because I have some E150 and E250, which I would like to=20
convert from SunOS 2.6 to Linux, but I am dependant on proper serial=20
console support.

Maybe I am just (again) the "lucky" guy, who ownes some obscure systems=20
which trigger strange bugs. (Wouldn't be the first time for me, as I also=20
own a PowerstackII, which was broken from 2.5.30 to 2.6.10 and nearly=20
nobody was able to reproduce my problems.)

Gr=FC=DFe,
Sven

--=20
Sven Hartge -- professioneller Unix-Geek
Meine Gedanken im Netz: http://sven.formvision.de/blog/

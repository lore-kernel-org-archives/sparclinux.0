From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Thu, 24 May 2007 07:12:23 +0000
Subject: Which compiler for 2.6 sparc32 kernel?
Message-Id: <46553ad77742c@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

I tried to build the latest kernel 2.6.22-rc2 and it did not
compile correctly with my self build compiler (from Slackaware
10) and stock compiler from Aurora 2.0 (3.4.x). I tried to boot
it on the SS20 with two Supersparcs II. It was the UP (not SMP)
version.

The problem is that it miscompile va_arg(args, long long) in the
vsnprintf() function (I learned it hard way). The kernel simply
hangs at boot with "Booting linux" the message.
If the va_arg(args, long long) is replaced with two va_arg(args,
long) the problem goes away.

The problem appeared since the kernel 2.6.21. The kernel 2.6.20
works without any change and it was compiled with the same compiler.

Have any of you compiled and booted the sparc32 kernel since
2.6.21? Which compiler have you used?

Kind regards,
Krzysztof

----------------------------------------------------
"Ma=B3a Ikar" Helen Oyeyemi - poetycka i mroczna opowie=B6=E6 o bolesnej
samotno=B6ci dziecka dorastaj=B1cego mi=EAdzy kulturami.
http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fksiazki.wp.pl%2Fkatalog%2Fksiazki%2Fk=
siazka.html%3Fkw%3D4379&sid=1160



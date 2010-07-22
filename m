From: Rene Rebe <rene@exactcode.de>
Date: Thu, 22 Jul 2010 10:17:22 +0000
Subject: compiling silo with any gcc newer than 4.3 (4.4, 4.5)
Message-Id: <5C484984-6370-4804-8617-18C83CF16296@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi David,

I got some problem compiling silo with gcc 4.4 or 4.5. This binary diff cre=
ation fails due to too big chunks:

./util second.map second.aout second2.aout second.b second.b2
Distance between two changes larger than 63K 3 116953 43805

Anything else and the kernel do build just fine, silo appears to be my last=
 problem getting a new T2 ISO out, ...

Do you get the same error, or just use very much older gcc versions? Then a=
gain you may not compile silo to often at all, ...

Any idea or feedback appreciated.

Ren=E9

--=20
  Ren=E9 Rebe, ExactCODE GmbH, Jaegerstr. 67, DE-10117 Berlin
  http://exactcode.com | http://t2-project.org | http://rene.rebe.de


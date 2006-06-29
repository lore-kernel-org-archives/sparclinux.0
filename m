From: Rene Rebe <rene@exactcode.de>
Date: Thu, 29 Jun 2006 07:37:49 +0000
Subject: booting the T1000
Message-Id: <200606290937.49481.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,

I gave the current Ubuntu boot image a try on a T1000. The file I got has t=
his
md5sum:

49f61b1efbc662b4f12061a9571ac65b  boot.img

I used the existing arpd and hpa-tftpd setup to network boot that new box, =
but
the box does not appear to like loading the kerne image.

In a blog of someone working on the Ubuntu suport I found a note
about "problems with hpa-tftpd", so I tried iputils/tftpd and atftpd without
success. Note  that an Ultra30 booted the same image served from the
same daemons just fine.

This is what atftp logged:

Jun 29 09:21:22 g5 atftpd[7209]: Serving C0A80271 to 192.168.2.113:32768
Jun 29 09:21:27 g5 atftpd[7209]: timeout: retrying...
Jun 29 09:21:47 g5 last message repeated 4 times
Jun 29 09:21:52 g5 atftpd[7209]: client (192.168.2.113) not responding

Maybe someone can enlighten me which tftp server is compaible with
the Niagara boxes?

Thanks in advance,

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45

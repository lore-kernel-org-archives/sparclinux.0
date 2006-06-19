From: Rene Rebe <rene@exactcode.de>
Date: Mon, 19 Jun 2006 14:21:19 +0000
Subject: [ANNOUNCE] T2 sparc64 2.2.0-rc "Get the power back!" is now available
Message-Id: <200606191621.20089.rene@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,

we are proud to announce the availability of T2 2.2.0-rc "Get the power
back!" for sparc64, that is Sun Ultra SPARC systems.

Sparc64 suppost has come a long way back from the root in ROCK Linux
where I already started to do all the work, puzzling the pieces together but
this is the first fully installable CD ever built for sparc64 from that cod=
ebase.

Specifically dietlibc, used for the T2 early user-space, had to be fixed
significantly - which took about the whole last weekend.

Also special thanks go to David S. Miller for his ongoing hard work on the
low-level code chunks!

This release includes quite some fixes specifically for sparc64 since
the 2.2.0-rc release was tagged, specifically a 2.6.17-rc Kernel was used
that should suppost latest Niagara based T1000 and T2000 systems and
fixes D-cache corruption on quite some systems, latest SILO loader with
last night CDROM boot fix and X11R7 for the X windowing systems as well
as GCC 4.1.1 and GLIBC CVS from just some days ago.=20

As usual for sparc64 the user-space is built defaulting to 32bit for enhanc=
ed
performace, however a full multilib environment is available.

It is a minimal-xorg build of T2 fitting in just 300MB but misses the usual
KDE and GNOME gimicks - however they can be installed from source using
our usual ports-a-like collection (I simply lack the computing power to bui=
ld
all the packages on the 270MHz machines I currently have).

Tested on Sun Ultra 5 and Ultra30, the later with the usual Creator 3D.

About T2:
  http://www.t2-project.org

Sparc64 ISO:
  http://gsmp.tfh-berlin.de/mirror/t2/stable/2.2.0-rc/minimal-sparc64-v9vis/

Yours still celebrating,

--=20
Ren=E9 Rebe - Rubensstr. 64 - 12157 Berlin (Europe / Germany)
            http://exactcode.de | http://t2-project.org | http://rebe.name
            +49 (0)30 / 255 897 45

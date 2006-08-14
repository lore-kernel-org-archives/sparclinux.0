From: Rene Rebe <rene@exactcode.de>
Date: Mon, 14 Aug 2006 13:34:16 +0000
Subject: sunffb dri/drm
Message-Id: <44E097B9.8080301@exactcode.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi all,

in former times {Creator,Elite} 3D used to have a hardware accelerated=20
3D implementation (DRM,DRI) however the DRM part in the linux kernel=20
suffered bitrot is not beeing built since ages.

I wonder if it is worth fixing it, given that it only accelerates lines=20
and the like and no texturing. It is likely of much use in modern 3D=20
applications.

Comments anyone?

--=20
   Ren=E9 Rebe - ExactCODE - Berlin (Europe / Germany)
   http://exactcode.de | http://t2-project.org | http://rene.rebe.name
   +49 (0)30 / 255 897 45

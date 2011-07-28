From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 28 Jul 2011 10:40:17 +0000
Subject: Re: sparc: rename atomic_add_unless
Message-Id: <20110728104017.GA27861@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

This patch[0] seems to fix a build issue, but it doesn't fix the
functionality - the previous change[1] changed the return value semantics,
it's now supposed to be to be just the old value, rather than a comparison.

[0] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;hg8624e401b0b7747762b5223fb23f86dcdacc93
[1] http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3D=
commitdiff;h=F24219b4e90cf70ec4a211b17fbabc725a0ddf3c

--=20
     2. That which causes joy or happiness.

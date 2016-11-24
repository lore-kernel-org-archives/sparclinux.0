From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Thu, 24 Nov 2016 22:35:29 +0000
Subject: Re: [PATCH] silo: Add 64-bit support
Message-Id: <9e7977d2-44cd-09b6-1022-d1d33bb66585@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
In-Reply-To: <20161124173330.3087-1-glaubitz@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 11/24/2016 11:32 PM, James Clarke wrote:
> Part of the problem is not forcing 64-bit, but that the Makefile is incon=
sistent.
> The default CC is gcc without any flags, but ld is given -m elf64_sparc. =
If you
> are running with sparc32 as your default target, gcc will generate 32-bit=
 files
> but ld expects 64-bit. If you really want to force 64-bit, you should als=
o pass
> appropriate -m64/-64 flags to gcc/as. However, I think the sensible, least
> controversial solution is to just drop the -m elf64_sparc and let everyth=
ing
> be the default. It was only changed to force 32-bit in c836dbda because 6=
4-bit
> support wasn=E2=80=99t present.

Thank you! This is actually very constructive criticism which actually helps
improving the patch.  I'll look into improving the Makefile.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

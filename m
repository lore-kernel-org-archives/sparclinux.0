From: Frans Pop <aragorn@tiscali.nl>
Date: Wed, 16 Feb 2005 02:27:51 +0000
Subject: Re: [atyfb] No display on Sparc Ultra 10 with kernel 2.6.10-rc2 or later
Message-Id: <200502160328.00148.aragorn@tiscali.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart2352160.gDsNIb2Vma"
List-Id: <sparclinux.vger.kernel.org>
References: <200502140251.00645.aragorn@tiscali.nl> <200502152010.22880.adaplas@hotpop.com> <20050215084958.1f68b39b.davem@davemloft.net>
In-Reply-To: <20050215084958.1f68b39b.davem@davemloft.net>
To: "David S. Miller" <davem@davemloft.net>, adaplas@pol.net
Cc: debian-sparc@lists.debian.org, sparclinux@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

--nextPart2352160.gDsNIb2Vma
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 15 February 2005 17:49, David S. Miller wrote:
> On sparc, when "mode" is NULL, we should always use default_var as
> setup by PROM probed values.
>
> Here is the fix:

Excellent!
Tested the patch with 2.6.11-rc3-bk2 and AFAICT it completely restores the=
=20
old behavior. I guess that solves the regression since 2.6.10-rc2.

Please let me know if this patch will be submitted for inclusion as is so=20
I can also submit it for inclusion in the Debian 2.6.10 kernel.


=46rom my experiences in tracing and testing this, I have a couple of=20
questions I'd like to put before you and the lists. (I should add that my=20
experience with sparcs is still very limited.)

I would like to set a lower default resolution as my monitor barely=20
supports 1152x900@66. I tried two things:
=2D # eeprom output-device=3Dscreen:r1024x768x70
  This seems to be completely ignored during boot; resolution is still
  1152x900.

=2D boot with parameter 'video=3Datyfb:1024x768@70'
  This does work, but csync is not set to high and so the monitor again
  goes into suspend; after 'fbset -csync high' the monitor turns on.
  Is csync something that needs to be set by the user or should the driver
  take care of that also at frequencies other then 1152x900?


The second question concerns the use of Stop-A.
With the console at 1152x900@66, if I press Stop-A, I get the openprom=20
prompt. The screen has the last display before pressing Stop-A with a=20
white square inside it containing the openprom display (filling about 75%=20
of the screen).
If I do the same at 1024x768@70, I get a garbled display (no readable text=
=20
from the openprom). I can still press go to return to linux though and=20
the display is restored after clearing it.

Can/should this be fixed or should the conclusion be that resolutions=20
other than 1152x900@66 are just not supported?

Cheers,
=46rans Pop

--nextPart2352160.gDsNIb2Vma
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCEq+wgm/Kwh6ICoQRAlhhAJ4xx6wi3T6lyxfvno66gqaKWOteeACgykPe
b2YUXgsP8BbFS2NlPahxveA=
=qOEG
-----END PGP SIGNATURE-----

--nextPart2352160.gDsNIb2Vma--

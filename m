From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Feb 2016 08:51:29 +0000
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc code,Re: [PATCH 0/3] video/fbde
Message-Id: <56D40691.6030002@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tm63m6t9h9xjDofsvDsVwOcL8ccTrhKDG"
List-Id: <sparclinux.vger.kernel.org>
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <56D02FB8.90803@ti.com>
 <20160226.122112.1169840448330570848.davem@davemloft.net>
In-Reply-To: <20160226.122112.1169840448330570848.davem@davemloft.net>
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, sparclinux@vger.kernel.org

--tm63m6t9h9xjDofsvDsVwOcL8ccTrhKDG
Content-Type: multipart/mixed; boundary="6ukDhQ3aGS2soHdhnwofaxEC03hE59ima"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: David Miller <davem@davemloft.net>
Cc: paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org,
 plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org,
 sparclinux@vger.kernel.org
Message-ID: <56D40691.6030002@ti.com>
Subject: Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc
 code,Re: [PATCH 0/3] video/fbdev: avoid module usage in non-modular sparc
 code
References: <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <1456110792-21771-1-git-send-email-paul.gortmaker@windriver.com>
 <56D02FB8.90803@ti.com>
 <20160226.122112.1169840448330570848.davem@davemloft.net>
In-Reply-To: <20160226.122112.1169840448330570848.davem@davemloft.net>

--6ukDhQ3aGS2soHdhnwofaxEC03hE59ima
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 26/02/16 19:21, David Miller wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Date: Fri, 26 Feb 2016 12:58:00 +0200
>=20
>> While doing this, did you just go forward removing the module support,=

>> or did you check if it would be trivial to make the driver build as a
>> module? I wouldn't be surprised if in some cases all that would need t=
o
>> be done is change the Kconfig's bool to tristate.
>=20
> I think what he is doing is reasonable, and none of these sparc drivers=

> have any reason to be built modular.  You need them to have any bootup
> console whatsoever, so they have to be built in statically to be
> usable at all.

I disagree. Having drivers buildable as modules is always good, even if
the normal use case would be to have them as built-in.

> I plan to apply this patch series to my sparc tree as-is.

They are fbdev patches without any dependency to sparc afaics. So let's
apply them via fbdev tree.

 Tomi


--6ukDhQ3aGS2soHdhnwofaxEC03hE59ima--

--tm63m6t9h9xjDofsvDsVwOcL8ccTrhKDG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1AaRAAoJEPo9qoy8lh71UygP/jf4TLfp63mxTsCDIeD11pX5
26XL0PikiNhS+I30fO5El8C3fPRIdrCGkTk/z9foT5LIneRjYl4catVZOhd0vTlw
RiaLUuXSs57bQH4U0fJA9Ch3umtgbzs0x/290lppGfzFgmjZsqOc2WkEF3PgtftL
RWDDCJbRNFKtP4DxX8eVBg7jnAJsxHwGyvuM7O0NkNUlqBrkcO3x/9AiAYC2cbQ3
/9F6LPMj0ZBRBlZiNzdKym6OQUWo0H57j3v05X2rNRKhWekZZ1bEqpuh5mewPogg
068FVExXtIKW/VwGc4Zj1Zv73j7gnypleDajSHNETiwwU7afMc+Wi1p/7PLjfR/i
CcfeaQrwTicDC/BAS+1GFVr7oaBovtgFxgdHpWONhSdOnqWtF8rWz+mDksx1IiLS
yh+U2ctVeH0CZNWRW1nB9ahFCWIuRBfPf+H9l6tn5ETs//I0IcxBKrLvcnV+Tyeu
uS4bhL/+eFojMCiJS/Ty5on5CviBszRpk3CJYWhn/Szmt2mhkX8lzMnWCKbWBic9
OtNjg+0CVF1+peDNiSpF/6ufWkOMgzhB7gGmlwyLcKUAE9UKhAYIrF59nVycZ+Dz
CqIdvOQEYATe9OTffNGDfB/OW2hE+yVkYC/VDOOdys2l2aSsPEqNcCGxNcij5lJa
JSu14Mh35jFnB8xvrAut
=IYBC
-----END PGP SIGNATURE-----

--tm63m6t9h9xjDofsvDsVwOcL8ccTrhKDG--

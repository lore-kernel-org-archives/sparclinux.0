From: Michal Simek <monstr@monstr.eu>
Date: Mon, 25 Sep 2017 13:37:00 +0000
Subject: Re: [PATCH 2/2] arch: change default endian for microblaze
Message-Id: <192895e1-00d6-bc68-160b-7cbab3192737@monstr.eu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="GJMajlcGALAWllo9lVqPIWxpOlAjl261v"
List-Id: <sparclinux.vger.kernel.org>
References: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
 <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
 <cf4bd066-b349-070a-ddf9-d6ae02f44cd7@monstr.eu>
 <e755625e-0b3a-4027-0754-4873fc8446b1@oracle.com>
In-Reply-To: <e755625e-0b3a-4027-0754-4873fc8446b1@oracle.com>
To: Babu Moger <babu.moger@oracle.com>, jejb@parisc-linux.org, deller@gmx.de, davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GJMajlcGALAWllo9lVqPIWxpOlAjl261v
Content-Type: multipart/mixed; boundary="NEs71qLvUmTUlacMA9tBHJ5w1REDB6DTl";
 protected-headers="v1"
From: Michal Simek <monstr@monstr.eu>
Reply-To: monstr@monstr.eu
To: Babu Moger <babu.moger@oracle.com>, jejb@parisc-linux.org, deller@gmx.de,
 davem@davemloft.net, akpm@linux-foundation.org
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-parisc@vger.kernel.org
Message-ID: <192895e1-00d6-bc68-160b-7cbab3192737@monstr.eu>
Subject: Re: [PATCH 2/2] arch: change default endian for microblaze
References: <1505753609-602923-1-git-send-email-babu.moger@oracle.com>
 <1505753609-602923-3-git-send-email-babu.moger@oracle.com>
 <cf4bd066-b349-070a-ddf9-d6ae02f44cd7@monstr.eu>
 <e755625e-0b3a-4027-0754-4873fc8446b1@oracle.com>
In-Reply-To: <e755625e-0b3a-4027-0754-4873fc8446b1@oracle.com>

--NEs71qLvUmTUlacMA9tBHJ5w1REDB6DTl
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.9.2017 20:05, Babu Moger wrote:
>=20
> On 9/18/2017 12:49 PM, Michal Simek wrote:
>> On 18.9.2017 18:53, Babu Moger wrote:
>>> Fix the default for microblaze. Michal Simek mentioned default for
>>> microblaze should be CPU_LITTLE_ENDIAN.
>>>
>>> Fixes : commit 206d3642d8ee ("arch/microblaze: add choice for endiann=
ess
>>> =C2=A0=C2=A0=C2=A0=C2=A0and update Makefile")
>>>
>>> Signed-off-by: Babu Moger <babu.moger@oracle.com>
>>> Cc: Michal Simek <monstr@monstr.eu>
>>> ---
>>> =C2=A0 arch/microblaze/Kconfig |=C2=A0=C2=A0=C2=A0 2 +-
>>> =C2=A0 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
>>> index 9d26abd..4f798aa 100644
>>> --- a/arch/microblaze/Kconfig
>>> +++ b/arch/microblaze/Kconfig
>>> @@ -39,7 +39,7 @@ config MICROBLAZE
>>> =C2=A0 # Endianness selection
>>> =C2=A0 choice
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 prompt "Endianness selection"
>>> -=C2=A0=C2=A0=C2=A0 default CPU_BIG_ENDIAN
>>> +=C2=A0=C2=A0=C2=A0 default CPU_LITTLE_ENDIAN
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 help
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 microblaze architectures c=
an be configured for either little or
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 big endian formats. Be sur=
e to select the appropriate mode.
>>>
>> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Thanks.
>> If you want me to take this through my microblaze tree please let me
>> know.
> Sure. Thanks

I can't see this in linux-next yet that's why pplied this one to mb/next
to be the part of my pull request.

Thanks,
Michal

--=20
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP SoCs



--NEs71qLvUmTUlacMA9tBHJ5w1REDB6DTl--

--GJMajlcGALAWllo9lVqPIWxpOlAjl261v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlnJBnwACgkQykllyylKDCGc5QCfWmwikKfj6nKpGvLIb+FnJ9t1
Yj4AnjjESocs5JE0MmhMIwwcNYUEBcN1
=MxEH
-----END PGP SIGNATURE-----

--GJMajlcGALAWllo9lVqPIWxpOlAjl261v--

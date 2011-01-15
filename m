From: =?ISO-8859-1?Q?Ra=FAl_Porcel?= <armin76@gentoo.org>
Date: Sat, 15 Jan 2011 12:07:46 +0000
Subject: Re: silo fails to build with e2fsprogs-1.41.14 (undefined references
Message-Id: <4D318E12.5000406@gentoo.org>
List-Id: <sparclinux.vger.kernel.org>
References: <4D2B59AC.8040203@gentoo.org>
In-Reply-To: <4D2B59AC.8040203@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On 01/10/2011 08:29 PM, David Miller wrote:
> From: Ra=FAl Porcel <armin76@gentoo.org>
> Date: Mon, 10 Jan 2011 20:10:36 +0100
>=20
>> Hi,
>>
>> SILO fails to build here with e2fsprogs-1.41.14 installed, i'm attaching
>> the build log.
>=20
> I really appreciate how they make libext2 harder and harder to link into
> embedded self-contained things like bootloaders over time.
>=20
> I just pushed the following fix for this:
> <snip>


Hi,

Thanks, it builds, but silo fails to work:

Boot device: disk1  File and args:
SILO Version 1.4.14_git2010228_p1

Unknown ext2 error: 4294967295

Fatal error: Unable to open filesystem

Couldn't load /etc/silo.conf
No config file loaded, you can boot just from this command line
Type [prompath;]part/path_to_image [parameters] on the prompt
E.g. /iommu/sbus/espdma/esp/sd@3,0;4/vmlinux root=3D/dev/sda4
or 2/vmlinux.live (to load vmlinux.live from 2nd partition of boot disk)
boot:



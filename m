From: "Dmitry V. Levin" <ldv@altlinux.org>
Date: Wed, 17 Jul 2019 23:30:31 +0000
Subject: Re: [PATCH 09/16] sparc64: use the generic get_user_pages_fast code
Message-Id: <20190717233031.GB30369@altlinux.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="eJnRUKwClWJh1Khz"
List-Id: <sparclinux.vger.kernel.org>
References: <20190625143715.1689-1-hch@lst.de>
 <20190625143715.1689-10-hch@lst.de>
 <20190717215956.GA30369@altlinux.org>
 <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
In-Reply-To: <CAHk-=whj_+tYSRcDsw7mDGrkmyU9tAk-a53XK271wYtDqYRzig@mail.gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christoph Hellwig <hch@lst.de>, Khalid Aziz <khalid.aziz@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Anatoly Pugachev <matorola@gmail.com>, sparclinux@vger.kernel.org, Linux-MM <linux-mm@kvack.org>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 03:04:56PM -0700, Linus Torvalds wrote:
> On Wed, Jul 17, 2019 at 2:59 PM Dmitry V. Levin <ldv@altlinux.org> wrote:
> >
> > So this ended up as commit 7b9afb86b6328f10dc2cad9223d7def12d60e505
> > (thanks to Anatoly for bisecting) and introduced a regression:
> > futex.test from the strace test suite now causes an Oops on sparc64
> > in futex syscall.
>=20
> Can you post the oops here in the same thread too? Maybe it's already
> posted somewhere else, but I can't seem to find anything likely on
> lkml at least..

Sure, here it is:

[  514.137217] Unable to handle kernel paging request at virtual address 00=
060000541d0000
[  514.137295] tsk->{mm,active_mm}->context =3D 00000000000005b2
[  514.137343] tsk->{mm,active_mm}->pgd =3D fff80024955a2000
[  514.137387]               \|/ ____ \|/
                             "@'/ .. \`@"
                             /_| \__/ |_\
                                \__U_/
[  514.137493] futex(1599): Oops [#1]
[  514.137533] CPU: 26 PID: 1599 Comm: futex Not tainted 5.2.0-05721-gd3649=
f68b433 #1096
[  514.137595] TSTATE: 0000000011001603 TPC: 000000000051adc4 TNPC: 0000000=
00051adc8 Y: 00000000    Not tainted
[  514.137678] TPC: <get_futex_key+0xe4/0x6a0>
[  514.137712] g0: 0000000000000000 g1: 0000000000e75178 g2: 000000000009a2=
1d g3: 0000000000000000
[  514.137769] g4: fff8002474fbc0e0 g5: fff80024aa80c000 g6: fff8002495aec0=
00 g7: 0000000000000200
[  514.137825] o0: 0000000000000001 o1: 0000000000000001 o2: 00000000000000=
00 o3: fff8002495aefa28
[  514.137882] o4: fff8000100030000 o5: fff800010002e000 sp: fff8002495aef1=
61 ret_pc: 000000000051ada4
[  514.137944] RPC: <get_futex_key+0xc4/0x6a0>
[  514.137978] l0: 000000000051b144 l1: 0000000000000001 l2: 0000000000c019=
50 l3: fff80024626051c0
[  514.138036] l4: 0000000000c01970 l5: 0000000000cf6800 l6: 00060000541d13=
f0 l7: 00000000014b3000
[  514.138094] i0: 0000000000000001 i1: 000000000051af30 i2: fff8002495aefc=
28 i3: 0000000000000001
[  514.138152] i4: 0000000000cf69b0 i5: fff800010002e000 i6: fff8002495aef2=
31 i7: 000000000051b3a8
[  514.138211] I7: <futex_wait_setup+0x28/0x120>
[  514.138245] Call Trace:
[  514.138271]  [000000000051b3a8] futex_wait_setup+0x28/0x120
[  514.138313]  [000000000051b550] futex_wait+0xb0/0x200
[  514.138352]  [000000000051d734] do_futex+0xd4/0xc00
[  514.138390]  [000000000051e384] sys_futex+0x124/0x140
[  514.138435]  [0000000000406294] linux_sparc_syscall+0x34/0x44
[  514.138478] Disabling lock debugging due to kernel taint
[  514.138501] Caller[000000000051b3a8]: futex_wait_setup+0x28/0x120
[  514.138524] Caller[000000000051b550]: futex_wait+0xb0/0x200
[  514.138547] Caller[000000000051d734]: do_futex+0xd4/0xc00
[  514.138568] Caller[000000000051e384]: sys_futex+0x124/0x140
[  514.138590] Caller[0000000000406294]: linux_sparc_syscall+0x34/0x44
[  514.138614] Caller[0000010000000e90]: 0x10000000e90
[  514.138633] Instruction DUMP:
[  514.138635]  0640016e=20
[  514.138650]  b13da000=20
[  514.138663]  ec5fa7f7=20
[  514.138676] <c25da008>
[  514.138689]  ae100016=20
[  514.138702]  84086001=20
[  514.138714]  82007fff=20
[  514.138727]  af789401=20
[  514.138740]  f05de018=20


--=20
ldv

--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJdL6+XAAoJEAVFT+BVnCUItv0P/RQl7zn0jCq+B4G33r61CH0f
MM3lOaEkCdZV3KhE/13PJWKFSRP2b6rh0k95kDhUNnPdItg3b4xEwHuMwHKzyzCs
RdDrQ5ISjKrSwGJqrAywjpEX5Wf7JnUS98muIIWgcrfA3M3HzQMgKmVIna3SstVD
ZTXmMFjnnuGSKI5xA79VBve9xPbDDkF0cPTrRIkXwk3HzTrQi9NKwj+VyFnzvri/
vXBb8oQ5OJymQryUnoeVxs2MmraXPotL+M/8krsZIoAuaK4IMFiFh5T7ZBVigqFv
934gPFbRyRdErsuiJo6PMqJUay39etJBifC4sem9zw6NcP+sSMB5L8EABFkWT0j+
VuW3foMsOIoH/+8dbYsdTsw4RHpXv6WeUwrNLXZLCWACt2M/m5wBlrBFf0NMbRW4
LtWcIzy4IYfmmUiKrVfAUNv3Yx991ah+QTeq871+Wsy2irvJuE7c4lfH6RxCOjKT
CrtF6oqFcOFHZRfl4JSzc2dbd/tepmNwonQeO6WXwruxRoMI2NhL350ijQJjkXOP
qhz/qutyUOk662ZP30+j0G1iT4TGERug8SLaI11eEjTpqIMUQMtPa0ATsoIkR/+x
S1637lihAJh2d2ik4os1nLjDNakmc6TMgS0KcDXhfo219fWAD5YrgmQD8g7fUnLp
4bgJDOaNpCu6rzRT4WY4
=3YbY
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--

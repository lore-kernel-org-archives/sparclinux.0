From: Erik Kooistra <me@erikkooistra.nl>
Date: Sun, 02 Mar 2014 14:48:09 +0000
Subject: Ptrace implementation
Message-Id: <D37E7164-2F27-4758-AF5A-72173FA4C969@erikkooistra.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Apple-Mail=_B6A0FC7B-EA46-4805-AC49-FE506E70A0E6"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--Apple-Mail=_B6A0FC7B-EA46-4805-AC49-FE506E70A0E6
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hello,

I am porting http://hetgrotebos.org/wiki/Tracy to sparc on linux. But i =
encounters some issues, If i read the sys call docs correctly the sycall =
number is stored in, G1, but from my tests it seems it is stored in G0.

Second, the syscall_restore function is not implemented, see =
http://lxr.free-electrons.com/source/arch/sparc/include/asm/syscall.h =
powerpc and x86/amd64 use a orig_ register. Maybe this is also a =
desirable solution for sparc ??

finally, i can't seem to find the result of the sys call in the =
registers. Powerpc has solved this by adding a result to the pt_regs =
struct, (the result should be in the o0 if i am correct).

(I am currently working on a sparc v100 with a TI UltraSparc IIe =
(Hummingbird))

Erik Kooistra

--Apple-Mail=_B6A0FC7B-EA46-4805-AC49-FE506E70A0E6
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Version: GnuPG/MacGPG2 v2.0.22 (Darwin)
Comment: GPGTools - http://gpgtools.org

iQIcBAEBAgAGBQJTE0SqAAoJEDtJ99QrnBhnD3YP/2rhx0xIQlhP093/7cl2f/2I
lQXQGwJ3sQmJLghrSyK5p9UPKneOx4QBvKJxwwfCsJKH8O436GAsJWD7aAiV+/XJ
4AxaXJTeI1pkFJEi20Mf2SXNn9I5cO6fKkATaGAQTSL7v06/VBN4xxmAF6HhsZ52
eJhTijJc1o16oZFtWyTRJFd5BIA4QGQsZdU151OgMz1tRB8vlLVEukgho/oQy5i4
FAVDm4HtlGbwSMH3JCD02Fq/3DF9rgsr8JGXAKOY3mwADCEeecAF/bgv1LGXvWSb
EqO3/zhbnOyyv7iSfIR0YttB/s9DXlsiCBlGZL2McagcGMJAKgVive0EwBii8EZ8
DuZ+Fz3F43M5Ky4WTfG+RJgB0yvV+ytATrep9m+mN3V7RD1aZFdYbF+k16bG2kZW
YuQPw/r5O2lD43HTv++gjR11XSzD8u8I6S7s8DERSmGU+PfZmVtCdskXEi3KIC7I
dOc7qtwBsV1DOr827sErnz+nmZ3OTHBFNMHleoChpvaoJwONbGXyMhIdHlCqBqiZ
SbfcZzuy2+iOioWQA1AGJC25a2i0C92oy51ro0pWhL3W1zCBZtJkF+8EuCQGv9tb
JzoC5TiU3jA0vthkhR/Yjl7AANyCYu7qnwn0hU+6TG0k+nid5V0hQVW7tSIWf5i2
OSHGLGPC1es22Yxjcflo
=FCU8
-----END PGP SIGNATURE-----

--Apple-Mail=_B6A0FC7B-EA46-4805-AC49-FE506E70A0E6--

From: joshk@triplehelix.org (Joshua Kwan)
Date: Wed, 18 Aug 2004 23:55:28 +0000
Subject: [2.6] busybox EFAULT on sparc64
Message-Id: <20040818235528.GA8070@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here's an example of a strange phenomenon seen by me and more recently
Jeff Bailey...

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D264482

I'm not sure exactly what's happening here. Summary: passing static
memory to mount(2) returns Bad address, and starting klogd hangs on a
fork(2) call. A mount call will succeed if the memory is copied first
onto the heap. This is 2.6.8 without any SPARC-specific patches, built
for sparc64.

You can check this out at (misnomer)
http://people.debian.org/~joshk/2.4.27/kernel-image-2.6.8-sparc/kernel-imag=
e-2.6.8-1-sparc64_2.4.27-1_sparc.deb
for yourself.

I'm inclined to believe that the two bugs are related; these both happen
with busybox-cvs and the exact same programs work with 2.4. Bastian
Blank suggests that it is the compat wrapper for sys_mount that is not
clean.

Could I get any idea of what is going on here? I'm CC:ing lkml because
this may be a general 2.6 bug that neither Jeff or I have encountered.

--=20
Joshua Kwan

--WIyZ46R2i8wDzkSu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQSPsb6OILr94RG8mAQL9ChAAoVivg5h79ctFmi9KvYUMMYDrGBeH+lLL
B0k3eJmWD91E7s3g0ZxJE9rog7gy3BS7XDTMBTUBv/milnQrtLMTLxDcDk18qOBp
QFK+Y72Htrq0N6QPg/OAdV3Wh4tMCXMKyplqwtOodrBDyksxhkue1Sm01/HGwRGQ
h+uoJBw+kO4uoa0VgUtX6/Ms383fcPuPk2v94+wTAiwIcFDA9ky3koR4fhVQ4WBe
CQdhM0k+Qd2Sg27daye+AyG4kCB13PCRiqbnxtYvUCuBtMY7RcT69CyF7z3WBjUV
vjmxsDAiuaQfpMxWW9w+/DxX5Rdb2LiNGjUcRbXyR8se9e9Zs3TG3QEKMyG3n821
+vJFHrH0Oa9wyoBpKro3ubm3G5NU8OgXprivGQ4/WQ4fYihv4VcdZ9Jodox8Rv0B
EOKcM11Aa7r0PqlMh3rqZ3qwXWaWOs0Sqd2pLpcguoY7GMjF1sLGY5o0qHuucdMW
qI7yenBfChFsq/yX19/vqb/2R5OgJSpjp/SLt7sLdhUMr8zML5kwBzd/5QUsHTF2
Hw33I0fMRowvfGkw16yIjU+cGFwFBoaOi6huwIo34XG6HnlZNsofQHotTCpuRzMd
u6G5yWn1jeeQpAdokCtd9PoEyXjXlLD09BTpQJWUFeGjVRrSzMSS41DO3borLG4q
E670AnVSvEs=
=x+6X
-----END PGP SIGNATURE-----

--WIyZ46R2i8wDzkSu--

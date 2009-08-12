From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 12 Aug 2009 22:36:30 +0000
Subject: Re: bug: spinlock on UP system
Message-Id: <200908121736.31813.dennis@ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="nextPart4439674.I9gJIQTc7f"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--nextPart4439674.I9gJIQTc7f
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

sorry for the crappy subject=20

forgot to also add that we are now using dracut for the initrd=20

it happens just after  usb initialisation=20

Dennis


On Wednesday 12 August 2009 05:07:37 pm Dennis Gilmore wrote:
> On one of my netra X1's that i just updated to the F-12 rawhide tree i got
> the following
> uname -a
> Linux thor.ausil.us 2.6.31-0.149.rc5.git3.fc12.sparc64 #1 SMP Wed Aug 12
> 03:02:38 UTC 2009 sparc64 sparc64 sparc64 GNU/Linux
>
> We disabled the -smp kernel and are now only building a smp kernel. the
> netra has only a single cpu
>
> BUG: spinlock bad magic on CPU#0, swapper/1 (Not tainted)
>  lock: fffff8006f2ce528, .magic: 00000000, .owner: <none>/-1, .owner_cpu:=
 0
> Call Trace:
>  [0000000000650f58] spin_bug+0x8c/0x9c
>  [0000000000651030] _raw_spin_lock+0x24/0x150
>  [000000000084a30c] _spin_lock_bh+0x14/0x24
>  [0000000000794d28] alloc_netdev_mq+0xf0/0x288
>  [00000000006f49b4] loopback_net_init+0x20/0x84
>  [000000000078d064] register_pernet_operations+0x38/0xe0
>  [000000000078d128] register_pernet_device+0x1c/0x5c
>  [0000000000aaef04] net_dev_init+0x174/0x1f4
>  [0000000000426d30] do_one_initcall+0x5c/0x188
>  [0000000000a8e3a4] kernel_init+0x238/0x29c
>  [000000000042b550] kernel_thread+0x38/0x50
>  [0000000000832c1c] rest_init+0x18/0x80


--nextPart4439674.I9gJIQTc7f
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)

iEYEABECAAYFAkqDQ+8ACgkQkSxm47BaWffo9QCdF3LTtrJPRej8kRtYHPNCunqY
qwYAnjRgMCD5/gpcdb/sEmY7JI1lVw5X
=1N2b
-----END PGP SIGNATURE-----

--nextPart4439674.I9gJIQTc7f--

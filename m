From: Joshua Kwan <joshk@triplehelix.org>
Date: Sat, 28 Aug 2004 00:01:01 +0000
Subject: Re: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <412FCB3D.3040600@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig90E874D8B829FDAA2B3D12D3"
List-Id: <sparclinux.vger.kernel.org>
References: <20040825233247.237c1fb1.davem@redhat.com>
In-Reply-To: <20040825233247.237c1fb1.davem@redhat.com>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig90E874D8B829FDAA2B3D12D3
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

David S. Miller wrote:
> ===== arch/sparc64/lib/Makefile 1.19 vs edited =====
> --- 1.19/arch/sparc64/lib/Makefile	2004-08-23 14:33:04 -07:00
> +++ edited/arch/sparc64/lib/Makefile	2004-08-27 15:25:45 -07:00
> @@ -12,7 +12,7 @@
>  	 U1memcpy.o U1copy_from_user.o U1copy_to_user.o \
>  	 U3memcpy.o U3copy_from_user.o U3copy_to_user.o U3patch.o \
>  	 copy_in_user.o user_fixup.o memmove.o \
> -	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o
> +	 mcount.o ipcsum.o rwsem.o xor.o splock.o find_bit.o delay.o
>  
>  lib-$(CONFIG_DEBUG_SPINLOCK) += debuglocks.o
>  lib-$(CONFIG_HAVE_DEC_LOCK) += dec_and_lock.o

You forgot delay.c.

-- 
Joshua Kwan

--------------enig90E874D8B829FDAA2B3D12D3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS/LQKOILr94RG8mAQLcpBAApp5HSm0EqtsugGe2faKO/kvRn4780urp
40RvoCycSz0DWJCu+mUphWgvzU06xgOYaEr3gxpN/1uOJFxR6lIvTkO1cNycXIiQ
dYA9yeVk6e2MtQSRI5XW0b4wf4pZevqCCyU/Gy7KlYIaKKkXm8R4F80Gi6oM6fdI
Az/sexd0LSZalhGJb6jSxoUr3QJHWxuFQP0YQJxYKJpMhrZ/avBbCsvC8DSpAzSp
BRhs06tiDFR3lfsCwQbs4pp0qPbXdndKITUCZEi6GzXaHP6e/HwWBppbBo7iQFHh
XUeS/AgemQIj23VkcsTiwxKPgNevD9cyEsQArY0+KEyanhFgYbNYitGSa7cuXDzm
u0eyaPuU4nJSAAuoTzsQIDAdOHib+3VrBDj3bjgdij+cD287H6a0CiVuIs58avpg
CIj1ae9zCqI1pd9JLSwWPUsfNjT6SLJMa08P5PUfVjZVHxofj0BNBqQ32Ql4Lg+a
NE3bwohkdP4rf7Q6UZ3AZo5THwF+bMUHzfhRhnUy5Y7kBq/dHs0pNCMUd2eg9v+w
wA6Fjq+JUUGOw0yMfua4Szvhe6MAqoF/45F0AwjkwTpneHcM8gg9m+BwiuqDQX5g
D8B3sOgB4EEIiQdyf+YX7wqO6XkY3iwFKm3IQjzu/bHnGmwQEpJeJR0vb6o0ENsm
aUbd9KBJvI8=
=azGv
-----END PGP SIGNATURE-----

--------------enig90E874D8B829FDAA2B3D12D3--

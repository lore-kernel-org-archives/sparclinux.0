From: Joshua Kwan <joshk@triplehelix.org>
Date: Fri, 27 Aug 2004 20:06:08 +0000
Subject: Re: [sparc32] unversioned udiv taints kernel
Message-Id: <412F9430.6020805@triplehelix.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig5150C143EBE30EC7EF97C529"
List-Id: <sparclinux.vger.kernel.org>
References: <cgo1li$t40$1@sea.gmane.org>
In-Reply-To: <cgo1li$t40$1@sea.gmane.org>
To: sparclinux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5150C143EBE30EC7EF97C529
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Keith M Wesolowski wrote:
> The versioning method has changed; all symbols are versioned now using
> a different method.  I believe I had fixed this quite a while ago -
> check the bk logs.  What kernel are you using?

2.6.8.1. It's reproducible any time core SCSI support is modularized.

-- 
Joshua Kwan

--------------enig5150C143EBE30EC7EF97C529
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iQIVAwUBQS+UMaOILr94RG8mAQJrfRAAsi6ZeAub0PfJte6y7A4r/bUrGnSwp6c6
lOIzE3/+/QVEjGlJ/8J72GSCHtNNVyvXidqhl7CL7dW39fqn7ae34jfMgbbMIHk3
2PByKewClGFkW2RxBd7aDixWInID9Vd6DuUe+U/eKxYIAngjgLx0xCamlK4FCUCc
BpcY5/zSifLo/IC5mHUJRE07zlFVKHRa7hTfEOmZ30MWbFJD3Se0fbKmrf7OcluE
zyG9Egug9MJKcwA32t/49eP4l+O6eRQUh5+RdTe1X5F8oj8vLoVZ6ic7RcpsTh9V
oZ+lf9FZGTpMxSkpuUSWYE7bzei1ds3CD9QbEk3/C9O481jnncbYKpd9c1WXye+d
Io80olrIrlOvHZiQihTbP1dFxic5t9AxCh+McKrRf6ry4eFKfU2q0k0cQ15hJaP3
52HY9TUKIcdcbgP33jIXyL+TIIv0DBY5mOJSVjGQN0RYS3WjWhAl+hqEE22mjfaB
wam4AoDkyebLIWXbCGOtwvNMS+jBZmvzPAplee0wg4/mhffqqHsZ1D42c+zk6+go
oB0IfFrX33pnttjeb2BgdctdovW7NVio2thFGVPwWp+DwlXTjXXbsmJ5l24yaUlT
aNp7CPrxhh5xS1bCAJ1RYyfK+kVZSjft0FxzxgHOWga8vcN0MBseJ83CcF5gYm/M
kS/65RyeiRI=
=ALcX
-----END PGP SIGNATURE-----

--------------enig5150C143EBE30EC7EF97C529--

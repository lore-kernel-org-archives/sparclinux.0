From: simoneau@ele.uri.edu
Date: Fri, 10 Mar 2006 03:37:47 +0000
Subject: setting resolution on *secondary* ffb
Message-Id: <20060309223747.wex88g85ogowc0og@webmail.ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_7d0flnzrxcgs"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This message is in MIME format and has been PGP signed.

--=_7d0flnzrxcgs
Content-Type: text/plain;
	charset=ISO-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

I've got a dual-headed Ultra80 running Linux with two Creator3D cards. The
problem is that I can't figure out how to set the resolution on the second
card. Since this is Linux, there's no ffbconfig, which is the normal way to do
this under Solaris. The only way to set the resolution is through OpenBoot. I
can set the resolution of the primary (console) framebuffer through the
output-device variable, but since only one head at a time is the console head I
can't do this for the second head. According to the Sun Framebuffer FAQ, you can
use the nvramrc like so:

probe-all
" /iommu/sbus/cgsix@0" select-dev
r1280x1024x76
" /iommu/sbus/cgsix@1" " set-resolution" execute-device-method drop
device-end
install-console
banner

However, the FFB seems to lack the device methods set-resolution and
r1280x1024x76 (as well as all the other supported rWxHxR combinations), so this
doesn't work. I can't find any obvious way to use the other device methods -
there is one called ffb_change_scrn_params but it appears to take several
unknown arguments.

Ideas? More info available on request.
--=_7d0flnzrxcgs
Content-Type: application/pgp-signature
Content-Description: PGP Digital Signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBEEPSLLYBaX8VDLLURAvORAKCthXfybibfLlHlUiZPT0xbsx+2TwCdFVqD
A0LyOuJ61jiUcpMjYYuWVzs=
=WS8Z
-----END PGP SIGNATURE-----

--=_7d0flnzrxcgs--


From: simoneau@ele.uri.edu
Date: Fri, 10 Mar 2006 19:05:38 +0000
Subject: Re: setting resolution on *secondary* ffb
Message-Id: <20060310140538.kioesb9es4osg0gc@webmail.ele.uri.edu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_6pgxmh2955wk"
List-Id: <sparclinux.vger.kernel.org>
References: <20060309223747.wex88g85ogowc0og@webmail.ele.uri.edu>
In-Reply-To: <20060309223747.wex88g85ogowc0og@webmail.ele.uri.edu>
To: sparclinux@vger.kernel.org

This message is in MIME format and has been PGP signed.

--=_6pgxmh2955wk
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Quoting simoneau@ele.uri.edu:

> I've got a dual-headed Ultra80 running Linux with two Creator3D cards. The
> problem is that I can't figure out how to set the resolution on the second
> card. Since this is Linux, there's no ffbconfig, which is the normal 
> way to do
> this under Solaris. The only way to set the resolution is through OpenBoot. I
> can set the resolution of the primary (console) framebuffer through the
> output-device variable, but since only one head at a time is the 
> console head I
> can't do this for the second head. According to the Sun Framebuffer 
> FAQ, you can
> use the nvramrc like so:
>
> probe-all
> " /iommu/sbus/cgsix@0" select-dev
> r1280x1024x76
> " /iommu/sbus/cgsix@1" " set-resolution" execute-device-method drop
> device-end
> install-console
> banner
>
> However, the FFB seems to lack the device methods set-resolution and
> r1280x1024x76 (as well as all the other supported rWxHxR 
> combinations), so this
> doesn't work. I can't find any obvious way to use the other device methods -
> there is one called ffb_change_scrn_params but it appears to take several
> unknown arguments.
>
> Ideas? More info available on request.



I've figured it out myself, info here for those interested:
http://www.ele.uri.edu/~simoneau/sunstuff/ffb-secondary-resolution.html

What you do in your nvramrc is set the secondary head to be the console head
with a specified resolution, then switch it back to the primary head. The OBP
conveniently leaves the card initialized for whatever mode you wanted.

--=_6pgxmh2955wk
Content-Type: application/pgp-signature
Content-Description: PGP Digital Signature
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBEEc4CLYBaX8VDLLURAlhqAKCnYkpIUMIkoUHW51GjizAkwWsf3QCfYJCM
HqGkHMzDTxFdxjSUiv4H/2o=
=LFJt
-----END PGP SIGNATURE-----

--=_6pgxmh2955wk--


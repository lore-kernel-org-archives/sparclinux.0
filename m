From: Josh Grebe <josh@brokedown.net>
Date: Wed, 08 Mar 2006 21:59:13 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <440F53B1.30600@brokedown.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_unix1.shortcutsolutions.net-13097-1141855386-0001-2"
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
To: sparclinux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_unix1.shortcutsolutions.net-13097-1141855386-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit



Richard Mortimer wrote:
> 
> I'm not sure if you noticed this (but neither you or Dave mentioned it)
> so I'll mention it. But there is an earlier error in your log...
> 
> [   13.886016] BUG: spinlock wrong CPU on CPU#1, swapper/0
> [   13.886023]  lock: 00000000006bfa40, .magic: dead4ead, .owner: swapper/0, .owner_cpu: 0
> [   13.886029] Call Trace:
> [   13.886034]  [00000000006cc838] start_kernel+0x1d8/0x200
> [   13.886050]  [00000000004043f4] tlb_fixup_done+0x5c/0x64
> [   13.886060]  [0000000000000000] _start+0xffffffffffbfc000/0x12
> 
> Could that have been the start of things going wrong?

Hi Richard,

This happens on kernels that otherwise run, so I'd think not.  Obviously, Dave
knows more than I would though...

Josh


--=_unix1.shortcutsolutions.net-13097-1141855386-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFED1OzT/OY5rt9JCMRAxObAKDP0iO93NybUrEtxU6rAOydx5S3OQCfcw3j
xzCqRjL5bFj9oRYr3trules=
=P8Ou
-----END PGP SIGNATURE-----

--=_unix1.shortcutsolutions.net-13097-1141855386-0001-2--

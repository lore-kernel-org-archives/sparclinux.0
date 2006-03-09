From: Josh Grebe <josh@brokedown.net>
Date: Thu, 09 Mar 2006 03:54:31 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <440FA6F7.1050704@brokedown.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

David S. Miller wrote:
> 
> This fix works for me on SB2500, where I could reproduce your
> problem.  Let me know how it goes.  Stupid 32-bit truncation
> bug :(

Dave,

You Rock.

Thanks,

Josh


Linux v240 2.6.16-rc5-git11-sparse #6 SMP Wed Mar 8 21:49:16 CST
2006 sparc64 sun4u TI UltraSparc IIIi (Jalapeno) GNU/Linux

[   10.209530] Memory: 2071184k available (2104k kernel code, 720k
data, 144k init) [fffff80000000000,000000103feee000]
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFED6b2T/OY5rt9JCMRAvcjAKCw4gcM9Lo2Ri5a+IXqrr3CEU5qswCfaY3P
Gw+heYATfCpsGbl0GYPQZTsCA
-----END PGP SIGNATURE-----

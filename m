From: Jason Wever <weeve@gentoo.org>
Date: Wed, 31 Mar 2004 00:00:25 +0000
Subject: Re: Compiling sunlance as a module
Message-Id: <20040330170025.10b1e337@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Signature=_Tue__30_Mar_2004_17_00_25_-0700_ZSg9pgBTwszRI8DB"
List-Id: <sparclinux.vger.kernel.org>
References: <20040330234412.GB5439@artsapartment.org>
In-Reply-To: <20040330234412.GB5439@artsapartment.org>
To: sparclinux@vger.kernel.org

--Signature=_Tue__30_Mar_2004_17_00_25_-0700_ZSg9pgBTwszRI8DB
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Tue, 30 Mar 2004 17:44:12 -0600
"Art Haas" <ahaas@airmail.net> wrote:

> I'm still fiddling around with my configuration for my SS20, and I found
> that compiling the sunlance.c file as a module has problems. When
> booting up and the various init scripts are running, the eth0 interface
> fails to start correctly. By doing 'modprobe sunlance' after I log in I
> am able to start eth0 and things move smoothly, but I'm an curious to
> find out why having this code as a module fails

I'm currently doing this on a ss4 and my first guess would be is that
nothing is loading the module before the init scripts try to make use of
the network device.  As long as I have the module loaded *before* the
network dependent init scripts run, everything is fine.  Not sure which
distribution you are using or I'd make a suggestion as to where to setup
the module to load.

Additionally network drives don't seem to fall under the drivers the
kernel will auto-load as needed (since it probably can't determine what
you may have or in the case of multiple NICs, which one you want to use).

-- 
Jason Wever
Gentoo/Sparc Team Co-Lead

--Signature=_Tue__30_Mar_2004_17_00_25_-0700_ZSg9pgBTwszRI8DB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAagocdKvgdVioq28RAk57AKCbUnRJ16CcFPO2nCvam+4fU9cKXgCgifPU
z5uXNW8/kCnBHYmDShesI1Q=
=KrtX
-----END PGP SIGNATURE-----

--Signature=_Tue__30_Mar_2004_17_00_25_-0700_ZSg9pgBTwszRI8DB--

From: Josh Grebe <josh@brokedown.net>
Date: Tue, 07 Mar 2006 22:39:32 +0000
Subject: Re: Best bet for SPARC SMP and Sunfire V240
Message-Id: <440E0BA4.9020004@brokedown.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_unix1.shortcutsolutions.net-23901-1141771361-0001-2"
List-Id: <sparclinux.vger.kernel.org>
References: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
In-Reply-To: <a728f9f90603071426g547ba79at30c36e545db70f01@mail.gmail.com>
To: sparclinux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_unix1.shortcutsolutions.net-23901-1141771361-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Alex,

Current 2.6 kernels are doing pretty well for me. There are issues, though. You
will want to move all your memory to the bank of cpu0 if you can. Linux won't
see all of it no matter where you put it, but you get more if it is all on one
cpu. Make sure you have a current OBP, I'm running 4.17.1.

I can't even get 2.4 to userland.

Linux v240 2.6.15-gentoo-r7 #1 SMP Fri Mar 3 12:40:28 CST 2006 sparc64 sun4u TI
UltraSparc IIIi (Jalapeno) GNU/Linux

Josh



Alex Deucher wrote:
> I have a couple questions about Linux support for the sunfire V240. 
> I've only been able to find limited information about the status of
> the V240s.  I have several that I'd like to install linux on.  My
> other question is, what is the status of SMP on 2.6 kernels?  The last
> few times I tried it locked the boxes hard, however I seem to recall
> hearing that the problem had been fixed.  I'm currently running debian
> w/ 2.4 kernels on our SMP SPARC boxes and debian with 2.6 kernels on
> our UP SPARC boxes (E4500, 420R, 220R, etc.) and both have been rock
> solid.  What's my best bet for SMP V240 servers?  2.4? 2.6?
> 
> Thanks,
> 
> Alex
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=_unix1.shortcutsolutions.net-23901-1141771361-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFEDgusT/OY5rt9JCMRAweFAJ9zX5z7isMALYu1wgWVWPpa2bAKOgCeJKS2
QbF03n/ur89PCRh5wxzUe+0=
=zMKP
-----END PGP SIGNATURE-----

--=_unix1.shortcutsolutions.net-23901-1141771361-0001-2--

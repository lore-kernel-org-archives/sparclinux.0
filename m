From: Josh Grebe <squash@gentoo.org>
Date: Wed, 07 Sep 2005 20:01:35 +0000
Subject: Re: [gentoo-sparc] 2.6 kernel and docs
Message-Id: <431F471F.6070909@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=_unix1.shortcutsolutions.net-3055-1126123084-0001-2"
List-Id: <sparclinux.vger.kernel.org>
References: <20050829.130957.02952920.davem@davemloft.net>
In-Reply-To: <20050829.130957.02952920.davem@davemloft.net>
To: sparclinux@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_unix1.shortcutsolutions.net-3055-1126123084-0001-2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Dave,

Sorry it took a few days to get back on this, but I wanted to get some
additional testing in before I came back in.

Linus' current git tree crashes on my netra 1405, the same as previous 2.6
kernels. It also crashes on Ferris McCormick's Ultra60. I have tried both with
and without the second MEMORY_READ_BARRIER() call commented. Once the crash hit,
Ferris was unable to issue sysrq commands from the keyboard.

To complicate matters, I built a second Netra 1405 with a similar configuratino
(4x440 and 1G ram) but added a keyboard and framebuffer, and I could not trigger
the crash. Ferris' Ultra60 also has a keyboard and framebuffer and happily crashes.

I also built a T1125 (ultra60) with 2x440 and 1G ram, and I could not convince
it to crash. This unit used serial console. Since Ferris' Ultra60 has 2x300, I
also tried underclocking to that speed and could not trigger the crash.

To further complicate things, and to rule out compiler/toolchain, I used the
same binary kernel image on all boxes. I'm trying to kill every variable I can.

I guess my next step is to pick up the crashing Netra and throw a
framebuffer/keyboard on it, but I think that base has been covered by Ferris'
Ultra60. This will take a few days to do.

Josh



David S. Miller wrote:
> From: Josh Grebe <josh@brokedown.net>
> Date: Tue, 30 Aug 2005 10:04:10 -0500
> 
> 
>>Well, its a little different now! I crashed very quickly the first
>>run, before I commented out that MEMORY_READ_BARRIER().
> 
> 
> We really can't be testing the same kernels then.
> Mine ran for hours and hours on end, even spamming my
> xterms with tar output over the network to my workstation
> in parallel.
> 
> Linus's current 2.6.14 GIT tree has all of my fixes in
> it, maybe you can test that.
> 
> And if you get a wedge again, please turn on spinlock
> debugging, CONFIG_DEBUG_SPINLOCK, because that is how I
> got my traces.
> 
> And please do it with a head and keyboard attached so we
> can eliminate the sketchy serial console layer as a variable.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> !DSPAM:43149e2d95798517817808!
> 

--=_unix1.shortcutsolutions.net-3055-1126123084-0001-2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Transfer-Encoding: 7bit
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDH0chFAhB33r2ACYRA3dXAJ4g/Cy0UbrILLZHuPsEuKGL0vCkHwCgmGni
XPBcM0PW1vCWn7UOz1YQEHo=
=Yz+c
-----END PGP SIGNATURE-----

--=_unix1.shortcutsolutions.net-3055-1126123084-0001-2--

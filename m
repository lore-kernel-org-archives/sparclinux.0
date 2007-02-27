From: "Daniel J. Priem" <daniel@flexserv.de>
Date: Tue, 27 Feb 2007 20:22:00 +0000
Subject: Re: Unaligned accesses in ip_rcv and ip_fast_csum
Message-Id: <873b4rwduf.fsf@samuel.flexserv.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-=-="
List-Id: <sparclinux.vger.kernel.org>
References: <20070225200702.GA4451@droopy.oc.cox.net>
In-Reply-To: <20070225200702.GA4451@droopy.oc.cox.net>
To: sparclinux@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

David Miller <davem@davemloft.net> writes:

> From: "Doug Nazar" <nazard@dragoninc.ca>
> Date: Tue, 27 Feb 2007 14:43:23 -0500
>
>> > We have a report (Debian bug #409313 [0]) of the following unaligned
>> > accesses, occuring every 5-6 seconds on Netra X1 and SunFire v100 with
>> > kernel 2.6.18 and newer:

This also occurs on netra t1 105  TI UltraSparc IIe (Hummingbird)

[93548.504961] Kernel unaligned access at TPC[6aa660]
aoenet_rcv+0xa8/0x1a0


>>=20
>> A quick grep shows this issue is also in de2104x module in case somebody=
 is
>> using that.
>
> I've forwarded both of your patches to the netdev lists and
> Jeff Garzik, the network drivers maintainer.
>
> Thanks.
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

=2D-=20
 .''`.
 : :' :      Daniel J. Priem
 `. `'       http://flexserv.de
   `-=20=20=20=20=20=20=20=20
--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Processed by Mailcrypt 3.5.8+ <http://mailcrypt.sourceforge.net/>

iD8DBQFF5JLoU9jdS3sZZnERAryRAJ9rgVFMI728yg7E4bdZuRBpg7bQ1ACfXyEj
KmFwzKhzSN8DWf9bkfZ7/8k=
=577U
-----END PGP MESSAGE-----
--=-=-=--


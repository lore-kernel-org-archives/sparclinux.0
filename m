From: Jeremy Huddleston <eradicator@gentoo.org>
Date: Sun, 05 Dec 2004 22:03:46 +0000
Subject: Re: system lockup bug in >2.6.7-rc1-bk6 tracked down
Message-Id: <1102284226.20364.60.camel@cid.outersquare.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-w5tQrvzUEbUMBTvBQz+o"
List-Id: <sparclinux.vger.kernel.org>
References: <1101553907.21614.24.camel@cid.outersquare.org>
In-Reply-To: <1101553907.21614.24.camel@cid.outersquare.org>
To: sparclinux@vger.kernel.org


--=-w5tQrvzUEbUMBTvBQz+o
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2004-11-27 at 03:11 -0800, Jeremy Huddleston wrote:
> A change between 2.6.7-rc1-bk6 and 2.6.7-rc2 can results in a system
> lockdown.  One situation in which this can be triggered is when we are a
> nfs client, and the nfs server shuts down (or on the server, you simply
> issue an 'ifconfig eth1 down').  I have tracked this down to a bug in
> dev_ifconf() in fs/compat_ioctl.c

Ok, I was mistaken.  The bug isn't triggered by the NFS server becoming
unavailable.  It's actually triggered by NIS.  ypbind is the process
which eventually results in the dev_ifconf() call which locks up the
system.

This problem was originally reported in this post
http://marc.theaimsgroup.com/?l=3Dlinux-sparc&m=3D109830513430004&w=3D2 and=
 I
confirmed with the poster of that message that they were using NIS as
well and their NIS server was the same as the NFS server.

Sorry for the confusion.

--=20
Jeremy Huddleston <eradicator@gentoo.org>

--=-w5tQrvzUEbUMBTvBQz+o
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBs4XCOpjtAl+gMRURAhw3AKDOOPcAhGTmMZupA6A7kYDE4aIU9ACaA5CS
IL1qcwCuUNDEMTSWGVMza4Q=
=o8bv
-----END PGP SIGNATURE-----

--=-w5tQrvzUEbUMBTvBQz+o--


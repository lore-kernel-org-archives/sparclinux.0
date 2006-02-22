From: Jason Wever <weeve@gentoo.org>
Date: Wed, 22 Feb 2006 03:20:57 +0000
Subject: Re: possible spinlock/esp bug in 2.6.16-rc4
Message-Id: <20060221202057.444012e7@enterprise.weeve.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sig_YCnxm=PA65QNQ4cRyz9dT6a"
List-Id: <sparclinux.vger.kernel.org>
References: <20060219101701.6f2ce579@enterprise.weeve.org>
In-Reply-To: <20060219101701.6f2ce579@enterprise.weeve.org>
To: sparclinux@vger.kernel.org

--Sig_YCnxm=PA65QNQ4cRyz9dT6a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sun, 19 Feb 2006 10:21:10 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> Please do a "git bisect" from the last known working version
> so we can find out exactly what change caused this regression.
>=20
> The esp driver hasn't been touched in ages so it's probably
> a sparc64 or SCSI layer generic change that caused this.
>=20
> Please get in the habit of using git.  Using "git bisect" allows you
> to determine quickly exactly what patch introduced a regression
> saving developers and yourself a lot of wasted time analyzing
> bug reports.

Thanks for the pointer.  In using this method to track down the patch,
I started getting errors looking like this;

kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
INIT: version 2.86 booting
Badness in local_bh_enable at kernel/softirq.c:140
Call Trace:
 [0000000000441250] __dequeue_signal+0x50/0xa0
 [0000000000441354] dequeue_signal+0xb4/0xe0
 [0000000000442e48] get_signal_to_deliver+0x28/0x280
 [0000000000424bd8] do_signal32+0x38/0x2c0
 [000000000041b3cc] do_signal+0x4c/0x5e0
 [000000000040547c] __handle_signal+0x10/0x54
 [0000000000045288] 0x45288


Using git bisect, it traces down to the following;

4021cb279a532728c3208a16b9b09b0ca8016850 is first bad commit
diff-tree 4021cb279a532728c3208a16b9b09b0ca8016850 (from
d5bee775137c56ed993f1b3c9d66c268b3525d7d) Author: Ingo Molnar
<mingo@elte.hu> Date:   Wed Jan 25 15:23:07 2006 +0100

    [PATCH] fix uidhash_lock <-> RCU deadlock
   =20
    RCU task-struct freeing can call free_uid(), which is taking
    uidhash_lock - while other users of uidhash_lock are softirq-unsafe.
   =20
    The fix is to always take the uidhash_spinlock in a softirq-safe
manner.=20
    Signed-off-by: Ingo Molnar <mingo@elte.hu>
    Acked-by: Paul E. McKenney <paulmck@us.ibm.com>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

:040000 040000 98d3bd6cebd288defc2bee44054d252629e6c020
9319c402e05522b655c2445e9f19cf394b006e02 M      kernel


This was done against git when 2.6.16-rc4 was the most current and 2.6.14 w=
as the last known good version.

Cheers,
--=20
Jason Wever
Gentoo/Sparc Team Co-Lead

--Sig_YCnxm=PA65QNQ4cRyz9dT6a
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (GNU/Linux)

iD8DBQFD+9iZdKvgdVioq28RArU0AJ9qUmpYRSASFGimEm12f3BqvKDf+gCfZNiE
AxnX9WYNAqrflgIfA0ge+as=
=jR7j
-----END PGP SIGNATURE-----

--Sig_YCnxm=PA65QNQ4cRyz9dT6a--

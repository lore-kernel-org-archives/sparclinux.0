From: David Miller <davem@davemloft.net>
Date: Fri, 12 Jun 2009 00:06:25 +0000
Subject: Re: [2.6.29.4] Blade 2000
Message-Id: <20090611.170625.127899992.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4A1C36B5.6040707@systella.fr>
In-Reply-To: <4A1C36B5.6040707@systella.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: BERTRAND Jo=EBl <joel.bertrand@systella.fr>
Date: Thu, 11 Jun 2009 18:32:04 +0200

> tchebytchev:[~/linux/sparc-2.6] > git bisect start v2.6.29 v2.6.28 --
> drivers/scsi/qla2xxx/
> Checking out files: 100% (10708/10708), done.
> Switched to branch "master"
> Bisecting: 19 revisions left to test after this
> [8eca3f39c4b11320787f7b216f63214aee8415a9] [SCSI] qla2xxx: Always
> serialize mailbox command execution.
>=20
> -> kernel boots
>=20
> tchebytchev:[~/linux/sparc-2.6] > git bisect good
> Bisecting: 9 revisions left to test after this
> [618a752319503a64d1b66615e8ea2a0e7edaf914] [SCSI] qla2xxx: Remove
> interrupt request bit check in the response processing path in multiq
> mode.
>=20
> -> kernel doesn't boot
>=20
> tchebytchev:[~/linux/sparc-2.6] > git bisect bad
> Bisecting: 4 revisions left to test after this
> [b872ca4081c480e3d76443282ffd7f206321f50f] [SCSI] qla2xxx: Correct
> descriptions in flash manipulation routines.
> tchebytchev:[~/linux/sparc-2.6] >
>=20
> tchebytchev:[~/linux/sparc-2.6] > git bisect log
> # bad: [8e0ee43bc2c3e19db56a4adaa9a9b04ce885cd84] Linux 2.6.29
> # good: [4a6908a3a050aacc9c3a2f36b276b46c0629ad91] Linux 2.6.28
> git-bisect start 'v2.6.29' 'v2.6.28' '--' 'drivers/scsi/qla2xxx/'
> # good: [8eca3f39c4b11320787f7b216f63214aee8415a9] [SCSI] qla2xxx:
> # Always serialize mailbox command execution.
> git-bisect good 8eca3f39c4b11320787f7b216f63214aee8415a9
> # bad: [618a752319503a64d1b66615e8ea2a0e7edaf914] [SCSI] qla2xxx: Remove
> # interrupt request bit check in the response processing path in multiq
> # mode.
> git-bisect bad 618a752319503a64d1b66615e8ea2a0e7edaf914
> tchebytchev:[~/linux/sparc-2.6] >
>=20
> 	I'm investigating...

Keep going :-)

You need to keep building and going "git bisect bad" or "git bisect
good" until it tells you the final guilty commit.

I assume you understand this and are just giving a status report
mid-way in your task, but I wanted to be sure. :-)

Thanks!

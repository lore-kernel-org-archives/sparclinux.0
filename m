From: Josip Rodin <joy@entuzijast.net>
Date: Tue, 24 May 2011 08:59:50 +0000
Subject: Re: Sun4d boot crash in sun4d_init_timers
Message-Id: <20110524085949.GA7688@entuzijast.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1105231908050.7984@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

On Tue, May 24, 2011 at 01:05:14AM +0200, Josip Rodin wrote:
> +	board =3D of_getintprop_default(dp, "board#", 0);
> +	if (!board) {

> Passing around the 'board' property of 'cpu-unit' looks like it should be=
 done
> because the same thing is used to seed board_to_cpu[].
>=20
> http://git.kernel.org/?p=3Dlinux/kernel/git/davem/prtconfs.git;a=3Dblob;f=
=3Dss1000;h=F420dc005d6939b837134d146741316c024d5932;hb=3DHEAD
> says both cpu-units have the same, zeroth board, but it might not hurt
> to check just in case some other machine happens to use a different index.

In fact it looks like 0 is a common valid value in the analogous pieces of
code that don't even verify the result of that lookup. The above code should
either not check that lookup either (the simple solution), or set the
default to -1 so that it can actually discern error state.

--=20
     2. That which causes joy or happiness.

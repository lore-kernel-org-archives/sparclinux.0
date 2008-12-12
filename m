From: Bob <bo-liu@hotmail.com>
Date: Fri, 12 Dec 2008 09:04:33 +0000
Subject: RE: where forked child task first return?
Message-Id: <COL115-W2F3EF1B0C4B972377090C9FF90@phx.gbl>
List-Id: <sparclinux.vger.kernel.org>
References: <COL115-W66A1309552B49F8E7C76509FF90@phx.gbl>
In-Reply-To: <COL115-W66A1309552B49F8E7C76509FF90@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org


Still mess, how the new forked child task is switched...


> From: bo-liu@hotmail.com
> To: sparclinux@vger.kernel.org
> Subject: where forked child task first return?
> Date: Fri, 12 Dec 2008 10:16:52 +0800
>=20
>=20
> when task is forked, it will copy his parent's kernel stack.
>=20
> Then when first time switch_to a new created task, will change to its ker=
nel stack.
>=20
> But, in switch_to macro will " ldd [%%sp + 0x38], %%i6 ", for child task,=
 stack frame is copyed=20
>=20
> from parent, so %%i6 will also the same as the parent's .
>=20
> so switch to child task will return to parent's kernel stack again ?
_________________________________________________________________
Connect to the next generation of MSN Messenger=A0
http://imagine-msn.com/messenger/launch80/default.aspx?locale=3Den-us&sourc=
e=3Dwlmailtagline
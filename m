From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 13 Jul 2007 08:19:00 +0000
Subject: Bug 8232, framebuffer and Creator3D on U1/U2
Message-Id: <46973574.80500@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

	Hello,

	Some weeks ago, I have seen a patch that fix this bug :
<http://bugzilla.kernel.org/show_bug.cgi?id=8232>. This pach is now in=20
main kernel tree.

	Old Creator3D (R1) were affected by this bug and I though that it was=20
fixed. But, for two weeks, I have some troubles with Xorg 7.2=20
(sunffb/Xinerama is broken) and a lot of X programs are broken=20
(specially xscreensaver).

	I suppose that xscreensaver refreshes FB device, because without=20
xscreensaver, when DPMS turns FB off and when I turn it on with keyboard=20
or mouse, I can see this mistake again.

	Regards,

	JKB

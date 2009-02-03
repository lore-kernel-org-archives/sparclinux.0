From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Tue, 03 Feb 2009 10:43:53 +0000
Subject: Two V880, one working with a 2.6.28 kernel image, one hanging
Message-Id: <20090203104353.GA5223@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello Adrian,

On Mon, Feb 02, 2009 at 05:02:43PM +0100, Adrian Knoth wrote:
> On Mon, Feb 02, 2009 at 04:57:09PM +0100, Hermann Lauer wrote:
> > May I get your compiled, running kernel image to try that on my V880?
>=20
> The extracted tgz contains much more, but also my kernel, the silo
> config, the modules and so on.

unfortunately on my V880 your 2.6.28 image hangs at the same point as my
tries with David Miller. Looking throught your included dmesg file
I noticed the following main differences  from my console output available =
at:
http://www.iwr.uni-heidelberg.de/ftp/linux/sparc-boot/console-2.6.28-200902=
03.txt

1) your OBP firmware 4.17.1, mine is 4.22.34
2) you are on the rsc console, here it is the serial port
3) you have 6 cpus with more memory, I only two

Do you have your OBP firmware around ? Please don't search,
if not, I'll look myself for it. And a "lspci -v" would be interesting
for me, too.

For the linux sparc list: Adrians report and kernel config is available
on http://bugs.debian.org/cgi-bin/bugreport.cgi?bugP9202

Thanks,
  Hermann

> PS: Meinetwegen k=F6nnen wir auch auf Deutsch schreiben ;)
Ist halt schlecht mit den CC, sonst gerne :-)

--=20
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres=20
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de

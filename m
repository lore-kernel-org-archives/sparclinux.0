From: Tonu Samuel <tonu@jes.ee>
Date: Sun, 17 Dec 2006 20:20:52 +0000
Subject: Problems booting on Sun e10k
Message-Id: <200612172220.52954.tonu@jes.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi!

I have Sun Enterprise 10000 and cannot make it to be friends with linux. I =
had=20
nice success with E6500 but not with E10000. There are my attempts are=20
logged:

http://no.spam.ee/~tonu/sparc/gentooe10k.txt

http://no.spam.ee/~tonu/sparc/aurorae10k.txt

Notice, E10k usually needs to install software over lan. I have hacked cdro=
m=20
to it for making things more clear.

I believe problem is in console. on e10k there is no serial port or=20
framebuffer device. Console works over ethernet and this makes linux=20
confused.

I have not tried to compile sparc linux kernel on my own. Just had no time =
and=20
currently I have no installed Linux on sparc too.=20

   T=F5nu

From: =?ISO-8859-1?Q?T=F5nu?= Samuel <tonu@jes.ee>
Date: Fri, 19 Jan 2007 21:20:07 +0000
Subject: Linux on Sun e10k
Message-Id: <1169241607.30406.19.camel@duo.jes.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hello all good people!

Just in short - cannot make Linux work on Sun StarFire. There are few
different reports which claim they made it work and even some dedicated
code for Starfire in kernel but I can't.

Current situation: we can boot till /bin/init. Then we loose console.
----------
Jan 19 17:44:29 unknown netcon_server: [ID 366040 local1.info] (linux) :
Warning: unable to open an initial console.
Jan 19 17:44:29 unknown netcon_server: [ID 366040 local1.info] (linux) : fo=
obar1: '/sbin/init'
----------
No more output. But also does not come to network (there is a
preinstalled HDD under it with Aurora 2 and ssh enabled)

Adding init=3D/bin/bash will cause bash to fail and crash. Probably
because stdout is missing or such fatal stuff.

----------
Jan 19 21:51:19 unknown netcon_server: [ID 366040 local1.info] (linux) :
Warning: unable to open an initial console.
Jan 19 21:51:19 unknown netcon_server: [ID 366040 local1.info] (linux) : fo=
obar: '/bin/bash'
Jan 19 21:51:19 unknown netcon_server: [ID 366040 local1.info] (linux) : fo=
obar1: '/bin/bash'
Jan 19 21:51:20 unknown netcon_server: [ID 366040 local1.info] (linux) : Ke=
rnel panic - not syncing: Attempted to kill init!
----------

Those "foobars" are my own debugging.=20

Our current output is posted in web http://no.spam.ee/~tonu/sparc/netcon (b=
eware, 3,5M big file) and config http://no.spam.ee/~tonu/sparc/config
We tried very different configs, many of them panic. This one makes it most=
ly work. Kernel is vanilla 2.6.19.1.

There is a "known working" configuration for 2.6.4 but this kernel does not=
 compile for me. Some sources where people report e10k works:

http://lists.debian.org/debian-sparc/2004/02/threads.html#00177

http://people.debian.org/~fabbione/e10k/debian_on_e10k.txt

http://samba.org/~anton/e10000/

Noone provided copy of their working kernel.

I think we need some help in moving forward. Can provide shell access and s=
uch. After we get it working I can set up=20
automatic validating of linux kernels there to make sure it works in future.

  T=C3=B5nu


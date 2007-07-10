From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 10 Jul 2007 07:53:12 +0000
Subject: [sparc64] Strange interaction between 2.6 kernel and 2.5 (and 2.6)
Message-Id: <46933AE8.1080509@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	For one month, I try to debug a very strange interaction between 2.6 
kernel and glibc on sparc64 boxes. All boxes run debian/testing.
I have tested all kernel betwenn 2.6.20.3 and 2.6.21.6 with glibc 2.3, 
2.5 and 2.6 (2.6exp3 from debian/experimental).

Constatations:
1/ with all kernels and glibc2.3, all boxes run fine;
2/ with all kernels and glibc2.5 or 2.6, my U2/smp works fine too, but 
on U60/smp and U80/smp several daemons randmoly remain in sleep state 
and don't wake up anymore (named, clamd, milter-greylist, portmap...).

	I have tried to isolate parameters and I have found that the trouble 
comes from thread support introduced by new libc, and I though that I 
have to find it in glibc. Now, I think that this bug vomes from kernel, 
because I never seen this bug (with of course the same configuration) on 
my U2.

Steps to reproduce:
1/ install a sendmail server with mimedefang that calls clamav-daemon 
(in mimedefang.pl.conf : $Features{'Virus:CLAMD'}      = 1; $ClamdSock = 
"/var/run/clamav/clamd.ctl";)
2/ send or receive (by script ;-) ) huge amount of mails
3/ wait... nd see ;-)

	When clamav-daemon (or all other daemons) remain in sleep mode, I 
cannot quickly restart this daemon by /etc/init.d/$(daemon) restart, I 
have to wait for a timeout.

	Regards,

	JKB

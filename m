From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 06 Jul 2007 09:39:26 +0000
Subject: [BUG] 2.6.22-rc7 breaks nis server on sparc64
Message-Id: <468E0DCE.7020207@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I test a 2.6.22-rc7 kernel on a U60/SMP. This U60 is a NIS server for a 
U2 (that runs 2.6.21.3). If U60 runs a 2.6.21.5, ypserv runs fine. With 
2.6.22-rc7 (and of course the same system), ypbind on U2 cannot connect 
to ypserv. Portmap runs in both kernels.

	Regards,

	JKB

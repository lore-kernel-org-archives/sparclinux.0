From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Tue, 26 May 2009 07:53:50 +0000
Subject: [bbc_i2c] howto read CPU temp ?
Message-Id: <4A1BA00E.9070204@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I use several dual CPU (UIII+/900) blade 2000. This morning, one of 
these stations has halted. I can see in /var/log/syslog :

May 26 09:00:10 rayleigh kernel: temp0: Above safe CPU operating 
temperature, 80 C.
...
May 26 09:00:41 rayleigh kernel: temp0: Above safe CPU operating 
temperature, 81 C.
...
May 26 09:01:11 rayleigh kernel: temp0: Above safe CPU operating 
temperature, 83 C.
...
May 26 09:01:36 rayleigh kernel: temp0: Outside of safe CPU operating 
temperature, 85 C.
...
May 26 09:01:36 rayleigh kernel: kenvctrld: Shutting down the system now.
May 26 09:01:36 rayleigh shutdown[11935]: shutting down for system halt

	I have reduced maximal CPU frequencies, but I want to use cpufreqd (or 
some other script to modify cpu governor). I don't see where kernel 
writes CPU temperature ? I find anything in /sys or /proc. How can I 
obtain this temp ?

	Regards,

	JKB

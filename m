From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 09 Mar 2007 20:20:02 +0000
Subject: Dead lock with 2.6.20
Message-Id: <45F1C172.60103@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have seen a very strange deadlock on a UltraSPARC 2 workstation (2 
UltraSPARC-II/296 MHz, 2048 MB, framebuffer Creator3D on UPA slot, 2 73 
GB SCA disks that form a raid1 array).

	Hardware sounds good and I have tested it with SUNvts during two days 
without any failure.

	This workstation is a mail server and runs with Debian/testing, kernel 
2.6.20. It's a NIS and NFSv3/TCP clients. Its uptime was more than 9 
days and it hangs without any message in the log, without panic and 
without oops. When it hangs, the queue of sendmail was about 3 GB due to 
a failure of a internet peering. I have rebooted the workstation (power 
button :-( ). You can find my .config at

http://rayleigh.systella.fr/~bertrand/config-sun4u-2.6.20.gz

	I don't know how debug this bug...

	Regards,

	JKB

From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 04 Jan 2007 14:46:16 +0000
Subject: [2.6.19] Sunlance regression ?
Message-Id: <459D1338.9000101@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I'm testing both 2.6.19 and 2.6.19.1 on a SS20 with two sunlance 
ethernet cards (eth0/1) and one happymeal. The happymeal works fine but 
when I insert sunlance module, I obtain some messages (interrupt error, 
or tics error) and a white screen... The 2.6.18 branch works but is not 
stable with SMP and HIGHMEM (2.6.19 seems to be better, at this time, 
2.6.19.1 has not crashed even I use a lot of pipes ;-) ). Is it a known 
regression ?

	Regards,

	JKB

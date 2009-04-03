From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Fri, 03 Apr 2009 13:29:50 +0000
Subject: [2.6.29.1] Panic on boot
Message-Id: <49D60F4E.3080304@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I have built a 2.6.29.1 on a Blade 2000/smp. This last kernel panics 
with a "NMI Watchdog error" (on CPU 0 and after 5 or 6 seconds on CPU 1) 
when it tries to initialize qla2200 FCAL adapter or ethernet card. FCAL 
firmware is built into kernel. The same configuration boots fine with 
2.6.28.9 (but bbc_o2c seems to be broken).

	Regards,

	JKB

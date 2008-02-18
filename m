From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 18 Feb 2008 15:20:45 +0000
Subject: ESP DMA errir was Re: [Ann] SparcV8 depot
Message-Id: <47B9A24D.40301@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	Last message... 2.6.24.2 is _not_ stable on HyperSPARC/SMP. It randomly 
hangs without any message. I shall investigate. On dual SuperSPARC, 
2.6.24.2 can hang with ESP DMA error when raid1 is active. Without 
raid1, I cannot reproduce DMA error.

	Regards,

	JKB

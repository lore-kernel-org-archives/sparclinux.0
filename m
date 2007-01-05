From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Fri, 05 Jan 2007 09:47:51 +0000
Subject: [2.6.19.1] ESP regression ?
Message-Id: <459E1EC7.7050300@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	Some trouble again with ESP DMA and the 2.6.19 kernel ? With very high 
disk load (raid reconstruction or apt-get dist-upgrade), I can seen ESP 
DMA error on a SS20 workstation. This trouble has been fixed in 2.6.18. 
Is there any chance to fix this with the last 2.6.20-rc ?

	Test config :
- dual SS-II/75 MHz
- 448 MB
- 8MB VSIMM
- 2 36 GB internal SCSI disks
- 2.6.19.1 kernel

	Thanks for your help,

	JKB

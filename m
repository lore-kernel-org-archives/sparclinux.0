From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Sat, 04 Aug 2007 08:05:23 +0000
Subject: Creator 3D fb [Bug 8232 on kernel's bugzilla]
Message-Id: <46B43343.7050108@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I think this bug was forgotten ;-) David, you have sent a patch that 
partially fix this bug, but not totaly. Sometimes, after fb switches 
screen off, I have to switch between text console and X screen to 
reinitialize fb.

	This bug only occurs on Creator 3D (in a Sbus/UPA). I never see it on 
PCI/UPA workstation.

	Regards,

	JKB

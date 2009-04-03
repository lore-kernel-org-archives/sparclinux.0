From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Fri, 03 Apr 2009 12:13:37 +0000
Subject: [2.6.28.9] bbc driver
Message-Id: <49D5FD71.30004@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I'm trying to install a Sun Blade 2000 (2xUS III+/900) with a debian 
stable release (lenny). I have rebuilt a 2.6.28.9 kernel (to include 
fiber channel firmware) and i have some trouble with bbc driver.

1/ with 2.6.26-1 kernel from debian, I can run modprobe bbc and it works 
fine.
2/ with my 2.6.28.9 kernel, when I try to use bbc driver, I obtain an 
error -22.

	I haven't found any information about this error. Any idea ? I haven't 
found any modification in drivers/sbus/char/bcc* on kernel.org.

	Regards,

	JKB

From: boera@rdslink.ro
Date: Sun, 18 Dec 2005 10:15:36 +0000
Subject: BTTV and SPARC
Message-Id: <20051218101536.22906.qmail@webmail.rdslink.ro>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

I have posted already my problem on the Debian SPARC list, but unfortunately I didn't 
receive any suggestions.
The problem is connected with the bttv driver.
Machine: Sun Ultra 10 (360 MHz), onboard ATI video card.
Kernels tested: 2.6.14, 2.6.15 rc4 and rc5
The bttv driver seems to work fine but the machine locks up hard after about 20 minutes.
No error messages in the logs.
It seems to me that the lockup happens everytime after the same time interval.
I have tried with 2 different TV tuners (Jetway PCITV and Leadtek Winfast 2000 XP), the
result is the same.
I would like to know if bttv is supposed to work under SPARC, or the machine just cannot
handle the I/O bandwidth.

Best regards,
Boer Attila


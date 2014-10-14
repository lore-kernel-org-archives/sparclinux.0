From: Mikael Pettersson <mikpelinux@gmail.com>
Date: Tue, 14 Oct 2014 07:54:26 +0000
Subject: [3.17 regression] 3.17 spontaneous reboots on Sun Blade 2500
Message-Id: <21564.54962.191155.295709@gargle.gargle.HOWL>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Since updating my Sun Blade 2500 from the 3.16 to the 3.17 kernel on
Sunday, I got 3 spontaneous reboots during GCC bootstrap/regtest runs
on Monday.  There was nothing of interest in /var/log/messages.  Going
back to 3.16 makes the machine stable again.

I'll try to capture the serial console in a couple of days when I
have physcial access to the machine again.

/Mikael

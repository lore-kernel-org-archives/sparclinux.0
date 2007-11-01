From: Josip Rodin <joy@entuzijast.net>
Date: Thu, 01 Nov 2007 21:40:37 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <20071101214037.GA28838@keid.carnet.hr>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

lebrun.d.o hasn't crashed in a while now, but it has this in the
process list:

buildd    2382  0.0  0.2   8144  4736 ?        Ss   Oct30   0:00 /usr/bin/perl /usr/bin/buildd
buildd    2407  0.0  0.5  13920 11296 ?        SN   Oct30   0:10  \_ /usr/bin/perl /usr/bin/sbuild --batch --stats-dir=/home/buildd/
buildd   18174  0.0  0.0      0     0 ?        ZNs  Oct30   0:00      \_ [su] <defunct>
buildd   23305  100  1.6 1007296 33288 ?       RN   Oct30 3507:30 dpkg-query --status squashfs-source

At the same time:

% free
             total       used       free     shared    buffers     cached
Mem:       2073040    2021224      51816          0     196808      21144
-/+ buffers/cache:    1803272     269768
Swap:      1048688        104    1048584
% uptime
 22:38:36 up 2 days, 10:53,  1 user,  load average: 3.00, 3.01, 3.00

Given that it's still not catatonic, can I do something to provide some
debugging information?

(BTW, I'm subscribed to the sparclinux list now.)

-- 
     2. That which causes joy or happiness.

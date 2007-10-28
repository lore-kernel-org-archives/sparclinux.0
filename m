From: Bernd Zeimetz <bernd@bzed.de>
Date: Sun, 28 Oct 2007 12:58:11 +0000
Subject: Re: unkillable dpkg-query processes
Message-Id: <47248763.70003@bzed.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20071024223332.GA24557@keid.carnet.hr>
In-Reply-To: <20071024223332.GA24557@keid.carnet.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


>> [29074.766486] TSTATE: 0000000011009600 TPC: 000000000042f984 TNPC: 000000000042f928 Y: 00000000    Not tainted
>> [29074.884191] TPC: <sched_clock+0x0/0x30>
> 
> What kind of OOPS is this?  Please provide the kernel log messages
> that appeared right before these register dumps.


Oct 28 03:25:12 titan kernel: [29074.698695] BUG: soft lockup - CPU#0
stuck for 11s! [sh:4252]

This happened while a cronjob was running which updates the libnss-db
database... With an older kernel (2.6.23-rcsomething) this didn't crash
the machine.


-- 
Bernd Zeimetz
<bernd@bzed.de>                         <http://bzed.de/>

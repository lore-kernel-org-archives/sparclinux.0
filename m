From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Wed, 16 Sep 2009 09:22:33 +0000
Subject: Re: Sparc release requalification
Message-Id: <20090916092233.GB15341@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <4AA427E6.5000801@nerim.net>
In-Reply-To: <4AA427E6.5000801@nerim.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

tested davem's vmliux-debug on my sunfire880, hangs as usual.

Interresting, thougt, is when I send a xir via the rsc, after a moment
a line "ERROR: System-Watchdog Reset" appears and the system restarts 
- see below.

Greetings,
  Hermann

...
Memory: 4138880k available (2520k kernel code, 936k data, 184k init) [fffff80000000000,000000a0ffb1a000]
Calibrating delay using timer specific routine.. 20.01 BogoMIPS (lpj@035)
Mount-cache hash table entries: 512
CPU 0: synchronized TICK with master CPU (last diff 0 cycles, maxerr 11 cycles)
Brought up 2 CPUs
net_namespace: 1712 bytes
NET: Registered protocol family 16

ERROR: System-Watchdog Reset

Executing POST w/%o0 = 0000.0800.0101.4001
...

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de

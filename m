From: Bastian Blank <waldi@debian.org>
Date: Sun, 24 Jun 2007 06:58:26 +0000
Subject: sparc64 - empty call traces
Message-Id: <20070624065826.GA23454@wavehammer.waldi.eu.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi

I don't think it is expected that the call traces in a process dump
(sysrq t) are empty? This happens on at least 2.6.21 and 2.6.22-rc5. The
userland is 32bit. The machine is a T2000.

| inetutils-ine S 00000000004060d4     0  2290      1 (NOTLB)
| Call Trace:
| master        S 00000000004ab0b8     0  2350      1 (NOTLB)
| Call Trace:
| pickup        S 00000000004ab0b8     0  2353   2350 (NOTLB)
| Call Trace:
| qmgr          S 00000000004ab0b8     0  2354   2350 (NOTLB)
| Call Trace:
| sshd          S 00000000004ab0b8     0  2363      1 (NOTLB)
| Call Trace:
| mdadm         S 00000000004ab0b8     0  2398      1 (NOTLB)
| Call Trace:
| cron          S 00000000004777b0     0  2408      1 (NOTLB)
| Call Trace:
| getty         S 0000000000573d90     0  2434      1 (NOTLB)
| Call Trace:
| sshd          S 00000000004ab0b8     0  2435   2363 (NOTLB)
| Call Trace:

Bastian

-- 
Captain's Log, star date 21:34.5...

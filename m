From: "C.Newport" <crn@netunix.com>
Date: Sat, 21 Aug 2004 12:24:58 +0000
Subject: More Sun4d tests
Message-Id: <200408211324.58120.crn@netunix.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Another interesting result -
Running 2.4.27 SMP on the SS1000E with only one system board 
fails in similar ways but much sooner. For example the serial
console keyboard reading starts producing garbage almost
immediately rather than after several minutes with 3 boards.

I suspect a marginal timng issue of some kind.

The Sun4d hardware adds latency issues because arbitration has 
to go via the XDBus to the control board and back, rather than
being local as on the single board Sun4M systems.
The local bus on a system board is therefore faster than that on
(for example) the SS20 in order to reduce total latency with
multiple boards. 


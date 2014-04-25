From: David Miller <davem@davemloft.net>
Date: Fri, 25 Apr 2014 19:43:37 +0000
Subject: [PATCH 0/3] Fix several sparc64 THP bugs.
Message-Id: <20140425.154337.1159533755150765063.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: mroos@linux.ee, aaro.koskinen@iki.fi, hughd@google.com, linux-kernel@vger.kernel.org


Meelis and Aaro, I've found and fixed several THP bugs for sparc64
over the last week or so.

I cannot %100 account for the exit_mmap() WARN_ON that you two have
been able to trigger, however I'd like you both to test the changes
nonetheless.

They are against 3.15 but they should apply cleanly all the way back
to 3.13

Thanks in advance for testing.

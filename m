From: William Lee Irwin III <wli@holomorphy.com>
Date: Thu, 18 Nov 2004 14:41:42 +0000
Subject: circular console list in 2.6.9-bk3+
Message-Id: <20041118144142.GG2268@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Some changes that added serial console retry logic aren't interacting
well with PROM console setup and teardown and whatever sunzilog.c does,
and appear to result in a circular console list (hence indefinitely
repeated output). The trick is, of course, that I'm not sure which of
the three is wrong.


-- wli

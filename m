From: William Lee Irwin III <wli@holomorphy.com>
Date: Mon, 13 Dec 2004 13:33:30 +0000
Subject: bypassing -mm
Message-Id: <20041213133330.GA771@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Certain patches have gone into -mm that need drastic core changes done
to them before it's feasible to make sparc32 work with them. I'll be
bypassing -mm and patching against mainline, and there will be a small
(ca. 24 hours) porting delay while rediffing the pending patches
against the latest bk snapshot, due to (of course) having a day job. If
you're going to resend things, please do so against the latest bk snapshot.

I'll post the series to be sent upstream here first so that anyone
with an urgent need can bug me to include whatever fixes I left out.



-- wli

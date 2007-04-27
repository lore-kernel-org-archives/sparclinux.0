From: David Miller <davem@davemloft.net>
Date: Fri, 27 Apr 2007 08:39:41 +0000
Subject: Re: [PATCH]: Final ESP driver rewrite
Message-Id: <20070427.013941.41636227.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0704270956500.506@yvahk01.tjqt.qr>
	<20070427.012436.109059523.davem@davemloft.net>
	<Pine.LNX.4.61.0704271032380.506@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0704271032380.506@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jengelh@linux01.gwdg.de
Cc: linux-scsi@vger.kernel.org, sparclinux@vger.kernel.org

From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Date: Fri, 27 Apr 2007 10:33:30 +0200 (MEST)

> Well the patch looks like it's done in one commit (rather than two -
> delete+add), but that's probably just because it's the diff over both commits.

I didn't do it in multiple commits, I did it in one.

If I do it in two commits, the driver doesn't exist
at a point in the history and this screws things up
for people trying to bisect who have that hardware.

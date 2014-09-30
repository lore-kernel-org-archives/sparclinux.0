From: David Miller <davem@davemloft.net>
Date: Tue, 30 Sep 2014 21:38:34 +0000
Subject: Re: [PATCH] vio: fix reuse of vio_dring slot
Message-Id: <20140930.173834.935508379925550105.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1411134182-26705-1-git-send-email-dwight.engen@oracle.com>
In-Reply-To: <1411134182-26705-1-git-send-email-dwight.engen@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dwight Engen <dwight.engen@oracle.com>
Date: Fri, 19 Sep 2014 09:43:02 -0400

> vio_dring_avail() will allow use of every dring entry, but when the last
> entry is allocated then dr->prod = dr->cons which is indistinguishable from
> the ring empty condition. This causes the next allocation to reuse an entry.
> When this happens in sunvdc, the server side vds driver begins nack'ing the
> messages and ends up resetting the ldc channel. This problem does not effect
> sunvnet since it checks for < 2.
> 
> The fix here is to just never allocate the very last dring slot so that full
> and empty are not the same condition. The request start path was changed to
> check for the ring being full a bit earlier, and to stop the blk_queue if
> there is no space left. The blk_queue will be restarted once the ring is
> only half full again. The number of ring entries was increased to 512 which
> matches the sunvnet and Solaris vdc drivers, and greatly reduces the
> frequency of hitting the ring full condition and the associated blk_queue
> stop/starting. The checks in sunvent were adjusted to account for
> vio_dring_avail() returning 1 less.
> 
> Orabug: 19441666
> OraBZ: 14983
> 
> Signed-off-by: Dwight Engen <dwight.engen@oracle.com>

Applied.

From: "David S. Miller" <davem@redhat.com>
Date: Wed, 07 Jul 2004 20:03:22 +0000
Subject: Re: 2.6.7+BK: PCI scan gives lots of "bad: scheduling while
Message-Id: <20040707130322.6698da41.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0407071734050.18568-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0407071734050.18568-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 7 Jul 2004 17:37:28 +0300 (EEST)
Meelis Roos <mroos@linux.ee> wrote:

> This is a Ultra 5 with a couple of PCI cards (USB, VGA and SCSI). Tried
> todays Bk snapshot, it came up and works but gave lots of errors:

Turn off preemption, it's experimental at best on sparc64.

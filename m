From: William Lee Irwin III <wli@holomorphy.com>
Date: Sat, 14 Aug 2004 09:59:16 +0000
Subject: Re: printk()s, sun4d and SMP
Message-Id: <20040814095916.GV11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <b476569a04081402241c702af4@mail.gmail.com>
In-Reply-To: <b476569a04081402241c702af4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sat, Aug 14, 2004 at 02:24:44AM -0700, Adam Hunt wrote:
> While reading though the archive I ran across a thread from December
> '99 that says if the prink()s in calibrate_delay() were removed it was
> possible to get sun4d machines like the SparcServers and SparcCenters
> to boot in SMP mode.  I realize that we are talking about the 2.2 days
> but is this hack possible with 2.4 or 2.6?

Interesting to hear. Could you try this on 2.2.x and let me know how
well it works (e.g. does userspace run)?


-- wli

From: Ricky Beam <jfbeam@bluetronic.net>
Date: Thu, 08 Jul 2004 05:17:37 +0000
Subject: Re: 2.6.7+BK: PCI scan gives lots of "bad: scheduling while atomic!"
Message-Id: <Pine.GSO.4.33.0407080114580.25702-100000@sweetums.bluetronic.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.GSO.4.44.0407071734050.18568-100000@math.ut.ee>
In-Reply-To: <Pine.GSO.4.44.0407071734050.18568-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 7 Jul 2004, David S. Miller wrote:
>Turn off preemption, it's experimental at best on sparc64.

Somebody should set CONFIG_BROKEN if it isn't already set.  Preempt used
to not even compile for sparc64, much less run. (It's been a long time
since I even tried.)

--Ricky



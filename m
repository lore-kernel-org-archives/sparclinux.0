From: Bob Breuer <breuerr@mc.net>
Date: Mon, 14 Feb 2005 15:12:45 +0000
Subject: Re: sparc32 SMP for 2.6
Message-Id: <4210BFED.80603@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <420F070B.8010000@mc.net>
In-Reply-To: <420F070B.8010000@mc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

William Lee Irwin III wrote:
> Between networking and serial it sounds as if this is a partial
> explanation as to why I'm having trouble here.

The networking may be a red herring.  I only mentioned it because it was 
an easy option to remove to get the kernel size back down to a point 
where silo would boot it.

And for the serial, bash ran fine on the serial port, it was just init 
that had problems so far.

Bob

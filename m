From: Andrew Morton <akpm@linux-foundation.org>
Date: Sun, 25 Feb 2007 12:47:54 +0000
Subject: Re: sparc64 / bbc_i2c.c
Message-Id: <20070225044754.1d849a8d.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1171978032.18442.11.camel@lax.shef.ac.uk>
In-Reply-To: <1171978032.18442.11.camel@lax.shef.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "J.J. Green" <j.j.green@sheffield.ac.uk>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> On Tue, 20 Feb 2007 13:27:12 +0000 "J.J. Green" <j.j.green@sheffield.ac.uk> wrote:
> Hi all
> 
> I got bitten by this problem on sparc64 (a blade 1000)
> 
>   http://ubuntuforums.org/showthread.php?t)7474
>
> summary :
> 
>   modprobe bbc
> 
> runs kenvctrld which uses 100% of a CPU for 5 seconds,
> then 0% for 5 seconds, then 100% .. and so on. The author
> cited above suggests removing the line 
> 
>   remove_wait_queue(&bp->wq, &wait);
> 
> in the function 
> 
>   static int wait_for_pin(struct bbc_i2c_bus *bp, u8 *status)
> 
> Is there a better way?
> 
> I can test patches if that would be helpful.
> 

The code around there looks relatively unbuggy to me.  Removing that
remove_wait_queue() would be very bad - it would cause later stack
corruption.

msleep_interruptible() certainly shouldn't consume CPU like that.  Do we
know where the CPU time is being spent?  The output of:

readprofile -r
sleep 10
readprofile -n -v -m /boot/System.map | sort -n -k 3 | tail -40

would tell us.

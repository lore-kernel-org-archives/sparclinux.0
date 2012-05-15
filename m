From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 15 May 2012 18:56:30 +0000
Subject: Re: [PATCH 2/2] sparc32: Kill off software 32-bit multiply/divide routines.
Message-Id: <20120515185630.GA31164@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20120515.143748.225092224634923633.davem@davemloft.net>
In-Reply-To: <20120515.143748.225092224634923633.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, May 15, 2012 at 02:37:48PM -0400, David Miller wrote:
> 
> For the explicit calls to .udiv/.umul in assembler, I made a
> mechanical (read as: safe) transformation.  I didn't attempt
> to make any simplifications.
> 
> In particular, __ndelay and __udelay can be simplified significantly.
> Some of the %y reads are unnecessary and these routines have no need
> any longer for allocating a register window, they can be leaf
> functions.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

This was exactly what I hoped to see with Cypress dropped - great!

	Sam

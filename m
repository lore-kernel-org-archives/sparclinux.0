From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 09 Sep 2017 06:40:03 +0000
Subject: Re: [PATCH v2] sparc64: Handle additional cases of no fault loads
Message-Id: <20170909064003.GB841@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1504910061-248242-1-git-send-email-rob.gardner@oracle.com>
In-Reply-To: <1504910061-248242-1-git-send-email-rob.gardner@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 08, 2017 at 04:34:21PM -0600, Rob Gardner wrote:
> Load instructions using ASI_PNF or other no-fault ASIs should not
> cause a SIGSEGV or SIGBUS.
> 
> A garden variety unmapped address follows the TSB miss path, and when
> no valid mapping is found in the process page tables, the miss handler
> checks to see if the access was via a no-fault ASI.  It then fixes up
> the target register with a zero, and skips the no-fault load
> instruction.
> 
> But different paths are taken for data access exceptions and alignment
> traps, and these do not respect the no-fault ASI. We add checks in
> these paths for the no-fault ASI, and fix up the target register and
> TPC just like in the TSB miss case.
> 
> Signed-off-by: Rob Gardner <rob.gardner@oracle.com>
Looks much better!
Acked-by: Sam Ravnborg <sam@ravnborg.org>

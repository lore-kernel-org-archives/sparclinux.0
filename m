From: Ben Collins <bcollins@debian.org>
Date: Tue, 15 Jun 2004 17:42:08 +0000
Subject: Re: sparc env monitorin vs tasklist_lock
Message-Id: <20040615174208.GB1217@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040615172956.GA21361@lst.de>
In-Reply-To: <20040615172956.GA21361@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jun 15, 2004 at 07:29:56PM +0200, Christoph Hellwig wrote:
> Strange stuff going on here, bbc_envctrl.c and envctrl.c iterate over
> the complete task list to check whether the thread has been killed,
> yikes!
> 
> I've attached a patch to convert it to the kthread infrastructure, but
> it has been completely untested, not even compiled.
> 
> p.s. the drivers also have other strangenesses like calling execve
> directly instead of call_usermodehelper and the bbc driver having it's

You took out the use of poll_interval, so wouldn't that cause the thread
to eat up all the cpu with this patch?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

From: Ben Collins <bcollins@debian.org>
Date: Fri, 23 Jan 2004 13:46:28 +0000
Subject: Re: 2.6.2-rc1 smp crash
Message-Id: <20040123134628.GH27566@phunnypharm.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Jan 23, 2004 at 09:34:34AM -0500, Chris Ricker wrote:
> I just had a dual Ultra 2 running 2.6.2-rc1 lock up hard. The only messages 
> on the screen are from the spin-lock debugging:
> 
> spin_lock(fffff8003fab0208) CPU#1 stuck at 0053fd88, owner PC(0053d1ac):CPU(1)
> spin_lock(00000000006bee00) CPU#0 stuck at 004a551c, owner PC(005205a0):CPU(1)
> spin_lock(fffff8003fab0208) CPU#1 stuck at 0053fd88, owner PC(0053d1ac):CPU(1)
> spin_lock(00000000006bee00) CPU#0 stuck at 004a551c, owner PC(005205a0):CPU(1)
> spin_lock(fffff8003fab0208) CPU#1 stuck at 0053fd88, owner PC(0053d1ac):CPU(1)
> spin_lock(00000000006bee00) CPU#0 stuck at 004a551c, owner PC(005205a0):CPU(1)
> 
> What should I do next to start hunting this down?

Check your System.map for where the addresses for "stuck at XXX" and
"owner PC(XXX)". Also check for 0x006bee00, which is the spinlock in
question.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/

From: Chris Ricker <kaboom@gatech.edu>
Date: Fri, 23 Jan 2004 14:34:34 +0000
Subject: 2.6.2-rc1 smp crash
Message-Id: <Pine.GSO.4.58.0401230930180.26155@redfish.gatech.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <20040123134628.GH27566@phunnypharm.org>
In-Reply-To: <20040123134628.GH27566@phunnypharm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I just had a dual Ultra 2 running 2.6.2-rc1 lock up hard. The only messages 
on the screen are from the spin-lock debugging:

spin_lock(fffff8003fab0208) CPU#1 stuck at 0053fd88, owner PC(0053d1ac):CPU(1)
spin_lock(00000000006bee00) CPU#0 stuck at 004a551c, owner PC(005205a0):CPU(1)
spin_lock(fffff8003fab0208) CPU#1 stuck at 0053fd88, owner PC(0053d1ac):CPU(1)
spin_lock(00000000006bee00) CPU#0 stuck at 004a551c, owner PC(005205a0):CPU(1)
spin_lock(fffff8003fab0208) CPU#1 stuck at 0053fd88, owner PC(0053d1ac):CPU(1)
spin_lock(00000000006bee00) CPU#0 stuck at 004a551c, owner PC(005205a0):CPU(1)

What should I do next to start hunting this down?

thanks,
chris

From: "David S. Miller" <davem@davemloft.net>
Date: Wed, 05 Apr 2006 21:21:38 +0000
Subject: Re: clone return code
Message-Id: <20060405.142138.12167410.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87psjvu4wa.fsf@thorr.asgardr.info>
In-Reply-To: <87psjvu4wa.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel 'NebuchadnezzaR' Dehennin <sparc@asgardr.info>
Date: Wed, 05 Apr 2006 22:46:45 +0200

> Sorry if that question seems idiot but is it normal that clone return
> the parent pid in the child ?
> 
> Is seems that on other architectures it have the same behavior than
> fork: return 0 in the child.

The system call convention follows that of SunOS on which
the syscall handling was based.  Return "1" in the %o1
register in the child and "0" in the parent, and that's how
the the call sites distinguish the two cases.

GLIBC's fork() and clone() stubs interpret this properly and
give the expected return values.

If you want to implement your own direct calls to these
system calls you'll need to handle the return values
properly, else just call the glibc provided stubs directly
which will do this for you.

Why is this an issue?
